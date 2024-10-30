#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000001"
    location = "westus2"
    resource_group_tags = {
      Created_By = "ploceus",
      Department = "CIS"
    }
  }
}

recovery_service_vault_variable = {
  "recovery_service_vault_1" = {
    name                = "ploceusrsv000001"
    resource_group_name = "ploceusrg000001"
    sku                 = "Standard"
    soft_delete_enabled = true
    identity            = null
    storage_mode_type   = null
    encryption          = null
    tags = {
      Created_By = "ploceus"
    }
  },
  "recovery_service_vault_2" = {
    name                = "ploceusrsv000002"
    sku                 = "Standard"
    resource_group_name = "ploceusrg000001"
    soft_delete_enabled = true
    identity            = null
    storage_mode_type   = null
    encryption          = null
    tags = {
      Created_By = "ploceus"
    }
  }
}