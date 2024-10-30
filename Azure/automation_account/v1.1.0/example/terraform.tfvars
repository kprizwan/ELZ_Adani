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

user_assigned_identity_variables = {
  "uai1" = {
    user_assigned_identity_name                = "ploceusuai000001"
    user_assigned_identity_location            = "westus2"
    user_assigned_identity_resource_group_name = "ploceusrg000001"
    user_assigned_identity_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}


automation_account_variables = {
  "aa1" = {
    automation_account_identity = {
      automation_account_identity_type = "SystemAssigned, UserAssigned"
      automation_account_identity_identity = [{
        user_assigned_identity_name                = "ploceusuai000001"
        user_assigned_identity_resource_group_name = "ploceusrg000001"
      }]
    }
    automation_account_location                      = "westus2"
    automation_account_name                          = "ploceusaa000001"
    automation_account_public_network_access_enabled = true
    automation_account_resource_group_name           = "ploceusrg000001"
    automation_account_sku_name                      = "Basic"
    automation_account_tags = {
      Created_By = "Ploceus"
      Department = "CIS"
    }
  }
}