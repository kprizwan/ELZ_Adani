variable "general_role_assignment_variables" {
  type = map(object({
    role_definition_name                   = string
    scope                                  = string
    principal_id                           = string
    principal_type                         = string
    principal_display_name                 = string
    is_user_principal_id_exists            = bool
    is_service_principal_id_exists         = bool
    is_group_principal_id_exists           = bool
    user_principal_name                    = string
    service_principal_display_name         = string
    group_principal_display_name           = string
    condition                              = string
    condition_version                      = string
    delegated_managed_identity_resource_id = string
    description                            = string
    skip_service_principal_aad_check       = bool
    security_enabled                       = bool
  }))
}