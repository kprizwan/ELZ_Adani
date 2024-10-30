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

recovery_services_vault_variables = {
  "recovery_services_vault_1" = {
    name                         = "ploceusrsv000001"
    resource_group_name          = "ploceusrg000001"
    sku                          = "Standard" # (Required) Sets the vault's SKU. Possible values include: Standard, RS0
    location                     = "westus2"
    soft_delete_enabled          = true
    identity                     = null
    storage_mode_type            = null # (Optional) The storage type of the Recovery Services Vault. Possible values are GeoRedundant, LocallyRedundant and ZoneRedundant. Defaults to GeoRedundant.
    cross_region_restore_enabled = null #make it true only when storage_mode_type="GeoRedundant"
    encryption                   = null
    tags = {
      Created_By = "ploceus"
    }
  },
  "recovery_services_vault_2" = {
    name                         = "ploceusrsv000002"
    sku                          = "Standard"
    resource_group_name          = "ploceusrg000001"
    location                     = "westus2"
    soft_delete_enabled          = true
    identity                     = null
    storage_mode_type            = null
    cross_region_restore_enabled = null #make it true only when storage_mode_type="GeoRedundant"
    encryption                   = null
    tags = {
      Created_By = "ploceus"
    }
  }
}