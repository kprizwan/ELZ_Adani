#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000001"
    location = "eastus"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#APP SERVICE PLAN
app_service_plan_variables = {
  "app_service_plan_1" = {
    name                             = "ploceusappplan000001"
    resource_group_name              = "ploceusrg000001"
    location                         = "eastus"
    os_type                          = "Linux"
    maximum_elastic_worker_count     = null
    worker_count                     = null
    app_service_environment_required = false
    app_service_environment_name     = null
    sku_name                         = "F1"
    per_site_scaling_enabled         = false
    zone_balancing_enabled           = false
    app_service_plan_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  },
  "app_service_plan_2" = {
    name                             = "ploceusappplan000002"
    resource_group_name              = "ploceusrg000001"
    location                         = "eastus"
    os_type                          = "Windows"
    maximum_elastic_worker_count     = null
    worker_count                     = null
    app_service_environment_required = false
    app_service_environment_name     = null
    sku_name                         = "F1"
    per_site_scaling_enabled         = false
    zone_balancing_enabled           = false
    app_service_plan_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}