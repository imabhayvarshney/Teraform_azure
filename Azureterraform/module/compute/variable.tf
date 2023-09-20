variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable  "vnicpublicid" {
  #default = ""
  description = "Virtual network interface ID"
}

variable  "vnicprivateid" {
  #default = ""
  description = "Virtual network interface ID"
}
variable "env" {
  description = "ENvirnment"
  type        = string
}