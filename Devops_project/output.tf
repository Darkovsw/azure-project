resource "local_file" "Windows_Ansible_Inventory" {
    content =  templatefile("./templates/inventory-win.tftpl",
        {
            WindowsMachinesIPs = "${join("\n", azurerm_public_ip.windows_vm.*.fqdn)}"
            login = "${var.user_name}"
            password = "${random_password.password.result}"
            filesharelogin       = "${join("\\", ["Azure", azurerm_storage_share.file_share.storage_account_name])}"
            filesharepassword    = "${azurerm_storage_account.main_storageacc.primary_access_key}"
            fileshareurl         = "${join("", ["\\\\", azurerm_storage_account.main_storageacc.name, ".file.core.windows.net\\", azurerm_storage_share.file_share.name])}"
            fileshareurlgetcred  = "${join("", [azurerm_storage_account.main_storageacc.name, ".file.core.windows.net\\", azurerm_storage_share.file_share.name])}"
        }
    )
    filename = "./inventory-windows"
}
