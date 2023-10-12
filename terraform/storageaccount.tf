resource "azurerm_storage_account" "my_storage_account" {
  name                     = "diag${random_string.random.id}"
  location                 = var.location
  resource_group_name      = data.azurerm_resource_group.resourcegroup.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

