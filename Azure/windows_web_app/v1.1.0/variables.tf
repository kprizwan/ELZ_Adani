variable "windows_web_app_variables" {
  description = "The map of object of windows web app variables"
  default     = {}
  type = map(object({
    windows_web_app_service_plan_name                = string #(Required) The name of the Service Plan that this Windows App Service will be created in.
    windows_web_app_service_plan_resource_group_name = string #(Required) The resource group name of the Service Plan that this Windows App Service will be created in.

    windows_web_app_key_vault_user_assigned_identity_enabled             = bool   #(Optional) Should user assigned identity for key_vault be enabled to access key_vault secrets. This identity must also be present in windows_web_app_identity block.
    windows_web_app_key_vault_user_assigned_identity_name                = string #(Optional) The key_vault User Assigned Identity name used for accessing KeyVault secrets. The identity must be assigned to the application in the identity block.
    windows_web_app_key_vault_user_assigned_identity_resource_group_name = string #(Optional) The key_vault User Assigned Identity resource group name used for accessing KeyVault secrets. The identity must be assigned to the application in the identity block.
    windows_web_app_key_vault_name                                       = string #(Optional) The key vault name.
    windows_web_app_key_vault_resource_group_name                        = string #(Optional) The key vault resource group name.

    windows_web_app_storage_container_name = string #(Optional) The name of storage container required for blob container sas url.
    storage_account = list(object({
      storage_account_name                = string #(Optional) The backend storage account name which will be used by this Function App.
      storage_account_resource_group_name = string #(Optional) The backend storage account resource group name which will be used by this Function App.
    }))

    windows_web_app_api_management_api_name            = string #(Optional) The name of the API Management API.
    windows_web_app_api_management_name                = string #(Optional) The name of the API Management Service in which the API Management API exists.
    windows_web_app_api_management_resource_group_name = string #(Optional) The Name of the Resource Group in which the API Management Service exists.
    windows_web_app_api_management_api_revision        = string #(Optional) The Revision of the API Management API.

    windows_web_app_container_registry_name                = string #(Optional) This is required if in site_config block site_config_container_registry_use_managed_identity is set to true.
    windows_web_app_container_registry_resource_group_name = string #(Optional) This is required if in site_config block site_config_container_registry_use_managed_identity is set to true.

    windows_web_app_ip_restriction_subnet_name                         = string #(Optional) This value is required if in windows_web_app_site config in ip_restriction_block , the value for "ip_restriction_virtual_network_subnet_id_enabled" is set to true.
    windows_web_app_ip_restriction_virtual_network_name                = string #(Optional) This value is required if in windows_web_app_site config in ip_restriction_block , the value for "ip_restriction_virtual_network_subnet_id_enabled" is set to true.
    windows_web_app_ip_restriction_virtual_network_resource_group_name = string #(Optional) This value is required if in windows_web_app_site config in ip_restriction_block , the value for "ip_restriction_virtual_network_subnet_id_enabled" is set to true.

    windows_web_app_scm_ip_restriction_subnet_name                         = string #(Optional) This value is required if in windows_web_app_site config in scm_ip_restriction_block , the value for "scm_ip_restriction_virtual_network_subnet_id_enabled" is set to true.
    windows_web_app_scm_ip_restriction_virtual_network_name                = string #(Optional) This value is required if in windows_web_app_site config in scm_ip_restriction_block , the value for "scm_ip_restriction_virtual_network_subnet_id_enabled" is set to true.
    windows_web_app_scm_ip_restriction_virtual_network_resource_group_name = string #(Optional) This value is required if in windows_web_app_site config in scm_ip_restriction_block , the value for "scm_ip_restriction_virtual_network_subnet_id_enabled" is set to true.

    windows_web_app_name                       = string #(Required) The name which should be used for this Windows Web App.
    windows_web_app_location                   = string #(Required) The Azure Region where the Windows Web App should exist.
    windows_web_app_resource_group_name        = string #(Required) The name of the Resource Group where the Windows Web App should exist.
    windows_web_app_client_affinity_enabled    = bool   #(Optional) Should Client Affinity be enabled?
    windows_web_app_client_certificate_enabled = bool   #(Optional) Should Client Certificates be enabled?
    windows_web_app_client_certificate_mode    = string #(Optional) The Client Certificate mode. Possible values include Optional and Required. This property has no effect when client_cert_enabled is false.
    windows_web_app_enabled                    = bool   #(Optional) Should the Windows Web App be enabled? Defaults to true.
    windows_web_app_https_only                 = bool   #(Optional) Should the Windows Web App require HTTPS connections.
    windows_web_app_zip_deploy_file            = string #(Optional) The local path and filename of the Zip packaged application to deploy to this Windows Web App.

    windows_web_app_app_settings = map(any) # (Optional) A map of key-value pairs of App Settings.

    windows_web_app_auth_settings_enabled = bool                     #(Optional) Should windows_web_app auth settings be enabled .
    windows_web_app_auth_settings = object({                         #(Optional) A auth_settings block as defined below.
      auth_settings_enabled                           = bool         #(Required) Should the Authentication / Authorization feature be enabled for the windows Web App?
      auth_settings_additional_login_parameters       = map(any)     #(Optional) Specifies a map of login Parameters to send to the OpenID Connect authorization endpoint when a user logs in.
      auth_settings_allowed_external_redirect_urls    = list(string) #(Optional) Specifies a list of External URLs that can be redirected to as part of logging in or logging out of the windows Web App.
      auth_settings_configure_multiple_auth_providers = bool         #(Optional) Should Multiple Authentication providers be configured ?
      auth_settings_default_provider                  = string       #(Optional) The default authentication provider to use when multiple providers are configured. Possible values include: AzureActiveDirectory, Facebook, Google, MicrosoftAccount, Twitter, Github
      auth_settings_runtime_version                   = string       #(Optional) The RuntimeVersion of the Authentication / Authorization feature in use for the windows Web App.
      auth_settings_token_refresh_extension_hours     = number       #(Optional) The number of hours after session token expiration that a session token can be used to call the token refresh API. Defaults to 72 hours.
      auth_settings_token_store_enabled               = bool         #Optional) Should the windows Web App durably store platform-specific security tokens that are obtained during login flows? Defaults to false.
      auth_settings_unauthenticated_client_action     = string       #Optional) The action to take when an unauthenticated client attempts to access the app. Possible values include: RedirectToLoginPage, AllowAnonymous.
      auth_settings_issuer                            = string       #(Optional) The OpenID Connect Issuer URI that represents the entity which issues access tokens for this windows Web App.

      auth_settings_active_directory = object({
        active_directory_enabled                             = bool         #(Required) should active directory authentication be enabled ?
        active_directory_client_id                           = string       #(Required) The ID of the Client to use to authenticate with Azure Active Directory.
        active_directory_client_secret_key_vault_secret_name = string       #(Optional) The Key vault Secret key name for active directory authentication. 
        active_directory_client_secret_setting_name          = string       #(Optional) The App Setting name that contains the client secret of the Client. Cannot be used with client_secret.
        active_directory_allowed_audiences                   = list(string) #(Optional) Specifies a list of Allowed audience values to consider when validating JWTs issued by Azure Active Directory.
      })
      auth_settings_facebook = object({
        facebook_enabled                          = bool         #(Required) should facebook authentication be enabled ?
        facebook_app_id                           = string       #(Required) The App ID of the Facebook app used for login.
        facebook_app_secret_key_vault_secret_name = string       #(Optional) The Key vault Secret key name for facebook authentication.
        facebook_app_secret_setting_name          = string       #(Optional) The app setting name that contains the app_secret value used for Facebook login. Cannot be specified with app_secret.
        facebook_oauth_scopes                     = list(string) #(Optional) Specifies a list of OAuth 2.0 scopes to be requested as part of Facebook login authentication.
      })
      auth_settings_github = object({
        github_enabled                             = bool         #(Required) should github authentication be enabled ?
        github_client_id                           = string       # (Required) The ID of the GitHub app used for login.
        github_client_secret_key_vault_secret_name = string       #(Optional) The Key vault Secret key name for facebook authentication.
        github_client_secret_setting_name          = string       #(Optional) The app setting name that contains the client_secret value used for GitHub login. Cannot be specified with client_secret.
        github_oauth_scopes                        = list(string) #(Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of GitHub login authentication.
      })
      auth_settings_google = object({
        google_enabled                             = bool         #(Required) should google authentication be enabled ?
        google_client_id                           = string       # (Required) The ID of the google app used for login.
        google_client_secret_key_vault_secret_name = string       #(Optional) The Key vault Secret key name for facebook authentication.
        google_client_secret_setting_name          = string       #(Optional) The app setting name that contains the client_secret value used for google login. Cannot be specified with client_secret.
        google_oauth_scopes                        = list(string) #(Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of Google Sign-In authentication. If not specified, openid, profile, and email are used as default scopes.
      })
      auth_settings_microsoft = object({
        microsoft_enabled                             = bool         #(Required) should google authentication be enabled ?
        microsoft_client_id                           = string       # (Required) The ID of the microsoft app used for login.
        microsoft_client_secret_key_vault_secret_name = string       #(Optional) The Key vault Secret key name for facebook authentication.
        microsoft_client_secret_setting_name          = string       #(Optional) The app setting name that contains the client_secret value used for microsoft login. Cannot be specified with client_secret.
        microsoft_oauth_scopes                        = list(string) #(Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of Microsoft Account authentication. If not specified, wl.basic is used as the default scope.
      })
      auth_settings_twitter = object({
        twitter_enabled                               = bool   #(Required) should twitter authentication be enabled ?
        twitter_consumer_key_key_vault_secret_name    = string #(Required) The OAuth 1.0a consumer key of the Twitter application used for sign-in.
        twitter_consumer_secret_key_vault_secret_name = string #(Optional) The Key vault Secret key name for twitter authentication.
        twitter_consumer_secret_setting_name          = string #(Optional) The app setting name that contains the OAuth 1.0a consumer secret of the Twitter application used for sign-in. Cannot be specified with consumer_secret.
      })
    })

    windows_web_app_backup_enabled = bool #(Optional) should backup be enabled for windows_web_app.
    windows_web_app_backup = object({     #(Optional) A backup block as defined below.
      backup_enabled = bool               #(Optional) Should this backup job be enabled?
      backup_name    = string             #(Required) The name which should be used for this Backup.
      backup_schedule = object({
        backup_schedule_frequency_interval       = number #(Required) How often the backup should be executed (e.g. for weekly backup, this should be set to 7 and frequency_unit should be set to Day).
        backup_schedule_frequency_unit           = string #(Required) The unit of time for how often the backup should take place. Possible values include: Day and Hour.
        backup_schedule_keep_at_least_one_backup = bool   #(Optional) Should the service keep at least one backup, regardless of age of backup. Defaults to false.
        backup_schedule_retention_period_days    = number #(Optional) After how many days backups should be deleted.
        backup_schedule_start_time               = string #(Optional) When the schedule should start working in RFC-3339 format.
      })
    })

    windows_web_app_connection_string = map(object({         #(Optional) One or more connection_string blocks as defined below.
      connection_string_name                        = string #(Required) The name which should be used for this Connection.
      connection_string_type                        = string #(Required) Type of database. Possible values include: MySQL, SQLServer, SQLAzure, Custom, NotificationHub, ServiceBus, EventHub, APIHub, DocDb, RedisCache, and PostgreSQL.
      connection_string_value_key_vault_secret_name = string #(Required) The Key vault secret name containing value for each connection string type.
    }))

    windows_web_app_identity = object({                          #(Optional) A identity block as defined below.
      windows_web_app_identity_type = string                     #(Required) Possible values could be "UserAssigned", "SystemAssigned", "SystemAssigned, UserAssigned"
      windows_web_app_user_assigned_identity_ids = list(object({ #(Optional) This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
        identity_name                = string                    #(Required) The user assigned identity name.
        identity_resource_group_name = string                    #(Required) The user assigned identity resource group name.
      }))
    })

    windows_web_app_logs = object({       #(Optional) A logs block as defined below.
      logs_detailed_error_messages = bool #(Optional) Should detailed error messages be enabled.
      logs_failed_request_tracing  = bool #(Optional) Should tracing be enabled for failed requests.

      application_logs = object({                       #(Optional) A application_logs block as defined below.
        application_logs_file_system_level = string     #(Required) Log level. Possible values include: Verbose, Information, Warning, and Error.
        application_logs_azure_blob_storage = object({  #(Optional) A azure_blob_storage block as defined below.
          azure_blob_storage_level             = string #(Required) The level at which to log. Possible values include Error, Warning, Information, Verbose and Off. NOTE: this field is not available for http_logs.
          azure_blob_storage_retention_in_days = number #(Required) The time in days after which to remove blobs. A value of 0 means no retention.
        })
      })

      http_logs = object({                              #(Optional) A http_logs block as defined below.
        http_logs_azure_blob_storage = object({         # (Optional) A azure_blob_storage block as defined below.
          azure_blob_storage_retention_in_days = number #(Required) The time in days after which to remove blobs. A value of 0 means no retention.
        })
        http_logs_file_system = object({         #(Optional) A file_system block as defined below.
          file_system_retention_in_days = number #(Required) The retention period in days. A values of 0 means no retention.
          file_system_retention_in_mb   = string #(Required) The maximum size in megabytes that log files can use.
        })
      })
    })

    windows_web_app_sticky_settings = object({      #(Optional) A sticky_settings block as defined below.
      sticky_app_setting_names       = list(string) #(Optional) A list of app_setting names that the windows_web_app will not swap between Slots when a swap operation is triggered.
      sticky_connection_string_names = list(string) #(Optional) A list of connection_string names that the windows_web_app will not swap between Slots when a swap operation is triggered.
    })

    windows_web_app_storage_account = map(object({ #(Optional) One or more storage_account blocks as defined below
      storage_account_name       = string          #(Required) The name which should be used for this Storage Account.
      storage_account_name       = string          #(Required) The name which should be used for this TODO.
      storage_account_share_name = string          #(Required) The Name of the File Share or Container Name for Blob storage.
      storage_account_type       = string          #(Required) The Azure Storage Type. Possible values include AzureFiles and AzureBlob.
      storage_account_mount_path = string          #(Optional) The path at which to mount the storage share.
    }))

    windows_web_app_site_config = object({                                                #(Required) A site_config block as defined below.
      site_config_always_on                                                = bool         #(Optional) If this Windows Web App is Always On enabled. Defaults to true.
      site_config_api_management_enabled                                   = bool         ##(Optional) Should API Management be enabled for this Windows web App.
      site_config_app_command_line                                         = string       #(Optional) The App command line to launch.
      site_config_auto_heal_enabled                                        = bool         #(Optional) Should Auto heal rules be enabled. Required with auto_heal_setting.
      site_config_container_registry_managed_idenitity_name                = string       #(Optional) The User assigned Managed Service Identity name to use for connections to the Azure Container Registry.
      site_config_container_registry_managed_idenitity_resource_group_name = string       #(Optional) The User assigned Managed Service Identity resource group name to use for connections to the Azure Container Registry.
      site_config_container_registry_use_managed_identity                  = bool         #(Optional) Should connections for Azure Container Registry use Managed Identity.
      site_config_default_documents                                        = list(string) #(Optional) Specifies a list of Default Documents for the Windows Web App.
      site_config_ftps_state                                               = string       #(Optional) The State of FTP / FTPS service. Possible values include: AllAllowed, FtpsOnly, Disabled.
      site_config_health_check_path                                        = string       #(Optional) The path to the Health Check.
      site_config_health_check_eviction_time_in_min                        = number       #(Optional) The amount of time in minutes that a node can be unhealthy before being removed from the load balancer. Possible values are between 2 and 10. Only valid in conjunction with health_check_path.
      site_config_http2_enabled                                            = bool         #(Optional) Should the HTTP2 be enabled?
      site_config_load_balancing_mode                                      = string       #(Optional) The Site load balancing. Possible values include: WeightedRoundRobin, LeastRequests, LeastResponseTime, WeightedTotalTraffic, RequestHash, PerSiteRoundRobin. Defaults to LeastRequests if omitted.
      site_config_local_mysql_enabled                                      = bool         #(Optional) Use Local MySQL. Defaults to false.
      site_config_managed_pipeline_mode                                    = string       #(Optional) Managed pipeline mode. Possible values include: Integrated, Classic.
      site_config_minimum_tls_version                                      = string       #(Optional) The configures the minimum version of TLS required for SSL requests. Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
      site_config_remote_debugging_enabled                                 = bool         #(Optional) Should Remote Debugging be enabled. Defaults to false.
      site_config_remote_debugging_version                                 = string       #(Optional) The Remote Debugging Version. Possible values include VS2017 and VS2019
      site_config_scm_minimum_tls_version                                  = string       #(Optional) The configures the minimum version of TLS required for SSL requests to the SCM site Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
      site_config_scm_use_main_ip_restriction                              = bool         #(Optional) Should the Windows Web App ip_restriction configuration be used for the SCM also.
      site_config_use_32_bit_worker                                        = bool         #(Optional) Should the Windows Web App use a 32-bit worker.
      site_config_websockets_enabled                                       = bool         #(Optional) Should Web Sockets be enabled. Defaults to false.
      site_config_worker_count                                             = number       #(Optional) The number of Workers for this Windows App Service.

      site_config_application_stack = object({               #(Optional) A application_stack block as defined below.
        application_stack_current_stack             = string #(Optional) The Application Stack for the Windows Web App. Possible values include dotnet, dotnetcore, node, python, php, and java.
        application_stack_docker_container_name     = string #(Optional) The name of the Docker Container. For example azure-app-service/samples/aspnethelloworld
        application_stack_docker_container_registry = string #(Optional) The registry Host on which the specified Docker Container can be located. For example mcr.microsoft.com
        application_stack_docker_container_tag      = string #(Optional) The Image Tag of the specified Docker Container to use. For example latest
        application_stack_dotnet_version            = string #(Optional) The version of .NET to use when current_stack is set to dotnet. Possible values include v3.0, v4.0, v5.0, and v6.0.
        application_stack_java_container            = string #(Optional) The Java container type to use when current_stack is set to java. Possible values include JAVA, JETTY, and TOMCAT. Required with java_version and java_container_version.
        application_stack_java_container_version    = string #(Optional) The Version of the java_container to use. Required with java_version and java_container.
        application_stack_java_version              = string #(Optional) The version of Java to use when current_stack is set to java. Possible values include 1.7, 1.8 and 11. Required with java_container and java_container_version.
        application_stack_node_version              = string #(Optional) The version of node to use when current_stack is set to node. Possible values include 12-LTS, 14-LTS, and 16-LTS.
        application_stack_php_version               = string #(Optional) The version of PHP to use when current_stack is set to php. Possible values include v7.4.
        application_stack_python_version            = string #(Optional) The version of Python to use when current_stack is set to python. Possible values include 2.7 and 3.4.0.
      })

      site_config_auto_heal_setting = object({
        auto_heal_setting_action = object({       #(Required) An action block as defined below.
          action_type                    = string # (Required) Predefined action to be taken to an Auto Heal trigger. Possible values include: Recycle, LogEvent, and CustomAction.
          minimum_process_execution_time = string #(Optional) The minimum amount of time in hh:mm:ss the Windows Web App must have been running before the defined action will be run in the event of a trigger.
          custom_action = object({                #(Optional) A custom_action block as defined below.
            custom_action_executable = string     #(Required) The executable to run for the custom_action.
            custom_action_parameters = string     #(Optional) The parameters to pass to the specified executable.
          })
        })

        auto_heal_setting_trigger = object({ #(Required) A trigger block as defined below.
          trigger_private_memory_kb = number #(Optional) The amount of Private Memory to be consumed for this rule to trigger. Possible values are between 102400 and 13631488.
          trigger_requests = object({        # (Optional) A requests block as defined below.
            requests_count    = number       #(Required) The number of requests in the specified interval to trigger this rule.
            requests_interval = string       #(Required) The interval in hh:mm:ss.
          })

          trigger_slow_request = map(object({ #(Optional) One or more slow_request blocks as defined below.
            slow_request_count      = number  #(Required) The number of Slow Requests in the time interval to trigger this rule.
            slow_request_interval   = string  #(Required) The time interval in the form hh:mm:ss.
            slow_request_time_taken = string  #(Required) The threshold of time passed to qualify as a Slow Request in hh:mm:ss.
            slow_request_path       = string  #(Optional) The path for which this slow request rule applies.
          }))

          trigger_status_code = map(object({  #(Optional) One or more status_code blocks as defined above.
            status_code_count        = number #(Required) The number of occurrences of the defined status_code in the specified interval on which to trigger this rule.
            status_code_interval     = string #(Required) The time interval in the form hh:mm:ss.
            status_code_range        = string #(Required) The status code for this rule, accepts single status codes and status code ranges. e.g. 500 or 400-499. Possible values are integers between 101 and 599
            status_code_path         = string #(Optional) The path to which this rule status code applies.
            status_code_sub_status   = string #(Optional) The Request Sub Status of the Status Code.
            status_code_win32_status = string #(Optional) The Win32 Status Code of the Request.
          }))
        })
      })

      site_config_cors_enabled = bool #(Optional) Should windows_web_app cross origin resource sharing be enabled.
      cors = object({
        cors_allowed_origins     = list(string) #(Required) Specifies a list of origins that should be allowed to make cross-origin calls.
        cors_support_credentials = bool         #(Optional) Are credentials allowed in CORS requests? Defaults to false.
      })

      ip_restriction_enabled = bool                               #(Optional) should windows web app ip restriction be enabled.
      ip_restriction = map(object({                               ## NOTE:- One and only one of ip_address, service_tag or virtual_network_subnet_id must be specified.
        ip_restriction_action                            = string #(Optional) The action to take. Possible values are Allow or Deny.
        ip_restriction_ip_address                        = string #(Optional) The CIDR notation of the IP or IP Range to match. For example: 10.0.0.0/24 or 192.168.10.1/32
        ip_restriction_name                              = string #(Optional) The name which should be used for this ip_restriction.
        ip_restriction_priority                          = string #(Optional) The priority value of this ip_restriction.
        ip_restriction_service_tag                       = string #(Optional) The Service Tag used for this IP Restriction.
        ip_restriction_virtual_network_subnet_id_enabled = bool

        ip_restriction_headers = object({
          ip_restriction_headers_x_azure_fdid      = list(string) #(Optional) Specifies a list of Azure Front Door IDs.
          ip_restriction_headers_x_fd_health_probe = list(string) #(Optional) Specifies if a Front Door Health Probe should be expected.
          ip_restriction_headers_x_forwarded_for   = list(string) #(Optional) Specifies a list of addresses for which matching should be applied. Omitting this value means allow any.
          ip_restriction_headers_x_forwarded_host  = list(string) #(Optional) Specifies a list of Hosts for which matching should be applied.
        })
      }))

      scm_ip_restriction_enabled = bool #(Optional) should windows web app scm ip restriction be enabled.
      scm_ip_restriction = map(object({
        scm_ip_restriction_action                            = string #(Optional) The action to take. Possible values are Allow or Deny.
        scm_ip_restriction_ip_address                        = string #(Optional) The CIDR notation of the IP or IP Range to match. For example: 10.0.0.0/24 or 192.168.10.1/32
        scm_ip_restriction_name                              = string #(Optional) The name which should be used for this ip_restriction.
        scm_ip_restriction_priority                          = string #(Optional) The priority value of this ip_restriction.
        scm_ip_restriction_service_tag                       = string #(Optional) The Service Tag used for this IP Restriction.
        scm_ip_restriction_virtual_network_subnet_id_enabled = bool

        scm_ip_restriction_headers = object({
          scm_ip_restriction_headers_x_azure_fdid      = list(string) #(Optional) Specifies a list of Azure Front Door IDs.
          scm_ip_restriction_headers_x_fd_health_probe = list(string) #(Optional) Specifies if a Front Door Health Probe should be expected.
          scm_ip_restriction_headers_x_forwarded_for   = list(string) #(Optional) Specifies a list of addresses for which matching should be applied. Omitting this value means allow any.
          scm_ip_restriction_headers_x_forwarded_host  = list(string) #(Optional) Specifies a list of Hosts for which matching should be applied.
        })
      }))

      site_config_virtual_application = map(object({ #Optional) One or more virtual_application blocks as defined below.
        virtual_application_physical_path = string   #(Required) The physical path for the Virtual Application.
        virtual_application_preload       = bool     #(Required) Should pre-loading be enabled. Defaults to false.
        virtual_application_virtual_path  = string   #(Required) The Virtual Path for the Virtual Application.

        virtual_application_virtual_directory = map(object({ #(Optional) One or more virtual_directory blocks as defined below.
          virtual_directory_physical_path = string           #(Optional) The physical path for the Virtual Application.
          virtual_directory_virtual_path  = string           #(Optional) The Virtual Path for the Virtual Application.
        }))

      }))
    })

    windows_web_app_tags = map(string) #(Optional) A mapping of tags which should be assigned to the Windows Web App.
  }))
}