locals {
  backup_variable                   = { for k, v in var.windows_web_app_variables : k => v if lookup(v, "windows_web_app_backup_enabled", false) == true }
  is_subnet_required                = { for k, v in var.windows_web_app_variables : k => v if lookup(v, "windows_web_app_subnet_required", false) == true }
  is_storage_account_required       = { for k, v in var.windows_web_app_variables : k => v if lookup(v, "windows_web_app_storage_account_required", false) == true }
  is_ad_secret_required             = { for k, v in var.windows_web_app_variables : k => v if lookup(v.windows_web_app_auth_settings, "windows_web_app_ad_secret_required", false) == true && lookup(v.windows_web_app_auth_settings, "auth_settings_active_directory", null) != null }
  is_facebook_secret_required       = { for k, v in var.windows_web_app_variables : k => v if lookup(v.windows_web_app_auth_settings, "windows_web_app_facebook_secret_required", false) == true && lookup(v.windows_web_app_auth_settings, "auth_settings_facebook", null) != null }
  is_google_secret_required         = { for k, v in var.windows_web_app_variables : k => v if lookup(v.windows_web_app_auth_settings, "windows_web_app_google_secret_required", false) == true && lookup(v.windows_web_app_auth_settings, "auth_settings_google", null) != null }
  is_github_secret_required         = { for k, v in var.windows_web_app_variables : k => v if lookup(v.windows_web_app_auth_settings, "windows_web_app_github_secret_required", false) == true && lookup(v.windows_web_app_auth_settings, "auth_settings_github", null) != null }
  is_microsoft_secret_required      = { for k, v in var.windows_web_app_variables : k => v if lookup(v.windows_web_app_auth_settings, "windows_web_app_microsoft_secret_required", false) == true && lookup(v.windows_web_app_auth_settings, "auth_settings_microsoft", null) != null }
  is_twitter_secret_required        = { for k, v in var.windows_web_app_variables : k => v if lookup(v.windows_web_app_auth_settings, "windows_web_app_twitter_secret_required", false) == true && lookup(v.windows_web_app_auth_settings, "auth_settings_twitter", null) != null }
  is_api_management_api_id_required = { for k, v in var.windows_web_app_variables : k => v if lookup(v.windows_web_app_site_config, "site_config_windows_web_app_is_api_management_api_required", false) == true }
  identities                        = { for k, v in var.windows_web_app_variables : k => lookup(v, "windows_web_app_identity", null) != null ? v.windows_web_app_identity.windows_web_app_identity_type != "SystemAssigned" ? v.windows_web_app_identity.windows_web_app_user_assigned_identities : null : null }
  identities_list = flatten([
    for k, v in local.identities : [for i in v : [
      {
        main_key                          = k
        user_identity_name                = i.user_identity_name
        user_identity_resource_group_name = i.user_identity_resource_group_name
    }]] if v != null
  ])
}

locals {
  connection_string_value = flatten([for k, v in var.windows_web_app_variables : [
    for x, y in v.windows_web_app_connection_string :
    merge({ main_key = k, connection_string_key = x }, y)
  ] if v.windows_web_app_connection_string != null])
  app_insights_app_settings = {
    for k, v in var.windows_web_app_variables :
    k => merge(
      {
        APPINSIGHTS_INSTRUMENTATIONKEY             = "${data.azurerm_application_insights.application_insights[k].instrumentation_key}"
        APPLICATIONINSIGHTS_CONNECTION_STRING      = "${data.azurerm_application_insights.application_insights[k].connection_string}"
        ApplicationInsightsAgent_EXTENSION_VERSION = "~2"
      }, v.windows_web_app_app_settings
    ) if v.windows_web_app_application_insights_enabled
  }
}

data "azurerm_application_insights" "application_insights" {
  provider            = azurerm.application_insights_sub
  for_each            = { for k, v in var.windows_web_app_variables : k => v if lookup(v, "windows_web_app_application_insights_enabled", false) == true }
  name                = each.value.windows_web_app_application_insights_name
  resource_group_name = each.value.windows_web_app_application_insights_resource_group_name
}

