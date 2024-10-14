#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  type = map(object({
    resource_group_name       = string      #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = string      #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags       = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups"
  default     = {}
}

#ROUTE TABLE VARIABLES
variable "route_table_variables" {
  description = "Map of Route Table object"
  type = map(object({
    route_table_name                          = string      #(Required) The name of the route table. 
    route_table_location                      = string      #(Required) The Azure location where the resource should exist.
    route_table_resource_group_name           = string      #(Required) The name of the resource group in which to create the route table.
    route_table_disable_bgp_route_propagation = bool        #(Optional) Boolean flag which controls propagation of routes learned by BGP on that route table. True means disable. Default value "false"
    route_table_tags                          = map(string) #(Optional) A mapping of tags to assign to the resource.
    route_table_route = list(object({                       #(Optional) List of objects representing routes.
      route_name                   = string                 #(Required) The name of the route.
      route_address_prefix         = string                 #(Required) The destination to which the route applies. Can be CIDR(such as 10.1.0.0/16) or Azure Service Tag (such as ApiManagement, AzureBackup or AzureMonitor) format.
      route_next_hop_type          = string                 #(Required) The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None.
      route_next_hop_in_ip_address = string                 #(Optional) Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance. Default value "null"
    }))
  }))
  default = {}
}

#ROUTE VARIABLES
variable "route_variables" {
  description = "Map of Route object"
  type = map(object({
    route_name                   = string #(Required) The name of the route.
    route_resource_group_name    = string #(Required) The name of the resource group in which to create the route. 
    route_route_table_name       = string #(Required) The name of the route table within which to create the route.
    route_address_prefix         = string #(Required) The destination to which the route applies. Can be CIDR(such as 10.1.0.0/16) or Azure Service Tag (such as ApiManagement, AzureBackup or AzureMonitor) format.
    route_next_hop_type          = string #(Required) The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None.
    route_next_hop_in_ip_address = string #(Optional) Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance. Default value "null"
  }))
  default = {}
}