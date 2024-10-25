output "recovery_services_vault_output" {
  description = "Recovery Services Vault output values."
  value = { for k, v in azurerm_recovery_services_vault.recovery_services_vault : k => {
    id       = v.id
    identity = v.identity
    }
  }
}
