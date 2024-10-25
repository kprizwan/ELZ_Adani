terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.33.0"
      configuration_aliases = [azurerm.snapshot_sub, azurerm.key_vault_sub, azurerm.storage_account_sub]
    }
  }
}
