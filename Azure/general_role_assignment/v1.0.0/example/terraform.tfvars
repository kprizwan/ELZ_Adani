general_role_assignment_variables = {
  "role_assignment_1" = {
    role_definition_name                   = "Reader"
    description                            = "Grants full access to manage all resources, but does not allow you to assign roles in Azure RBAC"
    scope                                  = "/subscriptions/e3d2d88d-b54a-4fb7-b918-3cb24aad9ba9/resourceGroups/ploceusrg000001"
    principal_id                           = null               # give the principal id as a input
    principal_type                         = "ServicePrincipal" # type of the principal id.
    principal_display_name                 = "ploceustest000001"
    is_group_principal_id_exists           = false               # make it as true if Principal_type="Group".
    group_principal_display_name           = null                # give group display name if is_group_principal_id_exists =true, and principal_type="Group".
    is_service_principal_id_exists         = true                # make it as true if Principal_type="ServicePrincipal".
    service_principal_display_name         = "ploceustest000001" # give Service_principal_display_name if is_Service_principal_id_exists =true, and principal_type="ServicePrincipal".
    is_user_principal_id_exists            = false               # make it as true if Principal_type="User".
    user_principal_name                    = null                # give user_principal_name if is_user_principal_id_exists =true, and principal_type="User".
    condition                              = null
    security_enabled                       = true
    condition_version                      = null
    delegated_managed_identity_resource_id = null
    skip_service_principal_aad_check       = false
  }
}
