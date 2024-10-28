#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name       = "ploceusrg000001" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = "eastus2"         #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = "ploceus"         #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {                       #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

# STORAGE ACCOUNT
storage_account_variables = {
  "storage_account_1" = {
    storage_account_key_vault_name                                     = null               #(Required) The name of the Key Vault.
    storage_account_key_vault_resource_group_name                      = null               #(Required) The resource group name of the Key Vault.
    storage_account_key_vault_key_name                                 = null               #(Required) The name of the Key Vault key required for customer managed key.
    storage_account_user_assigned_identity_name_for_cmk                = null               #(Required) The name of a user assigned identity for customer managed key.
    storage_account_user_assigned_identity_resource_group_name_for_cmk = null               #(Required) The resource group name of a user assigned identity for customer managed key.
    storage_account_identity_type_for_cmk                              = "SystemAssigned"   #(Required) The identity type of a user assigned identity for customer managed key.Only Possible value could be "UserAssigned" in order to use customer managed key. Other Possible values are "SystemAssigned", "SystemAssigned, UserAssigned"
    storage_account_name                                               = "plocuessa0000001" #(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed.This must be unique across the entire Azure service, not just within the resource group.
    storage_account_resource_group_name                                = "ploceusrg000001"  #(Required) The name of the resource group in which to create the storage account.
    storage_account_location                                           = "eastus2"          #(Required) Specifies the supported Azure location where the resource exists.
    storage_account_account_kind                                       = "StorageV2"        #(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2.
    storage_account_account_tier                                       = "Standard"         #(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    storage_account_account_replication_type                           = "LRS"              #(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa.
    storage_account_cross_tenant_replication_enabled                   = true               #(Optional) Should cross Tenant replication be enabled? Defaults to true.
    storage_account_access_tier                                        = "Hot"              #(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot.
    storage_account_edge_zone                                          = null               #(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist.
    storage_account_enable_https_traffic_only                          = true               #(Optional) Boolean flag which forces HTTPS if enabled. Defaults to true.
    storage_account_min_tls_version                                    = "TLS1_2"           #(Optional) The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts.
    storage_account_allow_nested_items_to_be_public                    = true               #Allow or disallow nested items within this Account to opt into being public. Defaults to true.
    storage_account_shared_access_key_enabled                          = true               #Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true.
    storage_account_public_network_access_enabled                      = true               #(Optional) Whether the public network access is enabled? Defaults to true.
    storage_account_default_to_oauth_authentication                    = false              #(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false
    storage_account_is_hns_enabled                                     = false              #(Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2.
    storage_account_nfsv3_enabled                                      = false              #(Optional) Is NFSv3 protocol enabled? Defaults to false.
    storage_account_large_file_share_enabled                           = false              #(Optional) Is Large File Share Enabled?
    storage_account_queue_encryption_key_type                          = "Service"          #(Optional) The encryption type of the queue service. Possible values are Service and Account.Default value is Service.
    storage_account_table_encryption_key_type                          = "Service"          #(Optional) The encryption type of the table service. Possible values are Service and Account. Default value is Service.
    storage_account_infrastructure_encryption_enabled                  = false              #(Optional) Is infrastructure encryption enabled? Defaults to false.
    storage_account_allowed_copy_scope                                 = null               #(Optional) Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values are AAD and PrivateLink.
    storage_account_sftp_enabled                                       = false              #(Optional) Boolean, enable SFTP for the storage account, to enable this, is_hns_enabled should be true as well
    storage_account_custom_domain                                      = null
    # storage_account_custom_domain = {
    #     custom_domain_name = "www.ploceus.com" #(Required) The Custom Domain Name to use for the Storage Account, which will be validated by Azure.
    #     custom_domain_use_subdomain = false #(Optional) Should the Custom Domain Name be validated by using indirect CNAME validation?
    # }

    storage_account_identity = null
    # storage_account_identity = {
    #   storage_account_identity_type = "UserAssigned" # Possible values could be "UserAssigned", "SystemAssigned", "SystemAssigned, UserAssigned"
    #   # storage_account_user_assigned_identity_ids = null
    #   storage_account_user_assigned_identity_ids = [{ # This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
    #     identity_name                = "ploceusuai000002"
    #     identity_resource_group_name = "loceusrg000005"
    #   }]
    # }

    storage_account_blob_properties = {
      versioning_enabled            = true         #(Optional) Is versioning enabled? Default to false.
      change_feed_enabled           = true         #(Optional) Is the blob service properties for change feed events enabled? Default to false.
      change_feed_retention_in_days = 7            #(Optional) The duration of change feed events retention in days. The possible values are between 1 and 146000 days (400 years). Setting this to null (or omit this in the configuration file) indicates an infinite retention of the change feed.
      default_service_version       = "2020-06-12" #(Optional) The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version. Defaults to 2020-06-12.
      last_access_time_enabled      = false        #(Optional) Is the last access time based tracking enabled? Default to false.

      cors_enabled = true #(optional) Should cross origin resource sharing be enabled.
      cors_rule = {
        allowed_headers    = ["*"]                                                                 #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = ["DELETE", "GET", "HEAD", "MERGE", "POST", "OPTIONS", "PUT", "PATCH"] #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = ["*"]                                                                 #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = ["*", ]                                                               #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = 60                                                                    #(Required) The number of seconds the client should cache a preflight response.
      }
      restore_policy = {
        restore_policy_days = "4" #(Required) Specifies the number of days that the blob can be restored, between 1 and 365 days. This must be less than the days specified for delete_retention_policy.
      }
      delete_retention_policy = {
        delete_retention_policy_days = "7" #(Optional) Specifies the number of days that the blob should be retained, between 1 and 365 days. Defaults to 7.
      }

      container_delete_retention_policy = {
        container_delete_retention_policy_days = "7" #(Optional) Specifies the number of days that the container should be retained, between 1 and 365 days. Defaults to 7.
      }
    }

    storage_account_queue_properties = {
      cors_enabled = true #(optional) Should cross origin resource sharing be enabled.
      cors_rule = {
        allowed_headers    = ["*"]                                   #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = ["GET", "HEAD", "MERGE", "POST", "PUT"] #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = ["*"]                                   #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = ["*"]                                   #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = 60                                      #(Required) The number of seconds the client should cache a preflight response.
      }

      logging_enabled = true #Should storage account queue properties logging be enabled.
      logging = {
        delete                = true  #(Required) Indicates whether all delete requests should be logged.
        read                  = true  #(Required) Indicates whether all read requests should be logged.
        version               = "1.0" #(Required) The version of storage analytics to configure.
        write                 = true  #(Required) Indicates whether all write requests should be logged.
        retention_policy_days = 7     #(Optional) Specifies the number of days that logs will be retained.
      }

      minute_metrics = {
        enabled               = true  #(Required) Indicates whether minute metrics are enabled for the Queue service.
        version               = "1.0" #(Required) The version of storage analytics to configure.
        include_apis          = true  #(Optional) Indicates whether metrics should generate summary statistics for called API operations.
        retention_policy_days = 7     #(Optional) Specifies the number of days that logs will be retained.
      }

      hour_metrics = {
        enabled               = true  #(Required) Indicates whether minute metrics are enabled for the Queue service.
        version               = "1.0" #(Required) The version of storage analytics to configure.
        include_apis          = true  #(Optional) Indicates whether metrics should generate summary statistics for called API operations.
        retention_policy_days = 7     #(Optional) Specifies the number of days that logs will be retained.
      }
    }

    storage_account_static_website = null /*{
      index_document     = "index.html" #Optional) The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive.
      error_404_document = "404.html"   #(Optional) The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file.
    }*/

    storage_account_share_properties = {
      cors_enabled = true #(optional) Should cross origin resource sharing be enabled.
      cors_rule = {
        allowed_headers    = ["*"]                                   #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = ["GET", "HEAD", "MERGE", "POST", "PUT"] #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = ["*"]                                   #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = ["*"]                                   #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = 60                                      #(Required) The number of seconds the client should cache a preflight response.
      }

      retention_policy = {
        retention_policy_days = 7 #(Optional) Specifies the number of days that the azurerm_storage_share should be retained, between 1 and 365 days. Defaults to 7.
      }

      smb = {
        smb_versions                        = ["SMB2.1"]      #(Optional) A set of SMB protocol versions. Possible values are SMB2.1, SMB3.0, and SMB3.1.1.
        smb_authentication_types            = ["NTLMv2"]      #(Optional) A set of SMB authentication methods. Possible values are NTLMv2, and Kerberos.
        smb_kerberos_ticket_encryption_type = ["RC4-HMAC"]    #(Optional) A set of Kerberos ticket encryption. Possible values are RC4-HMAC, and AES-256.
        smb_channel_encryption_type         = ["AES-128-CCM"] #(Optional) A set of SMB channel encryption. Possible values are AES-128-CCM, AES-128-GCM, and AES-256-GCM.
        smb_multichannel_enabled            = false           #(Optional) Indicates whether multichannel is enabled. Defaults to false. This is only supported on Premium storage accounts.
      }
    }

    storage_account_network_rules = null /* {
      default_action = "Deny"                 #(Required) Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow.
      bypass         = ["Logging", "Metrics"] #(Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None.
      ip_rules       = ["8.29.228.191"]        #(Optional) List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed.

      storage_account_network_rules_vnet_subnets = [{
        storage_account_network_rules_virtual_network_name = "ploceusvnet000001"                   #(Required) Vitural Network name to be associated.
        storage_account_network_rules_subnet_name          = "ploceussubnet000001"                 #(Required) Subnet Name to be associated.
        storage_account_network_rules_vnet_subscription_id = "xxxxxxx-xxxxxxx-xxxxxxxxx-xxxxxxxxx" #(Required) Subscription Id where Vnet is created.
        storage_account_network_rules_vnet_rg_name         = "ploceusrg000001"                     #(Required) Resource group where Vnet is created.
        }]

      private_link_access = null /*{
        "private_link_access_1" = {
          endpoint_resource_id = "/subscriptions/XXXXXXXXXXXXXXXXXXXXXXX/resourceGroups/XXXXXXXXXXXXXXXXXXXX/providers/Microsoft.Sql/servers/XXXXXXXXXXXXXXXXXXXX"
          endpoint_tenant_id   = "xxxxxxxxx-xxxxxxxxx-xxxxxxxxxx-xxxxxxxxx"
        }
      }
    } */

    storage_account_azure_files_authentication = null
    # storage_account_azure_files_authentication = {  # Use this block when need to authenticate with Azure active directory domain services or Active Directory.
    #   directory_type = "AADDS" #(Required) Specifies the directory service used. Possible values are AADDS and AD.
    #   active_directory = {
    #     storage_sid         = "xxxxxxxxxx" #(Required) Specifies the security identifier (SID) for Azure Storage.
    #     domain_name         = "www.ploceus1.com" #(Required) Specifies the primary domain that the AD DNS server is authoritative for.
    #     domain_sid          = "xxxxxxxxxx" #(Required) Specifies the security identifier (SID).
    #     domain_guid         = "xxxxxxxxxx" #(Required) Specifies the domain GUID.
    #     forest_name         = "xxxxxxxxxx" #(Required) Specifies the Active Directory forest.
    #     netbios_domain_name = "www.ploceus2.com" #(Required) Specifies the NetBIOS domain name.
    #   }
    # }

    storage_account_routing = {
      publish_internet_endpoints  = false             #(Optional) Should internet routing storage endpoints be published? Defaults to false.
      publish_microsoft_endpoints = false             #(Optional) Should Microsoft routing storage endpoints be published? Defaults to false.
      choice                      = "InternetRouting" #(Optional) Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting. Defaults to MicrosoftRouting.
    }

    storage_account_immutability_policy = null /* {
      allow_protected_append_writes = false      #(Required) When enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted.
      state                         = "Disabled" #(Required) Defines the mode of the policy. Disabled state disables the policy, Unlocked state allows increase and decrease of immutability retention time and also allows toggling allowProtectedAppendWrites property, Locked state only allows the increase of the immutability retention time. A policy can only be created in a Disabled or Unlocked state and can be toggled between the two states. Only a policy in an Unlocked state can transition to a Locked state which cannot be reverted.
      period_since_creation_in_days = 7          #(Required) The immutability period for the blobs in the container since the policy creation, in days.
    } */

    storage_account_sas_policy = {
      expiration_period = "11:12:13:14" #(Required) The SAS expiration period in format of DD.HH:MM:SS.
      expiration_action = "Log"         #(Optional) The SAS expiration action. The only possible value is Log at this moment. Defaults to Log.
    }

    storage_account_tags = { #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus"
      Department = "CIS"
    }

  }
}

