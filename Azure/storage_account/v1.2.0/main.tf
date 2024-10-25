locals {
  identities = { for k, v in var.storage_account_variables : k => lookup(v, "storage_account_identity", null) != null ? v.storage_account_identity.storage_account_identity_type != "SystemAssigned" ? v.storage_account_identity.storage_account_user_assigned_identity_ids : null : null }
  identities_list = flatten([
    for k, v in local.identities : [for i in v : [
      {
        main_key                     = k
        identity_name                = i.identity_name
        identity_resource_group_name = i.identity_resource_group_name
    }]] if v != null
  ])

  network_rule_subnet_ids = flatten([for k, v in var.storage_account_variables : [
    for j in coalesce(v.storage_account_network_rules.storage_account_network_rules_vnet_subnets, []) : [
      ["/subscriptions/${j.storage_account_network_rules_vnet_subscription_id}/resourceGroups/${j.storage_account_network_rules_vnet_rg_name}/providers/Microsoft.Network/virtualNetworks/${j.storage_account_network_rules_virtual_network_name}/subnets/${j.storage_account_network_rules_subnet_name}"]
    ]
  ] if lookup(v, "storage_account_network_rules") != null])
}

data "azurerm_key_vault" "key_vault" {
  provider            = azurerm.key_vault_sub
  for_each            = { for k, v in var.storage_account_variables : k => v if lookup(v, "storage_account_key_vault_name", null) != null && lookup(v, "storage_account_key_vault_resource_group_name", null) != null }
  name                = each.value.storage_account_key_vault_name
  resource_group_name = each.value.storage_account_key_vault_resource_group_name
}

data "azurerm_key_vault_key" "key_vault_key" {
  provider     = azurerm.key_vault_sub
  for_each     = { for k, v in var.storage_account_variables : k => v if lookup(v, "storage_account_key_vault_key_name", null) != null }
  name         = each.value.storage_account_key_vault_key_name
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}

data "azurerm_user_assigned_identity" "user_assigned_identity_for_cmk" {
  provider            = azurerm.storage_account_sub
  for_each            = { for k, v in var.storage_account_variables : k => v if lookup(v, "storage_account_user_assigned_identity_name_for_cmk", null) != null && lookup(v, "storage_account_user_assigned_identity_resource_group_name_for_cmk", null) != null }
  name                = each.value.storage_account_user_assigned_identity_name_for_cmk
  resource_group_name = each.value.storage_account_user_assigned_identity_resource_group_name_for_cmk
}

data "azurerm_user_assigned_identity" "user_assigned_identities" {
  provider            = azurerm.storage_account_sub
  for_each            = { for v in local.identities_list : "${v.main_key},${v.identity_name}" => v }
  name                = each.value.identity_name
  resource_group_name = each.value.identity_resource_group_name
}

