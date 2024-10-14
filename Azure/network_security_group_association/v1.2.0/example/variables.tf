#RESORCE GROUP VARIABLES
variable "resource_group_variables" {
  type = map(object({
    resource_group_name     = string      #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_tags     = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups"
  default = {
  }
}
# NETWORK SECURITY GROUP VARIABLES
variable "network_security_group_variables" {
  type = map(object({
    network_security_group_name                = string                           # (Required) Specifies the name of the network security group
    network_security_group_resource_group_name = string                           # (Required) The name of the resource group in which to create the network security group
    network_security_group_location            = string                           # (Required) Specifies the supported Azure location where the resource exists
    network_security_group_security_rule = map(object({                           # (Optional) List of objects representing security rules
      security_rule_name                                           = string       # (Required) The name of the security rule
      security_rule_application_security_group_resource_group_name = string       # (Optional) The resource group name of the application security group
      security_rule_description                                    = string       # (Optional) A description for this rule. Restricted to 140 characters 
      security_rule_protocol                                       = string       # (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
      security_rule_source_port_range                              = string       # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified.
      security_rule_source_port_ranges                             = list(string) # (Optional) List of source ports or port ranges. This is required if source_port_range is not specified
      security_rule_destination_port_range                         = string       # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
      security_rule_destination_port_ranges                        = list(string) # (Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified.
      security_rule_source_address_prefix                          = string       # (Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified
      security_rule_source_address_prefixes                        = list(string) # (Optional) Tags may not be used. This is required if source_address_prefix is not specified.
      security_rule_source_application_security_group_names = map(object({
        application_security_group_name                = string
        application_security_group_resource_group_name = string
      }))                                                       # (Optional) A list of source application security group ids
      security_rule_destination_address_prefix   = string       # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if destination_address_prefixes is not specified.
      security_rule_destination_address_prefixes = list(string) # (Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified
      security_rule_destination_application_security_group_names = map(object({
        application_security_group_name                = string
        application_security_group_resource_group_name = string
      }))                              # (Optional) A list of destination application security group ids
      security_rule_access    = string # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny
      security_rule_priority  = string # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule
      security_rule_direction = string # (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound
    }))
    network_security_group_tags = map(string) #(Optional) A mapping of tags which should be assigned to the Network Security Group.
  }))
  description = "Map of object for network security group details"
  default     = {}
}

#VNET variable   #Uncomment the below lines if Vnet creation is required 
#VNET variable
variable "virtual_network_variables" {
  description = "Map of vnet objects. name, vnet_address_space, and dns_server supported"
  type = map(object({
    virtual_network_name                    = string       #(Required) the name of the virtual network. Changing this forces a new resource to be created.
    virtual_network_location                = string       #(Required) the location/region where the virtual network is created. Changing this forces a new resource to be created.
    virtual_network_resource_group_name     = string       #(Required) the name of the resource group in which to create the virtual network.
    virtual_network_address_space           = list(string) #(Required) the address space that is used the virtual network. You can supply more than one address space.
    virtual_network_dns_servers             = list(string) #(Optional) list of IP addresses of DNS servers.Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it.
    virtual_network_flow_timeout_in_minutes = number       #(Optional) the flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = string       #(Optional) the BGP community attribute in format <as-number>:<community-value>.
    virtual_network_ddos_protection_plan = object({        #(Optional) block for ddos protection
      virtual_network_ddos_protection_enable    = bool     #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = string   #(Required) for the ID of DDoS Protection Plan.
    })
    virtual_network_edge_zone = string                                           #(Optional) specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_subnet = list(object({                                       #(Optional) for the subnet block config. Set to null if not required
      virtual_network_subnet_name                                       = string #(Required) the subnet name to attach to vnet
      virtual_network_subnet_address_prefix                             = string #(Required) the address prefix to use for the subnet.
      virtual_network_subnet_network_security_group_name                = string #(Optional) the Network Security Group Name to associate with the subnet.
      virtual_network_subnet_network_security_group_resource_group_name = string #(Optional) the Network Security Group Resource Group to associate with the subnet.
    }))
    virtual_network_tags = map(string) #(Optional)a mapping of tags to assign to the resource.
  }))
  default = {}
}


