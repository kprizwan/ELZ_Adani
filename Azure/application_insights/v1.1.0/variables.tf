variable "application_insights_variables" {
  type = map(object({
    application_insights_name             = string
    resource_group_name                   = string
    application_insights_location         = string
    workspace_id                          = string
    application_type                      = string
    retention_in_days                     = number
    disable_ip_masking                    = bool
    daily_data_cap_in_gb                  = number
    daily_data_cap_notifications_disabled = string
    sampling_percentage                   = number
    local_authentication_disabled         = bool
    internet_ingestion_enabled            = bool
    internet_query_enabled                = bool
    force_customer_storage_for_profiler   = bool
    application_insights_tags             = map(string)
  }))
}
