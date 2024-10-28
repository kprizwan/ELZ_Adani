#Module call for metric alerts
module "metric_alerts" {
  source                         = "../"
  monitor_metric_alert_variables = var.monitor_metric_alert_variables
  providers = {
    azurerm.resource_tomonitor_sub   = azurerm.storage_account_sub
    azurerm.monitor_metric_alert_sub = azurerm.monitor_metric_alert_sub
  }
  depends_on = [
    module.storage_account,
    module.monitor_action_group
  ]
}

module "monitor_action_group" {
  source                         = "../../../monitor_action_group/v1.1.0"
  monitor_action_group_variables = var.monitor_action_group_variables
  providers = {
    azurerm = azurerm.action_group
  }
  depends_on = [module.resource_group]
}
module "storage_account" {
  source                    = "../../../storage_account/v1.1.0"
  storage_account_variables = var.storage_account_variables
  providers = {
    azurerm = azurerm.storage_account_sub
  }
  depends_on = [module.resource_group]
}

module "resource_group" {
  source = "../../../resource_group/v1.1.0"
  providers = {
    azurerm = azurerm.storage_account_sub
  }
  resource_group_variables = var.resource_group_variables
}
