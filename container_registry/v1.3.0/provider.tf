terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "3.75.0"
      configuration_aliases = [azurerm.key_vault_sub, azurerm.container_registry_sub]
    }
  }
}