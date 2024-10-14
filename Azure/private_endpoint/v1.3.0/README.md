### Attributes: ###
- private_endpoint_name                                = string #(Required) Specifies the Name of the Private Endpoint. Changing this forces a new resource to be created.
- private_endpoint_resource_group_name                 = string #(Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created.
- private_endpoint_location                            = string #(Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created.
- private_endpoint_virtual_network_name                = string #The name of the network interface associated with the private_endpoint
- private_endpoint_virtual_network_resource_group_name = string #(Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created.
- private_endpoint_subnet_name  = string #(Required) subnet in which private endpoint is hosting
- custom_network_interface_name = string #(Optional) The custom name of the network interface attached to the private endpoint. Changing this forces a new resource to be created.
- private_endpoint_private_dns_zone_group = object({})    #(Optional) A private_dns_zone_group block as defined below.
   - private_dns_zone_group_name          = string       #(Required) Specifies the Name of the Private DNS Zone Group.
   - private_dns_zone_names               = list(string) #(Required) Specifies the list of Private DNS Zones names to include within the private_dns_zone_group.These names will be fetched by the data resource of private_dns_zone name.
   - private_dns_zone_resource_group_name = string       #(Required) Specifies the resource group name of Private DNS Zones to include within the private_dns_zone_group.This will be fetched by the data resource of private_dns_zone resource group name.
- private_endpoint_private_service_connection = object({})           #(Required) A private_service_connection block as defined below.
   - private_service_connection_name                 = string       #(Required) Specifies the Name of the Private Service Connection. Changing this forces a new resource to be created.
   - private_service_connection_is_manual_connection = bool         #(Required) set true if resource_alias != null
   - private_connection_resource_name                = string       #(Optional) The Service Name of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
   - private_connection_resource_resource_group_name = string       #(Optional) The Service Resource Group Name of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
   - private_connection_resource_alias               = string       #(Optional) The Service Alias of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
   - request_message                                 = string       #(Optional) Should be enabled if the is_manual_connection is set as true.  A message passed to the owner of the remote resource
   - subresource_names                               = list(string) # (Optional) A list of subresource names which the Private Endpoint is able to connect to.
- private_endpoint_ip_configuration = map(object({})) # (Optional) One or more ip_configuration blocks as defined below. This allows a static IP address to be set for this Private Endpoint, otherwise an address is dynamically allocated from the Subnet.
   - ip_configuration_name               = string   #(Required) Specifies the Name of the IP Configuration. Changing this forces a new resource to be created.
   - ip_configuration_private_ip_address = string   #(Required) Specifies the static IP address within the private endpoint's subnet to be used. Changing this forces a new resource to be created.
   - ip_configuration_subresource_name   = string   #(Optional) A list of subresource names which the Private Endpoint is able to connect to.
   - ip_configuration_member_name        = string   #(Optional) Specifies the member name this IP address applies to. If it is not specified, it will use the value of subresource_name. Changing this forces a new resource to be created.
- private_endpoint_tags = map(string) #(Optional)A mapping of tags to assign to the resource.

### Notes: ###
>1. is_manual_connection - If you are trying to connect the Private Endpoint to a remote resource without having the correct RBAC permissions on the remote resource set this value to true.
>2. Some resource types (such as Storage Account) only support 1 subresource per private endpoint.
>3. member_name will be required and will not take the value of subresource_name in the next major version. 