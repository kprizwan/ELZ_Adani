#DATA BLOCK TO FETCH KEYVAULT ID
data "azurerm_key_vault" "log_analytics_workspace_keys_key_vault_id" {
  provider            = azurerm.keyvault_sub
  for_each            = var.log_analytics_workspace_variables
  name                = each.value.log_analytics_workspace_key_vault_name
  resource_group_name = each.value.log_analytics_workspace_key_vault_resource_group_name
}
#LOG ANALYTICS WORKSPACE
resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  provider                           = azurerm.log_analytics_sub
  for_each                           = var.log_analytics_workspace_variables
  name                               = each.value.log_analytics_workspace_name
  resource_group_name                = each.value.log_analytics_workspace_resource_group_name
  location                           = each.value.log_analytics_workspace_location
  sku                                = each.value.log_analytics_workspace_sku
  retention_in_days                  = each.value.log_analytics_workspace_retention_in_days
  daily_quota_gb                     = each.value.log_analytics_workspace_sku == "Free" ? "0.5" : each.value.log_analytics_workspace_daily_quota_gb
  cmk_for_query_forced               = each.value.log_analytics_workspace_cmk_for_query_forced
  internet_ingestion_enabled         = each.value.log_analytics_workspace_internet_ingestion_enabled
  internet_query_enabled             = each.value.log_analytics_workspace_internet_query_enabled
  reservation_capacity_in_gb_per_day = each.value.log_analytics_workspace_sku == "CapacityReservation" ? each.value.log_analytics_workspace_reservation_capacity_in_gb_per_day : null
  tags                               = merge(each.value.log_analytics_workspace_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}
#LOG ANALYTICS WORKSPACE PRIMARY SHARED KEY SECRET
resource "azurerm_key_vault_secret" "log_analytics_workspace_primary_shared_key" {
  provider     = azurerm.keyvault_sub
  for_each     = var.log_analytics_workspace_variables
  name         = each.value.log_analytics_workspace_primary_shared_key_vault_secret_name
  value        = azurerm_log_analytics_workspace.log_analytics_workspace[each.key].primary_shared_key
  key_vault_id = data.azurerm_key_vault.log_analytics_workspace_keys_key_vault_id[each.key].id
}
#LOG ANALYTICS WORKSPACE SECONDARY SHARED KEY SECRET
resource "azurerm_key_vault_secret" "log_analytics_workspace_secondary_shared_key" {
  provider     = azurerm.keyvault_sub
  for_each     = var.log_analytics_workspace_variables
  name         = each.value.log_analytics_workspace_secondary_shared_key_vault_secret_name
  value        = azurerm_log_analytics_workspace.log_analytics_workspace[each.key].secondary_shared_key
  key_vault_id = data.azurerm_key_vault.log_analytics_workspace_keys_key_vault_id[each.key].id
}