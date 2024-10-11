locals {
  is_container_registry_encryption_required = { for k, v in var.container_registry_variables : k => v if v.container_registry_encryption.encryption_enabled != false }
  is_container_virtual_network_required     = { for k, v in var.container_registry_variables : k => v if v.container_registry_network_rule_set_enabled != false }
}
locals {
  identities = { for k, v in var.container_registry_variables : k => lookup(v, "container_registry_identity", null) != null ? v.container_registry_identity.identity_type != "SystemAssigned" ? v.container_registry_identity.identity_identity_ids : null : null }
  identities_list = flatten([
    for k, v in local.identities : [
      for i in v : [
        {
          main_key                     = k,
          identity_name                = i.identity_ids_identity_name
          identity_resource_group_name = i.identity_ids_identity_resource_group_name
        }
      ]
    ] if v != null
  ])

  virtual_network_list = flatten([
    for k, v in var.container_registry_variables : [
      for i, j in v.container_registry_network_rule_set.network_rule_set_virtual_network : [
        merge(
          {
            main_key                            = k
            action                              = j.virtual_network_action
            subnet_name                         = j.virtual_network_subnet_name
            virtual_network_name                = j.virtual_network_virtual_network_name
            virtual_network_resource_group_name = j.virtual_network_resource_group_name

          },
          j
        )
      ]
    ] if v.container_registry_network_rule_set.network_rule_set_virtual_network != null

  ])
}
data "azurerm_key_vault" "key_vault" {
  provider            = azurerm.key_vault_sub
  for_each            = local.is_container_registry_encryption_required
  name                = each.value.container_registry_encryption.encryption_keyvault_name
  resource_group_name = each.value.container_registry_encryption.encryption_keyvault_resource_group_name
}
data "azurerm_key_vault_key" "key_vault_key" {
  provider     = azurerm.key_vault_sub
  for_each     = local.is_container_registry_encryption_required
  name         = each.value.container_registry_encryption.encryption_keyvault_key_name
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}
data "azurerm_user_assigned_identity" "user_assigned_ids" {
  provider            = azurerm.container_registry_sub
  for_each            = { for v in local.identities_list : "${v.main_key},${v.identity_name}" => v }
  name                = each.value.identity_name
  resource_group_name = each.value.identity_resource_group_name
}
data "azurerm_user_assigned_identity" "user_assigned_identity" {
  provider            = azurerm.container_registry_sub
  for_each            = local.is_container_registry_encryption_required
  name                = each.value.container_registry_encryption.encryption_identity_name
  resource_group_name = each.value.container_registry_encryption.encryption_identity_resource_group_name
}
data "azurerm_subnet" "subnet" {
  provider             = azurerm.container_registry_sub
  for_each             = { for v in local.virtual_network_list : "${v.main_key},${v.subnet_name}" => v }
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.virtual_network_resource_group_name
}

#CONTAINER REGISTRY
resource "azurerm_container_registry" "container_registry" {
  provider                      = azurerm.container_registry_sub
  for_each                      = var.container_registry_variables
  name                          = each.value.container_registry_name
  location                      = each.value.container_registry_location
  resource_group_name           = each.value.container_registry_resource_group_name
  export_policy_enabled         = each.value.container_registry_export_policy_enabled
  sku                           = each.value.container_registry_sku
  admin_enabled                 = each.value.container_registry_admin_enabled
  public_network_access_enabled = each.value.container_registry_public_network_access_enabled
  quarantine_policy_enabled     = each.value.container_registry_quarantine_policy_enabled
  zone_redundancy_enabled       = each.value.container_registry_zone_redundancy_enabled
  data_endpoint_enabled         = each.value.container_registry_data_endpoint_enabled
  anonymous_pull_enabled        = each.value.container_registry_anonymous_pull_enabled
  network_rule_bypass_option    = each.value.container_registry_network_rule_bypass_option
  dynamic "retention_policy" {
    for_each = each.value.container_registry_retention_policy.retention_policy_enabled != false ? [1] : []
    content {
      enabled = each.value.container_registry_retention_policy.retention_policy_enabled
      days    = each.value.container_registry_retention_policy.retention_policy_days
    }
  }
  dynamic "trust_policy" {
    for_each = each.value.container_registry_trust_policy != null ? [1] : []
    content {
      enabled = each.value.container_registry_trust_policy.trust_policy_enabled
    }
  }
  dynamic "identity" {
    for_each = each.value.container_registry_identity != null ? [1] : []
    content {
      type = each.value.container_registry_identity.identity_type
      identity_ids = each.value.container_registry_identity.identity_type == "SystemAssigned, UserAssigned" || each.value.container_registry_identity.identity_type == "UserAssigned" ? [
        for k, v in each.value.container_registry_identity.identity_identity_ids : data.azurerm_user_assigned_identity.user_assigned_ids["${each.key},${v.identity_ids_identity_name}"].id
      ] : null
    }
  }

  dynamic "encryption" {
    for_each = each.value.container_registry_encryption.encryption_enabled != false ? [1] : []
    content {
      enabled            = each.value.container_registry_encryption.encryption_enabled
      key_vault_key_id   = data.azurerm_key_vault_key.key_vault_key[each.key].id
      identity_client_id = data.azurerm_user_assigned_identity.user_assigned_identity[each.key].client_id
    }
  }
  dynamic "georeplications" {
    for_each = each.value.container_registry_georeplication_enabled == false ? [] : each.value.container_registry_georeplications
    content {
      location                  = georeplications.value.georeplications_location
      zone_redundancy_enabled   = georeplications.value.georeplications_regional_endpoint_enabled
      regional_endpoint_enabled = georeplications.value.georeplications_zone_redundancy_enabled
      tags                      = georeplications.value.georeplications_tags
    }
  }
  dynamic "network_rule_set" {
    for_each = each.value.container_registry_network_rule_set_enabled == true ? [1] : []
    content {
      default_action = each.value.container_registry_network_rule_set.network_rule_set_default_action
      dynamic "ip_rule" {
        for_each = each.value.container_registry_network_rule_set.network_rule_set_ip_rule != null ? { for k, v in each.value.container_registry_network_rule_set.network_rule_set_ip_rule : k => v } : null
        content {
          action   = ip_rule.value.ip_rule_action
          ip_range = ip_rule.value.ip_rule_ip_range
        }
      }
      dynamic "virtual_network" {
        for_each = each.value.container_registry_network_rule_set.network_rule_set_virtual_network != null ? each.value.container_registry_network_rule_set.network_rule_set_virtual_network : null
        content {
          action    = virtual_network.value.virtual_network_action
          subnet_id = data.azurerm_subnet.subnet["${each.key},${virtual_network.value.virtual_network_subnet_name}"].id
        }
      }
    }
  }

  tags = merge(each.value.container_registry_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}
