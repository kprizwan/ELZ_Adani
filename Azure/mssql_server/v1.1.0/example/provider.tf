terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.9.0"
      configuration_aliases = [azurerm.key_vault_sub, azurerm.mssql_server_sub]
    }
    azuread = {
      source                = "hashicorp/azuread"
      version               = "2.29.0"
      configuration_aliases = [azuread.azuread_tenant_id]
    }
  }
}

provider "azurerm" {
  alias = "key_vault_sub"
  features {}
  use_msi         = false
  subscription_id = var.key_vault_subscription_id
  tenant_id       = var.key_vault_tenant_id
}

provider "azurerm" {
  alias = "mssql_server_sub"
  features {}
  use_msi         = false
  subscription_id = var.mssql_server_subscription_id
  tenant_id       = var.mssql_server_tenant_id
}

provider "azuread" {
  alias     = "azuread_tenant_id"
  use_msi   = false
  tenant_id = var.azuread_tenant_id
}


