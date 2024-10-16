### Attributes: ###

- public_ip_location                                 = string       # (Required) Specifies the supported Azure location where the Public IP should exist. 
- public_ip_ip_version                               = string       # (Optional) The IP Version to use, IPv6 or IPv4.
- public_ip_allocation_method                        = string       # (Required) Defines the allocation method for this IP address. Possible values are Static or Dynamic.
- public_ip_sku                                      = string       # (Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic.
- public_ip_sku_tier                                 = string       # (Optional) The SKU Tier that should be used for the Public IP. Possible values are Regional and Global. Defaults to Regional.
- public_ip_zones                                    = list(string) # (Optional) A collection containing the availability zone to allocate the -Public IP in.
- public_ip_edge_zone                                = string       # (Optional) Specifies the Edge Zone within the Azure Region where this Public IP should exist. 
- public_ip_domain_name_label                        = string       # (Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system.
- public_ip_idle_timeout_in_minutes                  = string       # (Optional) Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes.
- public_ip_reverse_fqdn                             = string       # (Optional) A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN.
- public_ip_prefix_id                                = string       #  (Optional) If specified then public IP address allocated will be provided from the public IP prefix resource.
- public_ip_ip_tags                                  = map(string)  # (Optional) A mapping of IP tags to assign to the public IP.
- public_ip_is_ddos_protection_plan_enabled          = bool         # (Required) True if ddos_protection_plan enabled, else false
- public_ip_ddos_protection_plan_name                = string       # (Optional) The Name of DDoS protection plan associated with the public IP.
- public_ip_ddos_protection_plan_resource_group_name = string       # (Optional) The Resource group name of DDoS protection plan associated with the public IP.
- public_ip_ddos_protection_mode                     = string       #  (Optional) The DDoS protection mode of the public IP. Possible values are Disabled, Enabled, and VirtualNetworkInherited. Defaults to VirtualNetworkInherited.
- public_ip_tags                                     = map(string)  # (Optional) Public IP tags


>### Notes: ###
> 1. Dynamic Public IP Addresses aren't allocated until they're assigned to a resource (such as a Virtual Machine or a Load Balancer) by design within Azure. See ip_address argument.
> 2. Availability Zones are only supported with a Standard SKU and in select regions at this time. Standard SKU Public IP Addresses that do not specify a zone are not zone-redundant by default.
> 3. ddos_protection_plan_id can only be set when ddos_protection_mode is Enabled.
> 4. IP Tag RoutingPreference requires multiple zones and Standard SKU to be set.
> 5. Only static IP address allocation is supported for IPv6.
> 6. Public IP Standard SKUs require allocation_method to be set to Static.
> 7. When sku_tier is set to Global, sku must be set to Standard.
> 8. public_ip_is_ddos_protection_plan_enabled is set to True if ddos_protection_plan required 
> 9. PUBLIC IP is currently used in Application Gateway, Linux machines and Windows machines.
> 10. Any changes to the module will result in other modules to stop working.