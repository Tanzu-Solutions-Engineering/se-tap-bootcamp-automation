variable "region" {
  type        = string
  description = "The Azure Region where the Resource Group should exist.  For a list of regions execute [ az account list-locations -o table ]."
  default     = "westcentralus"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group that will be created"
}
