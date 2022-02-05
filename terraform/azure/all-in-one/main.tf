resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.region
}

module "main_dns" {
  source = "../main-dns"

  resource_group_name = azurerm_resource_group.rg.name
  base_domain = split(".", var.base_domain)[1]
  domain_prefix = split(".", var.base_domain)[0]

  depends_on = [ azurerm_resource_group.rg ]
}

module "child_dns" {
  source = "../child-dns"

  main_resource_group_name = var.main_resource_group_name
  resource_group_name = azurerm_resource_group.rg.name
  base_domain = var.base_domain
  domain_prefix = var.domain_prefix

  depends_on = [ module.main_dns.zone_subdomain, azurerm_resource_group.rg ]
}

module "vnet" {
  source = "../virtual-network"

  resource_group_name = azurerm_resource_group.rg.name
  vnet_cidr = var.vnet_cidr
  operator_subnet_cidr = var.operator_subnet_cidr
  aks_subnet_cidr = var.aks_subnet_cidr

  depends_on = [ azurerm_resource_group.rg ]
}

module "registry" {
  source = "../registry"

  registry_name = var.registry_name
  resource_group_name = azurerm_resource_group.rg.name
  region = azurerm_resource_group.rg.location

  depends_on = [ azurerm_resource_group.rg ]
}

module "bastion" {
  source = "../bastion"

  resource_group_name = azurerm_resource_group.rg.name
  vm_name = var.vm_name
  nic_name = module.vnet.nic_name

  depends_on = [ azurerm_resource_group.rg ]
}

module "cluster" {
  source = "../cluster"

  resource_group_name = azurerm_resource_group.rg.name
  suffix = module.vnet.vnet_suffix
  aks_nodes = var.aks_nodes
  aks_node_type = var.aks_node_type

  depends_on = [ azurerm_resource_group.rg ]
}
