#linux web app variables
variable "linux_web_app_variables" {
  type = map(object({
    linux_web_app_name                       = string      #(Required) The name which should be used for this Linux Web App. Changing this forces a new Linux Web App to be created.
    linux_web_app_location                   = string      #(Required) The Azure Region where the Linux Web App should exist. Changing this forces a new Linux Web App to be created.
    linux_web_app_resource_group_name        = string      #(Required) The name of the Resource Group where the Linux Web App should exist. Changing this forces a new Linux Web App to be created.
    linux_web_app_client_affinity_enabled    = bool        #(Optional) Should Client Affinity be enabled?
    linux_web_app_client_certificate_enabled = string      #(Optional) Should Client Certificates be enabled?
    linux_web_app_client_certificate_mode    = string      # (Optional) The Client Certificate mode. Possible values are Required, Optional, and OptionalInteractiveUser. This property has no effect when client_certificate_enabled is false
    linux_web_app_app_settings               = map(string) # (Optional) A map of key-value pairs of App Settings.
    linux_web_app_enabled                    = bool        #Defaults to true
    linux_web_app_https_only                 = bool        #(Optional) Should the Linux Web App require HTTPS connections. 
    linux_web_app_app_settings_enabled       = bool        #(Optional) A auth_settings block as defined below.
    linux_web_app_zip_deploy_file            = string      # (Optional) The local path and filename of the Zip packaged application to deploy to this Linux Web App.
    key_vault_reference_identity_id          = string      #(Optional) The User Assigned Identity ID used for accessing KeyVault secrets. The identity must be assigned to the application in the identity block. For more information see - Access vaults with a user-assigned identit
    linux_web_app_sticky_settings = list(object({          #(Optional) A sticky_settings block as defined below.
      sticky_settings_app_setting_names       = string     # (Optional) A list of app_setting names that the Linux Web App will not swap between Slots when a swap operation is triggered.
      sticky_settings_connection_string_names = string     #(Optional) A list of connection_string names that the Linux Web App will not swap between Slots when a swap operation is triggered.
    }))
    linux_web_app_connection_string = list(object({ # block supports the following:
      connection_string_name  = string              #Required) The name of the Connection String.
      connection_string_type  = string              # (Required) Type of database. Possible values include: MySQL, SQLServer, SQLAzure, Custom, NotificationHub, ServiceBus, EventHub, APIHub, DocDb, RedisCache, and PostgreSQL.
      connection_string_value = string              #(Required) The connection string value.
    }))
    linux_web_app_storage_account = list(object({ #- (Optional) One or more storage_account blocks as defined below.
      storage_account_name       = string         #(Required) The Name of the Storage Account.
      storage_account_share_name = string         #(Required) The Name of the File Share or Container Name for Blob storage
      storage_account_type       = string         #(Required) The Azure Storage Type. Possible values include AzureFiles and AzureBlob
      storage_account_mount_path = string         # (Optional) The path at which to mount the storage share.
    }))
    linux_web_app_logs = list(object({      # (Optional) A logs block as defined below.
      logs_detailed_error_messages = string #(Optional) Should detailed error messages be enabled?
      logs_failed_request_tracing  = string # (Optional) Should the failed request tracing be enabled?
      http_logs = list(object({
        azure_blob_storage = list(object({              # (Optional) A azure_blob_storage block as defined above.
          azure_blob_storage_retention_in_days = string # (Optional) A file_system block as defined above.
        }))
        file_system = list(object({          #block supports the following:
          content_retention_in_days = string #(Required) The retention period in days. A value of 0 means no retention.
          content_retention_in_mb   = string #(Required) The maximum size in megabytes that log files can use.
        }))
      }))
      linux_web_app_application_logs = list(object({
        file_system_level = string                      #Possible values include Error, Warning, Information, Verbose and Off
        azure_blob_storage = list(object({              #block supports the following:
          azure_blob_storage_level             = string # (Required) Log level. Possible values include: Verbose, Information, Warning, and Error.
          azure_blob_storage_retention_in_days = string ##(Required) The retention period in days. A value of 0 means no retention.
        }))
      }))
    }))
    linux_web_app_auth_settings = object({                          #block supports the following:
      auth_settings_enabled                          = bool         # (Required) Should the Authentication / Authorization feature be enabled for the Linux Web App?
      auth_settings_additional_login_parameters      = map(string)  #(Optional) Specifies a map of login Parameters to send to the OpenID Connect authorization endpoint when a user logs in.
      auth_settings_allowed_external_redirect_urls   = list(string) #(Optional) Specifies a list of External URLs that can be redirected to as part of logging in or logging out of the Linux Web App.
      auth_settings_unauthenticated_client_action    = string       #Possible values include: RedirectToLoginPage, AllowAnonymous.
      default_auth_provider                          = string       #Possible values include: BuiltInAuthenticationProviderAzureActiveDirectory, BuiltInAuthenticationProviderFacebook, BuiltInAuthenticationProviderGoogle, BuiltInAuthenticationProviderMicrosoftAccount, BuiltInAuthenticationProviderTwitter, BuiltInAuthenticationProviderGithub
      auth_settings_issuer                           = string       # (Optional) The action to take when an unauthenticated client attempts to access the app. Possible values include: RedirectToLoginPage, AllowAnonymous.
      multiple_auth_providers_configured             = bool         #(Optional) The OpenID Connect Issuer URI that represents the entity that issues access tokens for this Linux Web App.
      auth_settings_runtime_version                  = string       #(Optional) The RuntimeVersion of the Authentication / Authorization feature in use for the Linux Web App.
      token_refresh_extension_errors                 = string       # (Optional) The number of hours after session token expiration that a session token can be used to call the token refresh API. Defaults to 72 hours.
      auth_settings_token_store_enabled              = bool         #- (Optional) Should the Linux Web App durably store platform-specific security tokens that are obtained during login flows? Defaults to false.
      auth_settings_linux_web_app_ad_secret_required = bool         # make it false if auth_settings_active_directory=null
      auth_settings_active_directory = list(object({                #block supports the following:
        auth_settings_active_directory_client_id     = string       #(Required) The ID of the Client to use to authenticate with Azure Active Directory.
        auth_settings_active_directory_client_secret = string       # (Optional) The Client Secret for the Client ID. Cannot be used with client_secret_setting_name.
        auth_settings_allowed_audiences              = list(string) #(Optional) Specifies a list of Allowed audience values to consider when validating JWTs issued by Azure Active Directory.
        linux_web_app_ad_client_secret_setting_name  = string       # (Optional) The App Setting name that contains the client secret of the Client. Cannot be used with client_secret.
      }))
      linux_web_app_facebook_secret_required = bool                   # make it false if auth_settings_facebook=null
      auth_settings_facebook = list(object({                          # block supports the following:
        facebook_app_id                                = string       #(Required) The App ID of the Facebook app used for login.
        facebook_app_secret                            = string       # (Optional) The App Secret of the Facebook app used for Facebook login. Cannot be specified with app_secret_setting_name.
        facebook_oauth_scopes                          = list(string) # (Optional) Specifies a list of OAuth 2.0 scopes to be requested as part of Facebook login authentication.
        linux_web_app_facebook_app_secret_setting_name = string       # (Optional) The app setting name that contains the app_secret value used for Facebook login. Cannot be specified with app_secret.
      }))
      linux_web_app_github_secret_required = bool # make it false if auth_settings_github=null
      auth_settings_github = list(object({
        github_client_id                                = string       # (Required) The ID of the GitHub app used for login.
        github_client_secret                            = string       # (Optional) The Client Secret of the GitHub app used for GitHub login. Cannot be specified with client_secret_setting_name.
        github_oauth_scopes                             = list(string) #(Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of GitHub login authentication.
        linux_web_app_github_client_secret_setting_name = string       # (Optional) The app setting name that contains the client_secret value used for GitHub login. Cannot be specified with client_secret.
      }))
      linux_web_app_google_secret_required = bool # make it false if auth_settings_google=null
      auth_settings_google = list(object({
        google_client_id                                = string       #(Required) The OpenID Connect Client ID for the Google web application.
        google_client_secret                            = string       # (Optional) The client secret associated with the Google web application. Cannot be specified with client_secret_setting_name.
        google_oauth_scopes                             = list(string) # (Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of Google Sign-In authentication. If not specified, openid, profile, and email are used as default scopes.
        linux_web_app_google_client_secret_setting_name = string       #- (Optional) The app setting name that contains the client_secret value used for Google login. Cannot be specified with client_secret.  
      }))
      linux_web_app_microsoft_secret_required = bool # make it false if auth_settings_microsoft=null
      auth_settings_microsoft = list(object({
        microsoft_client_id                                = string       # (Required) The OAuth 2.0 client ID that was created for the app used for authentication.
        microsoft_client_secret                            = string       #(Optional) The OAuth 2.0 client secret that was created for the app used for authentication. Cannot be specified with client_secret_setting_name.
        linux_web_app_microsoft_client_secret_setting_name = string       # (Optional) The app setting name containing the OAuth 2.0 client secret that was created for the app used for authentication. Cannot be specified with client_secret.
        microsoft_oauth_scopes                             = list(string) #(Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of Microsoft Account authentication. If not specified, "wl.basic" is used as the default scope.
      }))
      linux_web_app_twitter_secret_required = bool # make it false if auth_settings_twitter=null
      auth_settings_twitter = list(object({
        twitter_consumer_secret                            = string #(Optional) The OAuth 1.0a consumer secret of the Twitter application used for sign-in. Cannot be specified with consumer_secret_setting_name.
        twitter_consumer_key                               = string # (Required) The OAuth 1.0a consumer key of the Twitter application used for sign-in.
        linux_web_app_twitter_consumer_secret_setting_name = string #(Optional) The app setting name that contains the OAuth 1.0a consumer secret of the Twitter application used for sign-in. Cannot be specified with consumer_secret.
      }))
    })
    linux_web_app_backup = list(object({
      backup_name                  = string              # (Required) The name which should be used for this Backup.
      linux_web_app_backup_enabled = string              #(Optional) Should this backup job be enabled?
      schedule = list(object({                           #(Required) A schedule block as defined below.
        backup_schedule_frequency_interval      = string #(Required) How often the backup should be executed (e.g. for weekly backup, this should be set to 7 and frequency_unit should be set to Day).
        backup_schedule_frequency_unit          = string # (Required) The unit of time for how often the backup should take place. Possible values include: Day, Hour
        backup_schedule_retention_period_days   = string #(Optional) After how many days backups should be deleted. 
        backup_schedule_start_time              = string #(Optional) When the schedule should start working in RFC-3339 format.
        backup_schedule_keep_atleast_one_backup = string # (Optional) Should the service keep at least one backup, regardless of the age of backup? Defaults to false.
      }))
    }))
    linux_web_app_identity = object({                        #(Optional) An identity block as defined below. 
      linux_web_app_identity_type = string                   # (Required) Specifies the type of Managed Service Identity that should be configured on this Linux Web App. Possible values are SystemAssigned, UserAssigned, and SystemAssigned, UserAssigned (to enable both).
      linux_web_app_user_assigned_identities = list(object({ #(Optional) A list of User Assigned Managed Identity IDs to be assigned to this Linux Web App.
        user_identity_name                = string           #(Optional) if linux web app user assigned identities vlaues are passed then name of the user_identity_name should be provided
        user_identity_resource_group_name = string           #(Optional) if linux web app user assigned identities vlaues are passed then name of the user_identity_name resource group should be provided
      }))
    })
    linux_web_app_site_config = list(object({                                  #(Required) A site_config block as defined below.
      site_config_always_on                                     = bool         # (Optional) If this Linux Web App is Always On enabled. Defaults to true.
      site_config_api_definition_url                            = string       # (Optional) The URL to the API Definition for this Linux Web App.
      site_config_api_management_api_id                         = string       #(Optional) The API Management API ID this Linux Web App is associated with.
      site_config_ftps_state                                    = string       # (Optional) The State of FTP / FTPS service. Possible values include AllAllowed, FtpsOnly, and Disabled.
      site_config_app_command_line                              = string       # (Optional) The App command line to launch.
      site_config_health_check_path                             = string       # (Optional) The path to the Health Check.
      site_config_health_check_eviction_time_in_min             = string       # (Optional) The amount of time in minutes that a node can be unhealthy before being removed from the load balancer. Possible values are between 2 and 10. Only valid in conjunction with health_check_path.
      site_config_http2_enabled                                 = bool         # (Optional) Should the HTTP2 be enabled?
      auto_heal_enabled                                         = bool         #(Optional) Should Auto heal rules be enabled? Required with auto_heal_setting.
      local_mysql_enabled                                       = bool         # (Optional) Use Local MySQL. Defaults to false.
      websockets_enabled                                        = bool         # (Optional) Should Web Sockets be enabled? Defaults to false.
      vnet_route_all_enabled                                    = bool         #(Optional) Should all outbound traffic have NAT Gateways, Network Security Groups and User Defined Routes applied? Defaults to false.
      scm_minimum_tls_version                                   = string       #Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
      scm_use_main_ip_restriction                               = string       #  (Optional) One or more ip_restriction blocks as defined above.
      site_config_use_32_bit_worker                             = string       #(Optional) Should the Linux Web App use a 32-bit worker? Defaults to true.
      site_config_default_documents                             = list(string) # (Optional) Specifies a list of Default Documents for the Linux Web App.
      site_config_load_balancing_mode                           = string       # (Optional) The Site load balancing. Possible values include: WeightedRoundRobin, LeastRequests, LeastResponseTime, WeightedTotalTraffic, RequestHash, PerSiteRoundRobin. Defaults to LeastRequests if omitted.
      site_config_managed_pipeline_mode                         = string       # (Optional) Managed pipeline mode. Possible values include Integrated, and Classic.
      site_config_minimum_tls_version                           = string       # (Optional) The configures the minimum version of TLS required for SSL requests. Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
      site_config_remote_debugging_enabled                      = bool         #(Optional) Should Remote Debugging be enabled? Defaults to false.
      site_config_remote_debugging_version                      = string       # (Optional) The Remote Debugging Version. Possible values include VS2017 and VS2019
      site_config_worker_count                                  = string       # (Optional) The number of Workers for this Linux App Service.
      site_config_container_registry_managed_identity_client_id = string       # (Optional) The Client ID of the Managed Service Identity to use for connections to the Azure Container Registry.
      site_config_container_registry_use_managed_identity       = string       #(Optional) Should connections for Azure Container Registry use Managed Identity.
      site_config_cors = list(object({                                         #block supports the following:
        site_config_cors_allowed_origins     = string                          #(Required) Specifies a list of origins that should be allowed to make cross-origin calls.
        site_config_cors_support_credentials = string                          # (Optional) Whether CORS requests with credentials are allowed. Defaults to false
      }))
      site_config_ip_restriction = list(object({
        ip_restriction_action                    = string #(Optional) The action to take. Possible values are Allow or Deny.
        ip_restriction_service_tag               = string #(Optional) The Service Tag used for this IP Restriction.
        ip_restriction_name                      = string #(Optional) The name which should be used for this ip_restriction.
        ip_restriction_priority                  = string # (Optional) The priority value of this ip_restriction.
        ip_restriction_ip_address                = string #(Optional) The CIDR notation of the IP or IP Range to match. For example: 10.0.0.0/24 or 192.168.10.1/32
        ip_restriction_virtual_network_subnet_id = string #(Optional) The Virtual Network Subnet ID used for this IP Restriction.
        ip_restriction_headers = list(object({            #(Optional) A headers block as defined above.
          headers_x_azure_fdid      = string              # (Optional) Specifies a list of Azure Front Door IDs.
          headers_x_fd_health_probe = string              #(Optional) Specifies if a Front Door Health Probe should be expected.
          headers_x_forwarded_for   = string              #(Optional) Specifies a list of addresses for which matching should be applied. Omitting this value means allow any.
          headers_x_forwarded_host  = string              # (Optional) Specifies a list of Hosts for which matching should be applied.
        }))
      }))
      site_config_scm_ip_restriction = list(object({          # block supports the following:
        scm_ip_restriction_action                    = string # (Optional) The action to take. Possible values are Allow or Deny.
        scm_ip_restriction_service_tag               = string # (Optional) The Service Tag used for this IP Restriction.
        scm_ip_restriction_name                      = string #(Optional) The name which should be used for this ip_restriction.
        scm_ip_restriction_priority                  = string #(Optional) The priority value of this ip_restriction.
        scm_ip_restriction_ip_address                = string # (Optional) The CIDR notation of the IP or IP Range to match. For example: 10.0.0.0/24 or 192.168.10.1/32
        scm_ip_restriction_virtual_network_subnet_id = string #(Optional) The Virtual Network Subnet ID used for this IP Restriction.
        scm_ip_restriction_headers = list(object({            #(Optional) A headers block as defined above.
          headers_x_azure_fdid      = string                  # (Optional) Specifies a list of Azure Front Door IDs.
          headers_x_fd_health_probe = string                  #(Optional) Specifies if a Front Door Health Probe should be expected.
          headers_x_forwarded_for   = string                  # (Optional) Specifies a list of addresses for which matching should be applied. Omitting this value means allow any.
          headers_x_forwarded_host  = string                  #(Optional) Specifies a list of Hosts for which matching should be applied.
        }))
      }))
      site_config_application_stack = list(object({                #block supports the following:
        site_config_application_stack_docker_image        = string #(Optional) The Docker image reference, including repository host as needed.
        site_config_application_stack_docker_image_tag    = string # (Optional) The image Tag to use. e.g. latest.
        site_config_application_stack_dotnet_version      = string # (Optional) The version of .NET to use. Possible values include 3.1, 5.0, 6.0 and 7.0.
        site_config_application_stack_java_server         = string # (Optional) The Java server type. Possible values include JAVA, TOMCAT, and JBOSSEAP.
        site_config_application_stack_java_server_version = string # (Optional) The Version of the java_server to use.
        site_config_application_stack_java_version        = string #(Optional) The Version of Java to use. Supported versions of Java vary depending on the java_server and java_server_version, as well as security and fixes to major versions. Please see Azure documentation for the latest information.
        site_config_application_stack_node_version        = string #Possible values include 12-lts, 14-lts, and 16-lts. This property conflicts with java_version.
        site_config_application_stack_php_version         = string #Possible values include 7.4, and 8.0.
        site_config_application_stack_python_version      = string #Possible values include 3.7, 3.8, and 3.9.
        site_config_application_stack_ruby_version        = string # Possible values include 2.6 and 2.7.
      }))
      site_config_auto_heal_setting = list(object({
        auto_heal_setting_action = list(object({         #(Optional) A action block as defined above.
          action_action_type                    = string # (Required) Predefined action to be taken to an Auto Heal trigger. Possible values include: Recycle.
          action_minimum_process_execution_time = string #(Optional) The minimum amount of time in hh:mm:ss the Linux Web App must have been running before the defined action will be run in the event of a trigger.
        }))
        auto_heal_setting_trigger = list(object({ #(Optional) A trigger block as defined below.
          trigger_requests = list(object({        #block supports the following:
            requests_count    = string            #(Required) The number of requests in the specified interval to trigger this rule.
            requests_interval = string            #(Required) The interval in hh:mm:ss.
          }))
          trigger_slow_request = list(object({ # block supports the following:
            slow_request_count      = string   #(Required) The number of Slow Requests in the time interval to trigger this rule.
            slow_request_interval   = string   #(Required) The time interval in the form hh:mm:ss.
            slow_request_time_taken = string   # (Required) The threshold of time passed to qualify as a Slow Request in hh:mm:ss.
            slow_request_path       = string   #(Optional) The path for which this slow request rule applies.
          }))
          trigger_status_code = list(object({      #block supports the following:
            status_code_count             = string #(Required) The number of occurrences of the defined status_code in the specified interval on which to trigger this rule.
            status_code_interval          = string #(Required) The time interval in the form hh:mm:ss.
            status_code_status_code_range = string #(Required) The status code for this rule, accepts single status codes and status code ranges. e.g. 500 or 400-499. Possible values are integers between 101 and 599
            status_code_path              = string #(Optional) The path to which this rule status code applies.
            status_code_sub_status        = string # (Optional) The Request Sub Status of the Status Code.
            status_code_win32_status      = string #(Optional) The Win32 Status Code of the Request.
          }))
        }))
      }))
    }))
    linux_web_app_subnet_required                = bool   #(Optional) if subnet is required then pass the value has true and provide the value for the below.
    linux_web_app_virtual_network_name           = string #(Optional) if subnet is passed true then we need virtual network name for the subnet.
    linux_web_app_subnet_name                    = string #(Optional) if subnet required true then pass the subnet name
    linux_web_app_subnet_resource_group_name     = string #(Optional) if subnet required true then resource group name should be provided.
    key_vault_name                               = string #(optional) key valut name should be provided for key_vault_reference_identity_id
    key_vault_resource_group_name                = string #(optional) key valut resource group name should be provided for key_vault_reference_identity_id
    app_service_plan_name                        = string #(Required) The name of the Service Plan that this Linux App Service will be created in for the service plan id .
    app_service_plan_resource_group_name         = string #(Required) The service plan resource group name  that this Linux App Service will be created in for the service plan id .
    linux_web_app_storage_account_required       = bool   #(Optional) storage account is required pass true value
    user_storage_account_name                    = string #(Optional) if storage account name is provided true than storage account name should be provided
    storage_account_resource_group_name          = string #(optional) if storage account resource group name is provided true than storage account name should be provided 
    linux_web_app_storage_account_sas_start_time = string #(optional) storage account sas start time should be pass here
    linux_web_app_storage_account_sas_end_time   = string #(optional) storage account sas end time should be pass here
    linux_web_app_tags                           = map(string)
  }))
  description = "Map of variables for Linux Web App"
  default     = {}
}
