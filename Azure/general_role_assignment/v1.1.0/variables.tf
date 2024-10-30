variable "general_role_assignment_variables" {
  type = map(object({
    general_role_assignment_role_definition_name                   = string
    general_role_assignment_target_resource_type                   = string
    general_role_assignment_target_resource_name                   = string
    general_role_assignment_description                            = string
    general_role_assignment_management_group_name                  = string
    general_role_assignment_principal_type                         = string
    is_user_principal_id_exists                                    = bool
    is_service_principal_id_exists                                 = bool
    is_group_principal_id_exists                                   = bool
    general_role_assignment_user_principal_name                    = string
    general_role_assignment_service_principal_display_name         = string
    general_role_assignment_group_principal_display_name           = string
    general_role_assignment_condition                              = string
    general_role_assignment_condition_version                      = string
    general_role_assignment_delegated_managed_identity_resource_id = string
    general_role_assignment_skip_service_principal_aad_check       = bool
    general_role_assignment_security_enabled                       = bool
  }))
}