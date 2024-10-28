data "azurerm_mssql_server" "mssql_server" {
  provider            = azurerm.mssql_server_sub
  for_each            = var.mssql_database_variables
  name                = each.value.mssql_database_mssql_server_name
  resource_group_name = each.value.mssql_database_mssql_server_resource_group_name
}

data "azurerm_mssql_server" "source_mssql_server" {
  provider            = azurerm.mssql_server_sub
  for_each            = { for k, v in var.mssql_database_variables : k => v if v.mssql_database_creation_source_database_name != null }
  name                = each.value.mssql_database_source_mssql_server_name
  resource_group_name = each.value.mssql_database_source_mssql_server_resource_group_name
}

data "azurerm_storage_account" "storage_account" {
  provider            = azurerm.storage_account_sub
  for_each            = { for k, v in var.mssql_database_variables : k => v if v.mssql_database_threat_detection_policy_required == true }
  name                = each.value.mssql_database_storage_account_name
  resource_group_name = each.value.mssql_database_storage_account_resource_group_name
}

data "azurerm_mssql_elasticpool" "elastic_pool" {
  provider            = azurerm.mssql_server_sub
  for_each            = { for k, v in var.mssql_database_variables : k => v if v.mssql_database_elastic_pool_name != null }
  name                = each.value.mssql_database_elastic_pool_name
  resource_group_name = each.value.mssql_database_elastic_pool_resource_group_name
  server_name         = each.value.mssql_database_mssql_server_name
}

data "azurerm_mssql_database" "source_database" {
  provider  = azurerm.mssql_server_sub
  for_each  = { for k, v in var.mssql_database_variables : k => v if v.mssql_database_creation_source_database_name != null }
  name      = each.value.mssql_database_creation_source_database_name
  server_id = data.azurerm_mssql_server.source_mssql_server[each.key].id
}

# MSSQL Database
resource "azurerm_mssql_database" "mssql_database" {
  provider                            = azurerm.mssql_server_sub
  for_each                            = var.mssql_database_variables
  name                                = each.value.mssql_database_name
  server_id                           = data.azurerm_mssql_server.mssql_server[each.key].id
  collation                           = each.value.mssql_database_collation
  license_type                        = each.value.mssql_database_license_type
  max_size_gb                         = each.value.mssql_database_max_size_gb
  read_scale                          = each.value.mssql_database_read_scale
  sku_name                            = each.value.mssql_database_sku_name
  zone_redundant                      = each.value.mssql_database_zone_redundant
  auto_pause_delay_in_minutes         = each.value.mssql_database_auto_pause_delay_in_minutes
  create_mode                         = each.value.mssql_database_create_mode
  creation_source_database_id         = each.value.mssql_database_creation_source_database_name == null ? null : each.value.mssql_database_create_mode == "Recovery" ? null : each.value.mssql_database_create_mode == "Restore" ? null : data.azurerm_mssql_database.source_database[each.key].id
  elastic_pool_id                     = each.value.mssql_database_elastic_pool_name != null ? data.azurerm_mssql_elasticpool.elastic_pool[each.key].id : null
  geo_backup_enabled                  = each.value.mssql_database_geo_backup_enabled
  ledger_enabled                      = each.value.mssql_database_ledger_enabled
  min_capacity                        = each.value.mssql_database_min_capacity
  restore_point_in_time               = each.value.mssql_database_create_mode == "PointInTimeRestore" ? each.value.mssql_database_restore_point_in_time : null
  recover_database_id                 = each.value.mssql_database_create_mode == "Recovery" ? data.azurerm_mssql_database.source_database[each.key].id : null
  restore_dropped_database_id         = each.value.mssql_database_create_mode == "Restore" ? data.azurerm_mssql_database.source_database[each.key].id : null
  read_replica_count                  = each.value.mssql_database_read_replica_count
  sample_name                         = each.value.mssql_database_sample_name
  storage_account_type                = each.value.mssql_database_storage_account_type
  transparent_data_encryption_enabled = each.value.mssql_database_transparent_data_encryption_enabled

  dynamic "threat_detection_policy" {
    for_each = each.value.mssql_database_threat_detection_policy_required == true ? [1] : []
    content {
      state                      = each.value.mssql_database_threat_detection_policy.threat_detection_policy_state
      disabled_alerts            = each.value.mssql_database_threat_detection_policy.threat_detection_policy_disabled_alerts
      email_account_admins       = each.value.mssql_database_threat_detection_policy.threat_detection_policy_email_account_admins
      email_addresses            = each.value.mssql_database_threat_detection_policy.threat_detection_policy_email_addresses
      retention_days             = each.value.mssql_database_threat_detection_policy.threat_detection_policy_retention_days
      storage_account_access_key = data.azurerm_storage_account.storage_account[each.key].primary_access_key
      storage_endpoint           = data.azurerm_storage_account.storage_account[each.key].primary_blob_endpoint
    }
  }
  dynamic "long_term_retention_policy" {
    for_each = each.value.mssql_database_long_term_retention_policy_required == true ? [1] : []
    content {
      weekly_retention  = each.value.mssql_database_long_term_retention_policy.long_term_retention_policy_weekly_retention
      monthly_retention = each.value.mssql_database_long_term_retention_policy.long_term_retention_policy_monthly_retention
      yearly_retention  = each.value.mssql_database_long_term_retention_policy.long_term_retention_policy_yearly_retention
      week_of_year      = each.value.mssql_database_long_term_retention_policy.long_term_retention_policy_week_of_year
    }
  }
  dynamic "short_term_retention_policy" {
    for_each = each.value.mssql_database_short_term_retention_policy_required == true ? [1] : []
    content {
      retention_days           = each.value.mssql_database_short_term_retention_policy.short_term_retention_policy_retention_days
      backup_interval_in_hours = each.value.mssql_database_short_term_retention_policy.short_term_retention_policy_backup_interval_in_hours
    }
  }
  tags = merge(each.value.mssql_database_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}