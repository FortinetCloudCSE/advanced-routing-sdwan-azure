resource "azurerm_route_table" "protected-rt" {
  depends_on          = [azurerm_virtual_machine.fgtvm]
  name                = "BranchFGT-Protected-RouteTable"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
}

resource "azurerm_route" "default" {
  name                   = "default"
  resource_group_name    = data.azurerm_resource_group.resourcegroup.name
  route_table_name       = azurerm_route_table.protected-rt.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_network_interface.fgtport2.private_ip_address
}

resource "azurerm_subnet_route_table_association" "protectedassociate" {
  depends_on     = [azurerm_route_table.protected-rt]
  subnet_id      = azurerm_subnet.potectedsubnet.id
  route_table_id = azurerm_route_table.protected-rt.id
}