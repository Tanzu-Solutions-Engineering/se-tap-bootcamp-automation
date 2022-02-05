data "azurerm_resource_group" "rg" {
  name  = var.resource_group_name
}

# Documentation Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_service_versions
# Datasource to get Latest Azure AKS latest Version
data "azurerm_kubernetes_service_versions" "current" {
  location = var.region
  include_preview = false
  depends_on = [ data.azurerm_resource_group.rg ]
}

output "supported_k8s_versions" {
  value = data.azurerm_kubernetes_service_versions.current.versions
}
