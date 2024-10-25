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

#APPLICATION INSIGHTS
application_insights_variables = {
  application_insights_1 = {
    name                = "applicationinsights000001"
    resource_group_name = "ploceusrg000001"
    location            = "eastus"
    application_type    = "web"
    retention_in_days   = 90
    disable_ip_masking  = false
    application_insights_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}