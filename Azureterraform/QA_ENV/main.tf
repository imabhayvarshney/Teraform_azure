terraform {
  backend "azurerm" {
    resource_group_name   = "myResourceGroup"
    storage_account_name  = "strepamaccount"
    container_name        = "qaepamcontainer"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "network" {
  source              = "../module/network"
  resource_group_name = var.resource_group_name
  location            = var.location
  env                 = var.env
}

module "security" {
  source              = "../module/security"
  resource_group_name = "${var.resource_group_name}"
  location            = var.location
  env                 = var.env
}

module "compute" {
  source              = "../module/compute"
  resource_group_name ="${var.resource_group_name}"
  location            = var.location
  #vnetwork_interface_id           = "${module.network.public_nic}"
  vnicpublicid        = "${module.network.public_nic}"
  vnicprivateid       = "${module.network.private_nic}"
  env                 = var.env
}



resource "azurerm_network_security_rule" "http" {
  name                        = "Allow_HTTP"
  priority                    = 1003
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${module.security.nsg_name}"
  #network_security_group_name = azurerm_network_security_group.example.name
}
