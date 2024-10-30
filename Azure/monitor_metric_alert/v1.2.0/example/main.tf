#MODULE CALL FOR RESOURCE GROUP
module "resource_group" {
  source = "../../../resource_group/v1.2.0"
  providers = {
    azurerm = azurerm.monitor_metric_alert_sub
  }
  resource_group_variables = var.resource_group_variables
}

#TARGET RESOURCE RESOURCE GROUP
module "target_resource_group" {
  source = "../../../resource_group/v1.2.0"
  providers = {
    azurerm = azurerm.resource_tomonitor_sub
  }
  resource_group_variables = var.target_resource_group_variables
}

#MODULE CALL FOR MONITOR ACTION GROUP
module "monitor_action_group" {
  source                         = "../../../monitor_action_group/v1.2.0"
  monitor_action_group_variables = var.monitor_action_group_variables
  providers = {
    azurerm = azurerm.monitor_metric_alert_sub
  }
  depends_on = [module.resource_group]
}

#MODULE CALL FOR STORAGE ACCOUNT
module "storage_account" {
  source                    = "../../../storage_account/v1.2.0"
  storage_account_variables = var.storage_account_variables
  providers = {
    azurerm.storage_account_sub = azurerm.resource_tomonitor_sub
    azurerm.key_vault_sub       = azurerm.resource_tomonitor_sub
  }
  depends_on = [module.resource_group]
}

#MODULE CALL FOR METRIC ALERTS
module "metric_alerts" {
  source                         = "../"
  monitor_metric_alert_variables = var.monitor_metric_alert_variables
  providers = {
    azurerm.resource_tomonitor_sub   = azurerm.resource_tomonitor_sub
    azurerm.monitor_metric_alert_sub = azurerm.monitor_metric_alert_sub
  }
  depends_on = [module.storage_account, module.monitor_action_group]
}