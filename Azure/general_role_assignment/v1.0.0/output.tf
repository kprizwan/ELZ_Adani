output "principal_type" {
  value = { for k, v in azurerm_role_assignment.general_role_assignment : k => v.principal_type }
}

output "role_definition_name" {
  value = { for k, v in azurerm_role_assignment.general_role_assignment : k => v.role_definition_name }
}

output "principal_id" {
  value = { for k, v in azurerm_role_assignment.general_role_assignment : k => v.principal_id }
}
output "scope" {
  value = { for k, v in azurerm_role_assignment.general_role_assignment : k => v.scope }
}

/* output"principal_display_name"{
    value = { for k, v in azurerm_role_assignment.general_role_assignment : k => v.principal_display_name }
} */
