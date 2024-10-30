<<<<<<<< HEAD:Azure/virtual_network/v1.3.0/provider.tf
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.75.0"
    }
  }
========
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.9.0"
    }
  }
>>>>>>>> feature04-connectivity:Azure/application_insights/v1.1.0/provider.tf
}