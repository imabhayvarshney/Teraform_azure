terraform {
   backend "azurerm" {
    resource_group_name   = "myResourceGroup"
    storage_account_name  = "strepamaccount"
    container_name        = "prodcontainer"
    key                   = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}




# Run the following command to create a Resource Group , Storage acnt & COntainer 
/*
az login 

az account show

az group create --name myResourceGroup --location eastus

az storage account create --name strepamaccount --resource-group myResourceGroup --location eastus --sku Standard_LRS

az storage container create --name prodcontainer --account-name strepamaccount --resource-group myResourceGroup

az storage container create --name qaepamcontainer --account-name strepamaccount --resource-group myResourceGroup

az storage container create --name terraformepamstate --account-name strepamaccount --account-key $(az storage account keys list --resource-group myResourceGroup --account-name strepamaccount --query '[0].value' --output tsv)

*/