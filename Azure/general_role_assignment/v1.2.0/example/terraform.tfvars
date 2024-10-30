#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000001" #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = "westus2"         #(Required) The Azure Region where the Resource Group should exist.
    resource_group_tags = {                     #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#GENERAL ROLE ASSIGNMENT VARIABLES
general_role_assignment_variables = {
  "general_role_assignment" = {
    general_role_assignment_role_definition_name                   = "Reader"                                                                                          # (Optional) A unique UUID/GUID for this Role Assignment - one will be generated if not specified. Changing this forces a new resource to be created.
    general_role_assignment_description                            = "Grants full access to manage all resources but does not allow you to assign roles in Azure RBAC" # (Optional) The description of the role
    general_role_assignment_target_resource_name                   = "ploceustargetresource000001"                                                                     # (Required) The name of the resource to which we are assigning role
    general_role_assignment_target_resource_type                   = "Subscription"                                                                                    # (Required) Possible values are Subscription, ManagementGroup or AzureResource
    general_role_assignment_management_group_name                  = null
    general_role_assignment_resource_group_name                    = null               # (Optional) The name of the management group. Please make as null if scope is not set as ManagementGroup
    general_role_assignment_principal_type                         = "ServicePrincipal" # (Optional) Type of the principal id. It maybe User, Group or ServicePrincipal
    is_group_principal_id_exists                                   = false              # (Optional) Provide true when principal_type is "Group"
    general_role_assignment_group_principal_display_name           = null               # (Optional) give user_principal_name if is_group_principal_id_exists =true, and principal_type="Group".
    is_service_principal_id_exists                                 = true               # (Optional) Provide true when principal_type is "ServicePrincipal"
    general_role_assignment_service_principal_display_name         = "ploceussp000001"  # (Optional) give service_principal_display_name if is_service_principal_id_exists =true, and principal_type="ServicePrincipal".
    is_user_principal_id_exists                                    = false              # (Optional) Provide true when principle_type is "User" 
    general_role_assignment_user_principal_name                    = null               # (Optional) give user_principal_name if is_user_principal_id_exists =true, and principal_type="User".
    general_role_assignment_condition                              = null               # (Optional) The condition that limits the resources that the role can be assigned to. Changing this forces a new resource to be created.
    general_role_assignment_security_enabled                       = true               # (Optional) Required for fetching group principal
    general_role_assignment_condition_version                      = null               # (Optional) The version of the condition. Possible values are 1.0 or 2.0. Changing this forces a new resource to be created.  
    general_role_assignment_delegated_managed_identity_resource_id = null               # (Optional) The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created 
    general_role_assignment_skip_service_principal_aad_check       = false              # (Optional) If the principal_id is a newly provisioned Service Principal set this value to true to skip the Azure Active Directory check which may fail due to replication lag. This argument is only valid if the principal_id is a Service Principal identity. Defaults to false.
  }
}