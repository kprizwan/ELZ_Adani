#DATA BLOCK TO FETCH KEYVAULT ID
data "azurerm_key_vault" "log_analytics_workspace_keys_key_vault_id" {
  provider            = azurerm.keyvault_sub
  for_each            = var.application_insights_variables
  name                = each.value.application_insights_key_vault_name
  resource_group_name = each.value.application_insights_key_vault_resource_group_name
}
#LOG ANALYTICS WORKSPACE
data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  provider            = azurerm.log_analytics_sub
  for_each            = var.application_insights_variables
  name                = each.value.application_insights_log_analytics_workspace_name
  resource_group_name = each.value.application_insights_log_analytics_workspace_resource_group_name
}
#Application Insights
resource "azurerm_application_insights" "application_insights" {
  provider                              = azurerm.application_insights_sub
  for_each                              = var.application_insights_variables
  name                                  = each.value.application_insights_name
  resource_group_name                   = each.value.application_insights_resource_group_name
  location                              = each.value.application_insights_location
  application_type                      = each.value.application_insights_application_type
  daily_data_cap_in_gb                  = each.value.application_insights_daily_data_cap_in_gb
  daily_data_cap_notifications_disabled = each.value.application_insights_daily_data_cap_notifications_disabled
  retention_in_days                     = each.value.application_insights_retention_in_days
  sampling_percentage                   = each.value.application_insights_sampling_percentage
  disable_ip_masking                    = each.value.application_insights_disable_ip_masking
  workspace_id                          = data.azurerm_log_analytics_workspace.log_analytics_workspace[each.key].id
  local_authentication_disabled         = each.value.application_insights_local_authentication_disabled
  internet_ingestion_enabled            = each.value.application_insights_internet_ingestion_enabled
  internet_query_enabled                = each.value.application_insights_internet_query_enabled
  force_customer_storage_for_profiler   = each.value.application_insights_force_customer_storage_for_profiler
  tags                                  = merge(each.value.application_insights_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}
#APPLICATION INSIGHTS INSTRUMENTATION KEY SECRET
resource "azurerm_key_vault_secret" "application_insights_instrumentation_key" {
  provider     = azurerm.keyvault_sub
  for_each     = var.application_insights_variables
  name         = each.value.application_insights_instrumentation_key_vault_secret_name
  value        = azurerm_application_insights.application_insights[each.key].instrumentation_key
  key_vault_id = data.azurerm_key_vault.log_analytics_workspace_keys_key_vault_id[each.key].id
}
#APPLICATION INSIGHTS CONNECTION STRING KEY SECRET
resource "azurerm_key_vault_secret" "application_insights_connection_string" {
  provider     = azurerm.keyvault_sub
  for_each     = var.application_insights_variables
  name         = each.value.application_insights_connection_string_key_vault_secret_name
  value        = azurerm_application_insights.application_insights[each.key].connection_string
  key_vault_id = data.azurerm_key_vault.log_analytics_workspace_keys_key_vault_id[each.key].id
}
