variable "resource_group_name" {
  type = string
  description = "The name of the resource group in which to create the Kubernetes cluster"
}

variable "region" {
  type        = string
  description = "AKS region (e.g. `West Europe`) -> `az account list-locations --output table`"
  default     = "westcentralus"
}
