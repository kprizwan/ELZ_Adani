terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "3.75.0"
      configuration_aliases = [azurerm.private_endpoint_sub, azurerm.private_connection_sub]
    }
  }
}

provider "azurerm" {
  alias = "private_endpoint_sub"
  features {}
  use_msi         = false
  subscription_id = var.source_pvtendpoint_subscription_id
  tenant_id       = var.source_pvtendpoint_tenant_id
}

provider "azurerm" {
  alias = "private_connection_sub"
  features {}
  use_msi         = false
  subscription_id = var.destination_pvtendpoint_subscription_id
  tenant_id       = var.destination_pvtendpoint_tenant_id
}

provider "azurerm" {
  alias = "private_dns_zone_sub"
  features {}
  use_msi         = false
  subscription_id = var.private_dns_zone_subscription_id
  tenant_id       = var.private_dns_zone_tenant_id

}
