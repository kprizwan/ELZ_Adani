terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.33.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  alias = "windows_web_app_sub"
  features {}
  use_msi         = false
  subscription_id = var.windows_web_app_sub_subscription_id
  tenant_id       = var.windows_web_app_sub_tenant_id
}
provider "azurerm" {
  alias = "storage_account_sub"
  features {}
  use_msi         = false
  subscription_id = var.storage_account_sub_subscription_id
  tenant_id       = var.storage_account_sub_tenant_id
}
provider "azurerm" {
  alias = "key_vault_sub"
  features {}
  use_msi         = false
  subscription_id = var.key_vault_sub_subscription_id
  tenant_id       = var.key_vault_sub_tenant_id
}