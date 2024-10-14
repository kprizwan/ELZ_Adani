#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000001" #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = "westus2"         #(Required) The Azure Region where the Resource Group should exist.
    resource_group_tags = {                     #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  },
  "resource_group_" = {
    resource_group_name     = "ploceusrg000002" #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = "westus2"         #(Required) The Azure Region where the Resource Group should exist.
    resource_group_tags = {                     #(Optional) A mapping of tags which should be assigned to the Resource Group.
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
    } }
    network_security_group_tags = { #(Optional) A mapping of tags which should be assigned to the Network Security Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  },
  "network_security_group_2" = {
    network_security_group_name                = "ploceusnsg000002" # (Required) Specifies the name of the network security group
    network_security_group_resource_group_name = "ploceusrg000001"  # (Required) The name of the resource group in which to create the network security group
    network_security_group_location            = "westus2"          # (Required) Specifies the supported Azure location where the resource exists
    network_security_group_security_rule = {                        # (Optional) Map of objects representing security rules
      "nsg_rule_01" = {
        security_rule_name                                           = "ploceusnsgrule000001" # (Required) The name of the security rule
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
    } }
    network_security_group_tags = { #(Optional) A mapping of tags which should be assigned to the Network Security Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#Virtual Network 
virtual_network_variables = {
  "virtual_network_1" = {
    virtual_network_name                    = "ploceusvnet000001" #(Required) The name of the virtual network.
    virtual_network_location                = "westus2"           #(Required) The location/region where the virtual network is created.
    virtual_network_resource_group_name     = "ploceusrg000002"   #(Required) The name of the resource group in which to create the virtual network.
    virtual_network_address_space           = ["10.0.0.0/16"]     #(Required) The address space that is used the virtual network.
    virtual_network_dns_servers             = null                #(Optional) List of IP addresses of DNS servers.Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it.
    virtual_network_flow_timeout_in_minutes = null                #(Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = null                #(Optional) The BGP community attribute in format <as-number>:<community-value>.The as-number segment is the Microsoft ASN, which is always 12076 for now.
    virtual_network_edge_zone               = null                #(Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_ddos_protection_plan = {                      #(Optional block) provide true for virtual_network_ddos_protection_enable incase ddos_protection needs to be enabled.
      virtual_network_ddos_protection_enable    = false           #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = null            #(Required) Needed for ddos protection plan id.Provide the name of the ddos protection plan if above enable is true
    }

    virtual_network_subnet = null #(Optional) Can be specified multiple times to define multiple subnets

    virtual_network_tags = { #(Optional) A mapping of tags which should be assigned to the virtual network.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#Subnets
subnet_variables = {
  "subnet_1" = {
    subnet_name                                           = "ploceussn000001"                  # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                            = "ploceusrg000002"                  #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                               = ["10.0.1.0/24"]                    #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                           = "ploceusvnet000001"                #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled  = null                               # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled      = null                               # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_enforce_private_link_endpoint_network_policies = null                               #(Optional) Enable or Disable network policies for the private link endpoint on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false.
    subnet_enforce_private_link_service_network_policies  = null                               #(Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false.
    subnet_service_endpoint_policy_ids                    = null                               #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                              = ["Microsoft.AzureActiveDirectory"] #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation = [{
      delegation_name            = "delegation000001"                                                                                                                                                                                                #(Required) A name for this delegation.
      service_delegation_name    = "Microsoft.Sql/managedInstances"                                                                                                                                                                                  # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"] #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }]
  },
  "subnet_2" = {
    subnet_name                                           = "ploceussn000002"                  # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                            = "ploceusrg000002"                  #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                               = ["10.0.2.0/24"]                    #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                           = "ploceusvnet000001"                #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled  = null                               # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled      = null                               # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_enforce_private_link_endpoint_network_policies = null                               #(Optional) Enable or Disable network policies for the private link endpoint on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false.
    subnet_enforce_private_link_service_network_policies  = false                              #(Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false.
    subnet_service_endpoint_policy_ids                    = null                               #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                              = ["Microsoft.AzureActiveDirectory"] #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation = [{
      delegation_name            = "delegation000002"                                                                                                                                       #(Required) A name for this delegation.
      service_delegation_name    = "Microsoft.Databricks/workspaces"                                                                                                                        # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"] #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }]
  },
  "subnet_3" = {
    subnet_name                                           = "ploceussn000003"                  # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                            = "ploceusrg000002"                  #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                               = ["10.0.3.0/24"]                    #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                           = "ploceusvnet000001"                #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled  = null                               # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled      = null                               # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_enforce_private_link_endpoint_network_policies = null                               #(Optional) Enable or Disable network policies for the private link endpoint on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false.
    subnet_enforce_private_link_service_network_policies  = false                              #(Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false.
    subnet_service_endpoint_policy_ids                    = null                               #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                              = ["Microsoft.AzureActiveDirectory"] #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation = [{
      delegation_name            = "delegation000002"                                                                                                                                       #(Required) A name for this delegation.
      service_delegation_name    = "Microsoft.Databricks/workspaces"                                                                                                                        # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"] #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }]
  }
}

#Network Interface
network_interface_variables = {
  "network_interface_1" = {
    network_interface_name                          = "ploceusnic000001" #The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_location                      = "westus2"          #The location where the Network Interface should exist. Changing this forces a new resource to be created.
    network_interface_resource_group_name           = "ploceusrg000001"  #The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.
    network_interface_dns_servers                   = []                 #if provided, it will override the DNS server value defined in vnet module
    network_interface_edge_zone                     = null               #Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created
    network_interface_enable_ip_forwarding          = false              #Enable only if IP Forwarding is required
    network_interface_enable_accelerated_networking = false              #Enable only if accelerated networking is required
    network_interface_internal_dns_label            = null               #The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.
    network_interface_ip_configuration = {
      "ip_configuration_1" = {
        ip_configuration_name                          = "ploceusnicipconfig000001" #A name used for this IP Configuration. Changing this forces a new resource to be created
        ip_configuration_private_ip_address_allocation = "Dynamic"                  #Possible values are Dynamic and Static
        #ip_configuration_private_ip_address            = "10.0.3.11"                #When private_ip_address_allocation is set to Static, The Static IP Address which should be used
        ip_configuration_private_ip_address         = null
        ip_configuration_private_ip_address_version = "IPv4" #The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.
        ip_configuration_subnet = ({
          subnet_virtual_network_name                = "ploceusvnet000001" #When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID
          subnet_name                                = "ploceussn000001"   #When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID
          subnet_virtual_network_resource_group_name = "ploceusrg000002"   #When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID
        })
        ip_configuration_public_ip = ({        #Reference to a Public IP Address to associate with this NIC
          public_ip_name                = null #Reference to a Public IP Address Name to associate with this NIC
          public_ip_resource_group_name = null #Reference to a Public IP Address Name Resource Group Name to associate with this NIC
        })
        ip_configuration_primary = true #Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false.Must be true for the first ip_configuration when multiple are specified
        ip_configuration_load_balancer = ({
          load_balancer_name                = null #Only works with Gateway SKU Load Balancer
          load_balancer_resource_group_name = null #The Load Balancer Resource Group name is required to fetch the Load Balancer ID
        })
      }
    }
    network_interface_tags = { #(Optional) A mapping of tags to assign to the resource.
      "Created_By" = "Ploceus"
      "Department" = "CIS"
    }
  },
  "network_interface_2" = {
    network_interface_name                          = "ploceusnic000002" #The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_location                      = "westus2"          #The location where the Network Interface should exist. Changing this forces a new resource to be created.
    network_interface_resource_group_name           = "ploceusrg000001"  #The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.
    network_interface_dns_servers                   = []                 #if provided, it will override the DNS server value defined in vnet module
    network_interface_edge_zone                     = null               #Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created
    network_interface_enable_ip_forwarding          = false              #Enable only if IP Forwarding is required
    network_interface_enable_accelerated_networking = false              #Enable only if accelerated networking is required
    network_interface_internal_dns_label            = null               #The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.
    network_interface_ip_configuration = {
      "ip_configuration_1" = {
        ip_configuration_name                          = "ploceusnicipconfig000001" #A name used for this IP Configuration. Changing this forces a new resource to be created
        ip_configuration_private_ip_address_allocation = "Dynamic"                  #Possible values are Dynamic and Static
        #ip_configuration_private_ip_address            = "10.0.3.11"                #When private_ip_address_allocation is set to Static, The Static IP Address which should be used
        ip_configuration_private_ip_address         = null
        ip_configuration_private_ip_address_version = "IPv4" #The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.
        ip_configuration_subnet = ({
          subnet_virtual_network_name                = "ploceusvnet000001" #When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID
          subnet_name                                = "ploceussn000002"   #When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID
          subnet_virtual_network_resource_group_name = "ploceusrg000002"   #When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID
        })
        ip_configuration_public_ip = ({        #Reference to a Public IP Address to associate with this NIC
          public_ip_name                = null #Reference to a Public IP Address Name to associate with this NIC
          public_ip_resource_group_name = null #Reference to a Public IP Address Name Resource Group Name to associate with this NIC
        })
        ip_configuration_primary = true #Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false.Must be true for the first ip_configuration when multiple are specified
        ip_configuration_load_balancer = ({
          load_balancer_name                = null #Only works with Gateway SKU Load Balancer
          load_balancer_resource_group_name = null #The Load Balancer Resource Group name is required to fetch the Load Balancer ID
        })
      }
    }
    network_interface_tags = { #(Optional) A mapping of tags to assign to the resource.
      "Created_By" = "Ploceus"
      "Department" = "CIS"
    }
  }
}



network_security_group_association_variables = {
  "network_security_group_association_1" = {
    network_interface_security_group_association = [ # (Optional) The block for security group association with network interface
      {
        network_security_group_association_network_interface_name                     = "ploceusnic000001" # (Required) The name of the network interface
        network_security_group_association_network_security_group_name                = "ploceusnsg000001" # (Required) The name of the network security group name to associate with network interface
        network_security_group_association_network_interface_resource_group_name      = "ploceusrg000001"  # (Required) The resource group name which contains network interface
        network_security_group_association_network_security_group_resource_group_name = "ploceusrg000001"  # (Required) The resource group name which contains security group
      }
    ]
    subnet_security_group_association = null # (Optional) The block for security group association with subnet
  },
  "network_security_group_association_2" = {
    network_interface_security_group_association = null # (Optional) The block for security group association with network interface
    subnet_security_group_association = [
      {
        network_security_group_association_network_security_group_name                = "ploceusnsg000001"  # (Required)  The name of network_security_group_name to assiciate with subnet
        network_security_group_association_network_security_group_resource_group_name = "ploceusrg000001"   # (Required) The resource group name of security group.
        network_security_group_association_subnet_name                                = "ploceussn000001"   # (Required) The name subnet which needs to be associated with network security group
        network_security_group_association_virtual_network_name                       = "ploceusvnet000001" # (Required) The name of the virtual network where subnets are created
        network_security_group_association_virtual_network_resource_group_name        = "ploceusrg000002"   # (Required) The resource group name of the virtual network
      }
    ]
  },
  "network_security_group_association_3" = {
    network_interface_security_group_association = [
      {
        network_security_group_association_network_interface_name                     = "ploceusnic000002" # (Required) The name of the network interface
        network_security_group_association_network_security_group_name                = "ploceusnsg000002" # (Required) The name of the network security group name to associate with network interface
        network_security_group_association_network_interface_resource_group_name      = "ploceusrg000001"  # (Required) The resource group name which contains network interface
        network_security_group_association_network_security_group_resource_group_name = "ploceusrg000001"  # (Required) The resource group name which contains security group
      }
    ],
    subnet_security_group_association = [
      {
        network_security_group_association_network_security_group_name                = "ploceusnsg000002"  # (Required)  The name of network_security_group_name to assiciate with subnet
        network_security_group_association_network_security_group_resource_group_name = "ploceusrg000001"   # (Required) The resource group name of security group.
        network_security_group_association_subnet_name                                = "ploceussn000002"   # (Required) The name subnet which needs to be associated with network security group
        network_security_group_association_virtual_network_name                       = "ploceusvnet000001" # (Required) The name of the virtual network where subnets are created
        network_security_group_association_virtual_network_resource_group_name        = "ploceusrg000002"   # (Required) The resource group name of the virtual network
      }
    ]
  }
}
