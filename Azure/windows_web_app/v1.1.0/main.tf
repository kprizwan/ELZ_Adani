locals {
  connection_string_value = flatten([for k, v in var.windows_web_app_variables : [
    for x, y in v.windows_web_app_connection_string :
    merge({ main_key = k, connection_string_key = x }, y)
  ] if v.windows_web_app_connection_string != null])

  identities = { for k, v in var.windows_web_app_variables : k => lookup(v, "windows_web_app_identity", null) != null ? v.windows_web_app_identity.windows_web_app_identity_type != "SystemAssigned" ? v.windows_web_app_identity.windows_web_app_user_assigned_identity_ids : null : null }
  identities_list = flatten([
    for k, v in local.identities : [for i in v : [
      {
        main_key                     = k
        identity_name                = i.identity_name
        identity_resource_group_name = i.identity_resource_group_name
    }]] if v != null
  ])

  storage_account = flatten([
    for k, v in var.windows_web_app_variables : [
      for i in v.storage_account :
      {
        main_key                            = k,
        storage_account_name                = i.storage_account_name,
        storage_account_resource_group_name = i.storage_account_resource_group_name
      }
    ]
  ])
}

locals {
  ip_configuration_details = flatten([for k, v in var.windows_web_app_variables :
    [for i, j in v.windows_web_app_site_config.ip_restriction :
      merge({
        main_key   = k,
        nested_key = i
    }, j) if v.windows_web_app_site_config.ip_restriction_enabled != false && j.ip_restriction_virtual_network_subnet_id_enabled != false]
  ])

  ip_configuration_scm_details = flatten([for k, v in var.windows_web_app_variables :
    [for i, j in v.windows_web_app_site_config.scm_ip_restriction :
      merge({
        main_key   = k,
        nested_key = i
    }, j) if v.windows_web_app_site_config.scm_ip_restriction_enabled != false && j.scm_ip_restriction_virtual_network_subnet_id_enabled != false]
  ])
}

data "azurerm_user_assigned_identity" "user_assigned_identities" {
  provider            = azurerm.user_assigned_identity_sub
  for_each            = { for v in local.identities_list : "${v.main_key},${v.identity_name}" => v }
  name                = each.value.identity_name
  resource_group_name = each.value.identity_resource_group_name
}

data "azurerm_subnet" "ip_restriction_subnet" {
  provider             = azurerm.virtual_network_sub
  for_each             = { for i in local.ip_configuration_details : "${i.main_key},${i.nested_key}" => i }
  name                 = each.value.windows_web_app_ip_restriction_subnet_name
  virtual_network_name = each.value.windows_web_app_ip_restriction_virtual_network_name
  resource_group_name  = each.value.windows_web_app_ip_restriction_virtual_network_resource_group_name
}

data "azurerm_subnet" "scm_ip_restriction_subnet" {
  provider             = azurerm.virtual_network_sub
  for_each             = { for i in local.ip_configuration_scm_details : "${i.main_key},${i.nested_key}" => i }
  name                 = each.value.windows_web_app_scm_ip_restriction_subnet_name
  virtual_network_name = each.value.windows_web_app_scm_ip_restriction_virtual_network_name
  resource_group_name  = each.value.windows_web_app_scm_ip_restriction_virtual_network_resource_group_name
}

data "azurerm_key_vault_secret" "connection_string_value" {
  provider     = azurerm.key_vault_sub
  for_each     = { for i in local.connection_string_value : "${i.main_key},${i.connection_string_key}" => i }
  name         = each.value.connection_string_value_key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault[each.value.main_key].id
}

data "azurerm_key_vault" "key_vault" {
  provider            = azurerm.key_vault_sub
  for_each            = var.windows_web_app_variables
  name                = each.value.windows_web_app_key_vault_name
  resource_group_name = each.value.windows_web_app_key_vault_resource_group_name
}

data "azurerm_key_vault_secret" "AD_client_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = { for k, v in var.windows_web_app_variables : k => v if lookup(v, "windows_web_app_auth_settings_enabled", false) == true && v.windows_web_app_auth_settings.auth_settings_active_directory.active_directory_enabled == true }
  name         = each.value.windows_web_app_auth_settings.auth_settings_active_directory.active_directory_client_secret_key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}

