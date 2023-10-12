resource "azurerm_virtual_wan" "vwan" {
  name                = "${var.username}-vwan"
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  location            = var.location
}

resource "azurerm_virtual_hub" "vhub" {
  name                = "${var.username}-virtualhub"
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  location            = var.location
  virtual_wan_id      = azurerm_virtual_wan.vwan.id
  address_prefix      = "10.1.0.0/16"
}

