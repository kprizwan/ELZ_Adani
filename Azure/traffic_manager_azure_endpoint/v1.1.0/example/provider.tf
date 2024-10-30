terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.9.0"
    }
  }
}

provider "azurerm" {
  alias   = "public_ip_sub"
  use_msi = false
  features {}
  subscription_id = var.public_ip_subscription_id
  tenant_id       = var.public_ip_tenant_id
}
provider "azurerm" {
  alias   = "traffic_manager_sub"
  use_msi = false
  features {}
  subscription_id = var.traffic_manager_subscription_id
  tenant_id       = var.traffic_manager_tenant_id
}