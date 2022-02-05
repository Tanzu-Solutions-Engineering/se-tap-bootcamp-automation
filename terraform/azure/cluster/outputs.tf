output "path_to_kubeconfig" {
  value = local_file.kubeconfig.filename
}

output "contents_of_kubeconfig" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "latest_k8s_version" {
  value = data.azurerm_kubernetes_service_versions.current.*.latest_version
}

output "k8s_version_installed" {
  value = local.k8s_version
}

output "k8s_cluster_egress_ip" {
  value = data.azurerm_public_ip.aks.ip_address
}

output "path_to_public_openssh_keyfile" {
  value = local_file.path_to_public_openssh_keyfile.filename
}

output "path_to_private_openssh_keyfile" {
  value = local_file.path_to_private_openssh_keyfile.filename
}

output "public_openssh_key" {
  value     = tls_private_key.pair.public_key_openssh
  sensitive = true
}

output "private_openssh_key" {
  value     = tls_private_key.pair.private_key_pem
  sensitive = true
}

output "aks_cluster_name" {
  value = resource.azurerm_kubernetes_cluster.aks.name
}
