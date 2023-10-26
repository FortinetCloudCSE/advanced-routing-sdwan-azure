resource "azurerm_route_table" "protected-rt" {
  for_each            = data.azurerm_resource_group.resourcegroup
  depends_on          = [azurerm_virtual_machine.fgtvm]
  name                = "Protected-Branch_RT"
  location            = each.value.location
  resource_group_name = each.value.name
}

resource "azurerm_route" "default" {
  for_each               = data.azurerm_resource_group.resourcegroup
  name                   = "default"
  resource_group_name    = each.value.name
  route_table_name       = azurerm_route_table.protected-rt[each.key].name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_network_interface.fgtport2[each.key].private_ip_address
}

resource "azurerm_subnet_route_table_association" "protectedassociate" {
  for_each       = azurerm_route_table.protected-rt
  subnet_id      = azurerm_subnet.protectedsubnet[each.key].id
  route_table_id = azurerm_route_table.protected-rt[each.key].id
}