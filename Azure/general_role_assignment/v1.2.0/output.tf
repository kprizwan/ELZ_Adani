#General role assignmnet output
output "general_role_assignment_output" {
  description = "General Role Assignment Output values"
  value = { for k, v in azurerm_role_assignment.general_role_assignment : k =>
    {
      id             = v.id
      principal_type = v.principal_type
    }
  }
}
