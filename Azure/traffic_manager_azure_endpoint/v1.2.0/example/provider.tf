terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.33.0"
    }
  }
}

provider "azurerm" {
  alias   = "target_resource_sub"
  use_msi = false
  features {}
  subscription_id = var.target_resource_subscription_id
  tenant_id       = var.target_resource_tenant_id
}
provider "azurerm" {
  alias   = "traffic_manager_sub"
  use_msi = false
  features {}
  subscription_id = var.traffic_manager_subscription_id
  tenant_id       = var.traffic_manager_tenant_id
}