locals {
  backup_variable              = { for k, v in var.linux_web_app_variables : k => v if lookup(v, "linux_web_app_backup_enabled", false) == true }
  is_key_vault_required        = { for k, v in var.linux_web_app_variables : k => v if lookup(v, "key_vault_reference_identity_id", false) == true }
  is_subnet_required           = { for k, v in var.linux_web_app_variables : k => v if lookup(v, "linux_web_app_subnet_required", false) == true }
  is_storage_account_required  = { for k, v in var.linux_web_app_variables : k => v if lookup(v, "linux_web_app_storage_account_required", false) == true }
  is_ad_secret_required        = { for k, v in var.linux_web_app_variables : k => v if lookup(v, "auth_settings_linux_web_app_ad_secret_required", false) == true }
  is_facebook_secret_required  = { for k, v in var.linux_web_app_variables : k => v if lookup(v, "linux_web_app_facebook_secret_required", false) == true }
  is_google_secret_required    = { for k, v in var.linux_web_app_variables : k => v if lookup(v, "linux_web_app_google_secret_required", false) == true }
  is_github_secret_required    = { for k, v in var.linux_web_app_variables : k => v if lookup(v, "linux_web_app_github_secret_required", false) == true }
  is_microsoft_secret_required = { for k, v in var.linux_web_app_variables : k => v if lookup(v, "linux_web_app_microsoft_secret_required", false) == true }
  is_twitter_secret_required   = { for k, v in var.linux_web_app_variables : k => v if lookup(v, "linux_web_app_twitter_secret_required", false) == true }
  identities                   = { for k, v in var.linux_web_app_variables : k => lookup(v, "linux_web_app_identity", null) != null ? v.linux_web_app_identity.linux_web_app_identity_type != "SystemAssigned" ? v.linux_web_app_identity.linux_web_app_user_assigned_identities : null : null }
  identities_list = flatten([
    for k, v in local.identities : [for i in v : [
      {
        main_key                          = k
        user_identity_name                = i.user_identity_name
        user_identity_resource_group_name = i.user_identity_resource_group_name
    }]] if v != null
  ])
}
#data source for subnet
data "azurerm_subnet" "subnet" {
  provider             = azurerm.linux_web_app_sub
  for_each             = local.is_subnet_required
  virtual_network_name = each.value.linux_web_app_virtual_network_name
  name                 = each.value.linux_web_app_subnet_name
  resource_group_name  = each.value.linux_web_app_subnet_resource_group_name
}
#data source for user assigned identity
data "azurerm_user_assigned_identity" "linux_user_identity" {
  provider            = azurerm.linux_web_app_sub
  for_each            = { for v in local.identities_list : "${v.main_key},${v.user_identity_name}" => v }
  name                = each.value.user_identity_name
  resource_group_name = each.value.user_identity_resource_group_name
}
#data source for key vault
data "azurerm_key_vault" "key_vault" {
  provider            = azurerm.key_vault_sub
  for_each            = local.is_key_vault_required
  name                = each.value.key_vault_name
  resource_group_name = each.value.key_vault_resource_group_name
}
#data source for key vault secret for ad client 
data "azurerm_key_vault_secret" "AD_client_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = local.is_ad_secret_required
  name         = each.value.linux_web_app_auth_settings.auth_settings_active_directory.auth_settings_active_directory_client_secret
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}
#data source for key vault secret facebook 
data "azurerm_key_vault_secret" "facebook_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = local.is_facebook_secret_required
  name         = each.value.linux_web_app_auth_settings.auth_settings_facebook.facebook_app_secret
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}
#data source for key vault secret for github 
data "azurerm_key_vault_secret" "github_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = local.is_github_secret_required
  name         = each.value.linux_web_app_auth_settings.auth_settings_github.github_client_secret
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}
#data source for key vault secret for google
data "azurerm_key_vault_secret" "google_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = local.is_google_secret_required
  name         = each.value.linux_web_app_auth_settings.auth_settings_google.google_client_secret
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}
#key vault secret for microsofr provider
data "azurerm_key_vault_secret" "microsoft_provider_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = local.is_microsoft_secret_required
  name         = each.value.linux_web_app_auth_settings.auth_settings_microsoft.microsoft_client_secret
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}
#data key vault secret twitter provider
data "azurerm_key_vault_secret" "twitter_provider_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = local.is_twitter_secret_required
  name         = each.value.linux_web_app_auth_settings.auth_settings_twitter.twitter_consumer_secret
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}
#data source for service paln
data "azurerm_service_plan" "app_service_plan" {
  provider            = azurerm.linux_web_app_sub
  for_each            = var.linux_web_app_variables
  name                = each.value.app_service_plan_name
  resource_group_name = each.value.app_service_plan_resource_group_name
}
#data source for storage account
data "azurerm_storage_account" "storage_account" {
  provider            = azurerm.storage_account_sub
  for_each            = local.is_storage_account_required
  name                = each.value.storage_account_name
  resource_group_name = each.value.storage_account_resource_group_name
}
#data source for Storage account sas
data "azurerm_storage_account_sas" "storage_account_sas" {
  provider          = azurerm.storage_account_sub
  for_each          = local.is_storage_account_required
  connection_string = data.azurerm_storage_account.storage_account[each.key].primary_connection_string
  start             = each.value.linux_web_app_storage_account_sas_start_time
  expiry            = each.value.linux_web_app_storage_account_sas_end_time

  resource_types {
    service   = true
    container = true
    object    = true
  }

  services {
    blob  = true
    queue = true
    table = true
    file  = true
  }

  permissions {
    add     = true
    create  = true
    delete  = true
    filter  = true
    list    = true
    process = true
    read    = true
    tag     = true
    update  = true
    write   = true
  }
}