#MONITOR ACTION GROUP
monitor_action_group_variables = {
  "monitor_action_group_1" = {
    monitor_action_group_name                = "ploceusmonitor000001" #(Required) The name of the Action Group.
    monitor_action_group_resource_group_name = "ploceusrg000001"      #(Required) The name of the resource group in which to create the Action Group instance.
    monitor_action_group_location            = "eastus2"              #(Optional) The Azure Region where the Action Group should exist. Changing this forces a new Action Group to be created. Defaults to global.
    monitor_action_group_short_name          = "action1"              #(Required) The short name of the action group. This will be used in SMS messages.
    monitor_action_group_enabled             = true                   #(Optional) Whether this action group is enabled. If an action group is not enabled, then none of its receivers will receive communications. Defaults to true.
    monitor_action_group_tags = {                                     #(Optional) A mapping of tags to assign to the resource. 
      Created_By = "Ploceus"
      Department = "CIS"
    }
    monitor_action_group_arm_role_receiver = null
    # monitor_action_group_arm_role_receiver =  [{                                          #(Optional) One or more arm_role_receiver blocks as defined below
    #   arm_role_receiver_name                    = "ploceusarmroleaction"                 #(Required) The name of the ARM role receiver.
    #   arm_role_receiver_role_id                 = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" #(Required) The arm role id.
    #   arm_role_receiver_use_common_alert_schema = true                                   #(Optional) Enables or disables the common alert schema.
    # }]
    monitor_action_group_automation_runbook_receiver = null #(Optional) One or more automation_runbook_receiver blocks as defined below.
    #   [{
    #   monitor_action_group_runbook_recevier_name              = string #(Required) The name of the automation runbook receiver.  
    #   automation_runbook_receiver_webhook_resource_group_name = string #(Required) The name of the resource group in which to create the Action Group instance.
    #   automation_runbook_receiver_webhook_account_name        = string #(Required) The name of the automation runbook account receiver.  
    #   automation_runbook_receiver_webhook_name                = string #(Required) The name for this runbook.
    #   monitor_action_group_is_global_runbook                  = string #(Required) The resource id for webhook linked to this runbook.
    #   monitor_action_group_is_global_runbook                  = bool   #(Required) Indicates whether this instance is global runbook. 
    #   monitor_action_group_service_uri                        = string #(Required) The URI where webhooks should be sent.
    #   monitor_action_group_use_common_alert_schema            = bool   #(Optional) Enables or disables the common alert schema. 
    # }]
    monitor_action_group_azure_app_push_receiver = null
    #monitor_action_group_azure_app_push_receiver = [{                #(Optional) One or more azure_app_push_receiver blocks as defined below.
    #   azure_app_push_receiver_name          = "test"                 #(Required) The name of the Azure app push receiver.
    #   azure_app_push_receiver_email_address = "xxxxxxxx@plocues.com" #(Required) The email address of the user signed into the mobile app who will receive push notifications from this receiver.
    # }]
    monitor_action_group_azure_function_receiver = null
    # monitor_action_group_azure_function_receiver = [{                   #(Optional) One or more azure_function_receiver blocks as defined below.
    #   monitor_action_group_function_receiver_name = "ploceusfuncaction" #(Required) The name of the Azure Function receiver. 
    #   # monitor_action_group_function_app_function_os_type = "windows"                     #(Required) Function app OS type. Possible values are windows and linux.
    #   monitor_action_group_function_name           = "myfuc"                       #(Required) The function name in the function app.
    #   monitor_action_group_http_trigger_url        = "https://example.com/trigger" #(Required) The HTTP trigger url where HTTP request sent to.
    #   monitor_action_group_use_common_alert_schema = true                          #(Optional) Enables or disables the common alert schema. 
    # }]
    monitor_action_group_email_receiver = null
    # monitor_action_group_email_receiver = [{                          #(Optional) One or more email_receiver blocks as defined below.
    #   email_receiver_name                    = "sendtoadmin"          #(Required) The name of the email receiver. Names must be unique (case-insensitive) across all receivers within an action group.
    #   email_receiver_email_address           = "xxxxxxxx@plocues.com" #(Required) The email address of this receiver.
    #   email_receiver_use_common_alert_schema = null                   #(Optional) Enables or disables the common alert schema. 
    # }]
    monitor_action_group_event_hub_receiver = null #(Optional) One or more event_hub_receiver blocks as defined below.
    #   [{
    #   event_hub_receiver_name                    = string   #(Required) The name of the EventHub Receiver, must be unique within action group.
    #   event_hub_receiver_event_hub_namespace     = string   #(Optional) The namespace name of the Event Hub.
    #   event_hub_receiver_event_hub_name          = string   #(Optional) The name of the specific Event Hub queue.
    #   event_hub_receiver_use_common_alert_schema = bool     #(Optional) Enables or disables the common alert schema. 
    # }]
    monitor_action_group_itsm_receiver = null
    # monitor_action_group_itsm_receiver = [{                                                                                                                                      #(Optional) One or more itsm_receiver blocks as defined below.
    #   itsm_receiver_name                      = "ploceusucticket"                                                                                                                #(Required) The name of the ITSM receiver.
    #   itsm_receiver_name_connection_id        = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxx"                                                                                              #(Required) The unique connection identifier of the ITSM connection.
    #   itsm_receiver_name_ticket_configuration = "{\"PayloadRevision\":0,\"WorkItemType\":\"Incident\",\"UseTemplate\":false,\"WorkItemData\":\"{}\",\"CreateOneWIPerCI\":false}" #(Required) A JSON blob for the configurations of the ITSM action.
    #   itsm_receiver_name_region               = "southcentralus"                                                                                                                 #(Required) The region of the workspace.
    # }]
    monitor_action_group_logic_app_receiver = null #(Optional) One or more logic_app_receiver blocks as defined below.
    #     [{
    #     logic_app_receiver_name                    = string   #(Required) The name of the logic app receiver.
    #     logic_app_receiver_callback_url            = string   #(Required) The callback url where HTTP request sent to.
    #     logic_app_receiver_use_common_alert_schema = string   #(Optional) Enables or disables the common alert schema.
    # }]
    monitor_action_group_sms_receiver = null #(Optional) One or more sms_receiver blocks as defined below.
    #   [{
    #   sms_receiver_name         = string              #(Required) The name of the SMS receiver.
    #   sms_receiver_country_code = string              #(Required) The country code of the SMS receiver.
    #   sms_receiver_phone_number = string              #(Required) The phone number of the SMS receiver.
    # }]
    monitor_action_group_voice_receiver = null #(Optional) One or more voice_receiver blocks as defined below.
    #   [{
    #   voice_receiver_name         = string              #(Required) The name of the voice receiver.
    #   voice_receiver_country_code = string              #(Required) The country code of the voice receiver.
    #   voice_receiver_phone_number = string              #(Required) The phone number of the voice receiver.
    # }]
    monitor_action_group_webhook_receiver = null #(Optional) One or more webhook_receiver blocks as defined below
    #  [{
    #   webhook_receiver_name                    = string  #(Required) The name of the webhook receiver. Names must be unique (case-insensitive) across all receivers within an action group.
    #   webhook_receiver_service_uri             = string  #(Required) The URI where webhooks should be sent.
    #   webhook_receiver_use_common_alert_schema = string  #(Optional) Enables or disables the common alert schema.
    #   webhook_receiver_aad_auth = {               #(Optional) The aad_auth block as defined below
    #     aad_auth_identifier_uri = string                 #(Optional) The identifier URI for AAD auth.
    #   }
    # }]
    monitor_action_group_itsm_receiver_log_analytics_workspace_name                         = null #(Optional) Specifies the name of the Log Analytics Workspace. Workspace name should include 4-63 letters, digits or '-'. The '-' shouldn't be the first or the last symbol. Changing this forces a new resource to be created.
    monitor_action_group_itsm_receiver_log_analytics_workspace_resource_group_name          = null #(Optional) The name of the resource group in which the Log Analytics workspace is created. Changing this forces a new resource to be created.
    monitor_action_group_logic_app_receiver_logic_app_workflow_name                         = null #(Optional) The name of the Logic App Workflow.
    monitor_action_group_logic_app_receiver_logic_app_workflow_resource_group_name          = null #(Optional) The name of the Resource Group in which the Logic App Workflow exists.
    monitor_action_group_automation_runbook_receiver_automation_account_name                = null #(Optional) The name of the Automation Account.
    monitor_action_group_automation_runbook_receiver_automation_account_resource_group_name = null #(Optional) Specifies the name of the Resource Group where the Automation Account exists.
    monitor_action_group_function_app_function_os_type                                      = null #(Required) Function app OS type. Possible values are windows and linux.
    monitor_action_group_azure_function_receiver_linux_function_name                        = null #(Optional) The function name in the function app.
    monitor_action_group_azure_function_receiver_linux_function_app_resource_group_name     = null #(Optional) The name of the resource group in which to create the Action Group instance.
    monitor_action_group_azure_function_receiver_windows_function_name                      = null #(Optional) The function name in the function app.
    monitor_action_group_azure_function_receiver_windows_function_app_resource_group_name   = null #(Optional) The name of the resource group in which to create the Action Group instance.
  }
}

