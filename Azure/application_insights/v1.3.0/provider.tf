terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "3.75.0"
      configuration_aliases = [azurerm.application_insights_sub, azurerm.keyvault_sub, azurerm.log_analytics_sub]
    }
  }
}