terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      /*version = "=3.9.0"*/
      version = ">=3.21"
    configuration_aliases = [azurerm.management]
    }
  }
}

