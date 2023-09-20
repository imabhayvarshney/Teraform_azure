provider "azurerm" {
  features {}
}

module "network" {
  source              = "./module/network"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "security" {
  source              = "./module/security"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "compute" {
  source              = "./module/compute"
  resource_group_name = var.resource_group_name
  location            = var.location
  #vnetwork_interface_id           = "${module.network.public_nic}"
  vnicpublicid       = "${module.network.public_nic}"
  vnicprivateid       = "${module.network.private_nic}"
}

