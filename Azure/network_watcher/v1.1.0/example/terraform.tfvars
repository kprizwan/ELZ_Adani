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

network_watcher_variables = {
  "network_watcher_1" = {
    name                = "ploceusnetworkwatcher000001"
    location            = "westus2"
    resource_group_name = "ploceusrg000001"
    network_watcher_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  },
  "network_watcher_2" = {
    name                = "ploceusnetworkwatcher000002"
    location            = "eastus2"
    resource_group_name = "ploceusrg000001"
    network_watcher_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
