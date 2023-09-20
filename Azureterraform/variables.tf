variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
  default     = "prod-rg"
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "East US"
}

# Define other common variables here.
