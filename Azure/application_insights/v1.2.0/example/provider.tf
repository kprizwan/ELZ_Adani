terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.33.0"
    }
  }
}
# Configure the Microsoft Azure Provider
provider "azurerm" {
  alias = "application_insights_sub"
  features {}
  subscription_id = var.application_insights_subscription_id
  tenant_id       = var.application_insights_tenant_id
}
provider "azurerm" {
  alias = "log_analytics_sub"
  features {}
  subscription_id = var.log_analytics_subscription_id
  tenant_id       = var.log_analytics_tenant_id
}
provider "azurerm" {
  alias = "keyvault_sub"
  features {}
  subscription_id = var.keyvault_subscription_id
  tenant_id       = var.keyvault_tenant_id
}
