#GENERAL ROLE ASSIGNMENT VARIABLES
variable "general_role_assignment_variables" {
  type = map(object({
    general_role_assignment_role_definition_name                   = string # (Optional) A unique UUID/GUID for this Role Assignment - one will be generated if not specified. Changing this forces a new resource to be created.
    general_role_assignment_target_resource_type                   = string # (Required) Possible values are Subscription, ManagementGroup or AzureResource
    general_role_assignment_target_resource_name                   = string # (Required) The name of the resource to which we are assigning role
    general_role_assignment_description                            = string # (Optional) The description of the role
    general_role_assignment_management_group_name                  = string # (Optional) The name of the management group. Please make as null if scope is not set as ManagementGroup
    general_role_assignment_resource_group_name                    = string # (Optional) The name of the resource group. Please make as null if scope is not set as ResourceGroup
    general_role_assignment_principal_type                         = string # (Optional) Type of the principal id. It maybe User, Group or ServicePrincipal
    is_user_principal_id_exists                                    = bool   # (Optional) Provide true when principle_type is "User" 
    is_service_principal_id_exists                                 = bool   # (Optional) Provide true when principal_type is "ServicePrincipal"
    is_group_principal_id_exists                                   = bool   # (Optional) Provide true when principal_type is "Group"
    general_role_assignment_user_principal_name                    = string # (Optional) give user_principal_name if is_user_principal_id_exists =true, and principal_type="User".
    general_role_assignment_service_principal_display_name         = string # (Optional) give service_principal_display_name if is_service_principal_id_exists =true, and principal_type="ServicePrincipal".
    general_role_assignment_group_principal_display_name           = string # (Optional) give user_principal_name if is_group_principal_id_exists =true, and principal_type="Group".
    general_role_assignment_condition                              = string # (Optional) The condition that limits the resources that the role can be assigned to. Changing this forces a new resource to be created.
    general_role_assignment_condition_version                      = string # (Optional) The version of the condition. Possible values are 1.0 or 2.0. Changing this forces a new resource to be created.
    general_role_assignment_delegated_managed_identity_resource_id = string # (Optional) The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created 
    general_role_assignment_skip_service_principal_aad_check       = bool   # (Optional) If the principal_id is a newly provisioned Service Principal set this value to true to skip the Azure Active Directory check which may fail due to replication lag. This argument is only valid if the principal_id is a Service Principal identity. Defaults to false.
    general_role_assignment_security_enabled                       = bool   # (Optional) Required for fetching group principal
  }))
  description = "Map of general role assignment variables"
  default     = {}
}