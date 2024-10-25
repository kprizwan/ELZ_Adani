locals {
  is_user_principal_id_exists = { for k, v in var.general_role_assignment_variables : k => v if lookup(v, "general_role_assignment_principal_type", null) == "User" }
}

locals {
  is_service_principal_id_exists = { for k, v in var.general_role_assignment_variables : k => v if lookup(v, "general_role_assignment_principal_type", null) == "ServicePrincipal" }
}

locals {
  is_group_principal_id_exists = { for k, v in var.general_role_assignment_variables : k => v if lookup(v, "general_role_assignment_principal_type", null) == "Group" }
}

locals {
  is_managemment_group_exists = { for k, v in var.general_role_assignment_variables : k => v if lookup(v, "general_role_assignment_target_resource_type", null) == "ManagementGroup" }
}

locals {
  is_resource_group_exists = { for k, v in var.general_role_assignment_variables : k => v if lookup(v, "general_role_assignment_target_resource_type", null) == "ResourceGroup" }
}

locals {
  is_resource_exists = { for k, v in var.general_role_assignment_variables : k => v if lookup(v, "general_role_assignment_target_resource_type", null) != "ManagementGroup" && lookup(v, "general_role_assignment_target_resource_type", null) != "Subscription" }
}

data "azuread_user" "user_principal" {
  for_each            = local.is_user_principal_id_exists
  user_principal_name = each.value.general_role_assignment_user_principal_name
}

data "azuread_service_principal" "service_principal" {
  for_each     = local.is_service_principal_id_exists
  display_name = each.value.general_role_assignment_service_principal_display_name
}

data "azuread_group" "group_principal" {
  for_each         = local.is_group_principal_id_exists
  display_name     = each.value.general_role_assignment_group_principal_display_name
  security_enabled = each.value.general_role_assignment_security_enabled
}


data "azurerm_resources" "azure_resource" {
  for_each = local.is_resource_exists
  name     = each.value.general_role_assignment_target_resource_name
  type     = each.value.general_role_assignment_target_resource_type
}

data "azurerm_subscription" "current" {
}

data "azurerm_management_group" "management_group_id" {
  for_each = local.is_managemment_group_exists
  name     = each.value.general_role_assignment_management_group_name
}

data "azurerm_resource_group" "resource_group_id" {
  for_each = local.is_resource_group_exists
  name     = each.value.general_role_assignment_resource_group_name
}

resource "azurerm_role_assignment" "general_role_assignment" {
  for_each                               = var.general_role_assignment_variables
  role_definition_name                   = each.value.general_role_assignment_role_definition_name
  scope                                  = each.value.general_role_assignment_target_resource_type == "ResourceGroup" ? data.azurerm_resource_group.resource_group_id[each.key].id : (each.value.general_role_assignment_target_resource_type == "ManagementGroup" ? data.azurerm_management_group.management_group_id[each.key].id : (each.value.general_role_assignment_target_resource_type == "Subscription" ? "/subscriptions/${each.value.general_role_assignment_target_resource_name}" : "${data.azurerm_resources.azure_resource[each.key].resources[0].id}"))
  principal_id                           = each.value.general_role_assignment_principal_type == "ServicePrincipal" ? data.azuread_service_principal.service_principal[each.key].id : (each.value.general_role_assignment_principal_type == "User" ? data.azuread_user.user_principal[each.key].id : data.azuread_group.group_principal[each.key].id)
  condition                              = each.value.general_role_assignment_condition
  condition_version                      = each.value.general_role_assignment_condition_version
  delegated_managed_identity_resource_id = each.value.general_role_assignment_delegated_managed_identity_resource_id
  description                            = each.value.general_role_assignment_description
  skip_service_principal_aad_check       = each.value.general_role_assignment_skip_service_principal_aad_check
}