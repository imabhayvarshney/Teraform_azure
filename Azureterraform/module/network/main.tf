resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "example" {
  name                = "${var.env}-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
}

# Define subnets and other network resources here.
resource "azurerm_subnet" "public" {
  name                 = "${var.env}-public"
  resource_group_name  =  azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]

}

resource "azurerm_subnet" "private" {
  name                 = "${var.env}-private"
  resource_group_name  =  azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]

}

resource "azurerm_public_ip" "example" {
  name                = "${var.env}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "public" {
  name                = "${var.env}-public-nic"
  location            = "${var.location}"
  resource_group_name =  "${var.resource_group_name}"
  ip_configuration {
    name                          = "${var.env}-public-ip-config"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id           = azurerm_public_ip.example.id
  }
}
resource "azurerm_network_interface" "private" {
  name                = "${var.env}-private-nic"
  location            = "${var.location}"
  resource_group_name =  "${var.resource_group_name}"
  ip_configuration {
    name                          = "${var.env}-private-ip-config"
    subnet_id                     = azurerm_subnet.private.id
    private_ip_address_allocation = "Dynamic"
  }
}

