#Logic App Standard Variables
variable "logic_app_standard_variables" {
  type = map(object({
    logic_app_standard_resource_group_name                  = string      #(Required) The name of the resource group in which to create the Logic App
    logic_app_standard_storage_account_name                 = string      #(Required) The backend storage account name which will be used by this Logic App (e.g. for Stateful workflows data)
    logic_app_standard_storage_account_resource_group_name  = string      #(Required) The resource group name of the storage account.
    logic_app_standard_app_service_plan_resource_group_name = string      #(Required) The resource group name of the app service plan.
    logic_app_standard_location                             = string      #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    logic_app_standard_app_service_plan_name                = string      #(Required) The name of the app service plan.
    logic_app_standard_name                                 = string      #(Required) Specifies the name of the Logic App Changing this forces a new resource to be created.
    logic_app_standard_app_settings                         = map(string) #(Optional) A map of key-value pairs for App Settings and custom values.
    logic_app_standard_use_extension_bundle                 = bool        #(Optional) Should the logic app use the bundled extension package? If true, then application settings for AzureFunctionsJobHost__extensionBundle__id and AzureFunctionsJobHost__extensionBundle__version will be created. Default true
    logic_app_standard_bundle_version                       = string      #(Optional) If use_extension_bundle then controls the allowed range for bundle versions. Default [1.*, 2.0.0)
    is_connection_string_required                           = bool        #(Optional) possible values are true and false
    logic_app_standard_connection_string = object({                       #(Optional)
      name = string                                                       #(Required) The name of the Connection String.
      type = string                                                       #Possible values are APIHub, Custom, DocDb, EventHub, MySQL, NotificationHub, PostgreSQL, RedisCache, ServiceBus, SQLAzure and SQLServer.
    })
    logic_app_standard_client_affinity_enabled = bool                 #(Optional) Should the Logic App send session affinity cookies, which route client requests in the same session to the same instance?
    logic_app_standard_client_certificate_mode = string               #(Optional) The mode of the Logic App's client certificates requirement for incoming requests. Possible values are Required and Optional.
    logic_app_standard_enabled                 = bool                 #(Optional) Is the Logic App enabled?, possible values are true and false
    logic_app_standard_https_only              = bool                 #(Optional) Can the Logic App only be accessed via HTTPS? Defaults to false.
    logic_app_standard_identity = object({                            #(Optional)
      logic_app_standard_identity_type = string                       # (Required) Specifies the type of Managed Service Identity that should be configured on this logic app standard. Possible values are SystemAssigned, UserAssigned.
      logic_app_standard_user_assigned_identities = list(object({     #Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Logic App Standard.
        logic_app_standard_user_identity_name                = string # (Optional) Specifies a User Assigned Managed Identity Name to be assigned to this Logic App standard.
        logic_app_standard_user_identity_resource_group_name = string # (Optional) Specifies a User Assigned Managed Identity Resource group Name to be assigned to this Logic App standard.
      }))
    })
    is_subnet_required = bool                      #(Optional)Variable to ask user whether subnet is required
    logic_app_standard_site_config = list(object({ #(Optional)
      always_on       = bool                       #(Optional) Should the Logic App be loaded at all times? Defaults to false.
      app_scale_limit = string                     #(Optional) The number of workers this Logic App can scale out to. Only applicable to apps on the Consumption and Premium plan.
      cors = list(object({                         #(Optional)
        allowed_origins     = list(string)         #(Optional) A list of origins which should be able to make cross-origin calls. * can be used to allow all calls.
        support_credentials = bool                 #(Optional) Are credentials supported?
      }))
      dotnet_framework_version = string    #(Optional) The version of the .NET framework's CLR used in this Logic App Possible values are v4.0 (including .NET Core 2.1 and 3.1), v5.0 and v6.0. For more information on which .NET Framework version to use based on the runtime version you're targeting - please see this table. Defaults to v4.0.
      elastic_instance_minimum = string    #(Optional) The number of minimum instances for this Logic App Only affects apps on the Premium plan.
      ftps_state               = string    #(Optional) State of FTP / FTPS service for this Logic App Possible values include: AllAllowed, FtpsOnly and Disabled. Defaults to AllAllowed.
      health_check_path        = string    #(Optional) Path which will be checked for this Logic App health.
      http2_enabled            = bool      #(Optional) Specifies whether or not the HTTP2 protocol should be enabled. Defaults to false.
      ip_restriction = list(object({       #(Optional) 
        ip_address  = string               #(Optional) The IP Address used for this IP Restriction in CIDR notation.
        service_tag = string               #(Optional) The Service Tag used for this IP Restriction.
        name        = string               #(Optional) The name for this IP Restriction.
        priority    = string               # (Optional) The priority for this IP Restriction. Restrictions are enforced in priority order. By default, the priority is set to 65000 if not specified.
        action      = string               #(Optional) Does this restriction Allow or Deny access for this IP range. Defaults to Allow.
        headers = object({                 #(Optional)
          x_azure_fdid      = list(string) #(Optional) A list of allowed Azure FrontDoor IDs in UUID notation with a maximum of 8.
          x_fd_health_probe = list(string) #(Optional) A list to allow the Azure FrontDoor health probe header. Only allowed value is "1".
          x_forwarded_for   = list(string) #(Optional) A list of allowed 'X-Forwarded-For' IPs in CIDR notation with a maximum of 8
          x_forwarded_host  = list(string) #(Optional) A list of allowed 'X-Forwarded-Host' domains with a maximum of 8.
        })
      }))
      linux_fx_version                 = string #(Optional) Linux App Framework and version for the AppService, e.g. DOCKER|(golang:latest). Setting this value will also set the kind of application deployed to functionapp,linux,container,workflowapp
      min_tls_version                  = string #(Optional) The minimum supported TLS version for the Logic App Possible values are 1.0, 1.1, and 1.2. Defaults to 1.2 for new Logic Apps.
      pre_warmed_instance_count        = string #(Optional) The number of pre-warmed instances for this Logic App Only affects apps on the Premium plan.
      runtime_scale_monitoring_enabled = bool   #(Optional) Should Runtime Scale Monitoring be enabled?. Only applicable to apps on the Premium plan. Defaults to false.
      use_32_bit_worker_process        = bool   #(Optional) Should the Logic App run in 32 bit mode, rather than 64 bit mode? Defaults to true.
      vnet_route_all_enabled           = bool   #(Optional) Should all outbound traffic to have Virtual Network Security Groups and User Defined Routes applied.
      websockets_enabled               = bool   #(Optional) Should WebSockets be enabled?
      scm_ip_restriction = list(object({        #(Optional) 
        ip_address  = string                    #(Optional) The IP Address used for this IP Restriction in CIDR notation.
        service_tag = string                    #(Optional) The Service Tag used for this IP Restriction.
        name        = string                    #(Optional) The name for this IP Restriction.
        priority    = string                    #(Optional) The priority for this IP Restriction. Restrictions are enforced in priority order. By default, the priority is set to 65000 if not specified.
        action      = string                    #(Optional) Does this restriction Allow or Deny access for this IP range. Defaults to Allow.
        headers = object({                      #(Optional)
          x_azure_fdid      = list(string)      #(Optional) A list of allowed Azure FrontDoor IDs in UUID notation with a maximum of 8.
          x_fd_health_probe = list(string)      #(Optional) A list to allow the Azure FrontDoor health probe header. Only allowed value is "1".
          x_forwarded_for   = list(string)      #(Optional) A list of allowed 'X-Forwarded-For' IPs in CIDR notation with a maximum of 8
          x_forwarded_host  = list(string)      #(Optional) A list of allowed 'X-Forwarded-Host' domains with a maximum of 8.
        })
      }))
      scm_use_main_ip_restriction = bool   #(Optional) Should the Logic App ip_restriction configuration be used for the SCM too. Defaults to false.
      scm_min_tls_version         = string #(Optional) Configures the minimum version of TLS required for SSL requests to the SCM site.
      scm_type                    = string #The type of Source Control used by the Logic App in use by the Windows Function App. Defaults to None. Possible values are: BitbucketGit, BitbucketHg, CodePlexGit, CodePlexHg, Dropbox, ExternalGit, ExternalHg, GitHub, LocalGit, None, OneDrive, Tfs, VSO, and VSTSRM
    }))
    storage_account_share_name_required                    = bool
    logic_app_standard_storage_account_share_name          = string      #(Optional) The name of the share used by the logic app, if you want to use a custom name. This corresponds to the WEBSITE_CONTENTSHARE appsetting, which this resource will create for you. If you don't specify a name, then this resource will generate a dynamic name. This setting is useful if you want to provision a storage account and create a share using azurerm_storage_share
    logic_app_standard_version                             = string      #(Optional) The runtime version associated with the Logic App Defaults to ~1.
    logic_app_standard_key_vault_name                      = string      #(Required) The name of the key vault.
    logic_app_standard_key_vault_resource_group_name       = string      #(Required) The resource group name of the app service plan.
    logic_app_standard_secret_connection_string_value_name = string      #(Required) The value for the Connection String.
    logic_app_standard_subnet_name                         = string      #(Required) The name of the subnet.
    logic_app_standard_vnet_name                           = string      #(Required) The name of the vnet.
    logic_app_standard_subnet_resource_group_name          = string      #(Required) The resource group name of the subnet.
    logic_app_standard_tags                                = map(string) #(Optional) A mapping of tags to assign to the resource.
  }))
  description = "Map of logic app standard object"
  default     = {}
}