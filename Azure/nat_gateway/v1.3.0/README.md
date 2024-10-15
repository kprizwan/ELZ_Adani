### Attributes:

- nat_gateway_name                    = string        #(Required) Specifies the name of the NAT Gateway. Changing this forces a new resource to be created.
- nat_gateway_location                = string        #(Optional) Specifies the supported Azure location where the NAT Gateway should exist. Changing this forces a new resource to be created.
- nat_gateway_resource_group_name     = string        #(Required) Specifies the name of the Resource Group in which the NAT Gateway should exist. Changing this forces a new resource to be created.
- nat_gateway_sku_name                = string        #(Optional) The SKU which should be used. At this time the only supported value is Standard. Defaults to Standard. 
- nat_gateway_idle_timeout_in_minutes = string        #(Optional) The idle timeout which should be used in minutes. Defaults to 4.
- nat_gateway_zones                   = list(string)  #(Optional) Specifies a list of Availability Zones in which this NAT Gateway should be located. Changing this forces a new NAT Gateway to be created.
- nat_gateway_tags                    = map(string)   #(Optional) A mapping of tags to assign to the resource. Changing this forces a new resource to be created.