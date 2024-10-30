# RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
  default = {}
}

# VNET VARIABLES
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

# SUBNET VARIABLES
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

# PUBLIC IP VARIABLES
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

# AZURE BASTION HOST VARIABLES
variable "azure_bastion_host_variables" {
  type = map(object({
    bastion_host_virtual_network_name                = string
    bastion_host_virtual_network_resource_group_name = string
    bastion_host_subnet_name                         = string # The Subnet used for the Bastion Host must have the name AzureBastionSubnet and the subnet mask must be at least a /26.
    bastion_host_subnet_resource_group_name          = string
    bastion_host_public_ip_name                      = string
    bastion_host_public_ip_resource_group_name       = string
    bastion_host_name                                = string # Specifies the name of the Bastion Host
    bastion_host_location                            = string # Specifies the supported Azure location where the resource exists.
    bastion_host_resource_group_name                 = string # The name of the resource group in which to create the Bastion Host.
    bastion_host_copy_paste_enabled                  = bool   # is Copy/Paste feature enabled for the Bastion Host. Defaults to true.
    bastion_host_file_copy_enabled                   = bool   # Is File Copy feature enabled for the Bastion Host. Defaults to false.
    bastion_host_sku                                 = string # Accepted values are Basic and Standard. Defaults to Basic.
    bastion_host_ip_connect_enabled                  = bool   # Is IP Connect feature enabled for the Bastion Host. Defaults to false.
    bastion_host_scale_units                         = number # scale_units can only be changed when sku is Standard. scale_units is always 2 when sku is Basic.Possible values are between 2 and 50
    bastion_host_shareable_link_enabled              = bool   # Is Shareable Link feature enabled for the Bastion Host. Defaults to false.
    bastion_host_tunneling_enabled                   = bool   # Is Tunneling feature enabled for the Bastion Host. Defaults to false.
    bastion_host_ip_configuration = object({
      ip_configuration_name = string # The name of the IP configuration.
    })

    bastion_host_tags = map(string)
  }))
}