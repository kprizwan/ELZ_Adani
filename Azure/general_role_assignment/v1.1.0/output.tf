output "principal_type" {
  value       = { for k, v in azurerm_role_assignment.general_role_assignment : k => v.principal_type }
  description = "General assignment principal outputs"
}

output "role_definition_name" {
  value       = { for k, v in azurerm_role_assignment.general_role_assignment : k => v.role_definition_name }
  description = "General assignment role definition outputs"
}

output "principal_id" {
  value       = { for k, v in azurerm_role_assignment.general_role_assignment : k => v.principal_id }
  description = "General assignment principal id outputs"
}
output "scope" {
  value       = { for k, v in azurerm_role_assignment.general_role_assignment : k => v.scope }
  description = "General assignment scope outputs"
}

output "resources" {
  value       = data.azurerm_resources.azure_resource
  description = "General assignment resources outputs"
}
