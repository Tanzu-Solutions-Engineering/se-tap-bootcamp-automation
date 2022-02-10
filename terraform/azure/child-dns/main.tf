data "azurerm_dns_zone" "main" {
  name                = var.base_domain
  resource_group_name = var.main_resource_group_name
}

resource "azurerm_dns_zone" "participant-zone" {
  name = "${var.domain_prefix}.${var.base_domain}"
  tags = {
    description = "Azure DNS managed zone for ${var.domain_prefix}.${var.base_domain}"
  }
  resource_group_name = var.resource_group_name
}

resource "azurerm_dns_ns_record" "ns_record" {
  name                = var.domain_prefix
  zone_name           = data.azurerm_dns_zone.main.name
  records             = azurerm_dns_zone.participant-zone.name_servers
  resource_group_name = var.main_resource_group_name
  ttl                 = 30
}
