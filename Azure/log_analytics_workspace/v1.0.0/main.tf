#LOG ANALYTICS WORKSPACE
resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  for_each                           = var.log_analytics_workspace_variables
  name                               = each.value.name
  location                           = each.value.location
  resource_group_name                = each.value.resource_group_name
  sku                                = each.value.sku
  retention_in_days                  = each.value.retention_in_days
  daily_quota_gb                     = each.value.sku == "Free" ? "0.5" : each.value.daily_quota_gb
  internet_ingestion_enabled         = each.value.internet_ingestion_enabled
  internet_query_enabled             = each.value.internet_query_enabled
  reservation_capacity_in_gb_per_day = each.value.sku == "CapacityReservation" ? each.value.reservation_capacity_in_gb_per_day : null
  tags                               = merge(each.value.log_analytics_workspace_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}
