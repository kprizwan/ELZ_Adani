#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000001" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location = "eastus2"         #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_managed_by = "ploceus" #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  },
  "resource_group_2" = {
    resource_group_name       = "ploceusrg000002" #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location   = "westus2"         #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = "ploceus"         #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {                       #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#APPLICATION SECURITY GROUP
application_security_group_variables = {
  "asg1" = {
    application_security_group_location            = "westus2"          # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created
    application_security_group_name                = "ploceusasg000001" # (Required) Specifies the name of the Application Security Group. Changing this forces a new resource to be created.
    application_security_group_resource_group_name = "ploceusrg000001"  # (Required) The name of the resource group in which to create the Application Security Group.
    application_security_group_tags = {                                 # (Optional) A mapping of tags to assign to the resource
      Created_By = "Ploceus",
      Department = "CIS"
    }
  },
  "asg2" = {
    application_security_group_location            = "westus2"          # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created
    application_security_group_name                = "ploceusasg000002" # (Required) Specifies the name of the Application Security Group. Changing this forces a new resource to be created.
    application_security_group_resource_group_name = "ploceusrg000002"  # (Required) The name of the resource group in which to create the Application Security Group.
    application_security_group_tags = {                                 # (Optional) A mapping of tags to assign to the resource
      Created_By = "Ploceus",
      Department = "CIS"
    }
  },
  "asg3" = {
    application_security_group_location            = "westus2"          # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created
    application_security_group_name                = "ploceusasg000003" # (Required) Specifies the name of the Application Security Group. Changing this forces a new resource to be created.
    application_security_group_resource_group_name = "ploceusrg000001"  # (Required) The name of the resource group in which to create the Application Security Group.
    application_security_group_tags = {                                 # (Optional) A mapping of tags to assign to the resource
      Created_By = "Ploceus",
      Department = "CIS"
    }
  },
  "asg4" = {
    application_security_group_location            = "westus2"          # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created
    application_security_group_name                = "ploceusasg000004" # (Required) Specifies the name of the Application Security Group. Changing this forces a new resource to be created.
    application_security_group_resource_group_name = "ploceusrg000002"  # (Required) The name of the resource group in which to create the Application Security Group.
    application_security_group_tags = {                                 # (Optional) A mapping of tags to assign to the resource
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#NETWORK SECURITY GROUP
network_security_group_variables = {
  "network_security_group_1" = {
    network_security_group_name                = "ploceusnsg000001" # (Required) Specifies the name of the network security group
    network_security_group_resource_group_name = "ploceusrg000001"  # (Required) The name of the resource group in which to create the network security group
    network_security_group_location            = "westus2"          # (Required) Specifies the supported Azure location where the resource exists
    network_security_group_security_rule = {                        # (Optional) Map of objects representing security rules
      "nsg_rule_01" = {
        security_rule_name                                           = "ploceusnsgrule000001" # (Required) The name of the security rule
        security_rule_application_security_group_resource_group_name = "ploceusrg000001"      # (Optional) The resource group name of the application security group
        security_rule_priority                                       = 100                    # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
        security_rule_direction                                      = "Inbound"              # (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.
        security_rule_access                                         = "Allow"                # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.
        security_rule_protocol                                       = "Tcp"                  # (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
        security_rule_source_port_range                              = "*"                    # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified
        security_rule_source_port_ranges                             = null                   # (Optional) List of source ports or port ranges. This is required if source_port_range is not specified
        security_rule_destination_port_range                         = "*"                    # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
        security_rule_destination_port_ranges                        = null                   # (Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified
        security_rule_source_address_prefix                          = null                   # (Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified.
        security_rule_source_address_prefixes                        = null                   # (Optional) List of source address prefixes. Tags may not be used. This is required if source_address_prefix is not specified.
        security_rule_destination_address_prefix                     = null                   # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if destination_address_prefixes is not specified.
        security_rule_destination_address_prefixes                   = null                   # (Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified.
        security_rule_description                                    = "InboundAllow100"      # (Optional) A description for this rule. Restricted to 140 characters
        security_rule_source_application_security_group_names = {                             # (Optional) A Map of source Application Security Group names
          "asg_rule_source_01" = {
            application_security_group_name                = "ploceusasg000001" # (Optional) Specifies the name of the Application Security Group. Changing this forces a new resource to be created
            application_security_group_resource_group_name = "ploceusrg000001"  # (Optional) The name of the resource group in which to create the Application Security Group

          },
          "asg_rule_source_02" = {
            application_security_group_name                = "ploceusasg000003" # (Optional) Specifies the name of the Application Security Group. Changing this forces a new resource to be created
            application_security_group_resource_group_name = "ploceusrg000001"  # (Required) The name of the resource group in which to create the Application Security Group

          }
        }
        security_rule_destination_application_security_group_names = { # (Optional) A Map of destination Application Security Group names
          "asg_rule_dest_01" = {
            application_security_group_name                = "ploceusasg000002" # (Optional) Specifies the name of the Application Security Group. Changing this forces a new resource to be created
            application_security_group_resource_group_name = "ploceusrg000002"  # (Required) The name of the resource group in which to create the Application Security Group
          },
          "asg_rule_dest_02" = {
            application_security_group_name                = "ploceusasg000004" # (Optional) Specifies the name of the Application Security Group. Changing this forces a new resource to be created
            application_security_group_resource_group_name = "ploceusrg000002"  # (Required) The name of the resource group in which to create the Application Security Group

          }
        }
    } }
    network_security_group_tags = { #(Optional) A mapping of tags which should be assigned to the Network Security Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  },
  #NSG WITH NONE SECURITY RULES
  "network_security_group_2" = {
    network_security_group_name                = "ploceusnsg000002" # (Required) Specifies the name of the network security group
    network_security_group_resource_group_name = "ploceusrg000001"  # (Required) The name of the resource group in which to create the network security group
    network_security_group_location            = "westus2"          # (Required) Specifies the supported Azure location where the resource exists
    network_security_group_security_rule       = null               # (Optional) Specifying NSG with no security rules
    network_security_group_tags = {                                 # (Optional) A mapping of tags which should be assigned to the Network Security Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  },
  #NSG WITH MULTIPLE SECURITY RULES
  "network_security_group_3" = {
    network_security_group_name                = "ploceusnsg000003" # (Required) Specifies the name of the network security group
    network_security_group_resource_group_name = "ploceusrg000001"  # (Required) The name of the resource group in which to create the network security group
    network_security_group_location            = "westus2"          # (Required) Specifies the supported Azure location where the resource exists
    network_security_group_security_rule = {
      "nsg_rule_01" = {
        security_rule_name                                           = "ploceusnsgrule000002" # (Required) The name of the security rule
        security_rule_application_security_group_resource_group_name = null                   # (Optional) The resource group name of the application security group
        security_rule_priority                                       = 100                    # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
        security_rule_direction                                      = "Inbound"              # (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.
        security_rule_access                                         = "Allow"                # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.
        security_rule_protocol                                       = "Tcp"                  # (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
        security_rule_source_port_range                              = "*"                    # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified
        security_rule_source_port_ranges                             = null                   # (Optional) List of source ports or port ranges. This is required if source_port_range is not specified
        security_rule_destination_port_range                         = "*"                    # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
        security_rule_destination_port_ranges                        = null                   # (Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified
        security_rule_source_address_prefix                          = "*"                    # (Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified.
        security_rule_source_address_prefixes                        = null                   # (Optional) List of source address prefixes. Tags may not be used. This is required if source_address_prefix is not specified.
        security_rule_destination_address_prefix                     = "*"                    # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if destination_address_prefixes is not specified.
        security_rule_destination_address_prefixes                   = null                   # (Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified.
        security_rule_description                                    = "InboundAllow100"      # (Optional) A description for this rule. Restricted to 140 characters
        security_rule_source_application_security_group_names        = null                   # (Optional) A List of source Application Security Group names
        security_rule_destination_application_security_group_names   = null                   # (Optional) A List of destination Application Security Group names
      },
      "nsg_rule_02" = {
        security_rule_name                                           = "ploceusnsgrule000003" # (Required) The name of the security rule
        security_rule_application_security_group_resource_group_name = null                   # (Optional) The resource group name of the application security group
        security_rule_priority                                       = 100                    # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
        security_rule_direction                                      = "Outbound"             # (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.
        security_rule_access                                         = "Allow"                # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.
        security_rule_protocol                                       = "Tcp"                  # (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
        security_rule_source_port_range                              = "*"                    # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified
        security_rule_source_port_ranges                             = null                   # (Optional) List of source ports or port ranges. This is required if source_port_range is not specified
        security_rule_destination_port_range                         = "*"                    # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
        security_rule_destination_port_ranges                        = null                   # (Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified
        security_rule_source_address_prefix                          = "*"                    # (Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified.
        security_rule_source_address_prefixes                        = null                   # (Optional) List of source address prefixes. Tags may not be used. This is required if source_address_prefix is not specified.
        security_rule_destination_address_prefix                     = "*"                    # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if destination_address_prefixes is not specified.
        security_rule_destination_address_prefixes                   = null                   # (Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified.
        security_rule_description                                    = "OutboundAllow100"     # (Optional) A description for this rule. Restricted to 140 characters
        security_rule_source_application_security_group_names        = null                   # (Optional) A List of source Application Security Group names
        security_rule_destination_application_security_group_names   = null                   # (Optional) A List of destination Application Security Group names
    } }
    network_security_group_tags = { # (Optional) A mapping of tags which should be assigned to the Network Security Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