#Subnet Variables
variable "subnet_variables" {
  type = map(object({
    subnet_name                                           = string       # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                            = string       #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_virtual_network_name                           = string       #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                               = list(string) #(Required) The address prefixes to use for the subnet.
    subnet_private_link_service_network_policies_enabled  = bool         # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled      = bool         # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_service_endpoints                              = list(string) #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    subnet_enforce_private_link_endpoint_network_policies = bool         #(Optional) Enable or Disable network policies for the private link endpoint on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false.
    subnet_enforce_private_link_service_network_policies  = bool         #(Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false.
    subnet_service_endpoint_policy_ids                    = list(string) #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    delegation = list(object({
      delegation_name            = string       #(Required) A name for this delegation.
      service_delegation_name    = string       # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = list(string) #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }))
  }))
  default = {}
}

#Network Interface variable
variable "network_interface_variables" {
  description = "Map of Network interface"
  type = map(object({
    network_interface_name                          = string       #(Required) The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_location                      = string       #(Required) The location where the Network Interface should exist. Changing this forces a new resource to be created.
    network_interface_resource_group_name           = string       #(Required) The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.
    network_interface_dns_servers                   = list(string) #(Optional) A list of IP Addresses defining the DNS Servers which should be used for this Network Interface. 
    network_interface_edge_zone                     = string       #(Optional) Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created.
    network_interface_enable_ip_forwarding          = bool         #Optional)  Should IP Forwarding be enabled? Defaults to false
    network_interface_enable_accelerated_networking = bool         #(Optional) Should Accelerated Networking be enabled? Defaults to false
    network_interface_internal_dns_label            = string       #(Optional) The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.
    network_interface_ip_configuration = map(object({              #(Required) One or more ip_configuration blocks
      ip_configuration_name                          = string      #(Required) A name used for this IP Configuration. Changing this forces a new resource to be created.
      ip_configuration_private_ip_address_allocation = string      #(Required) The allocation method used for the Private IP Address. Possible values are Dynamic and Static.
      ip_configuration_private_ip_address            = string      #(Optional) When private_ip_address_allocation is set to Static, The Static IP Address which should be used
      ip_configuration_private_ip_address_version    = string      #(Optional) The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.
      ip_configuration_subnet = object({                           #(Required) When private_ip_address_version is set to IPv4,The ID of the Subnet where this Network Interface should be located in.
        subnet_virtual_network_name                = string        #(Required) When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID.
        subnet_name                                = string        #(Required) When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID.
        subnet_virtual_network_resource_group_name = string        #(Required) When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID.
      })
      ip_configuration_public_ip = object({    #(Optional) Reference to a Public IP Address to associate with this NIC
        public_ip_name                = string #(Optional) Reference to a Public IP Address Name to associate with this NIC
        public_ip_resource_group_name = string #(Optional) Reference to a Public IP Address Name Resource Group Name to associate with this NIC
      })
      ip_configuration_primary = bool              #(Optional) Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false
      ip_configuration_load_balancer = object({    #(Optional) The Frontend IP Configuration ID of a Gateway SKU Load Balancer.
        load_balancer_name                = string #(Optional) The Load Balancer name is required to fetch the Load Balancer ID.
        load_balancer_resource_group_name = string #(Optional) The Load Balancer Resource Group name is required to fetch the Load Balancer ID
      })
    }))
    network_interface_tags = map(string) #(Optional) A mapping of tags to assign to the resource.
  }))
  default = {}
}

# Network security group association variable
variable "network_security_group_association_variables" {
  type = map(object({
    network_interface_security_group_association = list(object({                             # (Optional) The block for security group association with network interface
      network_security_group_association_network_interface_name                     = string # (Required) The name of the network interface
      network_security_group_association_network_security_group_name                = string # (Required) The name of the network security group name to associate with network interface
      network_security_group_association_network_interface_resource_group_name      = string # (Required) The resource group name which contains network interface
      network_security_group_association_network_security_group_resource_group_name = string # (Required) The resource group name which contains security group
    }))
    subnet_security_group_association = list(object({                                        # (Optional) The block for security group association with subnet
      network_security_group_association_virtual_network_name                       = string # (Required) The name of the virtual network where subnets are created
      network_security_group_association_subnet_name                                = string # (Required) The name subnet which needs to be associated with network security group
      network_security_group_association_network_security_group_name                = string # (Required)  The name of network_security_group_name to assiciate with subnet
      network_security_group_association_virtual_network_resource_group_name        = string # (Required) The resource group name of the virtual network
      network_security_group_association_network_security_group_resource_group_name = string # (Required) The resource group name of security group.
    }))
  }))
  description = "Map of object network security group association variables"
  default     = {}
}
