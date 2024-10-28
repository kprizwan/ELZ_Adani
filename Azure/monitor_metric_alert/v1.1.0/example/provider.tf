terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.9.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  alias           = "storage_account_sub"
  subscription_id = var.storage_account_sub_subscription_id
  tenant_id       = var.storage_account_sub_tenant_id
}
provider "azurerm" {
  features {}
  alias           = "action_group"
  subscription_id = var.action_group_subscription_id
  tenant_id       = var.action_group_tenant_id
}

provider "azurerm" {
  features {}
  alias           = "monitor_metric_alert_sub"
  subscription_id = var.monitor_metric_alert_sub_subscription_id
  tenant_id       = var.monitor_metric_alert_sub_tenant_id

}