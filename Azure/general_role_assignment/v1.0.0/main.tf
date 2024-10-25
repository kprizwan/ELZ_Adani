locals {
  is_user_principal_id_exists = { for k, v in var.general_role_assignment_variables : k => v if lookup(v, "principal_type", null) == "User" }
}

locals {
  is_service_principal_id_exists = { for k, v in var.general_role_assignment_variables : k => v if lookup(v, "principal_type", null) == "ServicePrincipal" }
}

locals {
  is_group_principal_id_exists = { for k, v in var.general_role_assignment_variables : k => v if lookup(v, "principal_type", null) == "Group" }
}

resource "azurerm_role_assignment" "general_role_assignment" {
  for_each                               = var.general_role_assignment_variables
  role_definition_name                   = each.value.role_definition_name
  scope                                  = each.value.scope
  principal_id                           = each.value.principal_type == "ServicePrincipal" ? data.azuread_service_principal.service_principal[each.key].id : (each.value.principal_type == "User" ? data.azuread_user.user_principal[each.key].id : data.azuread_group.group_principal[each.key].id)
  condition                              = each.value.condition
  condition_version                      = each.value.condition_version
  delegated_managed_identity_resource_id = each.value.delegated_managed_identity_resource_id
  description                            = each.value.description
  skip_service_principal_aad_check       = each.value.skip_service_principal_aad_check
}

data "azuread_user" "user_principal" {
  for_each            = local.is_user_principal_id_exists
  user_principal_name = each.value.user_principal_name
}

data "azuread_service_principal" "service_principal" {
  for_each     = local.is_service_principal_id_exists
  display_name = each.value.service_principal_display_name
}

data "azuread_group" "group_principal" {
  for_each         = local.is_group_principal_id_exists
  display_name     = each.value.group_principal_display_name
  security_enabled = each.value.security_enabled
}