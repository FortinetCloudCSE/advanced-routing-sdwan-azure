resource "azurerm_network_interface" "linuxvm-hub1spoke2-nic1" {
  name                = "linuxvm-hub1spoke2-nic1"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.resourcegroup.name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.hub1spoke2-subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linuxvm-hub1-spoke2" {
  name                = "linuxvm-hub1spoke2"
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.linuxvm-hub1spoke2-nic1.id,
  ]

  admin_password = "test-password123$"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  disable_password_authentication = false
}