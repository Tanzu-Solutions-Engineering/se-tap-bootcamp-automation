
variable "resource_group_name" {
  type        = string
  description = "A name for a resource group; @see https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal#what-is-a-resource-group"
}

variable "kv_name" {
  type        = string
  description = "The name of the key vault"
}

variable "secret_map" {
  type        = map(string)
  description = "Map of secrets to add to the vault"
}