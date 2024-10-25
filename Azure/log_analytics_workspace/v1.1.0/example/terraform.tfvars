#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000002"
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
    log_analytics_workspace_resource_group_name                = "ploceusrg000002"  #Required
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

