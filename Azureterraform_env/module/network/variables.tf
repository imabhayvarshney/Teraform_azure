variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}
variable "env" {
  description = "ENvirnment"
  type        = string
}

# Define other variables specific to the network module here.
