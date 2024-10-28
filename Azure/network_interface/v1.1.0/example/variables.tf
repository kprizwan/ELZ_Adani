#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
  default = {}
}

#VNET VARIABLES
variable "vnets_variables" {
  description = "Map of vnet objects. name, vnet_address_space, and dns_server supported"
  type = map(object({
    name                        = string
    location                    = string
    resource_group_name         = string
    address_space               = list(string)
    dns_servers                 = list(string)
    flow_timeout_in_minutes     = number
    bgp_community               = string
    is_ddos_protection_required = bool
    ddos_protection_plan_name   = string
    vnet_tags                   = map(string)
    edge_zone                   = string
  }))
  default = {}
}

#Subnet Variables
variable "subnet_variables" {
  type = map(object({
    name                                           = string
    resource_group_name                            = string
    virtual_network_name                           = string
    address_prefixes                               = list(string)
    enforce_private_link_service_network_policies  = bool
    enforce_private_link_endpoint_network_policies = bool
    service_endpoints                              = list(string)
    is_delegetion_required                         = bool
    delegation_name                                = string
    service_name                                   = string
    service_actions                                = list(string)
  }))
  default = {}
}

#Public_IP Variables
variable "public_ip_variables" {
  type = map(object({
    name                    = string
    resource_group_name     = string
    location                = string
    ip_version              = string
    allocation_method       = string
    sku                     = string
    sku_tier                = string
    zones                   = list(string)
    edge_zone               = string
    public_ip_dns           = string
    idle_timeout_in_minutes = string
    reverse_fqdn            = string
    public_ip_prefix_id     = string
    ip_tags                 = map(string)
    public_ip_tags          = map(string)
  }))
}

variable "load_balancers_variables" {
  type = map(object({
    load_balancer_name                = string
    load_balancer_resource_group_name = string
    load_balancer_location            = string
    load_balancer_edge_zone           = string
    load_balancer_frontend_ip_configuration = map(object({
      frontend_ip_configuration_name  = string
      frontend_ip_configuration_zones = list(string)
      frontend_ip_configuration_subnet = object({
        subnet_name                    = string
        subnet_virtual_network_name    = string
        virtual_network_resource_group = string
      })
      frontend_ip_configuration_gateway_load_balancer_frontend_ip_configuration_id = object({
        gateway_load_balancer_name                = string
        gateway_load_balancer_resource_group_name = string
      })
      frontend_ip_configuration_private_ip_address            = string
      frontend_ip_configuration_private_ip_address_allocation = string
      frontend_ip_configuration_private_ip_address_version    = string
      frontend_ip_configuration_public_ip_address_id = object({
        public_ip_name                = string
        public_ip_resource_group_name = string
      })
      frontend_ip_configuration_public_ip_prefix_id = object({
        public_ip_prefix_name                = string
        public_ip_prefix_resource_group_name = string
      })
    }))
    load_balancer_sku      = string
    load_balancer_sku_tier = string
    load_balancer_tags     = map(string)
  }))
  default = {}
}
#Network interface Variables
variable "network_interface_variables" {
  type = map(object({
    network_interface_name                          = string
    network_interface_location                      = string
    network_interface_resource_group_name           = string
    network_interface_dns_servers                   = list(string)
    network_interface_edge_zone                     = string
    network_interface_enable_ip_forwarding          = bool
    network_interface_enable_accelerated_networking = bool
    network_interface_internal_dns_label            = string
    network_interface_ip_config = map(object({
      ip_configuration_name                          = string
      ip_configuration_private_ip_address_allocation = string
      ip_configuration_private_ip_address            = string
      ip_configuration_private_ip_address_version    = string
      ip_configuration_subnet = object({
        virtual_network_name                = string
        subnet_name                         = string
        virtual_network_resource_group_name = string
      })
      ip_configuration_public_ip = object({
        public_ip_name                = string
        public_ip_resource_group_name = string
      })
      ip_configuration_primary = bool
      ip_configuration_load_balancer = object({
        load_balancer_name                = string
        load_balancer_resource_group_name = string
      })
    }))
    network_interface_tags = map(string)
  }))
  default = {}
}