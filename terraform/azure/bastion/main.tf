data "azurerm_resource_group" "vm" {
  name = var.vm_resource_group_name
}

data "azurerm_resource_group" "sig" {
  name = var.sig_resource_group_name
}

data "azurerm_subnet" "operator_subnet" {
  name                 = "operator-subnet-${var.suffix}"
  virtual_network_name = "vnet-${var.suffix}"
  resource_group_name  = data.azurerm_resource_group.vm.name
}

data "azurerm_shared_image_version" "toolset_source_image" {
  name                = var.toolset_image_version
  image_name          = var.toolset_image_name
  gallery_name        = var.sig_name
  resource_group_name = data.azurerm_resource_group.sig.name
}

resource "tls_private_key" "pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "bastion" {
  name                = var.vm_name
  location            = data.azurerm_resource_group.vm.location
  resource_group_name = data.azurerm_resource_group.vm.name
  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]
  size = var.vm_size

  computer_name                   = var.vm_name
  admin_username                  = var.ssh_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.ssh_username
    public_key = tls_private_key.pair.public_key_openssh
  }

  os_disk {
    name                 = "${var.vm_name}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  identity {
    type = "SystemAssigned"
  }

  source_image_id = data.azurerm_shared_image_version.toolset_source_image.id
}

resource "local_file" "path_to_public_openssh_keyfile" {
  sensitive_content = tls_private_key.pair.public_key_openssh
  filename          = pathexpand("~/.ssh/${var.vm_name}_rsa.pub")
  file_permission   = "600"
}

resource "local_file" "path_to_private_openssh_keyfile" {
  sensitive_content = tls_private_key.pair.private_key_pem
  filename          = pathexpand("~/.ssh/${var.vm_name}_rsa")
  file_permission   = "600"
}

resource "azurerm_public_ip" "operator_ip" {
  name                = "public-ip-for-nic-${var.suffix}"
  location            = data.azurerm_resource_group.vm.location
  resource_group_name = data.azurerm_resource_group.vm.name
  allocation_method   = "Static"
  sku                 = "Standard"
  availability_zone   = "No-Zone"
}

resource "azurerm_network_interface" "nic" {
  name                = "nic-${var.suffix}"
  location            = data.azurerm_resource_group.vm.location
  resource_group_name = data.azurerm_resource_group.vm.name

  ip_configuration {
    name                          = "nic-${var.suffix}"
    subnet_id                     = data.azurerm_subnet.operator_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.operator_ip.id
  }
}


resource "azurerm_role_assignment" "sp" {
  scope                = data.azurerm_resource_group.vm.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_linux_virtual_machine.bastion.identity.0.principal_id
}