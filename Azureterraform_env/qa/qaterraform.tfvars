storageaccount =  "strepamaccount"

containername = "prodepamcontainer"

location = "East US"

resource_group_name     = "qa-rg"

env = "qa"

nsg_rules = [
  {
    name                       = "Allowssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "AllowRDPIn"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]

/*
terraform plan -var-file="qaterraform.tfvars " 
terraform apply -var-file="qaterraform.tfvars" --auto-approve

*/