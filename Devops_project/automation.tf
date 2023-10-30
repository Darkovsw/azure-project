# resource "azurerm_automation_account" "automationaccmain" {
#   name                = "example-account"
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name
#   sku_name            = "Basic"

#   tags = {
#     environment = "development"
#   }
# }

# data "azurerm_subscription" "primary" {
# }

# data "azurerm_client_config" "example" {
# }

# resource "azurerm_role_assignment" "assign_owner_role" {
#   principal_id   = azurerm_automation_account.automationaccmain.identity[0].principal_id
#   role_definition_name = "Owner"
#   scope         = azurerm_automation_account.automationaccmain.id

#     depends_on = [
#         azurerm_automation_account.automationaccmain
#   ]
# }

# resource "azurerm_automation_runbook" "start_vm" {
#   name                    = "Start-VMs"
#   location                = azurerm_resource_group.main_rg.location
#   resource_group_name     = azurerm_resource_group.main_rg.name
#   automation_account_name = azurerm_automation_account.automationaccmain.id
#   content                 = file("./scripts/powershell/start-vm.ps1")
#   runbook_type            = "PowerShell"
#   log_verbose             = "true"
#   log_progress            = "true"

#       depends_on = [
#         azurerm_automation_account.automationaccmain,
#         azurerm_role_assignment.assign_owner_role
#   ]
# }

# resource "azurerm_automation_schedule" "start_vm_schedule" {
#   name                    = "StartVMsSchedule"
#   resource_group_name     = azurerm_resource_group.main_rg.name
#   automation_account_name = azurerm_automation_account.automationaccmain.name
#   description             = "Schedule to start VMs"
#   timezone                = "Europe/Warsaw"
#   start_time              = "2023-10-29T08:00:00+00:00" # Replace with your start time
#   frequency               = "Day"
#   interval                = 1
#   week_days               = ["Friday"]

#     depends_on = [
#         azurerm_automation_account.automationaccmain,
#         azurerm_role_assignment.assign_owner_role
#   ]
# }
