terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "3.33.0"
      configuration_aliases = [azurerm.logic_app_standard_sub, azurerm.key_vault_sub]
    }
  }
}