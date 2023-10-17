// Create Virtual Network

resource "azurerm_virtual_network" "fgtvnetwork" {
  for_each            = data.azurerm_resource_group.resourcegroup
  name                = "${each.value.name}-fgtvnetwork"
  address_space       = ["172.31.1.0/24"]
  location            = each.value.location
  resource_group_name = each.value.name
}

resource "azurerm_subnet" "publicsubnet" {
  for_each             = data.azurerm_resource_group.resourcegroup
  name                 = "${each.value.name}-publicSubnet"
  resource_group_name  = each.value.name
  virtual_network_name = azurerm_virtual_network.fgtvnetwork[each.key].name
  address_prefixes     = ["172.31.1.0/28"]
}

resource "azurerm_subnet" "privatesubnet" {
  for_each             = data.azurerm_resource_group.resourcegroup
  name                 = "${each.value.name}-privateSubnet"
  resource_group_name  = each.value.name
  virtual_network_name = azurerm_virtual_network.fgtvnetwork[each.key].name
  address_prefixes     = ["172.31.1.16/28"]
}

resource "azurerm_subnet" "protectedsubnet" {
  for_each             = data.azurerm_resource_group.resourcegroup
  name                 = "protectedSubnet"
  resource_group_name  = each.value.name
  virtual_network_name = azurerm_virtual_network.fgtvnetwork[each.key].name
  address_prefixes     = ["172.31.1.32/28"]
}

// Allocated Public IP
resource "azurerm_public_ip" "FGTPublicIp" {
  for_each            = data.azurerm_resource_group.resourcegroup
  name                = "FGTPublicIP"
  location            = var.location
  resource_group_name = each.value.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

//  Network Security Group
resource "azurerm_network_security_group" "publicnetworknsg" {
  for_each            = data.azurerm_resource_group.resourcegroup
  name                = "PublicNetworkSecurityGroup"
  location            = var.location
  resource_group_name = each.value.name

  security_rule {
    name                       = "TCP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "privatenetworknsg" {
  for_each            = data.azurerm_resource_group.resourcegroup
  name                = "PrivateNetworkSecurityGroup"
  location            = each.value.location
  resource_group_name = each.value.name

  security_rule {
    name                       = "All"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_rule" "outgoing_public" {
  for_each                    = data.azurerm_resource_group.resourcegroup
  name                        = "egress"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = each.value.name
  network_security_group_name = azurerm_network_security_group.publicnetworknsg[each.key].name
}

resource "azurerm_network_security_rule" "outgoing_private" {
  for_each                    = data.azurerm_resource_group.resourcegroup
  name                        = "egress-private"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = each.value.name
  network_security_group_name = azurerm_network_security_group.privatenetworknsg[each.key].name
}

// FGT Network Interface port1
resource "azurerm_network_interface" "fgtport1" {
  for_each            = data.azurerm_resource_group.resourcegroup
  name                = "fgtport1"
  location            = each.value.location
  resource_group_name = each.value.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.publicsubnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    public_ip_address_id          = azurerm_public_ip.FGTPublicIp[each.key].id
  }
}

resource "azurerm_network_interface" "fgtport2" {
  for_each             = data.azurerm_resource_group.resourcegroup
  name                 = "fgtport2"
  location             = each.value.location
  resource_group_name  = each.value.name
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.privatesubnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}


# Connect the security group to the network interfaces
resource "azurerm_network_interface_security_group_association" "port1nsg" {
  for_each                  = azurerm_network_interface.fgtport1
  network_interface_id      = azurerm_network_interface.fgtport1[each.key].id
  network_security_group_id = azurerm_network_security_group.publicnetworknsg[each.key].id
}

resource "azurerm_network_interface_security_group_association" "port2nsg" {
  for_each                  = azurerm_network_interface.fgtport1
  network_interface_id      = azurerm_network_interface.fgtport2[each.key].id
  network_security_group_id = azurerm_network_security_group.privatenetworknsg[each.key].id
}