output "vm_id" {
  value       = data.azurerm_virtual_machine.azure_vm.id
  description = "The ID of the VM you use in the module."
}