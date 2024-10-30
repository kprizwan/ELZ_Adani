terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.9.0"
      configuration_aliases = [azurerm.key_vault_sub, azurerm.postgresql_server_sub, azurerm.storage_account_sub]
    }
  }
}

provider "azurerm" {
  alias = "postgresql_server_sub"
  features {}
  use_msi         = false
  subscription_id = var.postgresql_server_subscription_id
  tenant_id       = var.postgresql_server_tenant_id
}

provider "azurerm" {
  alias = "key_vault_sub"
  features {}
  use_msi         = false
  subscription_id = var.key_vault_subscription_id
  tenant_id       = var.key_vault_tenant_id
}

provider "azurerm" {
  alias = "storage_account_sub"
  features {}
  use_msi         = false
  subscription_id = var.storage_account_subscription_id
  tenant_id       = var.storage_account_tenant_id
}

