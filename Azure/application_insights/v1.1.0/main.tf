#LOG ANALYTICS WORKSPACE
data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  for_each            = var.application_insights_variables
  name                = each.value.workspace_id
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_application_insights" "appinsight" {
  for_each                              = var.application_insights_variables
  name                                  = each.value.application_insights_name
  resource_group_name                   = each.value.resource_group_name
  location                              = each.value.application_insights_location
  workspace_id                          = data.azurerm_log_analytics_workspace.log_analytics_workspace[each.key].id
  application_type                      = each.value.application_type
  retention_in_days                     = each.value.retention_in_days
  disable_ip_masking                    = each.value.disable_ip_masking
  daily_data_cap_in_gb                  = each.value.daily_data_cap_in_gb
  daily_data_cap_notifications_disabled = each.value.daily_data_cap_notifications_disabled
  sampling_percentage                   = each.value.sampling_percentage
  local_authentication_disabled         = each.value.local_authentication_disabled
  internet_ingestion_enabled            = each.value.internet_ingestion_enabled
  internet_query_enabled                = each.value.internet_query_enabled
  force_customer_storage_for_profiler   = each.value.force_customer_storage_for_profiler
  tags                                  = merge(each.value.application_insights_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}
