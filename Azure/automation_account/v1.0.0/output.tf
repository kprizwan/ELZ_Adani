output "automation_account_id" {
    value = {for k,v in azurerm_automation_account.automation_account: k => v.id}
}

output "identity" {
    value = {for k,v in azurerm_automation_account.automation_account: k => v.identity}
}