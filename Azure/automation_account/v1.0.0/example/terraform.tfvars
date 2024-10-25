resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg00001"
    location = "westus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
} 

automation_account_variables = {
  "automation_account_1" = {
    identity_type       = "SystemAssigned"
    location            = "westus2"
    name                = "ploceusautomationaccount00001"
    resource_group_name = "ploceusrg00001"
    sku_name            = "Basic"
    user_identity_name  = null
    automation_account_tags = {
      Created_By = "Ploceus"
      Department = "CIS"
    }
  }
}