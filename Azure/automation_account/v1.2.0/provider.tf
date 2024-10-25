terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.33.0"
      configuration_aliases = [azurerm.key_vault_sub, azurerm.automation_account_sub, azurerm.user_assigned_identity_sub]
    }
  }
}