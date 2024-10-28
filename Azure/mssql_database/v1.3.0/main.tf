#DATA BLOCK TO FETCH MSSQL SERVER ID
data "azurerm_mssql_server" "mssql_server" {
  provider            = azurerm.mssql_server_sub
  for_each            = var.mssql_database_variables
  name                = each.value.mssql_database_mssql_server_name
  resource_group_name = each.value.mssql_database_mssql_server_resource_group_name
}

#DATA BLOCK TO FETCH SOURCE MSSQL SERVER ID
data "azurerm_mssql_server" "source_mssql_server" {
  provider            = azurerm.mssql_server_sub
  for_each            = { for k, v in var.mssql_database_variables : k => v if v.mssql_database_creation_source_database_name != null }
  name                = each.value.mssql_database_source_mssql_server_name
  resource_group_name = each.value.mssql_database_source_mssql_server_resource_group_name
}

#DATA BLOCK TO FETCH THREAT DETECTION POLICY STORAGE ACCOUNT
data "azurerm_storage_account" "storage_account" {
  provider            = azurerm.storage_account_sub
  for_each            = { for k, v in var.mssql_database_variables : k => v if v.mssql_database_threat_detection_policy != null }
  name                = each.value.mssql_database_storage_account_name
  resource_group_name = each.value.mssql_database_storage_account_resource_group_name
}

#DATA BLOCK TO FETCH IMPORT STORAGE ACCOUNT
data "azurerm_storage_account" "import_storage_account" {
  provider            = azurerm.storage_account_sub
  for_each            = { for k, v in var.mssql_database_variables : k => v if v.mssql_database_import != null }
  name                = each.value.mssql_database_import_storage_account_name
  resource_group_name = each.value.mssql_database_import_storage_account_resource_group_name
}

#DATA BLOCK TO FETCH IMPORT CREDS KEY VAULT ID
data "azurerm_key_vault" "key_vault_id" {
  provider            = azurerm.key_vault_sub
  for_each            = { for k, v in var.mssql_database_variables : k => v if v.mssql_database_import != null }
  name                = each.value.mssql_database_import_creds_key_vault_name
  resource_group_name = each.value.mssql_database_import_creds_key_vault_resource_group_name
}

#DATA BLOCK TO FETCH IMPORT ADMIN LOGIN KEYVAULT SECRET
data "azurerm_key_vault_secret" "adminlogin_username_key_vault_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = { for k, v in var.mssql_database_variables : k => v if v.mssql_database_import != null }
  name         = each.value.mssql_database_import_administrator_login_key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.key].id
}

#DATA BLOCK TO FETCH IMPORT ADMIN LOGIN PASSWORD KEY VAULT SECRET
data "azurerm_key_vault_secret" "adminlogin_password_key_vault_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = { for k, v in var.mssql_database_variables : k => v if v.mssql_database_import != null }
  name         = each.value.mssql_database_import_administrator_login_password_key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.key].id
}

#DATA BLOCK TO MSSQL ELASTIC POOL ID
data "azurerm_mssql_elasticpool" "elastic_pool" {
  provider            = azurerm.mssql_server_sub
  for_each            = { for k, v in var.mssql_database_variables : k => v if v.mssql_database_elastic_pool_name != null }
  name                = each.value.mssql_database_elastic_pool_name
  resource_group_name = each.value.mssql_database_elastic_pool_resource_group_name
  server_name         = each.value.mssql_database_mssql_server_name
}

#DATA BLOCK TO FETCH SOURCE MSSQL DATABASE
data "azurerm_mssql_database" "source_database" {
  provider  = azurerm.mssql_server_sub
  for_each  = { for k, v in var.mssql_database_variables : k => v if v.mssql_database_creation_source_database_name != null }
  name      = each.value.mssql_database_creation_source_database_name
  server_id = data.azurerm_mssql_server.source_mssql_server[each.key].id
}

#MSSQL DATABASE
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
  maintenance_configuration_name      = each.value.mssql_database_maintenance_configuration_name
  ledger_enabled                      = each.value.mssql_database_ledger_enabled
  min_capacity                        = each.value.mssql_database_min_capacity
  restore_point_in_time               = each.value.mssql_database_create_mode == "PointInTimeRestore" ? each.value.mssql_database_restore_point_in_time : null
  recover_database_id                 = each.value.mssql_database_create_mode == "Recovery" ? data.azurerm_mssql_database.source_database[each.key].id : null
  restore_dropped_database_id         = each.value.mssql_database_create_mode == "Restore" ? data.azurerm_mssql_database.source_database[each.key].id : null
  read_replica_count                  = each.value.mssql_database_read_replica_count
  sample_name                         = each.value.mssql_database_sample_name
  storage_account_type                = each.value.mssql_database_storage_account_type
  transparent_data_encryption_enabled = each.value.mssql_database_transparent_data_encryption_enabled

  dynamic "import" {
    for_each = each.value.mssql_database_import != null ? [each.value.mssql_database_import] : []
    content {
      storage_uri                  = import.value.import_storage_uri
      storage_key                  = data.azurerm_storage_account.import_storage_account[each.key].primary_access_key
      storage_key_type             = import.value.import_storage_key_type
      administrator_login          = data.azurerm_key_vault_secret.adminlogin_username_key_vault_secret[each.key].value
      administrator_login_password = data.azurerm_key_vault_secret.adminlogin_password_key_vault_secret[each.key].value
      authentication_type          = import.value.import_authentication_type
      storage_account_id           = import.value.import_storage_account_id_required != false ? data.azurerm_storage_account.import_storage_account[each.key].id : null
    }
  }

  dynamic "threat_detection_policy" {
    for_each = each.value.mssql_database_threat_detection_policy != null ? [each.value.mssql_database_threat_detection_policy] : []
    content {
      state                      = threat_detection_policy.value.threat_detection_policy_state
      disabled_alerts            = threat_detection_policy.value.threat_detection_policy_disabled_alerts
      email_account_admins       = threat_detection_policy.value.threat_detection_policy_email_account_admins
      email_addresses            = threat_detection_policy.value.threat_detection_policy_email_addresses
      retention_days             = threat_detection_policy.value.threat_detection_policy_retention_days
      storage_account_access_key = threat_detection_policy.value.threat_detection_policy_state == "Enabled" ? data.azurerm_storage_account.storage_account[each.key].primary_access_key : null
      storage_endpoint           = threat_detection_policy.value.threat_detection_policy_state == "Enabled" ? data.azurerm_storage_account.storage_account[each.key].primary_blob_endpoint : null
    }
  }

  dynamic "long_term_retention_policy" {
    for_each = each.value.mssql_database_long_term_retention_policy != null ? [each.value.mssql_database_long_term_retention_policy] : []
    content {
      weekly_retention  = long_term_retention_policy.value.long_term_retention_policy_weekly_retention
      monthly_retention = long_term_retention_policy.value.long_term_retention_policy_monthly_retention
      yearly_retention  = long_term_retention_policy.value.long_term_retention_policy_yearly_retention
      week_of_year      = long_term_retention_policy.value.long_term_retention_policy_week_of_year
    }
  }

  dynamic "short_term_retention_policy" {
    for_each = each.value.mssql_database_short_term_retention_policy != null ? [each.value.mssql_database_short_term_retention_policy] : []
    content {
      retention_days           = short_term_retention_policy.value.short_term_retention_policy_retention_days
      backup_interval_in_hours = short_term_retention_policy.value.short_term_retention_policy_backup_interval_in_hours
    }
  }

  tags = merge(each.value.mssql_database_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}