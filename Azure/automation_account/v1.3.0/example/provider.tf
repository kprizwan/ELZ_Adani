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
  alias = "key_vault_sub"
  features {}
  use_msi         = false
  subscription_id = var.key_vault_subscription_id
  tenant_id       = var.key_vault_tenant_id
}

#CONFIGURE THE MICROSOFT AZURE PROVIDER
provider "azurerm" {
  alias = "automation_account_sub"
  features {}
  use_msi         = false
  subscription_id = var.automation_account_subscription_id
  tenant_id       = var.automation_account_tenant_id
}

#CONFIGURE THE MICROSOFT AZURE PROVIDER
provider "azurerm" {
  alias = "user_assigned_identity_sub"
  features {}
  use_msi         = false
  subscription_id = var.user_assigned_identity_subscription_id
  tenant_id       = var.user_assigned_identity_tenant_id
}