data "azurerm_key_vault_secret" "auth_settings_facebook_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = { for k, v in var.windows_web_app_variables : k => v if(lookup(v, "windows_web_app_auth_settings_enabled", false) == true && v.windows_web_app_auth_settings.auth_settings_facebook.facebook_enabled == true) }
  name         = each.value.windows_web_app_auth_settings.auth_settings_facebook.facebook_app_secret_key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}

data "azurerm_key_vault_secret" "auth_settings_github_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = { for k, v in var.windows_web_app_variables : k => v if(lookup(v, "windows_web_app_auth_settings_enabled", false) == true && v.windows_web_app_auth_settings.auth_settings_github.github_enabled == true) }
  name         = each.value.windows_web_app_auth_settings.auth_settings_github.github_client_secret_key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}

data "azurerm_key_vault_secret" "auth_settings_google_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = { for k, v in var.windows_web_app_variables : k => v if(lookup(v, "windows_web_app_auth_settings_enabled", false) == true && v.windows_web_app_auth_settings.auth_settings_google.google_enabled == true) }
  name         = each.value.windows_web_app_auth_settings.auth_settings_google.google_client_secret_key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}

data "azurerm_key_vault_secret" "auth_settings_microsoft_provider_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = { for k, v in var.windows_web_app_variables : k => v if(lookup(v, "windows_web_app_auth_settings_enabled", false) == true && v.windows_web_app_auth_settings.auth_settings_microsoft.microsoft_enabled == true) }
  name         = each.value.windows_web_app_auth_settings.auth_settings_microsoft.microsoft_client_secret_key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}

data "azurerm_key_vault_secret" "twitter_provider_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = { for k, v in var.windows_web_app_variables : k => v if(lookup(v, "windows_web_app_auth_settings_enabled", false) == true && v.windows_web_app_auth_settings.auth_settings_twitter.twitter_enabled == true) }
  name         = each.value.windows_web_app_auth_settings.auth_settings_twitter.twitter_consumer_secret_key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}

data "azurerm_key_vault_secret" "twitter_consumer_key" {
  provider     = azurerm.key_vault_sub
  for_each     = { for k, v in var.windows_web_app_variables : k => v if(lookup(v, "windows_web_app_auth_settings_enabled", false) == true && v.windows_web_app_auth_settings.auth_settings_twitter.twitter_enabled == true) }
  name         = each.value.windows_web_app_auth_settings.auth_settings_twitter.twitter_consumer_key_key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}

data "azurerm_user_assigned_identity" "key_vault_user_assigned_identity" {
  provider            = azurerm.user_assigned_identity_sub
  for_each            = { for k, v in var.windows_web_app_variables : k => v if lookup(v, "windows_web_app_key_vault_user_assigned_identity_enabled", false) == true }
  name                = each.value.windows_web_app_key_vault_user_assigned_identity_name
  resource_group_name = each.value.windows_web_app_key_vault_user_assigned_identity_resource_group_name
}

data "azurerm_storage_account" "storage_account" {
  provider            = azurerm.storage_account_sub
  for_each            = { for i in local.storage_account : "${i.main_key},${i.storage_account_name}" => i }
  name                = each.value.storage_account_name
  resource_group_name = each.value.storage_account_resource_group_name
}

data "azurerm_storage_account_sas" "storage_account_sas" {
  provider          = azurerm.storage_account_sub
  for_each          = { for i in local.storage_account : "${i.main_key},${i.storage_account_name}" => i if var.windows_web_app_variables[i.main_key].windows_web_app_backup_enabled != false }
  connection_string = data.azurerm_storage_account.storage_account[each.key].primary_connection_string
  https_only        = true
  signed_version    = "2017-07-29"
  start             = "2023-01-21T00:00:00Z"
  expiry            = "2099-01-21T00:00:00Z"

  resource_types {
    service   = true
    container = false
    object    = false
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }


  permissions {
    read    = true
    write   = true
    delete  = false
    list    = false
    add     = true
    create  = true
    update  = false
    process = false
    tag     = false
    filter  = false
  }
}

data "azurerm_storage_account_blob_container_sas" "blob_container_sas" {
  provider          = azurerm.storage_account_sub
  for_each          = { for i in local.storage_account : "${i.main_key},${i.storage_account_name}" => i if var.windows_web_app_variables[i.main_key].windows_web_app_logs != null && var.windows_web_app_variables[i.main_key].windows_web_app_storage_container_name != null }
  connection_string = data.azurerm_storage_account.storage_account[each.key].primary_connection_string
  container_name    = var.windows_web_app_variables[each.value.main_key].windows_web_app_storage_container_name
  https_only        = true
  start             = "2023-02-21"
  expiry            = "2099-06-21"

  permissions {
    read   = true
    add    = true
    create = false
    write  = false
    delete = true
    list   = true
  }
}

