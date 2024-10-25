output "automation_account_ids" {
  value = module.automation_account[*].automation_account_id
}

output "identity" {
  value = module.automation_account[*].identity
}


