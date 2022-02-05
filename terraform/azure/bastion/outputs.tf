output "nic_name" {
  value = azurerm_network_interface.nic.name
}

output "nic_id" {
  value = azurerm_network_interface.nic.id
}

output "bastion_private_ip_address" {
  value = azurerm_linux_virtual_machine.bastion.private_ip_address
}

output "bastion_public_ip_address" {
  value = azurerm_linux_virtual_machine.bastion.public_ip_address
}

output "to_ssh_to_bastion" {
  value = join(" ", ["ssh -i", local_file.path_to_private_openssh_keyfile.filename, "ubuntu@${azurerm_linux_virtual_machine.bastion.public_ip_address}"])
}

output "bastion_id" {
  value = azurerm_linux_virtual_machine.bastion.id
}

output "bastion_vm_name" {
  value = azurerm_linux_virtual_machine.bastion.name
}

output "bastion_vm_id" {
  value = azurerm_linux_virtual_machine.bastion.virtual_machine_id
}

output "path_to_public_openssh_keyfile" {
  value = local_file.path_to_public_openssh_keyfile.filename
}

output "path_to_private_openssh_keyfile" {
  value = local_file.path_to_private_openssh_keyfile.filename
}

output "public_openssh_key" {
  value     = tls_private_key.pair.public_key_openssh
  sensitive = true
}

output "private_openssh_key" {
  value     = tls_private_key.pair.private_key_pem
  sensitive = true
}
