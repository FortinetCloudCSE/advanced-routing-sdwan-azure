resource "azurerm_virtual_wan" "vwan" {
  for_each            = data.azurerm_resource_group.resourcegroup
  name                = "${each.key}-${each.value.location}_VWAN"
  resource_group_name = each.value.name
  location            = each.value.location
}

resource "azurerm_virtual_hub" "vhub" {
  for_each            = data.azurerm_resource_group.resourcegroup
  name                = "vHub1_${each.value.location}_VHUB"
  resource_group_name = each.value.name
  location            = each.value.location
  virtual_wan_id      = azurerm_virtual_wan.vwan[each.key].id
  address_prefix      = "10.1.0.0/16"
}

