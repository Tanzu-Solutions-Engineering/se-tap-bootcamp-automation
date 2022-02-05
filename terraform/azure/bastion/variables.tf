variable "suffix" {
  type        = string
  description = "A Virtual Network suffix.  Used for looking up the subnet where this bastion will be running and creating a network interface and public IP."
}

variable "vm_name" {
  type        = string
  description = "The name given to bastion VM that provides a curated toolset"
  default     = "toolset-vm"
}

variable "ssh_username" {
  type        = string
  description = "The username of the administrator account used to SSH into the (bastion) toolset VM"
  default     = "ubuntu"
}

variable "vm_resource_group_name" {
  type        = string
  description = "The resource group within which this VM is created.  Must already exist!"
}

variable "vm_size" {
  type        = string
  description = "A valid Azure VM size.  See https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-general."
  default     = "Standard_D4_v4"
}

variable "toolset_image_version" {
  type        = string
  description = "The version of the image hosted in a Shared Image Gallery (in format major.minor.patch).  Can also be set to latest or recent."
  default     = "latest"
}

variable "toolset_image_name" {
  type        = string
  description = "The name of an image hosted in a Shared Image Gallery"
}

variable "sig_name" {
  type        = string
  description = "The name of a Shared Image Gallery"
}

variable "sig_resource_group_name" {
  type        = string
  description = "The resource group within which the Shared Image Gallery was created.  Must already exist!"
}
