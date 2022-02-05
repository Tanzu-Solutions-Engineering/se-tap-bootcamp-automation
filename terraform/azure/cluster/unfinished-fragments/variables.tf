variable "suffix" {
  type = string
  description = "A Virtual Network suffix.  Used for looking up the subnet where this cluster's nodes will be running."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Kubernetes cluster"
}

variable "aks_nodes" {
  type        = number
  description = "AKS Kubernetes worker nodes (e.g. `2`)"
  default     = 5
}

variable "aks_node_type" {
  type        = string
  description = "A valid Azure VM size.  See https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-general."
  default     = "Standard_D4_v4"
}

variable "aks_node_disk_size" {
  type        = number
  description = "AKS node instance disk size in GB (e.g. `30` => minimum: 30GB, maximum: 1024)"
  default     = 80
}

variable "windows_admin_username" {
  type        = string
  description = "Windows administrator account username"
  default     = "adm1n"
}

variable "environment" {
  type        = string
  description = "Operating environment (e.g., bootcamp, demo, workshop, dev, test, staging, production)"
  default     = "bootcamp"
}

# This variable should be set to false until https://github.com/kubernetes/kubernetes/issues/102849 is addressed
variable "enable_windows_nodepool" {
  type = bool
  description = "Whether or not to create an additional pool of Windows Datacenter 2019 nodes"
  default = false
}

variable "enable_linux_nodepool" {
  type = bool
  description = "Whether or not to create an additional pool of Ubuntu 18.04 nodes"
  default = false
}

variable "k8s_version" {
  type = string
  description = "If this variable is defined and is a supported Kubernetes version, then it is used to install a version for the cluster and node pool(s), otherwise the latest supported version is installed."
  default = "1.21.7"
}

variable "k8s_api_server_authorized_ip_ranges" {
  type = list(string)
  description = "List of IP addresses or CIDR blocks that are allowed to transact the K8s API server"
  default = [ "0.0.0.0/0" ]
}