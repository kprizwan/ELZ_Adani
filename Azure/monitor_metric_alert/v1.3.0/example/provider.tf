terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.75.0"
    }
  }
}

# CONFIGURE THE MICROSOFT AZURE PROVIDER
provider "azurerm" {
  features {}
  alias           = "resource_tomonitor_sub"
  subscription_id = var.resource_tomonitor_sub_subscription_id
  tenant_id       = var.resource_tomonitor_sub_tenant_id
}

provider "azurerm" {
  features {}
  alias           = "monitor_metric_alert_sub"
  subscription_id = var.monitor_metric_alert_sub_subscription_id
  tenant_id       = var.monitor_metric_alert_sub_tenant_id

}
