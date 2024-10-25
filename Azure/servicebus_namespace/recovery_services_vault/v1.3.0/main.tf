locals {
  identities_list = flatten([
    for k, v in var.recovery_services_vault_variables : [
      for i, j in coalesce(v.recovery_services_vault_identity.recovery_services_vault_user_assigned_identities, []) : [
        merge(
          {
            main_key                     = k
            identity_name                = j.recovery_services_vault_user_identity_name
            identity_resource_group_name = j.recovery_services_vault_user_identity_resource_group_name
          },
          j
        )
      ] if v.recovery_services_vault_identity.recovery_services_vault_user_assigned_identities != null
    ] if v.recovery_services_vault_identity != null
  ])
}

data "azurerm_key_vault" "encryption_key_vault" {
  for_each            = { for k, v in var.recovery_services_vault_variables : k => v if lookup(v, "recovery_services_vault_encryption") != null }
  name                = each.value.recovery_services_vault_encryption.encryption_key_vault_name
  resource_group_name = each.value.recovery_services_vault_encryption.encryption_key_vault_resource_group_name
}

data "azurerm_key_vault_key" "encryption_key" {
  for_each     = { for k, v in var.recovery_services_vault_variables : k => v if lookup(v, "recovery_services_vault_encryption") != null }
  name         = each.value.recovery_services_vault_encryption.encryption_key_vault_key_name
  key_vault_id = data.azurerm_key_vault.encryption_key_vault[each.key].id
}

data "azurerm_user_assigned_identity" "recovery_services_vault_user_assigned_identity" {
  for_each            = { for v in local.identities_list : "${v.main_key},${v.identity_name}" => v }
  name                = each.value.recovery_services_vault_user_identity_name
  resource_group_name = each.value.recovery_services_vault_user_identity_resource_group_name
}

#RECOVERY SERVICE VAULT RESOURCE
resource "azurerm_recovery_services_vault" "recovery_services_vault" {
  for_each                           = var.recovery_services_vault_variables
  name                               = each.value.recovery_services_vault_name
  resource_group_name                = each.value.recovery_services_vault_resource_group_name
  location                           = each.value.recovery_services_vault_location
  sku                                = each.value.recovery_services_vault_sku
  storage_mode_type                  = each.value.recovery_services_vault_storage_mode_type
  public_network_access_enabled      = each.value.recovery_services_vault_public_network_access_enabled
  immutability                       = each.value.recovery_services_vault_immutability
  classic_vmware_replication_enabled = each.value.recovery_services_vault_classic_vmware_replication_enabled
  cross_region_restore_enabled       = each.value.recovery_services_vault_storage_mode_type == "GeoRedundant" ? true : false
  soft_delete_enabled                = each.value.recovery_services_vault_soft_delete_enabled
  dynamic "identity" {
    for_each = each.value.recovery_services_vault_identity != null ? [1] : []
    content {
      type = each.value.recovery_services_vault_identity.recovery_services_vault_identity_type
      identity_ids = each.value.recovery_services_vault_identity.recovery_services_vault_identity_type == "SystemAssigned, UserAssigned" || each.value.recovery_services_vault_identity.recovery_services_vault_identity_type == "UserAssigned" ? [
        for k, v in each.value.recovery_services_vault_identity.recovery_services_vault_user_assigned_identities : data.azurerm_user_assigned_identity.recovery_services_vault_user_assigned_identity["${each.key},${v.recovery_services_vault_user_identity_name}"].id
      ] : null
    }
  }
  dynamic "encryption" {
    for_each = each.value.recovery_services_vault_identity != null && each.value.recovery_services_vault_encryption != null ? [each.value.recovery_services_vault_encryption] : []
    content {
      key_id                            = data.azurerm_key_vault_key.encryption_key[each.key].id
      infrastructure_encryption_enabled = encryption.value.encryption_infrastructure_encryption_enabled
      user_assigned_identity_id         = each.value.encryption_user_assigned_identity_id_required == true ? data.azurerm_user_assigned_identity.recovery_services_vault_user_assigned_identity[each.key].id : null
      use_system_assigned_identity      = encryption.value.encryption_use_system_assigned_identity
    }
  }
  dynamic "monitoring" {
    for_each = each.value.recovery_services_vault_monitoring == null ? [] : [each.value.recovery_services_vault_monitoring]
    content {
      alerts_for_all_job_failures_enabled            = monitoring.value.monitoring_alerts_for_all_job_failures_enabled
      alerts_for_critical_operation_failures_enabled = monitoring.value.monitoring_alerts_for_critical_operation_failures_enabled
    }
  }
  tags = merge(each.value.recovery_services_vault_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}
