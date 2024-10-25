output "recovery_service_vault_id" {
  value = { for k, v in azurerm_recovery_services_vault.recovery_service_vault : k => v.id }
}
