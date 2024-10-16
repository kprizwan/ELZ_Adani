### Attributes: ###
- network_security_group_name                = string  # (Required) Specifies the name of the network security group
- network_security_group_resource_group_name = string  # (Required) The name of the resource group in which to create the network security group
- network_security_group_location            = string  # (Required) Specifies the supported Azure location where the resource exists
- network_security_group_security_rule       = list(string) List of objects representing security rules
- name                                       = string       # (Required) The name of the security rule
- description                                = string       # (Optional) Note: Restricted to 140 characters
- protocol                                   = string       # Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
- source_port_range                          = string       # (Optional) Note: Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified
- source_port_ranges                         = list(string) #  (Optional) This is required if source_port_range is not    specified.
- destination_port_range                     = string       # (Optional) Note:  Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
- destination_port_ranges                    = list(string) # (Optional) Note: This is required if destination_port_range is not specified.
- source_address_prefix                      = string       # (Optional) Note: CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified
- source_address_prefixes                    = list(string) # (Optional) Note: Tags may not be used. This is required if source_address_prefix is not specified.
- source_application_security_group_ids      = list(string) # (Optional) 
- destination_address_prefix                 = string       # (Optional) Note: CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if destination_address_prefixes is not specified.
- destination_address_prefixes               = list(string) # (Optional) Note: This is required if destination_address_prefix is not specified.
- destination_application_security_group_ids = list(string) # (Optional) 
- access                                     = string       # Possible values are Allow and Deny.
- priority                                   = string       # Note: The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule
- direction                                  = string       # Possible values are Inbound and Outbound.
- network_security_group_tags                = map(string) #(Optional) A mapping of tags which should be assigned to the Network Security Group.

>### Notes: ###
>1. Terraform currently provides both a standalone Network Security Rule resource, and allows for Network Security Rules to be defined in-line within the Network Security Group resource. At this time you cannot use a Network Security Group with in-line Network Security Rules in conjunction with any Network Security Rule resources. Doing so will cause a conflict of rule settings and will overwrite rules.
>2. Since security_rule can be configured both inline and via the separate azurerm_network_security_rule resource, we have to explicitly set it to empty slice ([]) to remove it.
>3. Azure creates the following default rules in each network security group that you create
>    - AllowVNetInBound
>    - AllowAzureLoadBalancerInBound
>    - DenyAllInbound
>    - AllowVnetOutBound
>    - AllowInternetOutBound
>    - DenyAllOutBound
>4. NSG and ASG can be in same and different resource group while applying NSG rule as "Application Security Group" in source and destination field.
