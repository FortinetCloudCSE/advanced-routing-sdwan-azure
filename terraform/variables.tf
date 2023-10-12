variable "username" {
  type        = string
}

variable "location" {
  description = "resource_group_location"
  type        = string
  default     = "eastus"
}


variable "size" {
  description = "size of VM"
  type        = string
  default     = "eastus"
}

variable "publisher" {
  description = "Publisher of VM"
  type        = string
  default     = "eastus"
}

variable "fgtoffer" {
  description = "offer of VM"
  type        = string
  default     = "eastus"
}

variable "license_type" {
  description = "License of VM"
  type        = string
  default     = "eastus"
}

variable "fgtversion" {
  description = "version of VM"
  type        = string
  default     = "eastus"
}

variable "adminusername" {
  description = "version of VM"
  type        = string
  default     = "eastus"
}

variable "adminpassword" {
  description = "version of VM"
  type        = string
  default     = "eastus"
}