data "azurerm_subnet" "subnet" {
  provider             = azurerm.windows_web_app_sub
  for_each             = local.is_subnet_required
  virtual_network_name = each.value.windows_web_app_virtual_network_name
  name                 = each.value.windows_web_app_subnet_name
  resource_group_name  = each.value.windows_web_app_subnet_resource_group_name
}
data "azurerm_user_assigned_identity" "windows_user_identity" {
  provider            = azurerm.windows_web_app_sub
  for_each            = { for v in local.identities_list : "${v.main_key},${v.user_identity_name}" => v }
  name                = each.value.user_identity_name
  resource_group_name = each.value.user_identity_resource_group_name
}
data "azurerm_key_vault" "key_vault" {
  provider            = azurerm.key_vault_sub
  for_each            = { for k, v in var.windows_web_app_variables : k => v if lookup(v, "windows_web_app_key_vault_name", null) != null && lookup(v, "windows_web_app_key_vault_resource_group_name", null) != null }
  name                = each.value.windows_web_app_key_vault_name
  resource_group_name = each.value.windows_web_app_key_vault_resource_group_name
}

data "azurerm_key_vault_secret" "connection_string_value" {
  provider     = azurerm.key_vault_sub
  for_each     = { for i in local.connection_string_value : "${i.main_key},${i.connection_string_key}" => i }
  name         = each.value.connection_string_key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault[each.value.main_key].id
}

data "azurerm_key_vault_secret" "AD_client_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = local.is_ad_secret_required
  name         = each.value.windows_web_app_auth_settings.auth_settings_active_directory.active_directory_client_secret
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}

data "azurerm_key_vault_secret" "facebook_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = local.is_facebook_secret_required
  name         = each.value.windows_web_app_auth_settings.auth_settings_facebook.facebook_app_secret
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}

data "azurerm_key_vault_secret" "github_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = local.is_github_secret_required
  name         = each.value.windows_web_app_auth_settings.auth_settings_github.github_client_secret
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}

data "azurerm_key_vault_secret" "google_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = local.is_google_secret_required
  name         = each.value.windows_web_app_auth_settings.auth_settings_google.google_client_secret
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}

data "azurerm_key_vault_secret" "microsoft_provider_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = local.is_microsoft_secret_required
  name         = each.value.windows_web_app_auth_settings.auth_settings_microsoft.microsoft_client_secret
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}

data "azurerm_key_vault_secret" "twitter_provider_secret" {
  provider     = azurerm.windows_web_app_sub
  for_each     = local.is_twitter_secret_required
  name         = each.value.windows_web_app_auth_settings.auth_settings_twitter.twitter_consumer_secret
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}

data "azurerm_api_management_api" "api_management_api" {
  provider            = azurerm.windows_web_app_sub
  for_each            = local.is_api_management_api_id_required
  name                = each.value.windows_web_app_api_management_api_name
  api_management_name = each.value.windows_web_app_api_management_name
  resource_group_name = each.value.windows_web_app_api_management_resource_group_name
  revision            = each.value.windows_web_app_api_management_revision
}

data "azurerm_service_plan" "app_service_plan" {
  provider            = azurerm.windows_web_app_sub
  for_each            = var.windows_web_app_variables
  name                = each.value.windows_web_app_app_service_plan_name
  resource_group_name = each.value.windows_web_app_app_service_plan_resource_group_name
}

data "azurerm_storage_account" "storage_account" {
  provider            = azurerm.storage_account_sub
  for_each            = local.is_storage_account_required
  name                = each.value.windows_web_app_storage_account_name
  resource_group_name = each.value.windows_web_app_storage_account_resource_group_name
}

