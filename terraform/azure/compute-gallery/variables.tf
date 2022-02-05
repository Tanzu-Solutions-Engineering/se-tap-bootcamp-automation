
variable "resource_group_name" {
  type        = string
  description = "resource group that the gallery is in"
}

variable "gallery_name" {
  type        = string
  description = "name to use for gallery"
}

variable "image_name" {
  type        = string
  description = "Name of the image defintion to create"
}

variable "image_publisher" {
  type        = string
  description = "Name of the image defintion publisher to create"
}

variable "image_offer" {
  type        = string
  description = "Name of the image defintion offer to create"
}

variable "image_sku" {
  type        = string
  description = "Name of the image defintion sku to create"
}

variable "hyper_v_generation" {
  type    = string
  default = "V2"
}