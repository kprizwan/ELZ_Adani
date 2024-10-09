output "backup_policy_vm_output" {
  description = "The Id's of the Backup Policy"
  value = { for k, v in azurerm_backup_policy_vm.backup_policy_vm : k => {
    id = v.id
    }
  }
}