variable "registry_name" {
  type        = string
  description = "Specifies the name of the Container Registry.  This name will be updated to append a unique suffix so as not to collide with a pre-existing registry."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Container Registry"
}

variable "region" {
  type        = string
  description = "The Azure Region where the Resource Group exists.  For a list of regions execute [ az account list-locations -o table ]."
  default     = "westcentralus"
}
