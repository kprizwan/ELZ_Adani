output "automation_account_ids" {
  value = { for k, v in azurerm_automation_account.automation_account : k => v.id }
}
