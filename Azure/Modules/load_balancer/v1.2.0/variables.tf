variable "load_balancers_variables" {
  type = map(object({
    load_balancer_name                = string #(Required) Specifies the name of the Load Balancer.
    load_balancer_resource_group_name = string # (Required) The name of the Resource Group in which to create the Load Balancer.
    load_balancer_location            = string ## (Required) Specifies the supported Azure Region where the Load Balancer should be created.
    load_balancer_edge_zone           = string #(Optional) Specifies the Edge Zone within the Azure Region where this Load Balancer should exist. Changing this forces a new Load Balancer to be created.
    load_balancer_frontend_ip_configuration = map(object({
      frontend_ip_configuration_name  = string #(Required) Specifies the name of the frontend IP configuration.
      frontend_ip_configuration_zones = list(string)
      frontend_ip_configuration_subnet = object({
        subnet_name                    = string # Subnet name
        subnet_virtual_network_name    = string # virtual network name where subnet resides.
        virtual_network_resource_group = string # Resource group name where the virtual network resides.
      })
      frontend_ip_configuration_gateway_load_balancer_frontend_ip_configuration_id = object({ #(Optional) The Frontend IP Configuration ID of a Gateway SKU Load Balancer.
        gateway_load_balancer_name                = string                                    # gateway load balancer name
        gateway_load_balancer_resource_group_name = string                                    # gateway load balancer resource group name
      })
      frontend_ip_configuration_private_ip_address            = string # (Optional) Private IP Address to assign to the Load Balancer. The last one and first four IPs in any range are reserved and cannot be manually assigned.
      frontend_ip_configuration_private_ip_address_allocation = string #(Optional) The allocation method for the Private IP Address used by this Load Balancer. Possible values as Dynamic and Static.
      frontend_ip_configuration_private_ip_address_version    = string #The version of IP that the Private IP Address is. Possible values are IPv4 or IPv6.
      frontend_ip_configuration_public_ip_address_id = object({
        public_ip_name                = string # public ip  name
        public_ip_resource_group_name = string # public ip resource group name
      })
      frontend_ip_configuration_public_ip_prefix_id = object({
        public_ip_prefix_name                = string # public ip prefix name
        public_ip_prefix_resource_group_name = string # public ip prefix resource group name            
      })
    }))
    load_balancer_sku      = string      #(Optional) The SKU of the Azure Load Balancer. Accepted values are Basic, Standard and Gateway. Defaults to Basic.
    load_balancer_sku_tier = string      #(Optional) sku_tier - (Optional) The SKU tier of this Load Balancer. Possible values are Global and Regional. Defaults to Regional. Changing this forces a new resource to be created.
    load_balancer_tags     = map(string) # (Optional) A mapping of tags to assign to the resource.
  }))
  description = "Map of object of Load Balancer variables"
  default     = {}
}