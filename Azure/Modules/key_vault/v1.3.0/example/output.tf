#KEY VAULT OUTPUT VALUES
output "key_vault_output" {
  value       = module.key_vault.key_vault_output
  description = "key vault output values"
}
