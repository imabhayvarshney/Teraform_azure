variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
  default     = "qa-rg"
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "East US"
}
variable "env" {
  description = "ENvirnment"
  type        = string
  default     = "QA"
}
