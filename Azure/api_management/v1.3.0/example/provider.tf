terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.75.0"
    }
  }
}

# CONFIGURE THE MICROSOFT AZURE PROVIDER
provider "azurerm" {
  alias = "api_management_sub"
  features {}
  subscription_id = var.api_management_subscription_id
  tenant_id       = var.api_management_tenant_id
}

#CONFIGURE THE MICROSOFT AZURE PROVIDER
provider "azurerm" {
  alias = "key_vault_sub"
  features {}
  subscription_id = var.key_vault_subscription_id
  tenant_id       = var.key_vault_tenant_id
}