data "azurerm_api_management_api" "api_management_api" {
  provider            = azurerm.api_management_sub
  for_each            = { for k, v in var.windows_web_app_variables : k => v if lookup(v.windows_web_app_site_config, "site_config_api_management_enabled", false) == true }
  name                = each.value.windows_web_app_api_management_api_name
  api_management_name = each.value.windows_web_app_api_management_name
  resource_group_name = each.value.windows_web_app_api_management_resource_group_name
  revision            = each.value.windows_web_app_api_management_api_revision
}

data "azurerm_user_assigned_identity" "container_registry_identity" {
  provider            = azurerm.user_assigned_identity_sub
  for_each            = { for k, v in var.windows_web_app_variables : k => v if lookup(v.windows_web_app_site_config, "site_config_container_registry_use_managed_identity", false) == true }
  name                = each.value.windows_web_app_site_config.site_config_container_registry_managed_idenitity_name
  resource_group_name = each.value.windows_web_app_site_config.site_config_container_registry_managed_idenitity_resource_group_name
}

data "azurerm_service_plan" "service_plan" {
  provider            = azurerm.windows_web_app_sub
  for_each            = var.windows_web_app_variables
  name                = each.value.windows_web_app_service_plan_name
  resource_group_name = each.value.windows_web_app_service_plan_resource_group_name
}

