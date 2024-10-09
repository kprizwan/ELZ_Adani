#KEY VAULT OUTPUT VALUES
output "key_vault_output" {
  value = { for k, v in azurerm_key_vault.keyvault : k => {
    id        = v.id
    vault_uri = v.vault_uri
    }
  }
  description = "key vault output values"
}