#linux function app resource 
resource "azurerm_linux_web_app" "linux_web_app" {
  provider                        = azurerm.linux_web_app_sub
  for_each                        = var.linux_web_app_variables
  name                            = each.value.linux_web_app_name
  location                        = each.value.linux_web_app_location
  resource_group_name             = each.value.linux_web_app_resource_group_name
  service_plan_id                 = data.azurerm_service_plan.app_service_plan[each.key].id
  client_affinity_enabled         = each.value.linux_web_app_client_affinity_enabled
  client_certificate_enabled      = each.value.linux_web_app_client_certificate_enabled
  client_certificate_mode         = each.value.linux_web_app_client_certificate_enabled == null ? false : each.value.linux_web_app_client_certificate_mode
  enabled                         = each.value.linux_web_app_enabled
  https_only                      = each.value.linux_web_app_https_only
  app_settings                    = each.value.linux_web_app_app_settings
  zip_deploy_file                 = each.value.linux_web_app_zip_deploy_file
  key_vault_reference_identity_id = each.value.key_vault_reference_identity_id
  dynamic "sticky_settings" {
    for_each = each.value.linux_web_app_sticky_settings != null ? toset(each.value.linux_web_app_sticky_settings) : []
    content {
      app_setting_names       = sticky_settings.value.sticky_settings_app_setting_names
      connection_string_names = sticky_settings.value.sticky_settings_connection_string_names
    }
  }
  dynamic "storage_account" {
    for_each = each.value.linux_web_app_storage_account != null && each.value.linux_web_app_storage_account_required == false ? toset(each.value.linux_web_app_storage_account) : []
    content {
      access_key   = data.azurerm_storage_account.storage_account[each.key].primary_access_key
      account_name = each.value.user_storage_account_name
      name         = each.value.storage_account_name
      share_name   = storage_account.value.storage_account_share_name
      type         = storage_account.value.storage_account_type
      mount_path   = storage_account.value.storage_account_mount_path
    }
  }
  dynamic "logs" {
    for_each = each.value.linux_web_app_logs != null ? [1] : []
    content {
      detailed_error_messages = logs.value.logs_detailed_error_messages
      failed_request_tracing  = logs.value.logs_failed_request_tracing
      dynamic "http_logs" {
        for_each = logs.value.http_logs != null ? [1] : []
        content {
          dynamic "azure_blob_storage" {
            for_each = http_logs.value.azure_blob_storage != null && each.value.linux_web_app_storage_account_required == false ? [1] : []
            content {
              retention_in_days = azure_blob_storage.value.azure_blob_storage_retention_in_days
              sas_url           = data.azurerm_storage_account_sas.storage_account_sas[each.key].sas
            }
          }
          dynamic "file_system" {
            for_each = http_logs.value.file_system != null ? [1] : []
            content {
              retention_in_days = file_system.value.content_retention_in_days
              retention_in_mb   = file_system.value.content_retention_in_mb
            }
          }
        }
      }
      dynamic "application_logs" {
        for_each = logs.value.linux_web_app_application_logs != null ? [1] : []
        content {
          file_system_level = application_logs.value.application_logs_filesystem_level
          dynamic "azure_blob_storage" {
            for_each = application_logs.value.azure_blob_storage != null && each.value.linux_web_app_storage_account_required == false ? [1] : []
            content {
              level             = azure_blob_storage.value.azure_blob_storage_level
              retention_in_days = azure_blob_storage.value.azure_blob_storage_retention_in_days
              sas_url           = data.azurerm_storage_account_sas.storage_account_sas[each.key].sas
            }
          }
        }
      }
    }
  }
  dynamic "auth_settings" {
    for_each = each.value.linux_web_app_auth_settings != null ? toset([each.value.linux_web_app_auth_settings]) : []
    content {
      enabled                        = auth_settings.value.auth_settings_enabled
      additional_login_parameters    = auth_settings.value.auth_settings_additional_login_parameters
      allowed_external_redirect_urls = auth_settings.value.auth_settings_allowed_external_redirect_urls
      unauthenticated_client_action  = auth_settings.value.auth_settings_unauthenticated_client_action
      default_provider               = auth_settings.value.auth_settings_unauthenticated_client_action == "RedirectToLoginPage" && auth_settings.value.multiple_auth_providers_configured == true ? auth_settings.value.default_auth_provider : null
      runtime_version                = auth_settings.value.auth_settings_runtime_version
      token_store_enabled            = auth_settings.value.auth_settings_token_store_enabled
      issuer                         = auth_settings.value.auth_settings_issuer
      dynamic "active_directory" {
        for_each = auth_settings.value.auth_settings_active_directory != null ? toset(auth_settings.value.auth_settings_active_directory) : []
        content {
          client_id                  = active_directory.value.auth_settings_active_directory_client_id
          client_secret              = auth_settings.value.auth_settings_linux_web_app_ad_secret_required == true ? data.azurerm_key_vault_secret.AD_client_secret[each.key].value : null
          allowed_audiences          = active_directory.value.auth_settings_allowed_audiences
          client_secret_setting_name = auth_settings.value.auth_settings_linux_web_app_ad_secret_required == false ? active_directory.value.linux_web_app_ad_client_secret_setting_name : null
        }
      }
      dynamic "facebook" {
        for_each = auth_settings.value.auth_settings_facebook != null ? toset(auth_settings.value.auth_settings_facebook) : []
        content {
          app_id                  = facebook.value.facebook_app_id
          app_secret              = auth_settings.value.linux_web_app_facebook_secret_required == true ? data.azurerm_key_vault_secret.facebook_secret[each.key].value : null
          oauth_scopes            = facebook.value.facebook_oauth_scopes
          app_secret_setting_name = auth_settings.value.linux_web_app_facebook_secret_required == false ? facebook.value.linux_web_app_facebook_app_secret_setting_name : null
        }
      }
      dynamic "github" {
        for_each = auth_settings.value.auth_settings_github != null ? toset(auth_settings.value.auth_settings_github) : []
        content {
          client_id                  = github.value.github_client_id
          client_secret              = auth_settings.value.linux_web_app_github_secret_required == true ? data.azurerm_key_vault_secret.github_secret[each.key].value : null
          oauth_scopes               = github.value.github_oauth_scopes
          client_secret_setting_name = auth_settings.value.linux_web_app_github_secret_required == false ? github.value.linux_web_app_github_client_secret_setting_name : null
        }
      }
      dynamic "google" {
        for_each = auth_settings.value.auth_settings_google != null ? toset(auth_settings.value.auth_settings_google) : []
        content {
          client_id                  = google.value.google_client_id
          client_secret              = auth_settings.value.linux_web_app_google_secret_required == true ? data.azurerm_key_vault_secret.google_secret[each.key].value : null
          oauth_scopes               = google.value.google_oauth_scopes
          client_secret_setting_name = auth_settings.value.linux_web_app_google_secret_required == false ? google.value.linux_web_app_google_client_secret_setting_name : null
        }
      }
      dynamic "microsoft" {
        for_each = auth_settings.value.auth_settings_microsoft != null ? toset(auth_settings.value.auth_settings_microsoft) : []
        content {
          client_id                  = microsoft.value.microsoft_client_id
          client_secret              = auth_settings.value.linux_web_app_microsoft_secret_required == true ? data.azurerm_key_vault_secret.microsoft_provider_secret[each.key].value : null
          client_secret_setting_name = auth_settings.value.linux_web_app_microsoft_secret_required == false ? microsoft.value.linux_web_app_microsoft_client_secret_setting_name : null
          oauth_scopes               = microsoft.value.microsoft_oauth_scopes
        }
      }
      dynamic "twitter" {
        for_each = auth_settings.value.auth_settings_twitter != null ? toset(auth_settings.value.auth_settings_twitter) : []
        content {
          consumer_key                 = twitter.value.twitter_consumer_key
          consumer_secret              = auth_settings.value.linux_web_app_twitter_secret_required == true ? data.azurerm_key_vault_secret.twitter_provider_secret[each.key].value : null
          consumer_secret_setting_name = auth_settings.value.linux_web_app_twitter_secret_required == false ? twitter.value.linux_web_app_twitter_consumer_secret_setting_name : null
        }
      }
    }
  }
  dynamic "backup" {
    for_each = each.value.linux_web_app_backup != null && each.value.linux_web_app_storage_account_required == false ? toset(each.value.linux_web_app_backup) : []
    content {
      name                = each.value.backup_name
      storage_account_url = data.azurerm_storage_account_sas.storage_account_sas[each.key].sas
      enabled             = each.value.linux_web_app_backup_enabled
      dynamic "schedule" {
        for_each = backup.value.schedule != null ? toset(backup.value.schedule) : []
        content {
          frequency_interval       = each.value.backup_schedule_frequency_interval
          frequency_unit           = each.value.backup_schedule_frequency_unit
          retention_period_days    = each.value.backup_schedule_retention_period_days
          start_time               = each.value.backup_schedule_start_time
          keep_at_least_one_backup = each.value.backup_schedule_keep_at_least_one_backup
        }
      }
    }
  }
  dynamic "connection_string" {
    for_each = each.value.linux_web_app_connection_string != null ? toset(each.value.linux_web_app_connection_string) : []
    content {
      name  = connection_string.value.connection_string_name
      type  = connection_string.value.connection_string_type
      value = connection_string.value.connection_string_value
    }
  }
  dynamic "identity" { #Required, if boot diagnostics is required
    for_each = each.value.linux_web_app_identity != null ? [1] : []
    content {
      type = each.value.linux_web_app_identity.linux_web_app_identity_type
      identity_ids = each.value.linux_web_app_identity.linux_web_app_identity_type == "SystemAssigned, UserAssigned" || each.value.linux_web_app_identity.linux_web_app_identity_type == "UserAssigned" ? [
        for k, v in each.value.linux_web_app_identity.linux_web_app_user_assigned_identities : data.azurerm_user_assigned_identity.linux_user_identity["${each.key},${v.user_identity_name}"].id
      ] : null
    }
  }
  dynamic "site_config" {
    for_each = each.value.linux_web_app_site_config != null ? toset(each.value.linux_web_app_site_config) : []
    content {
      always_on                                     = site_config.value.site_config_always_on
      api_management_api_id                         = site_config.value.site_config_api_management_api_id
      api_definition_url                            = site_config.value.site_config_api_definition_url
      app_command_line                              = site_config.value.site_config_app_command_line
      ftps_state                                    = site_config.value.site_config_ftps_state
      health_check_path                             = site_config.value.site_config_health_check_path
      health_check_eviction_time_in_min             = site_config.value.site_config_health_check_eviction_time_in_min
      http2_enabled                                 = site_config.value.site_config_http2_enabled
      local_mysql_enabled                           = site_config.value.local_mysql_enabled
      websockets_enabled                            = site_config.value.websockets_enabled
      vnet_route_all_enabled                        = site_config.value.vnet_route_all_enabled
      scm_minimum_tls_version                       = site_config.value.scm_minimum_tls_version
      scm_use_main_ip_restriction                   = site_config.value.scm_use_main_ip_restriction
      use_32_bit_worker                             = site_config.value.site_config_use_32_bit_worker
      default_documents                             = site_config.value.site_config_default_documents
      load_balancing_mode                           = site_config.value.site_config_load_balancing_mode
      managed_pipeline_mode                         = site_config.value.site_config_managed_pipeline_mode
      minimum_tls_version                           = site_config.value.site_config_minimum_tls_version
      remote_debugging_enabled                      = site_config.value.site_config_remote_debugging_enabled
      remote_debugging_version                      = site_config.value.site_config_remote_debugging_enabled == true ? site_config.value.site_config_remote_debugging_version : null
      worker_count                                  = site_config.value.site_config_worker_count
      container_registry_managed_identity_client_id = site_config.value.site_config_container_registry_managed_identity_client_id
      container_registry_use_managed_identity       = site_config.value.site_config_container_registry_use_managed_identity
      dynamic "cors" {
        for_each = site_config.value.site_config_cors != null ? toset(site_config.value.site_config_cors) : []
        content {
          allowed_origins     = cors.value.site_config_cors_allowed_origins
          support_credentials = cors.value.site_config_cors_support_credentials
        }
      }
      dynamic "ip_restriction" {
        for_each = site_config.value.site_config_ip_restriction != null ? [1] : []
        content {
          action                    = ip_restriction.value.ip_restriction_action
          ip_address                = (ip_restriction.value.ip_restriction_service_tag == null && ip_restriction.value.ip_restriction_virtual_network_subnet_id == null) ? ip_restriction.value.ip_restriction_ip_address : null
          name                      = ip_restriction.value.ip_restriction_name
          priority                  = ip_restriction.value.ip_restriction_priority
          service_tag               = (ip_restriction.value.ip_restriction_ip_address == null && ip_restriction.value.ip_restriction_virtual_network_subnet_id == null) ? ip_restriction.value.ip_restriction_service_tag : null
          virtual_network_subnet_id = (ip_restriction.value.ip_restriction_ip_address == null && ip_restriction.value.ip_restriction_service_tag == null) ? data.azurerm_subnet.subnet[each.key].id : null
          dynamic "headers" {
            for_each = ip_restriction.value.ip_restriction_headers != null ? [1] : []
            content {
              x_azure_fdid      = headers.value.headers_x_azure_fdid
              x_fd_health_probe = headers.value.headers_x_fd_health_probe
              x_forwarded_for   = headers.value.headers_x_forwarded_for
              x_forwarded_host  = headers.value.headers_x_forwarded_host
            }
          }
        }
      }
      dynamic "scm_ip_restriction" {
        for_each = site_config.value.site_config_scm_ip_restriction != null ? [1] : []
        content {
          action                    = scm_ip_restriction.value.scm_ip_restriction_action
          ip_address                = (scm_ip_restriction.value.scm_ip_restriction_service_tag == null && scm_ip_restriction.value.scm_ip_restriction_virtual_network_subnet_id == null) ? svm_ip_restriction.value.scm_ip_restriction_ip_address : null
          name                      = scm_ip_restriction.value.scm_ip_restriction_name
          priority                  = scm_ip_restriction.value.scm_ip_restriction_priority
          service_tag               = (scm_ip_restriction.value.scm_ip_restriction_ip_address == null && scm_ip_restriction.value.scm_ip_restriction_virtual_network_subnet_id == null) ? scm_ip_restriction.value.scm_ip_restriction_service_tag : null
          virtual_network_subnet_id = (scm_ip_restriction.value.scm_ip_restriction_ip_address == null && scm_ip_restriction.value.scm_ip_restriction_service_tag == null) ? data.azurerm_subnet.subnet[each.key].id : null
          dynamic "headers" {
            for_each = scm_ip_restriction.value.scm_ip_restriction_headers != null ? [1] : []
            content {
              x_azure_fdid      = headers.value.headers_x_azure_fdid
              x_fd_health_probe = headers.value.headers_x_fd_health_probe
              x_forwarded_for   = headers.value.headers_x_forwarded_for
              x_forwarded_host  = headers.value.headers_x_forwarded_host
            }
          }
        }
      }
      dynamic "application_stack" {
        for_each = site_config.value.site_config_application_stack != null ? [1] : []
        content {
          docker_image        = application_stack.value.site_config_application_stack_docker_image
          docker_image_tag    = application_stack.value.site_config_application_stack_docker_image_tag
          dotnet_version      = application_stack.value.site_config_application_stack_dotnet_version
          java_server         = application_stack.value.site_config_application_stack_java_server
          java_server_version = application_stack.value.site_config_application_stack_java_server_version
          java_version        = application_stack.value.site_config_application_stack_java_version
          node_version        = application_stack.value.site_config_application_stack_node_version
          php_version         = application_stack.value.site_config_application_stack_php_version
          python_version      = application_stack.value.site_config_application_stack_python_version
          ruby_version        = application_stack.value.site_config_application_stack_ruby_version
        }
      }
      dynamic "auto_heal_setting" {
        for_each = site_config.value.auto_heal_enabled == true ? toset(site_config.value.site_config_auto_heal_setting) : []
        content {
          dynamic "action" {
            for_each = auto_heal_setting.value.auto_heal_setting_action != null ? toset(auto_heal_setting.value.auto_heal_setting_action) : []
            content {
              action_type                    = action.value.action_action_type
              minimum_process_execution_time = action.value.action_minimum_process_execution_time
            }
          }
          dynamic "trigger" {
            for_each = auto_heal_setting.value.auto_heal_setting_trigger != null ? toset(auto_heal_setting.value.auto_heal_setting_trigger) : []
            content {
              dynamic "requests" {
                for_each = trigger.value.trigger_requests != null ? [1] : []
                content {
                  count    = requests.value.requests_count
                  interval = requests.value.requests_interval
                }
              }
              dynamic "slow_request" {
                for_each = trigger.value.trigger_slow_request != null ? [1] : []
                content {
                  count      = slow_request.value.slow_request_count
                  interval   = slow_request.value.slow_request_interval
                  time_taken = slow_request.value.slow_request_time_taken
                  path       = slow_request.value.slow_request_path
                }
              }
              dynamic "status_code" {
                for_each = trigger.value.trigger_status_code != null ? [1] : []
                content {
                  count             = status_code.value.status_code_count
                  interval          = status_code.value.status_code_interval
                  status_code_range = status_code.value.status_code_status_code_range
                  path              = status_code.value.status_code_path
                  sub_status        = status_code.value.status_code_sub_status
                  win32_status      = status_code.value.status_code_win32_status
                }
              }
            }
          }
        }
      }
    }
  }
  tags = merge(each.value.linux_web_app_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}
