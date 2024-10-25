terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.33.0"
    }
  }
}

provider "azurerm" {
  alias = "storage_account_sub"
  features {}
  use_msi         = false
  subscription_id = var.storage_account_subscription_id
  tenant_id       = var.storage_account_tenant_id
}

provider "azurerm" {
  alias = "key_vault_sub"
  features {}
  use_msi         = false
  subscription_id = var.key_vault_subscription_id
  tenant_id       = var.key_vault_tenant_id
}

provider "azurerm" {
  alias = "snapshot_sub"
  features {}
  use_msi         = false
  subscription_id = var.snapshot_subscription_id
  tenant_id       = var.snapshot_tenant_id
}