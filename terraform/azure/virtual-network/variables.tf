variable "resource_group_name" {
  type        = string
  description = "The resource group within which all network resources are created.  Must already exist!"
}
variable "vnet_cidr" {
  type        = string
  description = "The Virtual Network CIDR block (e.g., 10.1.0.0/16)"
  default     = "10.1.0.0/16"
}

variable "operator_subnet_cidr" {
  type        = string
  description = "The Subnet CIDR block for operator resources (e.g., 10.1.0.0/24)"
  default     = "10.1.0.0/24"
}

variable "aks_subnet_cidr" {
  type        = string
  description = "The Subnet CIDR block hosting AKS cluster (e.g., 10.1.1.0/24)"
  default     = "10.1.1.0/24"
}
