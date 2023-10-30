resource "azurerm_storage_account" "main_storageacc" {
  name                     = var.storageacc_name
  resource_group_name      = azurerm_resource_group.main_rg.name
  location                 = azurerm_resource_group.main_rg.location
  account_tier             = var.storageacc_tier
  account_replication_type = var.storageacc_replication

  tags = {
    Environment = var.environment,
    Author = var.author,
    Time = "${local.now}"
  }
}

resource "azurerm_storage_share" "file_share" {
  name                 = var.storageshare_name
  storage_account_name = azurerm_storage_account.main_storageacc.name
  quota                = var.storageshare_quota

  depends_on = [
    azurerm_windows_virtual_machine.windows_vm
  ]
}
