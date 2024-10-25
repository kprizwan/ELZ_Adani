#LINUX WEB APP VARIABLE
variable "linux_web_app_variables" {
  type = map(object({
    linux_web_app_name                       = string
    linux_web_app_location                   = string
    linux_web_app_resource_group_name        = string
    linux_web_app_client_affinity_enabled    = bool
    linux_web_app_client_certificate_enabled = string
    linux_web_app_client_certificate_mode    = string
    linux_web_app_app_settings               = map(string)
    linux_web_app_enabled                    = bool #Defaults to true
    linux_web_app_https_only                 = bool
    linux_web_app_app_settings_enabled       = bool
    linux_web_app_zip_deploy_file            = string
    key_vault_reference_identity_id          = string
    linux_web_app_sticky_settings = list(object({
      sticky_settings_app_setting_names       = string
      sticky_settings_connection_string_names = string
    }))
    linux_web_app_connection_string = list(object({
      connection_string_name  = string
      connection_string_type  = string #Possible values include: MySQL, SQLServer, SQLAzure, Custom, NotificationHub, ServiceBus, EventHub, APIHub, DocDb, RedisCache, and PostgreSQL.
      connection_string_value = string
    }))

    linux_web_app_storage_account = list(object({
      storage_account_name       = string
      storage_account_share_name = string
      storage_account_type       = string
      storage_account_mount_path = string
    }))
    linux_web_app_logs = list(object({
      logs_detailed_error_messages = string
      logs_failes_request_tracing  = string
      http_logs = list(object({
        azure_blob_storage = list(object({
          azure_blob_storage_retention_in_days = string
        }))
        file_system = list(object({
          retention_in_days = string
          retention_in_mb   = string
        }))
      }))
      linux_web_app_application_logs = list(object({
        file_system_level = string #Possible values include Error, Warning, Information, Verbose and Off
        azure_blob_storage = list(object({
          azure_blob_storage_level             = string
          azure_blob_storage_retention_in_days = string
        }))
      }))
    }))
    linux_web_app_auth_settings = object({
      auth_settings_enabled                        = bool
      auth_settings_additional_login_parameters    = map(string)
      auth_settings_allowed_external_redirect_urls = list(string)
      unauthenticated_client_action                = string #Possible values include: RedirectToLoginPage, AllowAnonymous.
      default_auth_provider                        = string #Possible values include: BuiltInAuthenticationProviderAzureActiveDirectory, BuiltInAuthenticationProviderFacebook, BuiltInAuthenticationProviderGoogle, BuiltInAuthenticationProviderMicrosoftAccount, BuiltInAuthenticationProviderTwitter, BuiltInAuthenticationProviderGithub
      auth_settings_issuer                         = string
      multiple_auth_providers_configured           = bool
      runtime_version                              = string
      token_refresh_extension_errors               = string
      token_store_enabled                          = bool
      linux_web_app_ad_secret_required             = bool # make it false if auth_settings_active_directory=null
      auth_settings_active_directory = list(object({
        auth_settings_active_directory_client_id     = string
        auth_settings_active_directory_client_secret = string
        allowed_audiences                            = list(string)
        linux_web_app_ad_client_secret_setting_name  = string
      }))
      linux_web_app_facebook_secret_required = bool # make it false if auth_settings_facebook=null
      auth_settings_facebook = list(object({
        facebook_app_id                                = string
        facebook_app_secret                            = string
        facebook_oauth_scopes                          = list(string)
        linux_web_app_facebook_app_secret_setting_name = string
      }))
      linux_web_app_github_secret_required = bool # make it false if auth_settings_github=null
      auth_settings_github = list(object({
        github_client_id                                = string
        github_client_secret                            = string
        github_oauth_scopes                             = list(string)
        linux_web_app_github_client_secret_setting_name = string
      }))
      linux_web_app_google_secret_required = bool # make it false if auth_settings_google=null
      auth_settings_google = list(object({
        google_client_id                                = string
        google_client_secret                            = string
        google_oauth_scopes                             = list(string) #If not specified, openid, profile, and email are used as default scopes.
        linux_web_app_google_client_secret_setting_name = string
      }))
      linux_web_app_microsoft_secret_required = bool # make it false if auth_settings_microsoft=null
      auth_settings_microsoft = list(object({
        microsoft_client_id                                = string
        microsoft_client_secret                            = string
        linux_web_app_microsoft_client_secret_setting_name = string
        microsoft_oauth_scopes                             = list(string)
      }))
      linux_web_app_twitter_secret_required = bool # make it false if auth_settings_twitter=null
      auth_settings_twitter = list(object({
        twitter_consumer_secret                            = string
        twitter_consumer_key                               = string
        linux_web_app_twitter_consumer_secret_setting_name = string
      }))
    })
    linux_web_app_backup = list(object({
      backup_name                  = string
      linux_web_app_backup_enabled = string
      schedule = list(object({
        backup_schedule_frequency_interval      = string
        backup_schedule_frequency_unit          = string
        backup_schedule_retention_period_days   = string
        backup_schedule_start_time              = string
        backup_schedule_keep_atleast_one_backup = string
      }))
    }))
    linux_web_app_identity = object({
      linux_web_app_identity_type = string
      linux_web_app_user_assigned_identities = list(object({
        user_identity_name                = string
        user_identity_resource_group_name = string
      }))
    })
    linux_web_app_site_config = list(object({
      site_config_always_on                                     = bool #always_on must be explicitly set to false when using Free, F1, D1, or Shared Service Plans.
      site_config_api_management_config_id                      = string
      site_config_ftps_state                                    = string
      site_config_app_command_line                              = string
      site_config_health_check_path                             = string
      site_config_health_check_eviction_time_in_min             = string
      site_config_http2_enabled                                 = bool
      auto_heal_enabled                                         = bool
      local_mysql_enabled                                       = bool
      websockets_enabled                                        = bool
      vnet_route_all_enabled                                    = bool
      scm_minimum_tls_version                                   = string #Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
      scm_use_main_ip_restriction                               = string
      site_config_use_32_bit_worker                             = string
      site_config_default_documents                             = list(string)
      site_config_load_balancing_mode                           = string #Possible values include: WeightedRoundRobin, LeastRequests, LeastResponseTime, WeightedTotalTraffic, RequestHash, PerSiteRoundRobin. Defaults to LeastRequests
      site_config_managed_pipeline_mode                         = string
      site_config_minimum_tls_version                           = string
      site_config_remote_debugging                              = bool
      site_config_remote_debugging_version                      = string #Possible values include VS2017 and VS2019
      site_config_worker_count                                  = string
      site_config_container_registry_managed_identity_client_id = string
      site_config_container_registry_use_managed_identity       = string
      site_config_cors = list(object({
        site_config_cors_allowed_origins     = string
        site_config_cors_support_credentials = string
      }))
      site_config_ip_restriction = list(object({
        ip_restriction_action                    = string
        ip_restriction_service_tag               = string
        ip_restriction_name                      = string
        ip_restriction_priority                  = string
        ip_restriction_ip_address                = string
        ip_restriction_virtual_network_subnet_id = string
        ip_restriction_headers = list(object({
          x_azure_fdid      = string
          x_fd_health_probe = string
          x_forworded_for   = string
          x_forworded_host  = string
        }))
      }))
      site_config_scm_ip_restriction = list(object({
        scm_ip_restriction_action                    = string
        scm_ip_restriction_service_tag               = string
        scm_ip_restriction_name                      = string
        scm_ip_restriction_priority                  = string
        scm_ip_restriction_ip_address                = string
        scm_ip_restriction_virtual_network_subnet_id = string
        scm_ip_restriction_headers = list(object({
          x_azure_fdid      = string
          x_fd_health_probe = string
          x_forworded_for   = string
          x_forworded_host  = string
        }))
      }))
      site_config_application_stack = list(object({
        site_config_application_stack_docker_image        = string
        site_config_application_stack_docker_image_tag    = string #latest
        site_config_application_stack_dotnet_version      = string # Possible values include 3.1, 5.0, and 6.0.
        site_config_application_stack_java_server         = string # Possible values include JAVA, TOMCAT, and JBOSSEAP.
        site_config_application_stack_java_server_version = string
        site_config_application_stack_java_version        = string
        site_config_application_stack_node_version        = string #Possible values include 12-lts, 14-lts, and 16-lts. This property conflicts with java_version.
        site_config_application_stack_php_version         = string #Possible values include 7.4, and 8.0.
        site_config_application_stack_python_version      = string #Possible values include 3.7, 3.8, and 3.9.
        site_config_application_stack_ruby_version        = string # Possible values include 2.6 and 2.7.
      }))
      site_config_auto_heal_setting = list(object({
        auto_heal_setting_action = list(object({
          action_action_type                    = string
          action_minimum_process_execution_time = string
        }))
        auto_heal_setting_trigger = list(object({
          trigger_requests = list(object({
            requests_count    = string
            requests_interval = string
          }))
          trigger_slow_request = list(object({
            slow_request_count      = string
            slow_request_interval   = string
            slow_request_time_taken = string
            slow_request_path       = string
          }))
          trigger_status_code = list(object({
            status_code_count             = string
            status_code_interval          = string
            status_code_status_code_range = string #Possible values are integers between 101 and 599
            status_code_path              = string
            status_code_sub_status        = string
            status_code_win32_status      = string
          }))
        }))
      }))
    }))
    linux_web_app_subnet_required                = bool
    linux_web_app_virtual_network_name           = string
    linux_web_app_subnet_name                    = string
    linux_web_app_subnet_resource_group_name     = string
    key_vault_name                               = string
    key_vault_resource_group_name                = string
    app_service_plan_name                        = string
    app_service_plan_resource_group_name         = string
    linux_web_app_storage_account_required       = bool
    storage_account_name                         = string
    storage_account_resource_group_name          = string
    linux_web_app_storage_account_sas_start_time = string
    linux_web_app_storage_account_sas_end_time   = string
    linux_web_app_tags                           = map(string)
  }))
}
