variable "region" {
  type        = string
  description = "The Azure Region where the Resource Group should exist.  For a list of regions execute [ az account list-locations -o table ]."
  default     = "westcentralus"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group within which this VM is created.  Must already exist!"
}

variable "main_resource_group_name" {
  description = "Resource group where the main Azure DNS zone exists"
}

variable "vm_name" {
  type        = string
  description = "The name given to bastion VM that provides a curated toolset"
}

variable "base_domain" {
  description = "The base domain where an NS recordset will be added mirroring a new sub-domain's recordset"
}

variable "domain_prefix" {
  description = "Prefix for a domain (e.g. in lab.cloudmonk.me, 'lab' is the prefix)"
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

variable "registry_name" {
  type        = string
  description = "Specifies the name of the Container Registry.  This name will be updated to append a unique suffix so as not to collide with a pre-existing registry."
}

variable "vnet_cidr" {
  type = string
  description = "The Virtual Network CIDR block (e.g., 10.1.0.0/16)"
  default = "10.1.0.0/16"
}

variable "operator_subnet_cidr" {
  type = string
  description = "The Subnet CIDR block for operator resources (e.g., 10.1.0.0/24)"
  default = "10.1.0.0/24"
}

variable "aks_subnet_cidr" {
  type = string
  description = "The Subnet CIDR block hosting AKS cluster (e.g., 10.1.1.0/24)"
  default = "10.1.1.0/24"
}
