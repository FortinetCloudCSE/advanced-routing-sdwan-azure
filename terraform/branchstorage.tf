resource "random_id" "branch_random" {
  keepers = {
    resource_group = data.azurerm_resource_group.resourcegroup.name
  }

  byte_length = 8
}

resource "azurerm_storage_account" "branchfgtstorageaccount" {
  name                     = "diag${random_id.branch_random.hex}"
  resource_group_name      = data.azurerm_resource_group.resourcegroup.name
  location                 = var.location
  account_replication_type = "LRS"
  account_tier             = "Standard"
}