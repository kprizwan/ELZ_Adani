#RESOURCE GROUP
module "resource_group" {
  source = "../../../resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.monitor_metric_alert_sub
  }
  resource_group_variables = var.resource_group_variables
}

#MONITOR ACTION GROUP
module "monitor_action_group" {
  providers = {
    azurerm.log_analytics_sub = azurerm.monitor_metric_alert_sub
    azurerm.function_app_sub  = azurerm.monitor_metric_alert_sub
    azurerm.action_group_sub  = azurerm.monitor_metric_alert_sub
    azurerm.logic_app_sub     = azurerm.monitor_metric_alert_sub
  }
  source                         = "../../../monitor_action_group/v1.3.0"
  monitor_action_group_variables = var.monitor_action_group_variables
  depends_on                     = [module.resource_group]
}

#STORAGE ACCOUNT
module "storage_account" {
  source                    = "../../../storage_account/v1.3.0"
  storage_account_variables = var.storage_account_variables
  providers = {
    azurerm.storage_account_sub = azurerm.resource_tomonitor_sub
    azurerm.key_vault_sub       = azurerm.resource_tomonitor_sub
  }
  depends_on = [module.resource_group]
}

#MONITOR METRIC ALERT
module "monitor_metric_alert" {
  source                         = "../"
  monitor_metric_alert_variables = var.monitor_metric_alert_variables
  providers = {
    azurerm.resource_tomonitor_sub   = azurerm.resource_tomonitor_sub
    azurerm.monitor_metric_alert_sub = azurerm.monitor_metric_alert_sub
  }
  depends_on = [module.storage_account, module.monitor_action_group]
}
