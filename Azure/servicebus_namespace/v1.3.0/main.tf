locals {
  is_customer_managed_key_required = { for k, v in var.servicebus_namespace_variables : k => v if lookup(v, "servicebus_namespace_is_customer_managed_key_required", false) == true }
  identities_list = flatten([
    for k, v in var.servicebus_namespace_variables : [
      for i, j in v.servicebus_namespace_identity.identity_user_assigned_identities : [
        merge(
          {
            main_key                     = k,
            identity_name                = j.user_assigned_identities_name
            identity_resource_group_name = j.user_assigned_identities_resource_group_name
          },
          j
        )
      ]
    ] if v.servicebus_namespace_identity.identity_type != "SystemAssigned" || v.servicebus_namespace_identity.identity_type != null
  ])
  servicebus_namespace_network_rule_set_vals = { for k, v in var.servicebus_namespace_variables : k => v.servicebus_namespace_network_rule_set if lookup(v, "servicebus_namespace_network_rule_set", null) != null }
  subnets                                    = flatten([for k, v in local.servicebus_namespace_network_rule_set_vals : [for i, j in v.network_rules : { main_key = k, subnet_name = j.subnet_name, subnet_resource_group_name = j.subnet_resource_group_name, subnet_virtual_network_name = j.subnet_virtual_network_name } if lookup(j, "subnet_name", null) != null && lookup(j, "subnet_virtual_network_name", null) != null] if(lookup(v, "network_rules", null) != null)])
}

data "azurerm_key_vault" "key_vault_id" {
  provider            = azurerm.keyvault_sub
  for_each            = local.is_customer_managed_key_required
  name                = each.value.servicebus_namespace_key_vault_name
  resource_group_name = each.value.servicebus_namespace_key_vault_resource_group_name
}

data "azurerm_key_vault_key" "key_vault_key_id" {
  provider     = azurerm.keyvault_sub
  for_each     = local.is_customer_managed_key_required
  name         = each.value.servicebus_namespace_key_vault_key_name
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.key].id
}

data "azurerm_user_assigned_identity" "user_assigned_identity_id" {
  provider            = azurerm.servicebus_sub
  for_each            = { for v in local.identities_list : "${v.main_key},${v.identity_name}" => v }
  name                = each.value.user_assigned_identities_name
  resource_group_name = each.value.user_assigned_identities_resource_group_name
}

data "azurerm_subnet" "subnet" {
  for_each             = { for k, v in local.subnets : "${v.main_key}#${v.subnet_name}" => v }
  virtual_network_name = each.value.subnet_virtual_network_name
  name                 = each.value.subnet_name
  resource_group_name  = each.value.subnet_resource_group_name
}

resource "azurerm_servicebus_namespace" "servicebus_namespace" {
  provider                      = azurerm.servicebus_sub
  for_each                      = var.servicebus_namespace_variables
  name                          = each.value.servicebus_namespace_name
  resource_group_name           = each.value.servicebus_namespace_resource_group_name
  location                      = each.value.servicebus_namespace_location
  sku                           = each.value.servicebus_namespace_sku
  capacity                      = each.value.servicebus_namespace_capacity
  local_auth_enabled            = each.value.servicebus_namespace_local_auth_enabled
  public_network_access_enabled = each.value.servicebus_namespace_public_network_access_enabled
  minimum_tls_version           = each.value.servicebus_namespace_minimum_tls_version
  zone_redundant                = each.value.servicebus_namespace_zone_redundant
  dynamic "identity" {
    for_each = each.value.servicebus_namespace_identity != null ? [each.value.servicebus_namespace_identity] : []
    content {
      type = identity.value.identity_type
      identity_ids = identity.value.identity_user_assigned_identities == [] ? null : [
        for k, v in identity.value.identity_user_assigned_identities : data.azurerm_user_assigned_identity.user_assigned_identity_id["${each.key},${v.identity_name}"].id
      ]
    }
  }
  dynamic "customer_managed_key" {
    for_each = each.value.servicebus_namespace_customer_managed_key != null ? [each.value.servicebus_namespace_customer_managed_key] : []
    content {
      key_vault_key_id = data.azurerm_key_vault_key.key_vault_key_id[each.key].id
      identity_id = customer_managed_key.value.servicebus_namespace_identity.identity_user_assigned_identities == [] ? null : [
        for k, v in customer_managed_key.value.servicebus_namespace_identity.identity_user_assigned_identities : data.azurerm_user_assigned_identity.user_assigned_identity_id["${each.key},${v.identity_name}"].id
      ]
      infrastructure_encryption_enabled = customer_managed_key.value.customer_managed_key_infrastructure_encryption_enabled
    }
  }
  dynamic "network_rule_set" {
    for_each = each.value.servicebus_namespace_network_rule_set != null ? [each.value.servicebus_namespace_network_rule_set] : []
    content {
      default_action                = network_rule_set.value.default_action
      public_network_access_enabled = network_rule_set.value.public_network_access_enabled
      trusted_services_allowed      = network_rule_set.value.trusted_services_allowed
      ip_rules                      = network_rule_set.value.ip_rules
      dynamic "network_rules" {
        for_each = network_rule_set.value.network_rules != null ? network_rule_set.value.network_rules : []
        content {
          subnet_id                            = network_rules.value.subnet_name != null && network_rules.value.subnet_virtual_network_name != null ? data.azurerm_subnet.subnet["${each.key}#${network_rules.value.subnet_name}"].id : null
          ignore_missing_vnet_service_endpoint = network_rules.value.ignore_missing_vnet_service_endpoint
        }
      }
    }
  }
  tags = merge(each.value.servicebus_namespace_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}
