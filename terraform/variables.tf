variable "location" {
  description = "resource_group_location"
  type        = string
  default     = "eastus"
}

variable "size" {
  description = "size of VM"
  type        = string
  default     = "Standard_F2s_v2"
}

variable "publisher" {
  description = "Publisher of VM"
  type        = string
  default     = "fortinet"
}

variable "fgtoffer" {
  description = "offer of VM"
  type        = string
  default     = "fortinet_fortigate-vm_v5"
}

variable "license_type" {
  description = "License of VM"
  type        = string
  default     = "fortinet_fg-vm_payg_2022"
}

variable "fgtversion" {
  description = "version of VM"
  type        = string
  default     = "7.4.0"
}

variable "adminusername" {
  description = "version of VM"
  type        = string
  default     = "fortixperts"
}

variable "adminpassword" {
  description = "version of VM"
  type        = string
  default     = "Fortixperts2023!"
}