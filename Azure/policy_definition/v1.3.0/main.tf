locals {
  is_management_group_required = { for k, v in var.policy_definition_variables : k => v if v.policy_definition_management_group_display_name != null }
}

#DATA BLOCK FOR MANAGEMENT GROUP
data "azurerm_management_group" "management_group" {
  for_each     = local.is_management_group_required
  display_name = each.value.policy_definition_management_group_display_name
}

#POLICY DEFINITION
resource "azurerm_policy_definition" "policy_definition" {
  for_each            = var.policy_definition_variables
  name                = each.value.policy_definition_name
  policy_type         = each.value.policy_definition_policy_type
  mode                = each.value.policy_definition_mode
  display_name        = each.value.policy_definition_display_name
  description         = each.value.policy_definition_description
  management_group_id = each.value.policy_definition_management_group_display_name != null ? data.azurerm_management_group.management_group[each.key].id : null
  metadata            = each.value.policy_definition_metadata
  policy_rule         = each.value.policy_definition_policy_rule
  parameters          = each.value.policy_definition_parameters
  lifecycle {
    ignore_changes = [metadata, ]
  }
}