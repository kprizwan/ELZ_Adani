#LOG ANALYTICS WORKSPACE VARIABLE
variable "log_analytics_workspace_variables" {
  type = map(object({
    log_analytics_workspace_name                               = string
    log_analytics_workspace_location                           = string
    log_analytics_workspace_resource_group_name                = string
    log_analytics_workspace_sku                                = string
    log_analytics_workspace_retention_in_days                  = number
    log_analytics_workspace_daily_quota_gb                     = number
    log_analytics_workspace_internet_ingestion_enabled         = bool
    log_analytics_workspace_internet_query_enabled             = bool
    log_analytics_workspace_reservation_capacity_in_gb_per_day = number
    log_analytics_workspace_tags                               = map(string)
  }))
}
