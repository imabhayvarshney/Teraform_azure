resource "azurerm_windows_virtual_machine" "public_vm" {
  name                  = "${var.env}-public-vm"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = ["${var.vnicpublicid}"]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

# Define the private virtual machine
resource "azurerm_windows_virtual_machine" "private_vm" {
  name                  = "${var.env}-private-vm"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = ["${var.vnicprivateid}"]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}