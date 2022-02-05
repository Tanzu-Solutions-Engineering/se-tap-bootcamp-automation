locals {
  k8s_version    = var.k8s_version != null && contains(data.azurerm_kubernetes_service_versions.current.versions, var.k8s_version) ? var.k8s_version : data.azurerm_kubernetes_service_versions.current.latest_version
  min_node_count = var.aks_nodes
  max_node_count = var.aks_nodes * 5
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet-${var.suffix}"
  virtual_network_name = "vnet-${var.suffix}"
  resource_group_name  = data.azurerm_resource_group.rg.name
}

# Documentation Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_service_versions
# Datasource to get Latest Azure AKS latest Version
data "azurerm_kubernetes_service_versions" "current" {
  location        = data.azurerm_resource_group.rg.location
  include_preview = false
}

resource "random_id" "cluster_name" {
  byte_length = 2
}

resource "tls_private_key" "pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "insights" {
  name                = "aks-logs-${random_id.cluster_name.hex}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  retention_in_days   = 30
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${random_id.cluster_name.hex}"
  kubernetes_version  = local.k8s_version
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = "${data.azurerm_resource_group.rg.name}-cluster"
  node_resource_group = "${data.azurerm_resource_group.rg.name}-nrg"

  api_server_authorized_ip_ranges = var.k8s_api_server_authorized_ip_ranges

  default_node_pool {
    name                 = "aks${random_id.cluster_name.hex}"
    enable_auto_scaling  = true
    max_count            = local.max_node_count
    min_count            = local.min_node_count
    vm_size              = var.aks_node_type
    orchestrator_version = local.k8s_version
    os_disk_size_gb      = var.aks_node_disk_size
    type                 = "VirtualMachineScaleSets"
    vnet_subnet_id       = data.azurerm_subnet.aks_subnet.id

    node_labels = {
      "nodepool-type" = "system"
      "environment"   = var.environment
      "nodepool-os"   = "linux"
    }

    tags = {
      "nodepool-type" = "system"
      "environment"   = var.environment
      "nodepool-os"   = "linux"
    }
  }

  # Identity (System Assigned or Service Principal)
  identity {
    type = "SystemAssigned"
  }

  # Add On Profiles
  addon_profile {
    azure_policy { enabled = true }
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.insights.id
    }
  }

  # Linux Profile
  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
      key_data = tls_private_key.pair.public_key_openssh
    }
  }

  # Network Profile
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "Standard"
  }

  tags = {
    environment = var.environment
  }
}

resource "local_file" "kubeconfig" {
  content  = azurerm_kubernetes_cluster.aks.kube_config_raw
  filename = pathexpand("~/.kube/${azurerm_kubernetes_cluster.aks.name}-config")
}

data "azurerm_public_ip" "aks" {
  name                = reverse(split("/", tolist(azurerm_kubernetes_cluster.aks.network_profile.0.load_balancer_profile.0.effective_outbound_ips)[0]))[0]
  resource_group_name = azurerm_kubernetes_cluster.aks.node_resource_group
}

resource "local_file" "path_to_public_openssh_keyfile" {
  sensitive_content = tls_private_key.pair.public_key_openssh
  filename          = pathexpand("~/.ssh/${azurerm_kubernetes_cluster.aks.name}_rsa.pub")
  file_permission   = "600"
}

resource "local_file" "path_to_private_openssh_keyfile" {
  sensitive_content = tls_private_key.pair.private_key_pem
  filename          = pathexpand("~/.ssh/${azurerm_kubernetes_cluster.aks.name}_rsa")
  file_permission   = "600"
}
