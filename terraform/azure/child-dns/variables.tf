variable "base_domain" {
  description = "The base domain where an NS recordset will be added mirroring a new sub-domain's recordset"
}

variable "domain_prefix" {
  description = "Prefix for a domain (e.g. in lab.cloudmonk.me, 'lab' is the prefix)"
}

variable "resource_group_name" {
  description = "reosurce group name to place the child zone"
}

variable "main_resource_group_name" {
  description = "resource group where the main zone exists"
}
