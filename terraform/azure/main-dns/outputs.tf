output "zone_subdomain" {
  value = azurerm_dns_zone.tap-workshop-zone.name
}

output "zone_subdomain_ns_records" {
  value = azurerm_dns_zone.tap-workshop-zone.name_servers
}