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
  alias = "cosmos_db_account_sub"
  features {}
  use_msi         = false # make it false while running terraform plan
  subscription_id = var.cosmos_db_account_subscription_id
  tenant_id       = var.cosmos_db_account_tenant_id
}

provider "azurerm" {
  alias = "key_vault_sub"
  features {}
  use_msi         = false # make it false while running terraform plan
  subscription_id = var.key_vault_subscription_id
  tenant_id       = var.key_vault_tenant_id
}