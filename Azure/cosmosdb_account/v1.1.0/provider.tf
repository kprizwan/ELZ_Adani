terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.9.0"
      configuration_aliases = [azurerm.cosmos_db_account_sub, azurerm.key_vault_sub]
    }
  }
}
