# Create Windows Azure AKS Node Pool
resource "azurerm_kubernetes_cluster_node_pool" "windows_np" {
  count                 = var.enable_windows_nodepool ? 1 : 0
  enable_auto_scaling   = true
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  max_count             = local.max_node_count
  min_count             = local.min_node_count
  mode                  = "User"
  name                  = "wp${random_id.cluster_name.hex}"
  orchestrator_version  = local.k8s_version
  os_disk_size_gb       = var.aks_node_disk_size
  os_type               = "Windows" # Default is Linux, we can change to Windows
  vm_size               = var.aks_node_type
  priority              = "Regular"  # Default is Regular, we can change to Spot with additional settings like eviction_policy, spot_max_price, node_labels and node_taints
  vnet_subnet_id        = data.azurerm_subnet.aks_subnet.id

  node_labels = {
    "nodepool-type" = "user"
    "environment"   = var.environment
    "nodepool-os"   = "windows"
  }
  tags = {
    "nodepool-type" = "user"
    "environment"   = var.environment
    "nodepool-os"   = "windows"
  }
}