data "azurerm_storage_account_sas" "storage_account_sas" {
  provider          = azurerm.storage_account_sub
  for_each          = local.is_storage_account_required
  connection_string = data.azurerm_storage_account.storage_account[each.key].primary_connection_string
  start             = each.value.windows_web_app_storage_account_sas_start_time
  expiry            = each.value.windows_web_app_storage_account_sas_end_time

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

data "azurerm_storage_account_blob_container_sas" "blob_container_sas" {
  provider          = azurerm.storage_account_sub
  for_each          = { for k, v in var.windows_web_app_variables : k => v if lookup(v, "windows_web_app_logs") != null && lookup(v, "windows_web_app_storage_account_name") != null && lookup(v, "windows_web_app_storage_container_name") != null }
  connection_string = data.azurerm_storage_account.storage_account[each.key].primary_connection_string
  container_name    = each.value.windows_web_app_storage_container_name
  https_only        = true
  start             = "2023-02-04"
  expiry            = "2023-03-04"

  permissions {
    read   = true
    add    = true
    create = false
    write  = false
    delete = true
    list   = true
  }
}

resource "azurerm_windows_web_app" "windows_web_app" {
  provider                           = azurerm.windows_web_app_sub
  for_each                           = var.windows_web_app_variables
  name                               = each.value.windows_web_app_name
  location                           = each.value.windows_web_app_location
  resource_group_name                = each.value.windows_web_app_resource_group_name
  service_plan_id                    = data.azurerm_service_plan.app_service_plan[each.key].id
  client_affinity_enabled            = each.value.windows_web_app_client_affinity_enabled
  client_certificate_enabled         = each.value.windows_web_app_client_certificate_enabled
  client_certificate_mode            = each.value.windows_web_app_client_certificate_enabled == false ? null : each.value.windows_web_app_client_certificate_mode
  client_certificate_exclusion_paths = each.value.windows_web_app_client_certificate_exclusion_paths
  enabled                            = each.value.windows_web_app_enabled
  https_only                         = each.value.windows_web_app_https_only
  app_settings                       = each.value.windows_web_app_application_insights_enabled == true ? local.app_insights_app_settings[each.key] : each.value.windows_web_app_app_settings
  zip_deploy_file                    = each.value.windows_web_app_zip_deploy_file
  public_network_access_enabled      = each.value.windows_web_app_public_network_access_enabled
  key_vault_reference_identity_id    = each.value.windows_web_app_key_vault_reference_identity_id_required == true ? data.azurerm_user_assigned_identity.windows_user_identity[each.key].id : null
  virtual_network_subnet_id          = each.value.windows_web_app_is_regional_virtual_network_integration_required == true ? data.azurerm_subnet.subnet[each.key].id : null
  dynamic "sticky_settings" {
    for_each = each.value.windows_web_app_sticky_settings != null ? toset(each.value.windows_web_app_sticky_settings) : []
    content {
      app_setting_names       = sticky_settings.value.sticky_settings_app_setting_names
      connection_string_names = sticky_settings.value.sticky_settings_connection_string_names
    }
  }
  dynamic "storage_account" {
    for_each = each.value.windows_web_app_storage_account != null && each.value.windows_web_app_storage_account_required == true ? each.value.windows_web_app_storage_account : {}
    content {
      access_key   = data.azurerm_storage_account.storage_account[each.key].primary_access_key
      account_name = storage_account.value.storage_account_name
      name         = storage_account.value.storage_account_todo_name
      share_name   = storage_account.value.storage_account_share_name
      type         = storage_account.value.storage_account_type
      mount_path   = storage_account.value.storage_account_mount_path
    }
  }
  dynamic "logs" {
    for_each = each.value.windows_web_app_logs != null ? each.value.windows_web_app_logs : []
    content {
      detailed_error_messages = logs.value.logs_detailed_error_messages
      failed_request_tracing  = logs.value.logs_failed_request_tracing
      dynamic "http_logs" {
        for_each = logs.value.http_logs != null ? logs.value.http_logs : []
        content {
          dynamic "azure_blob_storage" {
            for_each = http_logs.value.https_logs_azure_blob_storage != null && each.value.windows_web_app_storage_account_required == true ? [1] : []
            content {
              retention_in_days = azure_blob_storage.value.azure_blob_storage_retention_in_days
              sas_url           = data.azurerm_storage_account_blob_container_sas.blob_container_sas[each.key].sas
            }
          }
          dynamic "file_system" {
            for_each = http_logs.value.https_logs_file_system != null ? http_logs.value.https_logs_file_system : []
            content {
              retention_in_days = file_system.value.file_system_retention_in_days
              retention_in_mb   = file_system.value.file_system_retention_in_mb
            }
          }
        }
      }
      dynamic "application_logs" {
        for_each = logs.value.application_logs != null ? logs.value.application_logs : []
        content {
          file_system_level = application_logs.value.application_logs_file_system_level
          dynamic "azure_blob_storage" {
            for_each = application_logs.value.application_logs_azure_blob_storage != null && each.value.windows_web_app_storage_account_required == true ? [1] : []
            content {
              level             = azure_blob_storage.value.azure_blob_storage_level
              retention_in_days = azure_blob_storage.value.azure_blob_storage_retention_in_days
              sas_url           = data.azurerm_storage_account_blob_container_sas.blob_container_sas[each.key].sas
            }
          }
        }
      }
    }
  }
  dynamic "auth_settings" {
    for_each = each.value.windows_web_app_auth_settings != null ? [each.value.windows_web_app_auth_settings] : []
    content {
      enabled                        = auth_settings.value.auth_settings_enabled
      additional_login_parameters    = auth_settings.value.auth_settings_additional_login_parameters
      allowed_external_redirect_urls = auth_settings.value.auth_settings_allowed_external_redirect_urls
      default_provider               = auth_settings.value.auth_settings_unauthenticated_client_action == "RedirectToLoginPage" ? auth_settings.value.auth_settings_default_provider : null
      issuer                         = auth_settings.value.auth_settings_issuer
      runtime_version                = auth_settings.value.auth_settings_runtime_version
      token_refresh_extension_hours  = auth_settings.value.auth_settings_token_refresh_extension_hours
      token_store_enabled            = auth_settings.value.auth_settings_token_store_enabled
      unauthenticated_client_action  = auth_settings.value.auth_settings_unauthenticated_client_action
      dynamic "active_directory" {
        for_each = auth_settings.value.auth_settings_active_directory != null ? [auth_settings.value.auth_settings_active_directory] : []
        content {
          client_id                  = active_directory.value.active_directory_client_id
          allowed_audiences          = active_directory.value.active_directory_allowed_audiences
          client_secret              = auth_settings.value.windows_web_app_ad_secret_required == true ? data.azurerm_key_vault_secret.AD_client_secret[each.key].value : null
          client_secret_setting_name = auth_settings.value.windows_web_app_ad_secret_required == false ? active_directory.value.active_directory_client_secret_setting_name : null
        }
      }
      dynamic "facebook" {
        for_each = auth_settings.value.auth_settings_facebook != null ? [auth_settings.value.auth_settings_facebook] : []
        content {
          app_id                  = facebook.value.facebook_app_id
          app_secret              = auth_settings.value.windows_web_app_facebook_secret_required == true ? data.azurerm_key_vault_secret.facebook_secret[each.key].value : null
          app_secret_setting_name = auth_settings.value.windows_web_app_facebook_secret_required == false ? facebook.value.facebook_app_secret_setting_name : null
          oauth_scopes            = facebook.value.facebook_oauth_scopes
        }
      }
      dynamic "github" {
        for_each = auth_settings.value.auth_settings_github != null ? [auth_settings.value.auth_settings_github] : []
        content {
          client_id                  = github.value.github_client_id
          client_secret              = auth_settings.value.windows_web_app_github_secret_required == true ? data.azurerm_key_vault_secret.github_secret[each.key].value : null
          client_secret_setting_name = auth_settings.value.windows_web_app_github_secret_required == false ? github.value.github_client_secret_setting_name : null
          oauth_scopes               = github.value.github_oauth_scopes
        }
      }
      dynamic "google" {
        for_each = auth_settings.value.auth_settings_google != null ? [auth_settings.value.auth_settings_google] : []
        content {
          client_id                  = google.value.google_client_id
          client_secret              = auth_settings.value.windows_web_app_google_secret_required == true ? data.azurerm_key_vault_secret.google_secret[each.key].value : null
          client_secret_setting_name = auth_settings.value.windows_web_app_google_secret_required == false ? google.value.google_client_secret_setting_name : null
          oauth_scopes               = google.value.google_oauth_scopes
        }
      }
      dynamic "microsoft" {
        for_each = auth_settings.value.auth_settings_microsoft != null ? [auth_settings.value.auth_settings_microsoft] : []
        content {
          client_id                  = microsoft.value.microsoft_client_id
          client_secret              = auth_settings.value.windows_web_app_microsoft_secret_required == true ? data.azurerm_key_vault_secret.microsoft_provider_secret[each.key].value : null
          client_secret_setting_name = auth_settings.value.windows_web_app_microsoft_secret_required == false ? microsoft.value.microsoft_client_secret_setting_name : null
          oauth_scopes               = microsoft.value.microsoft_oauth_scopes
        }
      }
      dynamic "twitter" {
        for_each = auth_settings.value.auth_settings_twitter != null ? [auth_settings.value.auth_settings_twitter] : []
        content {
          consumer_key                 = twitter.value.twitter_consumer_key
          consumer_secret              = auth_settings.value.windows_web_app_twitter_secret_required == true ? data.azurerm_key_vault_secret.twitter_provider_secret[each.key].value : null
          consumer_secret_setting_name = auth_settings.value.windows_web_app_twitter_secret_required == false ? twitter.value.twitter_consumer_secret_setting_name : null
        }
      }
    }
  }
  dynamic "auth_settings_v2" {
    for_each = each.value.windows_web_app_auth_settings_v2 != null ? toset([each.value.windows_web_app_auth_settings_v2]) : []
    content {
      auth_enabled                            = auth_settings_v2.value.auth_settings_v2_auth_enabled
      runtime_version                         = auth_settings_v2.value.auth_settings_v2_runtime_version
      config_file_path                        = auth_settings_v2.value.auth_settings_v2_config_file_path
      require_authentication                  = auth_settings_v2.value.auth_settings_v2_require_authentication
      unauthenticated_action                  = auth_settings_v2.value.auth_settings_v2_unauthenticated_action
      default_provider                        = auth_settings_v2.value.auth_settings_v2_default_provider
      excluded_paths                          = auth_settings_v2.value.auth_settings_v2_excluded_paths
      require_https                           = auth_settings_v2.value.auth_settings_v2_require_https
      http_route_api_prefix                   = auth_settings_v2.value.auth_settings_v2_http_route_api_prefix
      forward_proxy_convention                = auth_settings_v2.value.auth_settings_v2_forward_proxy_convention
      forward_proxy_custom_host_header_name   = auth_settings_v2.value.auth_settings_v2_forward_proxy_custom_host_header_name
      forward_proxy_custom_scheme_header_name = auth_settings_v2.value.auth_settings_v2_forward_proxy_custom_scheme_header_name
      dynamic "apple_v2" {
        for_each = auth_settings_v2.value.auth_settings_v2_apple_v2 != null ? toset(auth_settings_v2.value.auth_settings_v2_apple_v2) : []
        content {
          client_id                  = apple_v2.value.apple_v2_client_id
          client_secret_setting_name = apple_v2.value.apple_v2_client_secret_setting_name
          login_scopes               = apple_v2.value.apple_v2_login_scopes
        }
      }
      dynamic "active_directory_v2" {
        for_each = auth_settings_v2.value.auth_settings_v2_active_directory_v2 != null ? toset([auth_settings_v2.value.auth_settings_v2_active_directory_v2]) : []
        content {
          client_id                            = active_directory_v2.value.active_directory_v2_client_id
          tenant_auth_endpoint                 = active_directory_v2.value.active_directory_v2_tenant_auth_endpoint
          client_secret_setting_name           = active_directory_v2.value.active_directory_v2_client_secret_setting_name
          client_secret_certificate_thumbprint = active_directory_v2.value.active_directory_v2_client_secret_certificate_thumbprint
          jwt_allowed_groups                   = active_directory_v2.value.active_directory_v2_jwt_allowed_groups
          jwt_allowed_client_applications      = active_directory_v2.value.active_directory_v2_jwt_allowed_client_applications
          www_authentication_disabled          = active_directory_v2.value.active_directory_v2_www_authentication_disabled
          allowed_groups                       = active_directory_v2.value.active_directory_v2_allowed_groups
          allowed_identities                   = active_directory_v2.value.active_directory_v2_allowed_identities
          allowed_applications                 = active_directory_v2.value.active_directory_v2_allowed_applications
          login_parameters                     = active_directory_v2.value.active_directory_v2_login_parameters
          allowed_audiences                    = active_directory_v2.value.active_directory_v2_allowed_audiences
        }
      }
      dynamic "azure_static_web_app_v2" {
        for_each = auth_settings_v2.value.auth_settings_v2_azure_static_web_app_v2 != null ? toset([auth_settings_v2.value.auth_settings_v2_azure_static_web_app_v2]) : []
        content {
          client_id = azure_static_web_app_v2.value.azure_static_web_app_v2_client_id
        }
      }
      dynamic "custom_oidc_v2" {
        for_each = auth_settings_v2.value.auth_settings_v2_custom_oidc_v2 != null ? toset([auth_settings_v2.value.auth_settings_v2_custom_oidc_v2]) : []
        content {
          name                          = custom_oidc_v2.value.custom_oidc_v2_name
          client_id                     = custom_oidc_v2.value.custom_oidc_v2_client_id
          openid_configuration_endpoint = custom_oidc_v2.value.custom_oidc_v2_openid_configuration_endpoint
          name_claim_type               = custom_oidc_v2.value.custom_oidc_v2_name_claim_type
          scopes                        = custom_oidc_v2.value.custom_oidc_v2_scopes
          client_secret_setting_name    = custom_oidc_v2.value.custom_oidc_v2_client_secret_setting_name
          client_credential_method      = custom_oidc_v2.value.custom_oidc_v2_client_credential_method
          authorisation_endpoint        = custom_oidc_v2.value.custom_oidc_v2_authorisation_endpoint
          token_endpoint                = custom_oidc_v2.value.custom_oidc_v2_token_endpoint
          issuer_endpoint               = custom_oidc_v2.value.custom_oidc_v2_issuer_endpoint
          certification_uri             = custom_oidc_v2.value.custom_oidc_v2_certification_uri
        }
      }
      dynamic "facebook_v2" {
        for_each = auth_settings_v2.value.auth_settings_v2_facebook_v2 != null ? toset([auth_settings_v2.value.auth_settings_v2_facebook_v2]) : []
        content {
          app_id                  = facebook_v2.value.facebook_v2_app_id
          app_secret_setting_name = facebook_v2.value.facebook_v2_app_secret_setting_name
          graph_api_version       = facebook_v2.value.facebook_v2_graph_api_version
          login_scopes            = facebook_v2.value.facebook_v2_login_scopes
        }
      }
      dynamic "github_v2" {
        for_each = auth_settings_v2.value.auth_settings_v2_github_v2 != null ? toset([auth_settings_v2.value.auth_settings_v2_github_v2]) : []
        content {
          client_id                  = github_v2.value.github_v2_client_id
          client_secret_setting_name = github_v2.value.github_v2_client_secret_setting_name
          login_scopes               = github_v2.value.github_v2_login_scopes
        }
      }
      dynamic "google_v2" {
        for_each = auth_settings_v2.value.auth_settings_v2_google_v2 != null ? toset([auth_settings_v2.value.auth_settings_v2_google_v2]) : []
        content {
          client_id                  = google_v2.value.google_v2_client_id
          client_secret_setting_name = google_v2.value.google_v2_client_secret_setting_name
          allowed_audiences          = google_v2.value.google_v2_allowed_audiences
          login_scopes               = google_v2.value.google_v2_login_scopes
        }
      }
      dynamic "microsoft_v2" {
        for_each = auth_settings_v2.value.auth_settings_v2_microsoft_v2 != null ? toset([auth_settings_v2.value.auth_settings_v2_microsoft_v2]) : []
        content {
          client_id                  = microsoft_v2.value.microsoft_v2_client_id
          client_secret_setting_name = microsoft_v2.value.microsoft_v2_client_secret_setting_name
          allowed_audiences          = microsoft_v2.value.microsoft_v2_allowed_audiences
          login_scopes               = microsoft_v2.value.microsoft_v2_login_scopes
        }
      }
      dynamic "twitter_v2" {
        for_each = auth_settings_v2.value.auth_settings_v2_twitter_v2 != null ? toset([auth_settings_v2.value.auth_settings_v2_twitter_v2]) : []
        content {
          consumer_key                 = twitter_v2.value.twitter_v2_consumer_key
          consumer_secret_setting_name = twitter_v2.value.twitter_v2_consumer_secret_setting_name
        }
      }
      dynamic "login" {
        for_each = auth_settings_v2.value.auth_settings_v2_login != null ? toset([auth_settings_v2.value.auth_settings_v2_login]) : []
        content {
          logout_endpoint                   = login.value.login_logout_endpoint
          token_refresh_extension_time      = login.value.login_token_refresh_extension_time
          token_store_enabled               = login.value.login_token_store_enabled
          token_store_path                  = login.value.login_token_store_path
          token_store_sas_setting_name      = login.value.login_token_store_sas_setting_name
          preserve_url_fragments_for_logins = login.value.login_preserve_url_fragments_for_logins
          allowed_external_redirect_urls    = login.value.login_allowed_external_redirect_urls
          cookie_expiration_convention      = login.value.login_cookie_expiration_convention
          cookie_expiration_time            = login.value.login_cookie_expiration_time
          validate_nonce                    = login.value.login_validate_nonce
          nonce_expiration_time             = login.value.login_nonce_expiration_time
        }
      }
    }
  }
  dynamic "backup" {
    for_each = each.value.windows_web_app_backup != null && each.value.windows_web_app_storage_account_required == true ? toset(each.value.windows_web_app_backup) : []
    content {
      name                = backup.value.backup_name
      storage_account_url = "${data.azurerm_storage_account.storage_account[each.key].primary_blob_endpoint}${each.value.windows_web_app_storage_container_name}${data.azurerm_storage_account_sas.storage_account_sas[each.key].sas}"
      enabled             = backup.value.backup_enabled
      dynamic "schedule" {
        for_each = backup.value.backup_schedule
        content {
          frequency_interval       = schedule.value.schedule_frequency_interval
          frequency_unit           = schedule.value.schedule_frequency_unit
          retention_period_days    = schedule.value.schedule_retention_period_days
          start_time               = schedule.value.schedule_start_time
          keep_at_least_one_backup = schedule.value.schedule_keep_atleast_one_backup
        }
      }
    }
  }
  dynamic "connection_string" {
    for_each = each.value.windows_web_app_connection_string != null ? each.value.windows_web_app_connection_string : {}
    content {
      name  = connection_string.value.connection_string_name
      type  = connection_string.value.connection_string_type
      value = data.azurerm_key_vault_secret.connection_string_value["${each.key},${connection_string.key}"].value
    }
  }
  dynamic "identity" {
    for_each = each.value.windows_web_app_identity != null ? [1] : []
    content {
      type = each.value.windows_web_app_identity.windows_web_app_identity_type
      identity_ids = each.value.windows_web_app_identity.windows_web_app_identity_type == "SystemAssigned, UserAssigned" || each.value.windows_web_app_identity.windows_web_app_identity_type == "UserAssigned" ? [
        for k, v in each.value.windows_web_app_identity.windows_web_app_user_assigned_identities : data.azurerm_user_assigned_identity.windows_user_identity["${each.key},${v.user_identity_name}"].id
      ] : null
    }
  }
  dynamic "site_config" {
    for_each = each.value.windows_web_app_site_config != null ? [each.value.windows_web_app_site_config] : []
    content {
      always_on                                     = site_config.value.site_config_always_on
      api_management_api_id                         = site_config.value.site_config_windows_web_app_is_api_management_api_required == true ? data.azurerm_api_management_api.api_management_api[each.key].id : null
      app_command_line                              = site_config.value.site_config_app_command_line
      container_registry_managed_identity_client_id = site_config.value.site_config_container_registry_managed_identity_client_id
      container_registry_use_managed_identity       = site_config.value.site_config_container_registry_use_managed_identity
      auto_heal_enabled                             = site_config.value.site_config_auto_heal_enabled
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
      remote_debugging_version                      = site_config.value.site_config_remote_debugging_enabled == true ? site_config.value.site_config_remote_debugging_version : null
      scm_minimum_tls_version                       = site_config.value.site_config_scm_minimum_tls_version
      scm_use_main_ip_restriction                   = site_config.value.site_config_scm_use_main_ip_restriction
      use_32_bit_worker                             = site_config.value.site_config_use_32_bit_worker
      vnet_route_all_enabled                        = site_config.value.site_config_vnet_route_all_enabled
      websockets_enabled                            = site_config.value.site_config_websockets_enabled
      worker_count                                  = site_config.value.site_config_worker_count
      dynamic "cors" {
        for_each = site_config.value.site_config_cors != null ? toset(site_config.value.site_config_cors) : []
        content {
          allowed_origins     = cors.value.site_config_cors_allowed_origins
          support_credentials = cors.value.site_config_cors_support_credentials
        }
      }
      dynamic "virtual_application" {
        for_each = site_config.value.site_config_virtual_application != null ? site_config.value.site_config_virtual_application : {}
        content {
          physical_path = virtual_application.value.virtual_application_physical_path
          preload       = virtual_application.value.virtual_application_preload
          virtual_path  = virtual_application.value.virtual_application_virtual_path
          dynamic "virtual_directory" {
            for_each = virtual_application.value.virtual_application_virtual_directory != null ? virtual_application.value.virtual_application_virtual_directory : {}
            content {
              physical_path = virtual_directory.value.virtual_directory_physical_path
              virtual_path  = virtual_directory.value.virtual_directory_virtual_path
            }
          }
        }
      }
      dynamic "ip_restriction" {
        for_each = site_config.value.site_config_ip_restriction != null ? site_config.value.site_config_ip_restriction : {}
        content {
          action                    = ip_restriction.value.ip_restriction_action
          name                      = ip_restriction.value.ip_restriction_name
          priority                  = ip_restriction.value.ip_restriction_priority
          ip_address                = (ip_restriction.value.ip_restriction_service_tag == null && ip_restriction.value.ip_restriction_virtual_network_subnet_id == null) ? ip_restriction.value.ip_restriction_ip_address : null
          service_tag               = (ip_restriction.value.ip_restriction_ip_address == null && ip_restriction.value.ip_restriction_virtual_network_subnet_id == null) ? ip_restriction.value.ip_restriction_service_tag : null
          virtual_network_subnet_id = (ip_restriction.value.ip_restriction_ip_address == null && ip_restriction.value.ip_restriction_service_tag == null) ? data.azurerm_subnet.subnet[each.key].id : null
          dynamic "headers" {
            for_each = ip_restriction.value.ip_restriction_headers != null ? ip_restriction.value.ip_restriction_headers : []
            content {
              x_azure_fdid      = headers.value.headers_x_azure_fdid
              x_fd_health_probe = headers.value.headers_x_fd_health_probe
              x_forwarded_for   = headers.value.headers_x_forworded_for
              x_forwarded_host  = headers.value.headers_x_forworded_host
            }
          }
        }
      }
      dynamic "scm_ip_restriction" {
        for_each = site_config.value.site_config_scm_ip_restriction != null ? site_config.value.site_config_scm_ip_restriction : {}
        content {
          action                    = scm_ip_restriction.value.scm_ip_restriction_action
          name                      = scm_ip_restriction.value.scm_ip_restriction_name
          priority                  = scm_ip_restriction.value.scm_ip_restriction_priority
          ip_address                = (scm_ip_restriction.value.scm_ip_restriction_service_tag == null && scm_ip_restriction.value.scm_ip_restriction_virtual_network_subnet_id == null) ? scm_ip_restriction.value.scm_ip_restriction_ip_address : null
          service_tag               = (scm_ip_restriction.value.scm_ip_restriction_ip_address == null && scm_ip_restriction.value.scm_ip_restriction_virtual_network_subnet_id == null) ? scm_ip_restriction.value.scm_ip_restriction_service_tag : null
          virtual_network_subnet_id = (scm_ip_restriction.value.scm_ip_restriction_ip_address == null && scm_ip_restriction.value.scm_ip_restriction_service_tag == null) ? data.azurerm_subnet.subnet[each.key].id : null
          dynamic "headers" {
            for_each = scm_ip_restriction.value.scm_ip_restriction_headers != null ? scm_ip_restriction.value.scm_ip_restriction_headers : []
            content {
              x_azure_fdid      = headers.value.headers_x_azure_fdid
              x_fd_health_probe = headers.value.headers_x_fd_health_probe
              x_forwarded_for   = headers.value.headers_x_forworded_for
              x_forwarded_host  = headers.value.headers_x_forworded_host
            }
          }
        }
      }
      dynamic "application_stack" {
        for_each = site_config.value.site_config_application_stack != null ? [site_config.value.site_config_application_stack] : []
        content {
          current_stack                = application_stack.value.application_stack_current_stack
          docker_image_name            = application_stack.value.application_stack_docker_image_name
          docker_registry_url          = application_stack.value.application_stack_docker_registry_url
          docker_registry_username     = application_stack.value.application_stack_docker_registry_username
          docker_registry_password     = application_stack.value.application_stack_docker_registry_password
          dotnet_core_version          = application_stack.value.application_stack_dotnet_core_version
          tomcat_version               = application_stack.value.application_stack_tomcat_version
          java_embedded_server_enabled = application_stack.value.application_stack_java_embedded_server_enabled
          python                       = application_stack.value.application_stack_python
          dotnet_version               = application_stack.value.application_stack_dotnet_version
          java_version                 = application_stack.value.application_stack_java_version
          node_version                 = application_stack.value.application_stack_node_version
          php_version                  = application_stack.value.application_stack_php_version
        }
      }
      dynamic "auto_heal_setting" {
        for_each = site_config.value.site_config_auto_heal_enabled == true ? toset(site_config.value.site_config_auto_heal_setting) : []
        content {
          dynamic "action" {
            for_each = auto_heal_setting.value.auto_heal_setting_action
            content {
              action_type                    = action.value.action_action_type
              minimum_process_execution_time = action.value.action_minimum_process_execution_time
              dynamic "custom_action" {
                for_each = action.value.action_custom_action != null ? [action.value.action_custom_action] : []
                content {
                  executable = custom_action.value.custom_action_executable
                  parameters = custom_action.value.custom_action_parameters
                }
              }
            }
          }
          dynamic "trigger" {
            for_each = auto_heal_setting.value.auto_heal_setting_trigger
            content {
              private_memory_kb = trigger.value.trigger_private_memory_kb
              dynamic "requests" {
                for_each = trigger.value.trigger_requests != null ? [1] : []
                content {
                  count    = requests.value.requests_count
                  interval = requests.value.requests_interval
                }
              }
              dynamic "slow_request" {
                for_each = trigger.value.trigger_slow_request != null ? trigger.value.trigger_slow_request : {}
                content {
                  count      = slow_request.value.slow_request_count
                  interval   = slow_request.value.slow_request_interval
                  time_taken = slow_request.value.slow_request_time_taken
                  path       = slow_request.value.slow_request_path
                }
              }
              dynamic "status_code" {
                for_each = trigger.value.trigger_status_code != null ? trigger.value.trigger_slow_request : {}
                content {
                  count             = status_code.value.status_code_count
                  interval          = status_code.value.status_code_interval
                  status_code_range = status_code.value.status_code_status_code_range
                  path              = status_code.value.status_code_path
                  sub_status        = status_code.value.status_code_sub_status
                  win32_status_code = status_code.value.status_code_win32_status_code
                }
              }
            }
          }
        }
      }
    }
  }
  tags = merge(each.value.windows_web_app_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}
