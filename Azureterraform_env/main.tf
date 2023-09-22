terraform {
  backend "azurerm" {
    /*resource_group_name   = "myResourceGroup"
    #storage_account_name  = "${var.storageaccount}"
    #container_name        = "${var.containername}"
    storage_account_name  = "strepamaccount"
    container_name        = "contepam12task"
    key                   = ""*/
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_key_vault" "mytaskkvepam" {
  name                = "mytaskkvepam"
  resource_group_name = "myResourceGroup"
}
data "azurerm_key_vault_secret" "vm_username" {
  name         = "secret1" 
  key_vault_id = data.azurerm_key_vault.mytaskkvepam.id 
}
data "azurerm_key_vault_secret" "vm_password" {
  name         = "secret2" 
  key_vault_id = data.azurerm_key_vault.mytaskkvepam.id 
}

module "resource_group" {
  source              = "./module/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "network" {
  source              = "./module/network"
  resource_group_name = "${module.resource_group.name}"
  depends_on          = [module.resource_group]
  location            = var.location
  env                 = var.env
}

module "security" {
  source              = "./module/security"
  resource_group_name = "${module.resource_group.name}"
  location            = var.location
  depends_on          = [module.network]
  nsg_rules           = var.nsg_rules
  subnetid            = "${module.network.public_subnet_id}"   
  network_interface_id=  "${module.network.public_nic}"  
  env                 = var.env
}

module "compute" {
  source              = "./module/compute"
  resource_group_name =  "${module.resource_group.name}"
  location            = var.location
  depends_on          = [module.network]
  #vnetwork_interface_id           = "${module.network.public_nic}"
  vnicpublicid       = "${module.network.public_nic}"
  vnicprivateid       = "${module.network.private_nic}"
  env                 = var.env
  username            = data.azurerm_key_vault_secret.vm_username.value
  password            = data.azurerm_key_vault_secret.vm_password.value
}

