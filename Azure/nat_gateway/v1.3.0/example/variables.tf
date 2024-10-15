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

#NAT GATEWAY VARIABLES
variable "nat_gateway_variables" {
  type = map(object({
    nat_gateway_name                    = string       #(Required) Specifies the name of the NAT Gateway. Changing this forces a new resource to be created.
    nat_gateway_location                = string       #(Optional) Specifies the supported Azure location where the NAT Gateway should exist. Changing this forces a new resource to be created.
    nat_gateway_resource_group_name     = string       #(Required) Specifies the name of the Resource Group in which the NAT Gateway should exist. Changing this forces a new resource to be created.
    nat_gateway_sku_name                = string       #(Optional) The SKU which should be used. At this time the only supported value is Standard. Defaults to Standard. 
    nat_gateway_idle_timeout_in_minutes = string       #(Optional) The idle timeout which should be used in minutes. Defaults to 4.
    nat_gateway_zones                   = list(string) #(Optional) Specifies a list of Availability Zones in which this NAT Gateway should be located. Changing this forces a new NAT Gateway to be created.
    nat_gateway_tags                    = map(string)  #(Optional) A mapping of tags to assign to the resource. Changing this forces a new resource to be created.
  }))
  default     = {}
  description = "Map of object of nat gateway variables"
}