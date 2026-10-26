variable "location" {
  default = "East US 2"
}

variable "resource_group_name" {
  default = "task3-rg"
}

variable "admin_username" {
  default = "azureadmin"
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "vm_size" {
  default = "Standard_B2ms"
}


variable "public_ip_domain_name_label" {
  default = "task3-web-lb-demo"
}