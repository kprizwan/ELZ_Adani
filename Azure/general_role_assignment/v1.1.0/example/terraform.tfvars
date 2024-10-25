#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000001"
    location = "westus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

general_role_assignment_variables = {
  "general_role_assignment" = {
    general_role_assignment_role_definition_name                   = "Reader"
    general_role_assignment_description                            = "Grants full access to manage all resources but does not allow you to assign roles in Azure RBAC"
    general_role_assignment_target_resource_name                   = "ploceusavailabilityset000001"
    general_role_assignment_target_resource_type                   = "subscription"     # Possible values are Subscription, ManagementGroup or AzureResource
    general_role_assignment_management_group_name                  = null               # Please make as null if scope is not set as ManagementGroup
    general_role_assignment_principal_type                         = "ServicePrincipal" # type of the principal id.
    is_group_principal_id_exists                                   = false              # make it as true if Principal_type="Group".
    general_role_assignment_group_principal_display_name           = null               # give group display name if is_group_principal_id_exists =true, and principal_type="Group".
    is_service_principal_id_exists                                 = true               # make it as true if Principal_type="ServicePrincipal".
    general_role_assignment_service_principal_display_name         = "ploceussp000001"  # give Service_principal_display_name if is_Service_principal_id_exists =true, and principal_type="ServicePrincipal".
    is_user_principal_id_exists                                    = false              # make it as true if Principal_type="User".
    general_role_assignment_user_principal_name                    = null               # give user_principal_name if is_user_principal_id_exists =true, and principal_type="User".
    general_role_assignment_condition                              = null
    general_role_assignment_security_enabled                       = true
    general_role_assignment_condition_version                      = null
    general_role_assignment_delegated_managed_identity_resource_id = null
    general_role_assignment_skip_service_principal_aad_check       = false
  }
}


management_group_variables = {
  "ploceusparentmggroup000001" = {
    name                         = "ploceusmg000001"
    parent_management_group_name = null #incase of parent define as null
    subscription_id              = []
    level_number                 = 1
  },
  "ploceuschildmggroup000001" = {
    name                         = "ploceusmg000002"
    parent_management_group_name = "ploceusmg000001"
    subscription_id              = []
    level_number                 = 2
  }
  "ploceuschildmggroup000002" = {
    name                         = "ploceusmg000003"
    parent_management_group_name = "ploceusmg000001"
    subscription_id              = []
    level_number                 = 2

  },
  "ploceusparentmggroup000002" = {
    name                         = "ploceusmg000004"
    parent_management_group_name = null #incase of parent define as null
    subscription_id              = []
    level_number                 = 1
  },
  "ploceuschildmggroup000003" = {
    name                         = "ploceusmg000005"
    parent_management_group_name = "ploceusmg000004"
    subscription_id              = []
    level_number                 = 2
  }
  "ploceusparentmggroup000004" = {
    name                         = "ploceusmg000006"
    parent_management_group_name = "ploceusmg000004"
    subscription_id              = []
    level_number                 = 2
  },
  "ploceuschildmggroup000001" = {
    name                         = "ploceusmg000007"
    parent_management_group_name = "ploceusmg000006"
    subscription_id              = []
    level_number                 = 3
  }
}