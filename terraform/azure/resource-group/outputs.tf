output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "resource_group_region" {
  value = azurerm_resource_group.rg.location
}
