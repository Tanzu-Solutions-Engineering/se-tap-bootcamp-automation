output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "operator_subnet_name" {
  value = azurerm_subnet.operator_subnet.name
}

output "operator_subnet_id" {
  value = azurerm_subnet.operator_subnet.id
}

output "aks_subnet_name" {
  value = azurerm_subnet.aks_subnet.name
}

output "aks_subnet_id" {
  value = azurerm_subnet.aks_subnet.id
}

output "vnet_suffix" {
  value = random_string.suffix.result
}
