terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.9.0"
      configuration_aliases = [azurerm.key_vault_sub, azurerm.api_management_sub, azurerm.user_assigned_identity_sub, azurerm.windows_web_app_sub, azurerm.storage_account_sub, azurerm.virtual_network_sub]
    }
  }
}