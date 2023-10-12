// Create Virtual Network

resource "azurerm_virtual_network" "fgtvnetwork" {
  name                = "fgtvnetwork"
  address_space       = "[172.31.1.0/24]"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
}

resource "azurerm_subnet" "publicsubnet" {
  name                 = "publicSubnet"
  resource_group_name  = data.azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.fgtvnetwork.name
  address_prefixes     = "[172.31.1.0/28]"
}

resource "azurerm_subnet" "privatesubnet" {
  name                 = "privateSubnet"
  resource_group_name  = data.azurerm_resource_group.resourcegroupgroup.name
  virtual_network_name = azurerm_virtual_network.fgtvnetwork.name
  address_prefixes     = "[172.31.1.16/28]"
}

resource "azurerm_subnet" "protectedsubnet" {
  name                 = "protectedSubnet"
  resource_group_name  = data.azurerm_resource_group.resourcegroupgroup.name
  virtual_network_name = azurerm_virtual_network.fgtvnetwork.name
  address_prefixes     = "[172.31.1.32/28]"
}

// Allocated Public IP
resource "azurerm_public_ip" "FGTPublicIp" {
  name                = "FGTPublicIP"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.resourcegroupgroup.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

//  Network Security Group
resource "azurerm_network_security_group" "publicnetworknsg" {
  name                = "PublicNetworkSecurityGroup"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.resourcegroupgroup.name

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
  name                = "PrivateNetworkSecurityGroup"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.resourcegroupgroup.name

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
  name                        = "egress"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.myterraformgroup.name
  network_security_group_name = azurerm_network_security_group.publicnetworknsg.name
}

resource "azurerm_network_security_rule" "outgoing_private" {
  name                        = "egress-private"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.myterraformgroup.name
  network_security_group_name = azurerm_network_security_group.privatenetworknsg.name
}

// FGT Network Interface port1
resource "azurerm_network_interface" "fgtport1" {
  name                = "fgtport1"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.resourcegroupgroup.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.publicsubnet.id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    public_ip_address_id          = azurerm_public_ip.FGTPublicIp.id
  }
}

resource "azurerm_network_interface" "fgtport2" {
  name                 = "fgtport2"
  location             = var.location
  resource_group_name  = data.azurerm_resource_group.resourcegroupgroup.name
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.privatesubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}


# Connect the security group to the network interfaces
resource "azurerm_network_interface_security_group_association" "port1nsg" {
  depends_on                = [azurerm_network_interface.fgtport1]
  network_interface_id      = azurerm_network_interface.fgtport1.id
  network_security_group_id = azurerm_network_security_group.publicnetworknsg.id
}

resource "azurerm_network_interface_security_group_association" "port2nsg" {
  depends_on                = [azurerm_network_interface.fgtport2]
  network_interface_id      = azurerm_network_interface.fgtport2.id
  network_security_group_id = azurerm_network_security_group.privatenetworknsg.id
}