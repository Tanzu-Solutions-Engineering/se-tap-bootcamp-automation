resource "azurerm_dns_zone" "tap-workshop-zone" {
  name = "${var.domain_prefix}.${var.base_domain}"
  tags = {
    description = "Azure DNS managed zone for ${var.domain_prefix}.${var.base_domain}"
  }
  resource_group_name = var.resource_group_name
}
