terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.9.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  alias = "servicebus_sub"
  features {}
  use_msi         = false
  subscription_id = var.servicebus_subscription_id
  tenant_id       = var.servicebus_tenant_id
}

provider "azurerm" {
  alias = "keyvault_sub"
  features {}
  use_msi         = false
  subscription_id = var.keyvault_subscription_id
  tenant_id       = var.keyvault_tenant_id
}