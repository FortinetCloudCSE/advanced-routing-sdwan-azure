resource "azurerm_virtual_network" "hub1spoke1-vnet" {
  name                = "hub1spoke1-vnet"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  address_space       = ["192.168.1.0/24"]
}

resource "azurerm_subnet" "hub1spoke1-subnet1" {
  name                 = "hub1spoke1-subnet1"
  resource_group_name  = data.azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.hub1spoke1-vnet.name
  address_prefixes     = ["192.168.1.0/24"]

}

resource "azurerm_virtual_network" "hub1spoke2-vnet" {
  name                = "hub1spoke2-vnet"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  address_space       = ["172.16.1.0/24"]

}

resource "azurerm_subnet" "hub1spoke2-subnet1" {
  name                 = "hub1spoke2-subnet1"
  resource_group_name  = data.azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.hub1spoke2-vnet.name
  address_prefixes     = ["172.16.1.0/24"]

}