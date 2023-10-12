###################### Generate Random String ######################
resource "random_string" "random" {
  length           = 6
  special          = false
  lower            = true
  upper            = false
}

###################### ResourceGroup ######################
data "azurerm_resource_group" "resourcegroup" {
  name     = "${var.username}-training"
}