# WINDOWS WEB APP RESOURCE
resource "azurerm_windows_web_app" "windows_web_app" {
  provider                        = azurerm.windows_web_app_sub
  for_each                        = var.windows_web_app_variables
  name                            = each.value.windows_web_app_name
  resource_group_name             = each.value.windows_web_app_resource_group_name
  location                        = each.value.windows_web_app_location
  service_plan_id                 = data.azurerm_service_plan.service_plan[each.key].id
  client_affinity_enabled         = each.value.windows_web_app_client_affinity_enabled
  client_certificate_enabled      = each.value.windows_web_app_client_certificate_enabled
  client_certificate_mode         = each.value.windows_web_app_client_certificate_mode
  enabled                         = each.value.windows_web_app_enabled
  https_only                      = each.value.windows_web_app_https_only
  key_vault_reference_identity_id = lookup(each.value, "windows_web_app_key_vault_user_assigned_identity_enabled", false) == true ? data.azurerm_user_assigned_identity.key_vault_user_assigned_identity[each.key].id : null
  zip_deploy_file                 = each.value.windows_web_app_zip_deploy_file

  app_settings = each.value.windows_web_app_app_settings == null ? {} : each.value.windows_web_app_app_settings

  dynamic "auth_settings" {
    for_each = each.value.windows_web_app_auth_settings_enabled == false ? [] : [each.value.windows_web_app_auth_settings]
    content {
      enabled                        = auth_settings.value.auth_settings_enabled
      additional_login_parameters    = auth_settings.value.auth_settings_additional_login_parameters
      allowed_external_redirect_urls = auth_settings.value.auth_settings_allowed_external_redirect_urls
      default_provider               = auth_settings.value.auth_settings_configure_multiple_auth_providers == true && auth_settings.value.auth_settings_unauthenticated_client_action == "RedirectToLoginPage" ? auth_settings.value.auth_settings_default_provider : null
      runtime_version                = auth_settings.value.auth_settings_runtime_version
      token_refresh_extension_hours  = auth_settings.value.auth_settings_token_refresh_extension_hours
      token_store_enabled            = auth_settings.value.auth_settings_token_store_enabled
      unauthenticated_client_action  = auth_settings.value.auth_settings_unauthenticated_client_action
      issuer                         = auth_settings.value.auth_settings_issuer

      dynamic "active_directory" {
        for_each = auth_settings.value.auth_settings_active_directory["active_directory_enabled"] == true ? [auth_settings.value.auth_settings_active_directory] : []
        content {
          client_id                  = active_directory.value.active_directory_client_id
          allowed_audiences          = active_directory.value.active_directory_allowed_audiences
          client_secret              = active_directory.value.active_directory_client_secret_setting_name != null ? null : data.azurerm_key_vault_secret.AD_client_secret[each.key].value
          client_secret_setting_name = active_directory.value.active_directory_client_secret_setting_name == null ? null : active_directory.value.active_directory_client_secret_setting_name
        }
      }
      dynamic "facebook" {
        for_each = auth_settings.value.auth_settings_facebook["facebook_enabled"] == true ? [auth_settings.value.auth_settings_facebook] : []
        content {
          app_id                  = facebook.value.facebook_app_id
          app_secret              = facebook.value.facebook_app_secret_setting_name != null ? null : data.azurerm_key_vault_secret.auth_settings_facebook_secret[each.key].value
          app_secret_setting_name = facebook.value.facebook_app_secret_setting_name == null ? null : facebook.value.facebook_app_secret_setting_name
          oauth_scopes            = facebook.value.facebook_oauth_scopes
        }
      }
      dynamic "github" {
        for_each = auth_settings.value.auth_settings_github["github_enabled"] == true ? [auth_settings.value.auth_settings_github] : []
        content {
          client_id                  = github.value.github_client_id
          client_secret              = github.value.github_client_secret_setting_name != null ? null : data.azurerm_key_vault_secret.auth_settings_github_secret[each.key].value
          client_secret_setting_name = github.value.github_client_secret_setting_name == null ? null : github.value.github_client_secret_setting_name
          oauth_scopes               = github.value.github_oauth_scopes
        }
      }
      dynamic "google" {
        for_each = auth_settings.value.auth_settings_google["google_enabled"] == true ? [auth_settings.value.auth_settings_google] : []
        content {
          client_id                  = google.value.google_client_id
          client_secret              = google.value.google_client_secret_setting_name != null ? null : data.azurerm_key_vault_secret.auth_settings_google_secret[each.key].value
          client_secret_setting_name = google.value.google_client_secret_setting_name == null ? null : google.value.google_client_secret_setting_name
          oauth_scopes               = google.value.google_oauth_scopes
        }
      }
      dynamic "microsoft" {
        for_each = auth_settings.value.auth_settings_microsoft["microsoft_enabled"] == true ? [auth_settings.value.auth_settings_microsoft] : []
        content {
          client_id                  = microsoft.value.microsoft_client_id
          client_secret              = microsoft.value.microsoft_client_secret_setting_name != null ? null : data.azurerm_key_vault_secret.auth_settings_microsoft_provider_secret[each.key].value
          client_secret_setting_name = microsoft.value.microsoft_client_secret_setting_name == null ? null : microsoft.value.microsoft_client_secret_setting_name
          oauth_scopes               = microsoft.value.microsoft_oauth_scopes
        }
      }
      dynamic "twitter" {
        for_each = auth_settings.value.auth_settings_twitter["twitter_enabled"] == true ? [auth_settings.value.auth_settings_twitter] : []
        content {
          consumer_key                 = data.azurerm_key_vault_secret.twitter_consumer_key[each.key].value
          consumer_secret              = twitter.value.twitter_consumer_secret_setting_name != null ? null : data.azurerm_key_vault_secret.twitter_provider_secret[each.key].value
          consumer_secret_setting_name = twitter.value.twitter_consumer_secret_setting_name == null ? null : twitter.value.twitter_consumer_secret_setting_name
        }
      }
    }
  }

  dynamic "backup" {
    for_each = each.value.windows_web_app_backup_enabled != false ? [each.value.windows_web_app_backup] : []
    content {
      enabled             = backup.value.backup_enabled
      name                = backup.value.backup_name
      storage_account_url = "https://${each.value.storage_account[0].storage_account_name}.blob.core.linux.net/${each.value.windows_web_app_storage_container_name}${data.azurerm_storage_account_sas.storage_account_sas["${each.key},${each.value.storage_account[0].storage_account_name}"].sas}&sr=b"
      dynamic "schedule" {
        for_each = [backup.value.backup_schedule]
        content {
          frequency_interval       = schedule.value.backup_schedule_frequency_interval
          frequency_unit           = schedule.value.backup_schedule_frequency_unit
          keep_at_least_one_backup = schedule.value.backup_schedule_keep_at_least_one_backup
          retention_period_days    = schedule.value.backup_schedule_retention_period_days
          start_time               = schedule.value.backup_schedule_start_time
        }
      }
    }
  }

  dynamic "connection_string" {
    for_each = each.value.windows_web_app_connection_string == null ? {} : each.value.windows_web_app_connection_string
    content {
      name  = connection_string.value.connection_string_name
      type  = connection_string.value.connection_string_type
      value = data.azurerm_key_vault_secret.connection_string_value["${each.key},${connection_string.key}"].value
    }
  }

  dynamic "identity" {
    for_each = each.value.windows_web_app_identity != null ? [1] : []
    content {
      type         = each.value.windows_web_app_identity.windows_web_app_identity_type
      identity_ids = each.value.windows_web_app_identity.windows_web_app_user_assigned_identity_ids == null ? [] : [for k, v in each.value.windows_web_app_identity.windows_web_app_user_assigned_identity_ids : data.azurerm_user_assigned_identity.user_assigned_identities["${each.key},${v.identity_name}"].id]
    }
  }

  dynamic "logs" {
    for_each = each.value.windows_web_app_logs == null ? [] : [each.value.windows_web_app_logs]
    content {
      dynamic "application_logs" {
        for_each = logs.value.application_logs == null ? [] : [logs.value.application_logs]
        content {
          dynamic "azure_blob_storage" {
            for_each = application_logs.value.application_logs_azure_blob_storage == null ? [] : [application_logs.value.application_logs_azure_blob_storage]
            content {
              level             = azure_blob_storage.value.azure_blob_storage_level
              retention_in_days = azure_blob_storage.value.azure_blob_storage_retention_in_days
              sas_url           = data.azurerm_storage_account_blob_container_sas.blob_container_sas["${each.key},${each.value.storage_account[0].storage_account_name}"].sas
            }
          }
          file_system_level = application_logs.value.application_logs_file_system_level
        }
      }

      detailed_error_messages = logs.value.logs_detailed_error_messages
      failed_request_tracing  = logs.value.logs_failed_request_tracing

      dynamic "http_logs" {
        for_each = logs.value.http_logs == null ? [] : [logs.value.http_logs]
        content {
          dynamic "azure_blob_storage" {
            for_each = http_logs.value.http_logs_azure_blob_storage == null ? [] : (http_logs.value.http_logs_file_system == null ? [http_logs.value.http_logs_azure_blob_storage] : [])
            content {
              retention_in_days = azure_blob_storage.value.azure_blob_storage_retention_in_days
              sas_url           = data.azurerm_storage_account_blob_container_sas.blob_container_sas["${each.key},${each.value.storage_account[0].storage_account_name}"].sas
            }
          }
          dynamic "file_system" {
            for_each = http_logs.value.http_logs_file_system == null ? [] : (http_logs.value.http_logs_azure_blob_storage == null ? [http_logs.value.http_logs_file_system] : [])
            content {
              retention_in_days = file_system.value.file_system_retention_in_days
              retention_in_mb   = file_system.value.file_system_retention_in_mb
            }
          }
        }
      }
    }
  }

  dynamic "sticky_settings" {
    for_each = each.value.windows_web_app_sticky_settings == null ? [] : [each.value.windows_web_app_sticky_settings]
    content {
      app_setting_names       = sticky_settings.value.sticky_app_setting_names
      connection_string_names = sticky_settings.value.sticky_connection_string_names
    }
  }

  dynamic "storage_account" {
    for_each = each.value.windows_web_app_storage_account == null ? {} : each.value.windows_web_app_storage_account
    content {
      # access_key   = data.azurerm_storage_account.storage_account["${each.key},${each.value.storage_account[0].storage_account_name}"].primary_access_key
      access_key   = data.azurerm_storage_account.storage_account["${each.key},${storage_account.value.storage_account_name}"].primary_access_key
      account_name = storage_account.value.storage_account_name
      name         = storage_account.value.storage_account_name
      share_name   = storage_account.value.storage_account_share_name
      type         = storage_account.value.storage_account_type
      mount_path   = storage_account.value.storage_account_mount_path
    }
  }

  dynamic "site_config" {
    for_each = each.value.windows_web_app_site_config == [] ? [] : [each.value.windows_web_app_site_config]
    content {
      always_on                                     = site_config.value.site_config_always_on
      api_management_api_id                         = site_config.value.site_config_api_management_enabled == true ? data.azurerm_api_management_api.api_management_api[each.key].id : null
      app_command_line                              = site_config.value.site_config_app_command_line
      auto_heal_enabled                             = site_config.value.site_config_auto_heal_enabled
      container_registry_managed_identity_client_id = site_config.value.site_config_container_registry_use_managed_identity == true ? data.azurerm_user_assigned_identity.container_registry_identity[each.key].client_id : null
      container_registry_use_managed_identity       = site_config.value.site_config_container_registry_use_managed_identity
      default_documents                             = site_config.value.site_config_default_documents
      ftps_state                                    = site_config.value.site_config_ftps_state
      health_check_path                             = site_config.value.site_config_health_check_path
      health_check_eviction_time_in_min             = site_config.value.site_config_health_check_eviction_time_in_min
      http2_enabled                                 = site_config.value.site_config_http2_enabled
      load_balancing_mode                           = site_config.value.site_config_load_balancing_mode
      local_mysql_enabled                           = site_config.value.site_config_local_mysql_enabled
      managed_pipeline_mode                         = site_config.value.site_config_managed_pipeline_mode
      minimum_tls_version                           = site_config.value.site_config_minimum_tls_version
      remote_debugging_enabled                      = site_config.value.site_config_remote_debugging_enabled
      remote_debugging_version                      = site_config.value.site_config_remote_debugging_version
      scm_minimum_tls_version                       = site_config.value.site_config_scm_minimum_tls_version
      scm_use_main_ip_restriction                   = site_config.value.site_config_scm_use_main_ip_restriction
      use_32_bit_worker                             = site_config.value.site_config_use_32_bit_worker
      websockets_enabled                            = site_config.value.site_config_websockets_enabled
      worker_count                                  = site_config.value.site_config_worker_count

      dynamic "application_stack" {
        for_each = site_config.value.site_config_application_stack == null ? [] : [site_config.value.site_config_application_stack]
        content {
          current_stack             = application_stack.value.application_stack_current_stack
          docker_container_name     = application_stack.value.application_stack_docker_container_name
          docker_container_registry = application_stack.value.application_stack_docker_container_registry
          docker_container_tag      = application_stack.value.application_stack_docker_container_tag
          dotnet_version            = application_stack.value.application_stack_current_stack == "dotnet" ? application_stack.value.application_stack_dotnet_version : null
          java_container            = application_stack.value.application_stack_current_stack == "java" ? application_stack.value.application_stack_java_container : null
          java_container_version    = application_stack.value.application_stack_current_stack == "java" ? application_stack.value.application_stack_java_container_version : null
          java_version              = application_stack.value.application_stack_current_stack == "java" ? application_stack.value.application_stack_java_version : null
          node_version              = application_stack.value.application_stack_current_stack == "node" ? application_stack.value.application_stack_node_version : null
          php_version               = application_stack.value.application_stack_current_stack == "php" ? application_stack.value.application_stack_php_version : null
          python_version            = application_stack.value.application_stack_current_stack == "python" ? application_stack.value.application_stack_python_version : null
        }
      }

      dynamic "auto_heal_setting" {
        for_each = site_config.value.site_config_auto_heal_enabled == true ? [site_config.value.site_config_auto_heal_setting] : []
        content {
          dynamic "action" {
            for_each = [auto_heal_setting.value.auto_heal_setting_action]
            content {
              action_type                    = action.value.action_type
              minimum_process_execution_time = action.value.minimum_process_execution_time

              dynamic "custom_action" {
                for_each = action.value.custom_action == null ? [] : [action.value.custom_action]
                content {
                  executable = custom_action.value.custom_action_executable
                  parameters = custom_action.value.custom_action_parameters
                }
              }
            }
          }

          dynamic "trigger" {
            for_each = [auto_heal_setting.value.auto_heal_setting_trigger]
            content {
              private_memory_kb = trigger.value.trigger_private_memory_kb

              dynamic "requests" {
                for_each = trigger.value.trigger_requests == null ? [] : [trigger.value.trigger_requests]
                content {
                  count    = requests.value.requests_count
                  interval = requests.value.requests_interval
                }
              }

              dynamic "slow_request" {
                for_each = trigger.value.trigger_slow_request == null ? {} : trigger.value.trigger_slow_request
                content {
                  count      = slow_request.value.slow_request_count
                  interval   = slow_request.value.slow_request_interval
                  time_taken = slow_request.value.slow_request_time_taken
                  path       = slow_request.value.slow_request_path
                }
              }

              dynamic "status_code" {
                for_each = trigger.value.trigger_status_code == null ? {} : trigger.value.trigger_status_code
                content {
                  count             = status_code.value.status_code_count
                  interval          = status_code.value.status_code_interval
                  status_code_range = status_code.value.status_code_range
                  path              = status_code.value.status_code_path
                  sub_status        = status_code.value.status_code_sub_status
                  win32_status      = status_code.value.status_code_win32_status
                }
              }
            }
          }
        }
      }

      dynamic "cors" {
        for_each = site_config.value.site_config_cors_enabled == true ? [site_config.value.cors] : []
        content {
          allowed_origins     = cors.value.cors_allowed_origins
          support_credentials = cors.value.cors_support_credentials
        }
      }

      dynamic "ip_restriction" {
        for_each = site_config.value.ip_restriction_enabled == false ? {} : site_config.value.ip_restriction
        content {
          action                    = ip_restriction.value.ip_restriction_action
          ip_address                = ip_restriction.value.ip_restriction_ip_address
          name                      = ip_restriction.value.ip_restriction_name
          priority                  = ip_restriction.value.ip_restriction_priority
          service_tag               = ip_restriction.value.ip_restriction_service_tag
          virtual_network_subnet_id = lookup(ip_restriction.value, "ip_restriction_virtual_network_subnet_id_enabled", false) == true ? data.azurerm_subnet.ip_restriction_subnet["${each.key},${ip_restriction.key}"].id : null

          dynamic "headers" {
            for_each = ip_restriction.value.ip_restriction_headers == null ? [] : [ip_restriction.value.ip_restriction_headers]
            content {
              x_azure_fdid      = headers.value.ip_restriction_headers_x_azure_fdid
              x_fd_health_probe = headers.value.ip_restriction_headers_x_fd_health_probe
              x_forwarded_for   = headers.value.ip_restriction_headers_x_forwarded_for
              x_forwarded_host  = headers.value.ip_restriction_headers_x_forwarded_host
            }
          }
        }
      }

      dynamic "scm_ip_restriction" {
        for_each = site_config.value.scm_ip_restriction_enabled == false ? {} : site_config.value.scm_ip_restriction
        content {
          action                    = scm_ip_restriction.value.scm_ip_restriction_action
          ip_address                = scm_ip_restriction.value.scm_ip_restriction_ip_address
          name                      = scm_ip_restriction.value.scm_ip_restriction_name
          priority                  = scm_ip_restriction.value.scm_ip_restriction_priority
          service_tag               = scm_ip_restriction.value.scm_ip_restriction_service_tag
          virtual_network_subnet_id = lookup(scm_ip_restriction.value, "scm_ip_restriction_virtual_network_subnet_id_enabled", false) == true ? data.azurerm_subnet.scm_ip_restriction_subnet["${each.key},${scm_ip_restriction.key}"].id : null

          dynamic "headers" {
            for_each = scm_ip_restriction.value.scm_ip_restriction_headers == null ? [] : [scm_ip_restriction.value.scm_ip_restriction_headers]
            content {
              x_azure_fdid      = headers.value.scm_ip_restriction_headers_x_azure_fdid
              x_fd_health_probe = headers.value.scm_ip_restriction_headers_x_fd_health_probe
              x_forwarded_for   = headers.value.scm_ip_restriction_headers_x_forwarded_for
              x_forwarded_host  = headers.value.scm_ip_restriction_headers_x_forwarded_host
            }
          }
        }
      }

      dynamic "virtual_application" {
        for_each = site_config.value.site_config_virtual_application == null ? {} : site_config.value.site_config_virtual_application
        content {
          physical_path = virtual_application.value.virtual_application_physical_path
          preload       = virtual_application.value.virtual_application_preload
          virtual_path  = virtual_application.value.virtual_application_virtual_path

          dynamic "virtual_directory" {
            for_each = virtual_application.value.virtual_application_virtual_directory == null ? {} : virtual_application.value.virtual_application_virtual_directory
            content {
              physical_path = virtual_directory.value.virtual_directory_physical_path
              virtual_path  = virtual_directory.value.virtual_directory_virtual_path
            }
          }
        }
      }
    }
  }

  tags = merge(each.value.windows_web_app_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"], connection_string] }
}