### Attributes: ###
- public_ip_name                  = string   #(Required) Specifies the name of the Public IP. 
- public_ip_resource_group_name   = string   #(Required) The name of the Resource Group wheres Public IP should exist.
- nat_gateway_name                = string   #(Required) Specifies the name of the NAT Gateway. Changing this forces a new resource to be created.
- nat_gateway_resource_group_name = string   #(Required) Specifies the name of the Resource Group in which the NAT Gateway should exist.

### Notes: ###
1. Associations between NAT Gateway and Public IP Addresses can be imported using the resource id in Terraform Specific ID format {natGatewayID}|{publicIPAddressID} 
