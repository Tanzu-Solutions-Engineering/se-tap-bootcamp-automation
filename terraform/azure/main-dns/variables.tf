variable "base_domain" {
  description = "The base domain where an NS recordset will be added mirroring a new sub-domain's recordset"
}

variable "domain_prefix" {
  description = "Prefix for a domain (e.g. in lab.cloudmonk.me, 'lab' is the prefix)"
}

variable "resource_group_name" {
  description = "A name for a resource group; @see https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal#what-is-a-resource-group"
}
