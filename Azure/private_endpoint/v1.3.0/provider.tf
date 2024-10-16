terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.75.0"
      configuration_aliases = [azurerm.private_endpoint_sub, azurerm.private_connection_sub, azurerm.private_dns_zone_sub]
    }
  }
}
