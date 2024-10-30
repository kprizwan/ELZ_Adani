output "recovery_services_vault_ids" {
  description = "The ID of the Recovery Services Vault"
  value       = { for k, v in azurerm_recovery_services_vault.recovery_service_vault : k => v.id }
}
