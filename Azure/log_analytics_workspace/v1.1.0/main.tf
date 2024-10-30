#LOG ANALYTICS WORKSPACE
resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  for_each                           = var.log_analytics_workspace_variables
  name                               = each.value.log_analytics_workspace_name
  location                           = each.value.log_analytics_workspace_location
  resource_group_name                = each.value.log_analytics_workspace_resource_group_name
  sku                                = each.value.log_analytics_workspace_sku
  retention_in_days                  = each.value.log_analytics_workspace_retention_in_days
  daily_quota_gb                     = each.value.log_analytics_workspace_sku == "Free" ? "0.5" : each.value.log_analytics_workspace_daily_quota_gb
  internet_ingestion_enabled         = each.value.log_analytics_workspace_internet_ingestion_enabled
  internet_query_enabled             = each.value.log_analytics_workspace_internet_query_enabled
  reservation_capacity_in_gb_per_day = each.value.log_analytics_workspace_sku == "CapacityReservation" ? each.value.log_analytics_workspace_reservation_capacity_in_gb_per_day : null
  tags                               = merge(each.value.log_analytics_workspace_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}
