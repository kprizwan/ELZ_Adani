terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.9.0"
    }
  }
}

provider "azurerm" {
  alias = "user_assigned_identity_sub"
  features {}
  use_msi         = false
  subscription_id = var.user_assigned_identity_subscription_id
  tenant_id       = var.user_assigned_identity_tenant_id
}

provider "azurerm" {
  alias = "api_management_sub"
  features {}
  use_msi         = false
  subscription_id = var.api_management_subscription_id
  tenant_id       = var.api_management_tenant_id
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

provider "azurerm" {
  alias = "virtual_network_sub"
  features {}
  use_msi         = false
  subscription_id = var.virtual_network_subscription_id
  tenant_id       = var.virtual_network_tenant_id
}

provider "azurerm" {
  alias = "windows_web_app_sub"
  features {}
  use_msi         = false
  subscription_id = var.windows_web_app_subscription_id
  tenant_id       = var.windows_web_app_tenant_id
}