#MONITOR METRIC ALERT
monitor_metric_alert_variables = {
  "alert1" = {
    monitor_metric_alert_action = [{   #(Required) Action Group name
      action_webhook_properties = null #(Optional) The map of custom string properties to include with the post operation. These data are appended to the webhook payload.
    }]
    monitor_action_group_resource_group_name                                          = "ploceusrg000001"
    monitor_action_group_name                                                         = "ploceusmonitor000001"
    monitor_metric_alert_application_insights_web_test_location_availability_criteria = null #When the alert rule contains multiple criteria, the use of dimensions is limited to one value per dimension within each criterion.
    monitor_metric_alert_auto_mitigate                                                = true #(Optional) Should the alerts in this Metric Alert be auto resolved? Defaults to true.
    monitor_metric_alert_criteria = {
      #When the alert rule contains multiple criteria, the use of dimensions is limited to one value per dimension within each criterion.
      "availability" = {
        criteria_aggregation = "Average" #(Required) The statistic that runs over the metric values. Possible values are Average, Count, Minimum, Maximum and Total.
        criteria_dimension = {           #(Optional) One or more dimension blocks as defined below.
          "d1" = {
            dimension_name     = "ApiName" #(Required) One of the dimension names.
            dimension_operator = "Include" #(Required) The dimension operator. Possible values are Include, Exclude and StartsWith.
            dimension_values   = ["*"]     #(Required) The list of dimension values.
          }
          "d2" = {
            dimension_name     = "GeoType"    #(Required) One of the dimension names.
            dimension_operator = "StartsWith" #(Required) The dimension operator. Possible values are Include, Exclude and StartsWith.
            dimension_values   = ["Primary"]  #(Required) The list of dimension values.
          }
        }
        criteria_metric_name            = "Availability"                      #(Required) One of the metric names to be monitored.
        criteria_metric_namespace       = "Microsoft.Storage/storageAccounts" #(Required) One of the metric namespaces to be monitored.
        criteria_operator               = "LessThan"                          # (Required) The criteria operator. Possible values are Equals, NotEquals, GreaterThan, GreaterThanOrEqual, LessThan and LessThanOrEqual.
        criteria_skip_metric_validation = false                               #(Optional) Skip the metric validation to allow creating an alert rule on a custom metric that isn't yet emitted? Defaults to false.
        criteria_threshold              = 5                                   #(Required) The criteria threshold value that activates the alert.
      }
    }
    monitor_metric_alert_description         = "Storage Transaction Alert" #(Optional) The description of this Metric Alert.
    monitor_metric_alert_dynamic_criteria    = null                        #When the alert rule contains multiple criteria, the use of dimensions is limited to one value per dimension within each criterion.
    monitor_metric_alert_enabled             = false                       #(Optional) Should this Metric Alert be enabled? Defaults to true
    monitor_metric_alert_frequency           = null                        #(Optional) The evaluation frequency of this Metric Alert, represented in ISO 8601 duration format. Possible values are PT1M, PT5M, PT15M, PT30M and PT1H. Defaults to PT1M.
    monitor_metric_alert_name                = "ploceusma000001"           #(Required) The name of the Metric Alert. Changing this forces a new resource to be created.
    monitor_metric_alert_resource_group_name = "ploceusrg000001"           #(Required) The name of the resource group in which to create the Metric Alert instance.
    monitor_metric_alert_scopes = {                                        #(Required) A set of strings of resource IDs at which the metric criteria should be applied.
      "ploceusstg000001" = {
        scopes_name                = "plocuessa0000001" #(Required) Scope name
        scopes_resource_group_name = "ploceusrg000001"  #(Required) Scope resource group name
      }
      #Alerts are currently not supported with multi resource level
    }
    monitor_metric_alert_severity = 1 #(Optional) The severity of this Metric Alert. Possible values are 0, 1, 2, 3 and 4. Defaults to 3.
    monitor_metric_alert_tags = {     #(Optional) A mapping of tags to assign to the resource.
      "Created_By" = "Ploceus"
      "Department" = "CIS"
    }
    monitor_metric_alert_target_resource_location = "eastus2"                           #(Optional) The location of the target resource.
    monitor_metric_alert_target_resource_type     = "Microsoft.Storage/storageAccounts" #(Optional) The resource type (e.g. Microsoft.Compute/virtualMachines) of the target resource.
    monitor_metric_alert_window_size              = null                                #(Optional) The period of time that is used to monitor alert activity, represented in ISO 8601 duration format. This value must be greater than frequency. Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D. Defaults to PT5M.
  }
}

monitor_metric_alert_sub_subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
monitor_metric_alert_sub_tenant_id       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
resource_tomonitor_sub_subscription_id   = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
resource_tomonitor_sub_tenant_id         = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
