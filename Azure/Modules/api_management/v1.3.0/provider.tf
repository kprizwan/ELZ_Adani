terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.75.0"
      configuration_aliases = [azurerm.api_management_sub, azurerm.key_vault_sub]
    }
  }
}
