resource "azurerm_storage_account" "mystorageaccount" {
    name                = "yufangstorageaccount"
    resource_group_name = "${var.resource_group_name}"
    location            = "${var.location}"
    account_type        = "Standard_LRS"

    tags {
        environment = "Terraform Demo"
    }
}

resource "azurerm_storage_container" "mystoragecontainer" {
  name                  = "vhds"
  resource_group_name   = "${var.resource_group_name}"
  storage_account_name  = "${azurerm_storage_account.mystorageaccount.name}"
  container_access_type = "private"
}