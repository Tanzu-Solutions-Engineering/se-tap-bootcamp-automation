variable "script" {
  description = "base64 encoded script to execute"
}

variable "vm_name" {
  description = "the vm name to run the command on"
}

variable "resource_group_name" {
  description = "A name for a resource group; @see https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal#what-is-a-resource-group"
}
