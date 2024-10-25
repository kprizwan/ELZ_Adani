locals {
  identities_list = flatten([
    for k, v in var.automation_account_variables : [
      for i, j in lookup(v.automation_account_identity, "automation_account_identity_identity", {}) : [
        merge(
          {
            main_key                     = k
            identity_name                = j.user_assigned_identity_name
            identity_resource_group_name = j.user_assigned_identity_resource_group_name
          },
          j
        )
      ]
    ] if v.automation_account_identity != null

  ])
}


data "azurerm_user_assigned_identity" "user_assigned_ids" {
  for_each            = { for v in local.identities_list : "${v.main_key},${v.identity_name}" => v }
  name                = each.value.identity_name
  resource_group_name = each.value.identity_resource_group_name
}


resource "azurerm_automation_account" "automation_account" {
  for_each                      = var.automation_account_variables
  name                          = each.value.automation_account_name
  public_network_access_enabled = each.value.automation_account_public_network_access_enabled
  location                      = each.value.automation_account_location
  resource_group_name           = each.value.automation_account_resource_group_name
  sku_name                      = each.value.automation_account_sku_name
  tags                          = merge(each.value.automation_account_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  dynamic "identity" {
    for_each = each.value.automation_account_identity == null ? [] : [1]
    content {
      type = each.value.automation_account_identity.automation_account_identity_type
      identity_ids = each.value.automation_account_identity.automation_account_identity_type == "SystemAssigned, UserAssigned" || each.value.automation_account_identity.automation_account_identity_type == "UserAssigned" ? [
        for v in each.value.automation_account_identity.automation_account_identity_identity : data.azurerm_user_assigned_identity.user_assigned_ids["${each.key},${v.user_assigned_identity_name}"].id
      ] : null
    }
  }

  lifecycle { ignore_changes = [tags["Created_Time"]] }
}