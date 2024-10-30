#AUTOMATION ACCOUNT OUTPUT
output "automation_account_output" {
  description = "automation account output values"
  value = { for k, v in azurerm_automation_account.automation_account : k => {
    id = v.id
    }
  }
}