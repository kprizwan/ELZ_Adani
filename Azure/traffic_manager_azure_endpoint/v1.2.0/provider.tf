terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.33.0"
      configuration_aliases = [azurerm.traffic_manager_sub, azurerm.target_resource_sub]
    }
  }
}