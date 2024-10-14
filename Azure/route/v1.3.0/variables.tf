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