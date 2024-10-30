#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000001" #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = "westus2"         #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#NETWORK WATCHER VARIABLES
network_watcher_variables = {
  "network_watcher_1" = {
    name                = "ploceusnetworkwatcher000001" #(Required) The name of the Network Watcher. Changing this forces a new resource to be created.
    location            = "westus2"                     #(Required) The name of the resource group in which to create the Network Watcher. Changing this forces a new resource to be created.
    resource_group_name = "ploceusrg000001"             #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    network_watcher_tags = {                            #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  },
  "network_watcher_2" = {
    name                = "ploceusnetworkwatcher000002" #(Required) The name of the Network Watcher. Changing this forces a new resource to be created.
    location            = "eastus"                      #(Required) The name of the resource group in which to create the Network Watcher. Changing this forces a new resource to be created.
    resource_group_name = "ploceusrg000001"             #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    network_watcher_tags = {                            #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}