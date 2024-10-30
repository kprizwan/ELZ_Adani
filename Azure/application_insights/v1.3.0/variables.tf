#APPLICATION INSIGHTS VARIABLES
variable "application_insights_variables" {
  type = map(object({
    application_insights_name                                        = string      #(Required) Specifies the name of the Application Insights component. Changing this forces a new resource to be created.
    application_insights_resource_group_name                         = string      #(Required) The name of the resource group in which to create the Application Insights component.
    application_insights_location                                    = string      #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    application_insights_application_type                            = string      #(Required) Specifies the type of Application Insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET. Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure. Changing this forces a new resource to be created
    application_insights_daily_data_cap_in_gb                        = number      #(Optional) Specifies the Application Insights component daily data volume cap in GB.  
    application_insights_daily_data_cap_notifications_disabled       = bool        #(Optional) Specifies if a notification email will be send when the daily data volume cap is met
    application_insights_retention_in_days                           = number      #(Optional) Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Defaults to 90
    application_insights_sampling_percentage                         = number      #(Optional) Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry
    application_insights_disable_ip_masking                          = bool        #(Optional) By default the real client IP is masked as 0.0.0.0 in the logs. Use this argument to disable masking and log the real client IP. Defaults to false
    application_insights_log_analytics_workspace_name                = string      #(Optional) The name of the log analytics workspace
    application_insights_log_analytics_workspace_resource_group_name = string      #(Optional) The Resource group name of the log analytics workspace
    application_insights_local_authentication_disabled               = bool        #(Optional) Disable Non-Azure AD based Auth. Defaults to false
    application_insights_internet_ingestion_enabled                  = bool        #(Optional) Should the Application Insights component support ingestion over the Public Internet? Defaults to true
    application_insights_internet_query_enabled                      = bool        #(Optional) Should the Application Insights component support querying over the Public Internet? Defaults to true
    application_insights_force_customer_storage_for_profiler         = bool        #(Optional) Should the Application Insights component force users to create their own storage account for profiling? Defaults to false.
    application_insights_key_vault_name                              = string      #(Required) specify the keyvault name to store the log analytics workspace keys.
    application_insights_key_vault_resource_group_name               = string      #(Required) The name of the resource group in which the keyvault is present.
    application_insights_instrumentation_key_vault_secret_name       = string      #(Required) The name of the keyvault secret where the instrumentation key of application insights is stored
    application_insights_connection_string_key_vault_secret_name     = string      #(Required) The name of the keyvault secret where the connection string of application insights is stored  
    application_insights_tags                                        = map(string) #(Optional) A mapping of tags to assign to the resource 
  }))
  description = "Map of objects of application insights"
  default     = {}
}