resource "azurerm_storage_account" "storage_account" {
  provider                          = azurerm.storage_account_sub
  for_each                          = var.storage_account_variables
  name                              = each.value.storage_account_name
  resource_group_name               = each.value.storage_account_resource_group_name
  location                          = each.value.storage_account_location
  account_kind                      = each.value.storage_account_account_kind
  account_tier                      = each.value.storage_account_account_tier
  account_replication_type          = each.value.storage_account_account_replication_type
  cross_tenant_replication_enabled  = each.value.storage_account_cross_tenant_replication_enabled
  access_tier                       = each.value.storage_account_access_tier
  edge_zone                         = each.value.storage_account_edge_zone
  enable_https_traffic_only         = each.value.storage_account_enable_https_traffic_only
  min_tls_version                   = each.value.storage_account_min_tls_version
  allow_nested_items_to_be_public   = each.value.storage_account_allow_nested_items_to_be_public
  shared_access_key_enabled         = each.value.storage_account_shared_access_key_enabled
  public_network_access_enabled     = each.value.storage_account_public_network_access_enabled
  default_to_oauth_authentication   = each.value.storage_account_default_to_oauth_authentication
  is_hns_enabled                    = ((lookup(each.value, "storage_account_account_tier") == "Standard") || (lookup(each.value, "storage_account_account_tier") == "Premium") && lookup(each.value, "storage_account_account_kind") == "BlockBlobStorage") ? each.value.storage_account_is_hns_enabled : false
  nfsv3_enabled                     = (lookup(each.value, "storage_account_account_tier") == "Standard" && lookup(each.value, "storage_account_account_kind") == "StorageV2") || (lookup(each.value, "storage_account_account_tier") == "Premium" && lookup(each.value, "storage_account_account_kind") == "BlockBlobStorage") || (lookup(each.value, "storage_account_is_hns_enabled") == true && lookup(each.value, "storage_account_enable_https_traffic_only") == false) ? each.value.storage_account_nfsv3_enabled : false
  large_file_share_enabled          = each.value.storage_account_large_file_share_enabled
  queue_encryption_key_type         = each.value.storage_account_account_kind == "StorageV2" ? each.value.storage_account_queue_encryption_key_type : null
  table_encryption_key_type         = each.value.storage_account_account_kind == "StorageV2" ? each.value.storage_account_table_encryption_key_type : null
  infrastructure_encryption_enabled = lookup(each.value, "storage_account_account_kind") == "StorageV2" || (lookup(each.value, "storage_account_account_tier") == "Premium" && lookup(each.value, "storage_account_account_kind") == "BlockBlobStorage") ? each.value.storage_account_infrastructure_encryption_enabled : false

  dynamic "custom_domain" {
    for_each = each.value.storage_account_custom_domain == null ? [] : [each.value.storage_account_custom_domain]
    content {
      name          = custom_domain.value.custom_domain_name
      use_subdomain = custom_domain.value.custom_domain_use_subdomain
    }
  }

  dynamic "customer_managed_key" {
    for_each = (lookup(each.value, "storage_account_account_kind") == "StorageV2" || lookup(each.value, "storage_account_account_tier") == "Premium") && lookup(each.value, "storage_account_identity_type_for_cmk") == "UserAssigned" ? [1] : []
    content {
      key_vault_key_id          = data.azurerm_key_vault_key.key_vault_key[each.key].id
      user_assigned_identity_id = data.azurerm_user_assigned_identity.user_assigned_identity_for_cmk[each.key].id
    }
  }

  dynamic "identity" {
    for_each = each.value.storage_account_identity != null ? [1] : []
    content {
      type         = each.value.storage_account_identity.storage_account_identity_type
      identity_ids = each.value.storage_account_identity.storage_account_user_assigned_identity_ids == null ? [] : [for k, v in each.value.storage_account_identity.storage_account_user_assigned_identity_ids : data.azurerm_user_assigned_identity.user_assigned_identities["${each.key},${v.identity_name}"].id]
    }
  }

  dynamic "blob_properties" {
    for_each = each.value.storage_account_blob_properties == null ? [] : [each.value.storage_account_blob_properties]
    content {
      versioning_enabled            = blob_properties.value.versioning_enabled
      change_feed_enabled           = blob_properties.value.change_feed_enabled
      change_feed_retention_in_days = blob_properties.value.change_feed_retention_in_days
      default_service_version       = blob_properties.value.default_service_version
      last_access_time_enabled      = blob_properties.value.last_access_time_enabled

      dynamic "cors_rule" {
        for_each = blob_properties.value.cors_enabled == true ? [blob_properties.value.cors_rule] : []
        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }

      dynamic "delete_retention_policy" {
        for_each = blob_properties.value.delete_retention_policy == null ? [] : [blob_properties.value.delete_retention_policy]
        content {
          days = delete_retention_policy.value.delete_retention_policy_days
        }
      }

      dynamic "container_delete_retention_policy" {
        for_each = blob_properties.value.container_delete_retention_policy == null ? [] : [blob_properties.value.container_delete_retention_policy]
        content {
          days = container_delete_retention_policy.value.container_delete_retention_policy_days
        }
      }
    }
  }

  dynamic "queue_properties" {
    for_each = each.value.storage_account_account_kind == "BlobStorage" || each.value.storage_account_queue_properties == null ? [] : [each.value.storage_account_queue_properties]
    content {
      dynamic "cors_rule" {
        for_each = queue_properties.value.cors_enabled == true ? [queue_properties.value.cors_rule] : []
        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }

      dynamic "logging" {
        for_each = queue_properties.value.logging_enabled == false ? [] : [queue_properties.value.logging]
        content {
          delete                = logging.value.delete
          read                  = logging.value.read
          version               = logging.value.version
          write                 = logging.value.write
          retention_policy_days = logging.value.retention_policy_days
        }
      }

      dynamic "minute_metrics" {
        for_each = queue_properties.value.minute_metrics == null ? [] : [queue_properties.value.minute_metrics]
        content {
          enabled               = minute_metrics.value.enabled
          version               = minute_metrics.value.version
          include_apis          = minute_metrics.value.include_apis
          retention_policy_days = minute_metrics.value.retention_policy_days
        }
      }

      dynamic "hour_metrics" {
        for_each = queue_properties.value.hour_metrics == null ? [] : [queue_properties.value.hour_metrics]
        content {
          enabled               = hour_metrics.value.enabled
          version               = hour_metrics.value.version
          include_apis          = hour_metrics.value.include_apis
          retention_policy_days = hour_metrics.value.retention_policy_days
        }
      }
    }

  }

  dynamic "static_website" {
    for_each = each.value.storage_account_account_kind == "BlobStorage" || each.value.storage_account_account_kind == "StorageV2" && each.value.storage_account_static_website != null ? [each.value.storage_account_static_website] : []
    content {
      index_document     = static_website.value.index_document
      error_404_document = static_website.value.error_404_document
    }
  }

  dynamic "share_properties" {
    for_each = each.value.storage_account_share_properties == null ? [] : [each.value.storage_account_share_properties]
    content {
      dynamic "cors_rule" {
        for_each = share_properties.value.cors_enabled == true ? [share_properties.value.cors_rule] : []
        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }

      dynamic "retention_policy" {
        for_each = share_properties.value.retention_policy == null ? [] : [share_properties.value.retention_policy]
        content {
          days = retention_policy.value.retention_policy_days
        }
      }

      dynamic "smb" {
        for_each = share_properties.value.smb == null ? [] : [share_properties.value.smb]
        content {
          versions                        = smb.value.smb_versions
          authentication_types            = smb.value.smb_authentication_types
          kerberos_ticket_encryption_type = smb.value.smb_kerberos_ticket_encryption_type
          channel_encryption_type         = smb.value.smb_channel_encryption_type
          multichannel_enabled            = smb.value.smb_multichannel_enabled
        }
      }
    }
  }

  dynamic "network_rules" {
    for_each = each.value.storage_account_network_rules == null ? [] : [each.value.storage_account_network_rules]
    content {
      default_action             = network_rules.value.default_action
      bypass                     = network_rules.value.bypass
      ip_rules                   = network_rules.value.ip_rules
      virtual_network_subnet_ids = local.network_rule_subnet_ids
      dynamic "private_link_access" {
        for_each = network_rules.value.private_link_access == null ? {} : network_rules.value.private_link_access
        content {
          endpoint_resource_id = private_link_access.value.endpoint_resource_id
          endpoint_tenant_id   = private_link_access.value.endpoint_tenant_id
        }
      }
    }
  }

  dynamic "azure_files_authentication" {
    for_each = each.value.storage_account_azure_files_authentication == null ? [] : [each.value.storage_account_azure_files_authentication]
    content {
      directory_type = azure_files_authentication.value.directory_type

      dynamic "active_directory" {
        for_each = azure_files_authentication.value.directory_type == "AD" ? [azure_files_authentication.value.active_directory] : []
        content {
          storage_sid         = active_directory.value.storage_sid
          domain_name         = active_directory.value.domain_name
          domain_sid          = active_directory.value.domain_sid
          domain_guid         = active_directory.value.domain_guid
          forest_name         = active_directory.value.forest_name
          netbios_domain_name = active_directory.value.netbios_domain_name
        }
      }
    }
  }

  dynamic "routing" {
    for_each = each.value.storage_account_routing == null ? [] : [each.value.storage_account_routing]
    content {
      publish_internet_endpoints  = routing.value.publish_internet_endpoints
      publish_microsoft_endpoints = routing.value.publish_microsoft_endpoints
      choice                      = routing.value.choice
    }
  }

  dynamic "immutability_policy" {
    for_each = each.value.storage_account_immutability_policy == null ? [] : [each.value.storage_account_immutability_policy]
    content {
      allow_protected_append_writes = immutability_policy.value.allow_protected_append_writes
      state                         = immutability_policy.value.state
      period_since_creation_in_days = immutability_policy.value.period_since_creation_in_days
    }
  }

  dynamic "sas_policy" {
    for_each = each.value.storage_account_sas_policy == null ? [] : [each.value.storage_account_sas_policy]
    content {
      expiration_period = sas_policy.value.expiration_period
      expiration_action = sas_policy.value.expiration_action
    }
  }

  tags = merge(each.value.storage_account_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}