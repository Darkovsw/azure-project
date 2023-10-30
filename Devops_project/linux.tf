resource "azurerm_network_interface_security_group_association" "linux_vm" {
  count                     = var.linvmnumber
  network_interface_id      = azurerm_network_interface.linux_vm.*.id[count.index]
  network_security_group_id = azurerm_network_security_group.main_nsg1.id
}

resource "azurerm_network_interface" "linux_vm" {
  count               = var.linvmnumber
  name                = "linux-vm-${var.linvmnumber}-NIC"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main_sn.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_vm[count.index].id
  }

  tags = {
    Environment = var.environment,
    Author = var.author,
    Time = "${local.now}"
  }
}

resource "tls_private_key" "linux_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "local_file" "linuxkey" {
  filename="linuxkey.pem"  
  content=tls_private_key.linux_key.private_key_pem 
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count               = var.linvmnumber
  name                = "linux-vm-${count.index}-Machine"
  resource_group_name = azurerm_resource_group.main_rg.name
  location            = azurerm_resource_group.main_rg.location
  size                = var.size
  admin_username      = var.lin_usrname
  computer_name  = var.computer_name
  network_interface_ids = [
    azurerm_network_interface.linux_vm[count.index].id,
  ]

  admin_ssh_key {
    username   = var.lin_usrname
    public_key = tls_private_key.linux_key.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.lin_publisher
    offer     = var.lin_offer
    sku       = var.lin_sku
    version   = var.lin_version
  }

  tags = {
    Environment = var.environment,
    Author = var.author,
    Time = "${local.now}"
  }

  depends_on = [
    azurerm_network_interface.linux_vm,
    tls_private_key.linux_key
  ]

}

resource "azurerm_public_ip" "linux_vm" {
  count               = var.linvmnumber
  name                = "linux-vm-${count.index}-PublicIP"
  resource_group_name = azurerm_resource_group.main_rg.name
  location            = azurerm_resource_group.main_rg.location
  allocation_method   = "Dynamic"

  tags = {
    Environment = var.environment,
    Author = var.author,
    Time = "${local.now}"
  }
}