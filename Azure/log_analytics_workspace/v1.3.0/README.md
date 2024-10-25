### Attributes: ###
- log_analytics_workspace_name                               = string       #(Required) Specifies the name of the Log Analytics Workspace. Workspace name should include 4-63 letters, digits or '-'. The '-' shouldn't be the first or the last symbol. Changing this forces a new resource to be created.
- log_analytics_workspace_resource_group_name                = string       #(Required) The name of the resource group in which the Log Analytics workspace is created. Changing this forces a new resource to be created.
- log_analytics_workspace_location                           = string       #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created
- log_analytics_workspace_allow_resource_only_permissions    = bool         #(Optional) Specifies if the log Analytics Workspace allow users accessing to data associated with resources they have permission to view, without permission to workspace. Defaults to true.
- log_analytics_workspace_local_authentication_disabled      = bool         #(Optional) Specifies if the log Analytics workspace should enforce authentication using Azure AD. Defaults to false.
- log_analytics_workspace_sku                                = string       #(Optional) Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018 (new SKU as of 2018-04-03). Defaults to PerGB2018
- log_analytics_workspace_retention_in_days                  = number       #(Optional) The workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730.
- log_analytics_workspace_daily_quota_gb                     = number       #(Optional) The workspace daily quota for ingestion in GB. Defaults to -1 (unlimited) if omitted.
- log_analytics_workspace_cmk_for_query_forced               = string       #(Optional) Is Customer Managed Storage mandatory for query management?
- log_analytics_workspace_internet_ingestion_enabled         = bool         #(Optional) Should the Log Analytics Workspace support ingestion over the Public Internet? Defaults to true
- log_analytics_workspace_internet_query_enabled             = bool         #(Optional) Should the Log Analytics Workspace support querying over the Public Internet? Defaults to true
- log_analytics_workspace_reservation_capacity_in_gb_per_day = number       #(Optional) The capacity reservation level in GB for this workspace. Must be in increments of 100 between 100 and 5000
- log_analytics_workspace_data_collection_rule_id            = string      #(Optional) The ID of the Data Collection Rule to use for this workspace.
- log_analytics_workspace_tags                               = map(string)  #(Optional) A mapping of tags to assign to the resource.
- log_analytics_workspace_key_vault_name                     = string      #(Required) specify the keyvault name to store the log analytics workspace keys.
- log_analytics_workspace_key_vault_resource_group_name      = string      #(Required) The name of the resource group in which the keyvault is present.
- log_analytics_workspace_primary_shared_key_vault_secret_name   = string      #(Required) The name of the keyvault secret where the primary shared key of log analytics workspace is stored
- log_analytics_workspace_secondary_shared_key_vault_secret_name = string      #(Required) The name of the keyvault secret where the secondary shared key of log analytics workspace is stored 

>### Notes: ###
>1. A new pricing model took effect on 2018-04-03, which requires the SKU PerGB2018. If you're provisioned resources before this date you have the option of remaining with the previous Pricing SKU and using the other SKUs defined above. More information about the Pricing SKUs is available at the following URI.
>2. The Free SKU has a default daily_quota_gb value of 0.5 (GB).
>3. When sku is set to Free this field should not be set and has a default value of 0.5.
>4. reservation_capacity_in_gb_per_day can only be used when the sku is set to CapacityReservation.
>5. If a azurerm_log_analytics_workspace is connected to a azurerm_log_analytics_cluster via a azurerm_log_analytics_linked_service you will not be able to modify the workspaces sku field until the link between the workspace and the cluster has been broken by deleting the azurerm_log_analytics_linked_service resource. All other fields are modifiable while the workspace is linked to a cluster.
>6. id refers to the Log Analytics Workspace ID
>7. workspace_id refers to the  Workspace (or Customer) ID for the Log Analytics Workspace
>8. primary and secondary shared key of the log analytics workspace are stored as secrets in keyvault
