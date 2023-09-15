terraform {
    required_providers {
        azurerm  = {
            source = "hashicorp/azurerm"
            version = "~>2/88/1"
        }
    }
    required_version = ">=0.15"
}
provider "azurerm"{
    features {}
}

resource "azurerm_rg" "main" {
    name = ""
    location = ""
}

resource "azurerm_vnet" "main"{
    name = "vnet1"
    location = azurerm_rg.main.location
    rg_name = azurerm_rg.main.name 
    address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "main" {
    name = "learn-subnet"
    vnet_name = azurerm_vnet.main.name 
    sg_name = azurerm_rg.main.name
    address_prefix = ["10.0.0.0/24"]
}

resource "azurerm_nic" "internal" {
    name = "learn-nic"
    location = azurerm_rg.main.location
    rg_name = azurerm_rg.main.name

    ip_configuration {
        name = "internal"
        subnet_id = azurerm_subnet.main.id
        private_ip_address_allocation = "Dynamic"

    }
}

resource "azurerm_vm" "main"{
    name = "learn-vm"
    rg_name = azurerm_rg.main.name
    location = azurerm_rg.main.location
    size = "Standard_B1s"
    admin_username = "user.admin"
    admin_password = "Demopass12"

    network_interface_ids = [
        azurerm_nic.internal.id
    ]
    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_refrence {
        publisher = "MicrosftwindowsServer"
        offer = "WindowsServer"
        sku = "2016-DataCenter"
        version = "latest"

    }
}