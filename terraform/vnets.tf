resource "azurerm_virtual_network" "hub1spoke1-vnet" {
  for_each            = data.azurerm_resource_group.resourcegroup
  name                = "Spoke1-vHub1_VNET"
  location            = each.value.location
  resource_group_name = each.value.name
  address_space       = ["192.168.1.0/24"]
}

resource "azurerm_subnet" "hub1spoke1-subnet1" {
  for_each             = data.azurerm_resource_group.resourcegroup
  name                 = "Subnet1-Spoke1_SUBNET"
  resource_group_name  = each.value.name
  virtual_network_name = azurerm_virtual_network.hub1spoke1-vnet[each.key].name
  address_prefixes     = ["192.168.1.0/24"]

}

resource "azurerm_virtual_network" "hub1spoke2-vnet" {
  for_each            = data.azurerm_resource_group.resourcegroup
  name                = "Spoke2-vHub1_VNET"
  location            = each.value.location
  resource_group_name = each.value.name
  address_space       = ["172.16.1.0/24"]
}

resource "azurerm_subnet" "hub1spoke2-subnet1" {
  for_each             = data.azurerm_resource_group.resourcegroup
  name                 = "Subnet1-Spoke2_SUBNET"
  resource_group_name  = each.value.name
  virtual_network_name = azurerm_virtual_network.hub1spoke2-vnet[each.key].name
  address_prefixes     = ["172.16.1.0/24"]
}