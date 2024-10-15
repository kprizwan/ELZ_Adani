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
  alias = "source_virtual_network_sub"
  features {}
  use_msi         = false
  subscription_id = var.source_subscription_id
  tenant_id       = var.source_tenant_id
}

provider "azurerm" {
  alias = "destination_virtual_network_sub"
  features {}
  use_msi         = false
  subscription_id = var.destination_subscription_id
  tenant_id       = var.destination_tenant_id
}