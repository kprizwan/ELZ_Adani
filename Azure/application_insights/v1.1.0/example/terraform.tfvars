#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000001"
    location = "westus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#LOG ANALYTICS WORKSPACE
log_analytics_workspace_variables = {
  "log_analytics_workspace_1" = {
    log_analytics_workspace_name                               = "ploceuslaw000001" #Required
    log_analytics_workspace_location                           = "westus2"          #Required
    log_analytics_workspace_resource_group_name                = "ploceusrg000001"  #Required
    log_analytics_workspace_sku                                = "PerGB2018"        #Optional
    log_analytics_workspace_retention_in_days                  = null               #Optional
    log_analytics_workspace_daily_quota_gb                     = null               #Optional
    log_analytics_workspace_internet_ingestion_enabled         = null               #Optional
    log_analytics_workspace_internet_query_enabled             = null               #Optional
    log_analytics_workspace_reservation_capacity_in_gb_per_day = null               #Optional
    log_analytics_workspace_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#APPLICATION INSIGHTS
application_insights_variables = {
  application_insights_1 = {
    application_insights_name             = "applicationinsights000001"
    resource_group_name                   = "ploceusrg000001"
    application_insights_location         = "eastus"
    workspace_id                          = "ploceuslaw000001" #log_analytics_workspace_name
    application_type                      = "web"
    retention_in_days                     = 90
    disable_ip_masking                    = false
    daily_data_cap_in_gb                  = 10
    daily_data_cap_notifications_disabled = null
    sampling_percentage                   = 50
    local_authentication_disabled         = false
    internet_ingestion_enabled            = true
    internet_query_enabled                = true
    force_customer_storage_for_profiler   = false
    application_insights_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
