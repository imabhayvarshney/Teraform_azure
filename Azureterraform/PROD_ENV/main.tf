terraform {
  backend "azurerm" {
    resource_group_name   = "myResourceGroup"
    storage_account_name  = "strepamaccount"
    container_name        = "prodcontainer"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "network" {
  source              = "../module/network"
  resource_group_name = "example-resources"
  location            = "East US"
  env                 = var.env
}

module "security" {
  source              = "../module/security"
  resource_group_name = "example-resources"
  location            = "East US"
  env                 = var.env
}

module "compute" {
  source              = "../module/compute"
  resource_group_name = "example-resources"
  location            = "East US"
  #vnetwork_interface_id           = "${module.network.public_nic}"
  vnicpublicid       = "${module.network.public_nic}"
  vnicprivateid       = "${module.network.private_nic}"
  env                 = var.env
}

