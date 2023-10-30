resource "azurerm_network_interface_security_group_association" "windows_vm" {
  count                     = var.winvmnumber
  network_interface_id      = azurerm_network_interface.windows_vm.*.id[count.index]
  network_security_group_id = azurerm_network_security_group.main_nsg.id

  depends_on = [
    azurerm_network_security_group.main_nsg
  ]
}

resource "azurerm_network_interface" "windows_vm" {
  count               = var.winvmnumber
  name                = "windows-vm-${count.index}-NIC"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main_sn.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows_vm[count.index].id
  }

  depends_on = [
    azurerm_subnet.main_sn
  ]

  tags = {
    Environment = var.environment,
    Author = var.author,
    Time = "${local.now}"
  }

}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  count               = var.winvmnumber
  name                = "${var.win_compname}-${count.index}-${random_string.prefix.result}"
  resource_group_name = azurerm_resource_group.main_rg.name
  location            = azurerm_resource_group.main_rg.location
  size                = var.size
  admin_username      = var.user_name
  admin_password      = random_password.password.result
  provision_vm_agent  = true
  custom_data         = file("./scripts/winrm/winrm.ps1")
  network_interface_ids = [
    azurerm_network_interface.windows_vm[count.index].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.win_publisher
    offer     = var.win_offer
    sku       = var.win_sku
    version   = var.win_version
  }

  winrm_listener {
    protocol = "Http"
  }

  additional_unattend_content {
    setting = "FirstLogonCommands"
    content = file("./scripts/winrm/executioncmds.xml")
  }

  tags = {
    Environment = var.environment,
    Author = var.author,
    Time = "${local.now}"
  }

}

resource "azurerm_public_ip" "windows_vm" {
  count               = var.winvmnumber
  name                = "windows-vm-${count.index}-PublicIP"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  allocation_method   = "Dynamic"
  domain_name_label   = "vm-${count.index}-${random_string.prefix.result}"

  tags = {
    Environment = var.environment,
    Author = var.author,
    Time = "${local.now}"
  }

}
