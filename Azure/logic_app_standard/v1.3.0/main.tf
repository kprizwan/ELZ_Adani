locals {
  identities_list = flatten([
    for k, v in var.logic_app_standard_variables : [
      for i, j in v.logic_app_standard_identity.logic_app_standard_user_assigned_identities : [
        merge(
          {
            main_key                     = k
            identity_name                = j.logic_app_standard_user_identity_name
            identity_resource_group_name = j.logic_app_standard_user_identity_resource_group_name
          },
          j
        )
      ]
    ] if v.logic_app_standard_identity.logic_app_standard_user_assigned_identities != null
  ])
}
locals {
  is_key_vault_exists = { for k, v in var.logic_app_standard_variables : k => v if lookup(v, "is_connection_string_required", false) == true }
}
locals {
  is_subnet_exists = { for k, v in var.logic_app_standard_variables : k => v if lookup(v, "is_subnet_required", false) == true }
}

locals {
  is_storage_share_exists = { for k, v in var.logic_app_standard_variables : k => v if lookup(v, "storage_account_share_name_required", false) == true }
}
#DATA FOR STORAGE SHARE
data "azurerm_storage_share" "storage_share" {
  provider             = azurerm.storage_account_sub
  for_each             = local.is_storage_share_exists
  name                 = each.value.logic_app_standard_storage_share_name
  storage_account_name = each.value.logic_app_standard_storage_account_storage_share_name
}
#DATA FOR USER ASSIGNED IDENTITY
data "azurerm_user_assigned_identity" "logic_app_standard_user_assigned_identity" {
  provider            = azurerm.logic_app_standard_sub
  for_each            = { for v in local.identities_list : "${v.main_key},${v.identity_name}" => v }
  name                = each.value.logic_app_standard_user_identity_name
  resource_group_name = each.value.logic_app_standard_user_identity_resource_group_name
}
#DATA FOR KEY VAULT
data "azurerm_key_vault" "key_vault" {
  provider            = azurerm.key_vault_sub
  for_each            = local.is_key_vault_exists
  name                = each.value.logic_app_standard_key_vault_name
  resource_group_name = each.value.logic_app_standard_key_vault_resource_group_name
}
#DATA FOR KEY VAULT SECRET
data "azurerm_key_vault_secret" "secret_connection_string_value" {
  provider     = azurerm.key_vault_sub
  for_each     = local.is_key_vault_exists
  name         = each.value.logic_app_standard_secret_connection_string_value_name
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}
#DATA FOR SUBNET
data "azurerm_subnet" "subnet_id" {
  provider             = azurerm.logic_app_standard_sub
  for_each             = local.is_subnet_exists
  name                 = each.value.logic_app_standard_subnet_name
  virtual_network_name = each.value.logic_app_standard_vnet_name
  resource_group_name  = each.value.logic_app_standard_subnet_resource_group_name
}
#DATA FOR STORAGE ACCOUNT
data "azurerm_storage_account" "storage_account" {
  provider            = azurerm.storage_account_sub
  for_each            = var.logic_app_standard_variables
  name                = each.value.logic_app_standard_storage_account_name
  resource_group_name = each.value.logic_app_standard_storage_account_resource_group_name
}
#DATA FOR SERVICE PLAN
data "azurerm_service_plan" "service_plan" {
  provider            = azurerm.logic_app_standard_sub
  for_each            = var.logic_app_standard_variables
  name                = each.value.logic_app_standard_service_plan_name
  resource_group_name = each.value.logic_app_standard_service_plan_resource_group_name
}
#RESOURCE FOR LOGIC APP STANDARD
resource "azurerm_logic_app_standard" "logic_app_standard" {
  provider                   = azurerm.logic_app_standard_sub
  for_each                   = var.logic_app_standard_variables
  name                       = each.value.logic_app_standard_name
  resource_group_name        = each.value.logic_app_standard_resource_group_name
  location                   = each.value.logic_app_standard_location
  app_service_plan_id        = data.azurerm_service_plan.service_plan[each.key].id
  use_extension_bundle       = each.value.logic_app_standard_use_extension_bundle
  bundle_version             = each.value.logic_app_standard_bundle_version
  client_affinity_enabled    = each.value.logic_app_standard_client_affinity_enabled
  client_certificate_mode    = each.value.logic_app_standard_client_certificate_mode
  enabled                    = each.value.logic_app_standard_enabled
  https_only                 = each.value.logic_app_standard_https_only
  storage_account_name       = each.value.logic_app_standard_storage_account_name
  storage_account_access_key = data.azurerm_storage_account.storage_account[each.key].primary_access_key
  storage_account_share_name = each.value.logic_app_standard_storage_account_share_name
  version                    = each.value.logic_app_standard_version
  virtual_network_subnet_id  = each.value.is_subnet_required == false ? null : data.azurerm_subnet.subnet_id[each.key].id
  app_settings               = each.value.logic_app_standard_app_settings
  dynamic "connection_string" {
    for_each = each.value.is_connection_string_required == true ? [each.value.logic_app_standard_connection_string] : []
    content {
      name  = connection_string.value.connection_string_name
      type  = connection_string.value.connection_string_type
      value = data.azurerm_key_vault_secret.logic_app_standard_secret_connection_string_value_name[each.key].value
    }
  }
  dynamic "identity" {
    for_each = each.value.logic_app_standard_identity != null ? [1] : []
    content {
      type = each.value.logic_app_standard_identity.logic_app_standard_identity_type
      identity_ids = each.value.logic_app_standard_identity.logic_app_standard_identity_type == "SystemAssigned, UserAssigned" || each.value.logic_app_standard_identity.logic_app_standard_identity_type == "UserAssigned" ? [
        for k, v in each.value.logic_app_standard_identity.logic_app_standard_user_assigned_identities : data.azurerm_user_assigned_identity.logic_app_standard_user_assigned_identity["${each.key},${v.logic_app_standard_user_identity_name}"].id
      ] : null
    }
  }
  dynamic "site_config" {
    for_each = each.value.logic_app_standard_site_config != null ? each.value.logic_app_standard_site_config : []
    content {
      always_on       = site_config.value.site_config_always_on
      app_scale_limit = site_config.value.site_config_app_scale_limit
      dynamic "cors" {
        for_each = site_config.value.site_config_cors != null ? toset(site_config.value.site_config_cors) : []
        content {
          allowed_origins     = cors.value.cors_allowed_origins
          support_credentials = cors.value.cors_support_credentials
        }
      }
      dotnet_framework_version = site_config.value.site_config_dotnet_framework_version
      elastic_instance_minimum = site_config.value.site_config_elastic_instance_minimum
      ftps_state               = site_config.value.site_config_ftps_state
      health_check_path        = site_config.value.site_config_health_check_path
      http2_enabled            = site_config.value.site_config_http2_enabled
      dynamic "ip_restriction" {
        for_each = site_config.value.site_config_ip_restriction != null ? site_config.value.site_config_ip_restriction : []
        content {
          ip_address                = (ip_restriction.value.ip_restriction_ip_address != null && ip_restriction.value.ip_restriction_service_tag == null && is_subnet_required == false) ? ip_restriction.value.ip_restriction_ip_address : null
          service_tag               = (ip_restriction.value.ip_restriction_service_tag != null && ip_restriction.value.ip_restriction_ip_address == null && is_subnet_required == false) ? ip_restriction.value.ip_restriction_service_tag : null
          virtual_network_subnet_id = (ip_restriction.value.ip_restriction_ip_address == null && ip_restriction.value.ip_restriction_service_tag == null && is_subnet_required == true) ? data.azurerm_subnet.subnet_id[each.key].id : null
          name                      = ip_restriction.value.ip_restriction_name
          priority                  = ip_restriction.value.ip_restriction_priority
          action                    = ip_restriction.value.ip_restriction_action
          dynamic "headers" {
            for_each = ip_restriction.value.ip_restriction_headers != null ? [ip_restriction.value.ip_restriction_headers] : []
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
        for_each = site_config.value.site_config_scm_ip_restriction != null ? site_config.value.site_config_scm_ip_restriction : []
        content {
          ip_address                = (scm_ip_restriction.value.scm_ip_restriction_ip_address != null && scm_ip_restriction.value.scm_ip_restriction_service_tag == null && is_subnet_required == false) ? scm_ip_restriction.value.scm_ip_restriction_ip_address : null
          service_tag               = (scm_ip_restriction.value.scm_ip_restriction_service_tag != null && scm_ip_restriction.value.scm_ip_restriction_ip_address == null && is_subnet_required == false) ? scm_ip_restriction.value.scm_ip_restriction_service_tag : null
          virtual_network_subnet_id = (scm_ip_restriction.value.scm_ip_restriction_ip_address == null && scm_ip_restriction.value.scm_ip_restriction_service_tag == null && is_subnet_required == true) ? data.azurerm_subnet.subnet_id[each.key].id : null
          name                      = scm_ip_restriction.value.scm_ip_restriction_name
          priority                  = scm_ip_restriction.value.scm_ip_restriction_priority
          action                    = scm_ip_restriction.value.scm_ip_restriction_action
          dynamic "headers" {
            for_each = scm_ip_restriction.value.scm_ip_restriction_headers != null ? [scm_ip_restriction.value.scm_ip_restriction_headers] : []
            content {
              x_azure_fdid      = headers.value.headers_x_azure_fdid
              x_fd_health_probe = headers.value.headers_x_fd_health_probe
              x_forwarded_for   = headers.value.headers_x_forwarded_for
              x_forwarded_host  = headers.value.headers_x_forwarded_host
            }
          }
        }
      }
      scm_use_main_ip_restriction      = site_config.value.site_config_scm_use_main_ip_restriction
      scm_min_tls_version              = site_config.value.site_config_scm_min_tls_version
      scm_type                         = site_config.value.site_config_scm_type
      linux_fx_version                 = site_config.value.site_config_linux_fx_version
      min_tls_version                  = site_config.value.site_config_min_tls_version
      pre_warmed_instance_count        = site_config.value.site_config_pre_warmed_instance_count
      runtime_scale_monitoring_enabled = site_config.value.site_config_runtime_scale_monitoring_enabled
      use_32_bit_worker_process        = site_config.value.site_config_use_32_bit_worker_process
      vnet_route_all_enabled           = site_config.value.site_config_vnet_route_all_enabled
      websockets_enabled               = site_config.value.site_config_websockets_enabled
    }
  }
  tags = merge(each.value.logic_app_standard_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}