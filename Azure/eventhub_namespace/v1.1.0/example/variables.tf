
variable "resource_group_variables" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
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

#VNET variable   #Uncomment the below lines if Vnet creation is required 
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

#EVENTHUB CLUSTER
variable "eventhub_cluster_variables" {
  description = "Map of evenethub cluster"
  type = map(object({
    eventhub_cluster_name                = string
    eventhub_cluster_location            = string
    eventhub_cluster_resource_group_name = string
    eventhub_cluster_sku_name            = string
    eventhub_cluster_tags                = map(string)
  }))
  default = {}
}

variable "eventhub_namespace_variables" {
  description = "eventhub namespace variables"
  type = map(object({
    eventhub_namespace_name                        = string
    eventhub_namespace_location                    = string
    eventhub_namespace_resource_group_name         = string
    eventhub_namespace_tags                        = map(string)
    eventhub_namespace_sku                         = string
    eventhub_namespace_capacity                    = number
    eventhub_namespace_auto_inflate_enabled        = string
    eventhub_namespace_dedicated_cluster_id        = string
    eventhub_namespace_identity                    = string
    eventhub_namespace_maximum_throughput_units    = number
    eventhub_namespace_zone_redundant              = string
    eventhub_cluster_name                          = string
    eventhub_cluster_resource_group_name           = string
    eventhub_namespace_subnet_name                 = string
    eventhub_namespace_subnet_resource_group_name  = string
    eventhub_namespace_subnet_virtual_network_name = string

    eventhub_namespace_identity = list(object({
      eventhub_namespace_identity_type = string
    }))
    eventhub_namespace_network_rulesets = list(object({
      eventhub_namespace_default_action = string
      trusted_service_access_enabled    = bool

    }))
    eventhub_namespace_virtual_network_rule = list(object({
      eventhub_namespace_subnet_id                    = string
      ignore_missing_virtual_network_service_endpoint = string
    }))
    eventhub_namespace_ip_rule = list(object({
      ip_rule_ip_mask = string
      ip_rule_action  = string
    }))

  }))
}

