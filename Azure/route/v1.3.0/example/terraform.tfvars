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

#ROUTE TABLE
route_table_variables = {
  "route_table_1" = {
    route_table_name                          = "ploceusrt000001" #(Required) The name of the route table. 
    route_table_location                      = "westus2"         #(Required) The Azure location where the resource should exist.
    route_table_resource_group_name           = "ploceusrg000001" #(Required) The name of the resource group in which to create the route table.
    route_table_disable_bgp_route_propagation = false             #(Optional) Boolean flag which controls propagation of routes learned by BGP on that route table. True means disable. Default value "false"
    route_table_tags = {                                          #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
    route_table_route = [{                                #(Optional) List of objects representing routes.
      route_name                   = "ploceusroute000001" #(Required) The name of the route.
      route_address_prefix         = "10.3.0.0/16"        #(Required) The destination to which the route applies. Can be CIDR(such as 10.1.0.0/16) or Azure Service Tag (such as ApiManagement, AzureBackup or AzureMonitor) format.
      route_next_hop_type          = "None"               #(Required) The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None.
      route_next_hop_in_ip_address = "10.2.0.0/24"        #(Optional) Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance.
      },
      {
        route_name                   = "ploceusroute000002" #(Required) The name of the route.
        route_address_prefix         = "10.2.0.0/16"        #(Required) The destination to which the route applies. Can be CIDR(such as 10.1.0.0/16) or Azure Service Tag (such as ApiManagement, AzureBackup or AzureMonitor) format.
        route_next_hop_type          = "None"               #(Required) The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None.
        route_next_hop_in_ip_address = "10.2.1.0/24"        #(Optional) Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance. Default value "null"
    }]
  },
  "route_table_2" = {
    route_table_name                          = "ploceusrt000002" #(Required) The name of the route table. 
    route_table_location                      = "westus2"         #(Required) The Azure location where the resource should exist.
    route_table_resource_group_name           = "ploceusrg000001" #(Required) The name of the resource group in which to create the route table.
    route_table_disable_bgp_route_propagation = false             #(Optional) Boolean flag which controls propagation of routes learned by BGP on that route table. True means disable.
    route_table_tags = {                                          #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
    route_table_route = null #(Optional) List of objects representing routes.
  }
}

#ROUTE
route_variables = {
  "route-1" = {
    route_name                   = "ploceusroute000003" #(Required) The name of the route.
    route_route_table_name       = "ploceusrt000001"    #(Required) The name of the route table within which to create the route.
    route_resource_group_name    = "ploceusrg000001"    #(Required) The name of the resource group in which to create the route. 
    route_address_prefix         = "10.4.0.0/16"        #(Required) The destination to which the route applies. Can be CIDR(such as 10.1.0.0/16) or Azure Service Tag (such as ApiManagement, AzureBackup or AzureMonitor) format.
    route_next_hop_type          = "VnetLocal"          #(Required) The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None.
    route_next_hop_in_ip_address = "10.2.0.0/24"        #(Optional) Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance.
  },
  "route-2" = {
    route_name                   = "ploceusroute000004" #(Required) The name of the route.
    route_route_table_name       = "ploceusrt000001"    #(Required) The name of the route table within which to create the route.
    route_resource_group_name    = "ploceusrg000001"    #(Required) The name of the resource group in which to create the route. 
    route_address_prefix         = "10.5.0.0/16"        #(Required) The destination to which the route applies. Can be CIDR(such as 10.1.0.0/16) or Azure Service Tag (such as ApiManagement, AzureBackup or AzureMonitor) format.
    route_next_hop_type          = "None"               #(Required) The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None.
    route_next_hop_in_ip_address = "10.2.1.0/24"        #(Optional) Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance.
  }
}
