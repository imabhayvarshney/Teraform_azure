resource "azurerm_network_security_group" "example" {
  name                = "${var.env}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

 dynamic "security_rule" {
    for_each = var.nsg_rules
    content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
  }
  

}
resource "azurerm_subnet_network_security_group_association" "subnetnsg" {
  subnet_id                 = var.subnetid
  #network_interface_id      = var.nicpublicid 
  network_security_group_id = azurerm_network_security_group.example.id
}
resource "azurerm_network_interface_security_group_association" "nicnsg" {
  network_interface_id      = var.network_interface_id
  network_security_group_id = azurerm_network_security_group.example.id
}