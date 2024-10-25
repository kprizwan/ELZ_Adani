terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.9.0"
      configuration_aliases = [azurerm.key_vault_sub, azurerm.storage_account_sub, azurerm.linux_web_app_sub]
    }
  }
}

