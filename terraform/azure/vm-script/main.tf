data "azurerm_resource_group" "target_rg" {
  name = var.resource_group_name
}

data "azurerm_virtual_machine" "azure_vm" {
  name                = var.vm_name
  resource_group_name = data.azurerm_resource_group.target_rg.name
}

resource "azurerm_virtual_machine_extension" "linux_vm" {
  name                       = "${var.vm_name}-run-command"
  publisher                  = "Microsoft.Azure.Extensions"
  type                       = "CustomScript"
  type_handler_version       = "2.0"
  auto_upgrade_minor_version = true

  protected_settings = jsonencode({
    script = tostring(var.script)
  })

  virtual_machine_id = data.azurerm_virtual_machine.azure_vm.id
}