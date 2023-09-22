terraform {
  backend "azurerm" {
    resource_group_name   = "myResourceGroup"
    #storage_account_name  = "${var.storageaccount}"
    #container_name        = "${var.containername}"
    storage_account_name  = "strepamaccount"
    container_name        = "qacontepam"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "network" {
  source              = "./module/network"
  resource_group_name = var.resource_group_name
  location            = var.location
  env                 = var.env
}

module "security" {
  source              = "./module/security"
  resource_group_name = var.resource_group_name
  location            = var.location
  depends_on          = [module.network]
  nsg_rules           = var.nsg_rules
  env                 = var.env
}

module "compute" {
  source              = "./module/compute"
  resource_group_name = var.resource_group_name
  location            = var.location
  depends_on          = [module.network]
  #vnetwork_interface_id           = "${module.network.public_nic}"
  vnicpublicid       = "${module.network.public_nic}"
  vnicprivateid       = "${module.network.private_nic}"
  env                 = var.env
}

