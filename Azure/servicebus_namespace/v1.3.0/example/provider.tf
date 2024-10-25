terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.75.0"
    }
  }
}

#CONFIGURE THE MICROSOFT AZURE PROVIDER
provider "azurerm" {
  features {}
}
