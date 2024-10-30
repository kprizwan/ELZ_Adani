terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.9.0"
      configuration_aliases = [azurerm.traffic_manager_sub, azurerm.public_ip_sub]
    }
  }
}