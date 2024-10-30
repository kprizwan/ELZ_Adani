terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.33.0"
      configuration_aliases = [azurerm.monitor_metric_alert_sub, azurerm.resource_tomonitor_sub]
    }
  }
}