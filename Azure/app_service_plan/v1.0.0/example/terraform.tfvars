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

#APP SERVICE PLAN
app_service_plan_variables = {
  "app_service_plan_1" = {
    name                             = "ploceusappplan000003"
    resource_group_name              = "ploceusrg000001"
    location                         = "westus2"
    kind                             = "Windows"
    maximum_elastic_worker_count     = null
    reserved                         = false
    app_service_environment_required = false
    app_service_environment_name     = null
    sku_tier                         = "Shared"
    sku_size                         = "F1"
    sku_capacity                     = 1
    per_site_scaling                 = false
    app_service_plan_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
