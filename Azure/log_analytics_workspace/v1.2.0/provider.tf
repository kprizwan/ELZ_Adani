terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.33.0"
      configuration_aliases = [azurerm.log_analytics_sub, azurerm.keyvault_sub]
    }
  }
}
