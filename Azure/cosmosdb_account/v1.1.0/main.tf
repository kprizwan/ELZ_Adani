data "azurerm_key_vault" "key_vault" {
  provider            = azurerm.key_vault_sub
  for_each            = var.cosmosdb_account_variables
  name                = each.value.cosmosdb_account_key_vault_name
  resource_group_name = each.value.cosmosdb_account_key_vault_resource_group_name
}

data "azurerm_key_vault_key" "key_vault_key" {
  provider     = azurerm.key_vault_sub
  for_each     = var.cosmosdb_account_variables
  name         = each.value.cosmosdb_account_key_vault_Key_name
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}

data "azurerm_client_config" "client_config" {
  provider = azurerm.key_vault_sub
}

resource "azurerm_key_vault_access_policy" "key_vault_access_policy" {
  provider           = azurerm.key_vault_sub
  for_each           = var.cosmosdb_account_variables
  key_vault_id       = data.azurerm_key_vault.key_vault[each.key].id
  tenant_id          = data.azurerm_client_config.client_config.tenant_id
  object_id          = each.value.cosmosdb_account_object_id
  key_permissions    = each.value.cosmosdb_account_key_permissions
  secret_permissions = each.value.cosmosdb_account_secret_permissions
  depends_on         = [data.azurerm_key_vault.key_vault]
}

data "azurerm_subnet" "subnet" {
  provider             = azurerm.cosmos_db_account_sub
  for_each             = var.cosmosdb_account_variables
  name                 = each.value.cosmosdb_account_subnet_name
  virtual_network_name = each.value.cosmosdb_account_subnet_virtual_network_name
  resource_group_name  = each.value.cosmosdb_account_subnet_resource_group_name
}

resource "azurerm_cosmosdb_account" "cosmosdb_account" {
  provider                              = azurerm.cosmos_db_account_sub
  for_each                              = var.cosmosdb_account_variables
  name                                  = each.value.cosmosdb_account_name
  location                              = each.value.cosmosdb_account_location
  resource_group_name                   = each.value.cosmosdb_account_resource_group_name
  offer_type                            = each.value.cosmosdb_account_offer_type
  kind                                  = each.value.cosmosdb_account_kind
  enable_automatic_failover             = each.value.cosmosdb_account_enable_automatic_failover
  create_mode                           = each.value.cosmosdb_account_create_mode
  ip_range_filter                       = each.value.cosmosdb_account_ip_range_filter
  enable_free_tier                      = each.value.cosmosdb_account_enable_free_tier
  analytical_storage_enabled            = each.value.cosmosdb_account_analytical_storage_enabled
  public_network_access_enabled         = each.value.cosmosdb_account_public_network_access_enabled
  is_virtual_network_filter_enabled     = each.value.cosmosdb_account_is_virtual_network_filter_enabled
  enable_multiple_write_locations       = each.value.cosmosdb_account_enable_multiple_write_location
  access_key_metadata_writes_enabled    = each.value.cosmosdb_account_access_key_metadata_writes_enabled
  mongo_server_version                  = each.value.cosmosdb_account_mongo_server_version
  network_acl_bypass_for_azure_services = each.value.cosmosdb_account_network_acl_bypass_for_azure_services
  local_authentication_disabled         = each.value.cosmosdb_account_local_authentication_disabled
  default_identity_type                 = each.value.cosmosdb_account_default_identity_type
  network_acl_bypass_ids                = each.value.cosmosdb_account_network_acl_bypass_ids
  key_vault_key_id                      = data.azurerm_key_vault_key.key_vault_key[each.key].versionless_id
  tags                                  = merge(each.value.cosmosdb_account_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }

  dynamic "virtual_network_rule" {
    for_each = each.value.virtual_network_rule != null ? [each.value.virtual_network_rule] : []
    content {
      id                                   = data.azurerm_subnet.subnet[each.key].id
      ignore_missing_vnet_service_endpoint = virtual_network_rule.value.cosmosdb_account_virtual_network_rule_ignore_missing_vnet_service_endpoint
    }
  }
  dynamic "analytical_storage" {
    for_each = each.value.analytical_storage != null ? [each.value.analytical_storage] : []
    content {
      schema_type = analytical_storage.value.cosmosdb_account_analytical_storage_schema_type
    }
  }
  dynamic "capacity" {
    for_each = each.value.capacity != null ? [each.value.capacity] : []
    content {
      total_throughput_limit = capacity.value.cosmosdb_account_capacity_total_throughput_limit
    }
  }
  dynamic "backup" {
    for_each = each.value.backup != null ? [each.value.backup] : []
    content {
      type                = backup.value.cosmosdb_account_backup_type
      interval_in_minutes = backup.value.cosmosdb_account_backup_interval_in_minutes
      retention_in_hours  = backup.value.cosmosdb_account_backup_retention_in_hours
      storage_redundancy  = backup.value.cosmosdb_account_backup_storage_redundancy
    }
  }
  dynamic "cors_rule" {
    for_each = { for k, v in var.cosmosdb_account_variables : k => v if v.enable_cors_rule == true }
    content {
      allowed_headers    = each.value.cors_rule.cosmosdb_account_cors_rule_allowed_headers
      allowed_methods    = each.value.cors_rule.cosmosdb_account_cors_rule_allowed_methods
      allowed_origins    = each.value.cors_rule.cosmosdb_account_cors_rule_allowed_origins
      exposed_headers    = each.value.cors_rule.cosmosdb_account_cors_rule_exposed_headers
      max_age_in_seconds = each.value.cors_rule.cosmosdb_account_cors_rule_max_age_in_seconds
    }
  }
  dynamic "identity" {
    for_each = coalesce(each.value.cosmosdb_account_assign_identity, false) == false ? [] : tolist([coalesce(each.value.cosmosdb_account_assign_identity, false)])
    content {
      type = "SystemAssigned"
    }
  }
  dynamic "restore" {
    for_each = { for k, v in var.cosmosdb_account_variables : k => v if v.enable_restore == true }
    content {
      source_cosmosdb_account_id = each.value.restore.cosmosdb_account_restore_source_cosmosdb_account_id
      restore_timestamp_in_utc   = each.value.restore.cosmosdb_account_restore_restore_timestamp_in_utc
      dynamic "database" {
        for_each = { for k, v in var.cosmosdb_account_variables : k => v if v.enable_restore == true }
        content {
          name             = each.value.restore.cosmosdb_account_restore_database_name
          collection_names = each.value.restore.cosmosdb_account_restore_database_collection_names
        }
      }
    }
  }
  dynamic "capabilities" {
    for_each = each.value.capabilities != null ? each.value.capabilities : []
    content {
      name = capabilities.value.cosmosdb_account_capabilities_name
    }
  }
  dynamic "consistency_policy" {
    for_each = each.value.consistency_policy != null ? [each.value.consistency_policy] : []
    content {
      consistency_level       = consistency_policy.value.cosmosdb_account_consistency_policy_consistency_level
      max_interval_in_seconds = consistency_policy.value.cosmosdb_account_consistency_policy_max_interval_in_seconds
      max_staleness_prefix    = consistency_policy.value.cosmosdb_account_consistency_policy_max_staleness_prefix
    }
  }
  dynamic "geo_location" {
    for_each = each.value.geo_location != null ? each.value.geo_location : []
    content {
      location          = geo_location.value.cosmosdb_account_geo_location_location
      failover_priority = geo_location.value.cosmosdb_account_geo_location_failover_priority
      zone_redundant    = geo_location.value.cosmosdb_account_geo_location_zone_redundant
    }
  }
}



