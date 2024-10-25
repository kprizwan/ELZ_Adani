locals {
  is_user_identity_required = { for k, v in var.automation_account_variables : k => v if lookup(v, "identity_type", false) != "SystemAssigned" }
}


data "azurerm_user_assigned_identity" "automation_account_user_identity" {
    for_each            = local.is_user_identity_required
    name                = each.value.user_identity_name
    resource_group_name = each.value.resource_group_name
}


resource "azurerm_automation_account" "automation_account" {
  for_each            = var.automation_account_variables
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku_name            = each.value.sku_name
  tags                = merge(each.value.automation_account_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  identity {
    type                      = each.value.identity_type
    identity_ids              = each.value.identity_type == "SystemAssigned" ? null : data.azurerm_user_assigned_identity.automation_account_user_identity[each.key].id
  }
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}