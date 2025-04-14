resource "azurerm_public_ip" "vm_public_ip" {
  name                = "${var.env_name}-pip-${var.vm_index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Basic"
  tags                = var.tags
}

resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.env_name}-nic-${var.vm_index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "${var.env_name}-ipconfig-${var.vm_index}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.env_name}-vm-${var.vm_index}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  vm_size               = var.vm_size

  storage_os_disk {
    name              = "${var.env_name}-osdisk-${var.vm_index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = var.os_disk_size
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${var.env_name}-vm-${var.vm_index}"
    admin_username = "azureuser"
    admin_password = "P@ssw0rd1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = var.tags
}
