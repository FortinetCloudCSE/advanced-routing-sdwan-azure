resource "azurerm_storage_account" "my_storage_account" {
  for_each                 = data.azurerm_resource_group.resourcegroup
  name                     = "${each.key}diag${random_string.random.id}"
  location                 = each.value.location
  resource_group_name      = each.value.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

