output "storageaccountname" {
  description = "ID of the virtual network."
  value       = azurerm_storage_account. mystorageaccount.name
}

output "containername" {
  description = "ID of the virtual network."
  value       = azurerm_storage_container.mystoragecontainer.name
}