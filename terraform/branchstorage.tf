resource "random_id" "branch_random" {
  for_each = data.azurerm_resource_group.resourcegroup
  keepers = {
    resource_group = each.value.name
  }

  byte_length = 8
}

resource "azurerm_storage_account" "branchfgtstorageaccount" {
  for_each                 = data.azurerm_resource_group.resourcegroup
  name                     = "diag${random_id.branch_random[each.key].hex}"
  resource_group_name      = each.value.name
  location                 = each.value.location
  account_replication_type = "LRS"
  account_tier             = "Standard"
}