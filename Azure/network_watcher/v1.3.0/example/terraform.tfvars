#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000001" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location = "westus2"         #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_managed_by = "ploceus" #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#NETWORK WATCHER
network_watcher_variables = {
  "network_watcher_1" = {
    network_watcher_name                = "ploceusnetworkwatcher000001" #(Required) The name of the Network Watcher. Changing this forces a new resource to be created.
    network_watcher_location            = "eastus2"                     #(Required) The name of the resource group in which to create the Network Watcher. Changing this forces a new resource to be created.
    network_watcher_resource_group_name = "ploceusrg000001"             #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    network_watcher_tags = {                                            #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  },
  "network_watcher_2" = {
    network_watcher_name                = "ploceusnetworkwatcher000002" #(Required) The name of the Network Watcher. Changing this forces a new resource to be created.
    network_watcher_location            = "northeurope"                 #(Required) The name of the resource group in which to create the Network Watcher. Changing this forces a new resource to be created.
    network_watcher_resource_group_name = "ploceusrg000001"             #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    network_watcher_tags = {                                            #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}