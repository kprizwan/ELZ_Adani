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

resource "azurerm_servicebus_namespace" "servicebus_namespace" {
  provider            = azurerm.servicebus_sub
  for_each            = var.servicebus_namespace_variables
  name                = each.value.servicebus_namespace_name
  resource_group_name = each.value.servicebus_namespace_resource_group_name
  location            = each.value.servicebus_namespace_location
  sku                 = each.value.servicebus_namespace_sku
  capacity            = each.value.servicebus_namespace_capacity
  local_auth_enabled  = each.value.servicebus_namespace_local_auth_enabled
  zone_redundant      = each.value.servicebus_namespace_zone_redundant
  tags                = merge(each.value.servicebus_namespace_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }

  dynamic "identity" {
    for_each = each.value.servicebus_namespace_identity != null ? [each.value.servicebus_namespace_identity] : []
    content {
      type = each.value.servicebus_namespace_identity.identity_type
      identity_ids = each.value.servicebus_namespace_identity.identity_user_assigned_identities == [] ? null : [
        for k, v in each.value.servicebus_namespace_identity.identity_user_assigned_identities : data.azurerm_user_assigned_identity.user_assigned_identity_id["${each.key},${v.identity_name}"].id
      ]
    }
  }
  dynamic "customer_managed_key" {
    for_each = each.value.servicebus_namespace_customer_managed_key != null ? [each.value.servicebus_namespace_customer_managed_key] : []
    content {
      key_vault_key_id = data.azurerm_key_vault_key.key_vault_key_id[each.key].id
      identity_id = each.value.servicebus_namespace_identity.identity_user_assigned_identities == [] ? null : [
        for k, v in each.value.servicebus_namespace_identity.identity_user_assigned_identities : data.azurerm_user_assigned_identity.user_assigned_identity_id["${each.key},${v.identity_name}"].id
      ]
      infrastructure_encryption_enabled = each.value.servicebus_namespace_customer_managed_key.customer_managed_key_infrastructure_encryption_enabled
    }
  }
}