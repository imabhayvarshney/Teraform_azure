variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
  default     = "prod-rg"
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable env {
  description = "Environement"
  type        = string
}

variable "nsg_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "The values for each NSG rule "
} 

variable "storageaccount" {
  description = "storageaccount name"
  type        = string
}
variable "containername" {
  description = "containername"
  type        = string
}

/*
az login 
az account show
az group create --name myResourceGroup --location eastus
az storage account create --name strepamaccount --resource-group myResourceGroup --location eastus --sku Standard_LRS
az storage container create --name contproepam --account-name strepamaccount --resource-group myResourceGroup
az storage container create --name qacontepam --account-name strepamaccount --resource-group myResourceGroup

terraform init -backend-config="key=qa/terraform.tfstate" 

terraform plan -var-file="qaterraform.tfvars " 
terraform apply -var-file="qaterraform.tfvars" --auto-approve
*/