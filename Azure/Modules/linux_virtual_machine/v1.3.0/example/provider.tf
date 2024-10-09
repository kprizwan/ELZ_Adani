terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.75.0"
      configuration_aliases = [azurerm.linux_vm_sub, azurerm.key_vault_sub, azurerm.gallery_sub]
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.29.0"
    }
  }
}

#CONFIGURE THE MICROSOFT AZURE PROVIDER
provider "azurerm" {
  alias = "linux_vm_sub"
  features {}
  subscription_id = var.linux_vm_subscription_id
  tenant_id       = var.linux_vm_tenant_id
}

provider "azurerm" {
  alias = "key_vault_sub"
  features {}
  subscription_id = var.key_vault_subscription_id
  tenant_id       = var.key_vault_tenant_id
}

provider "azurerm" {
  alias = "gallery_sub"
  features {}
  use_msi         = false
  subscription_id = var.gallery_subscription_id
  tenant_id       = var.gallery_tenant_id
}
