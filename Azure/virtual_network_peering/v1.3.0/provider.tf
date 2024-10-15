terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.75.0"
      configuration_aliases = [azurerm.source_virtual_network_sub, azurerm.destination_virtual_network_sub]
    }
  }
}