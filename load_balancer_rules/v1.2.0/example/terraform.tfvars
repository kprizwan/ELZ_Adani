# RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000001" #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = "westus2"         #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#VIRTUAL NETWORK
virtual_network_variables = {
  "virtual_network_1" = {
    virtual_network_name                    = "ploceusvnet000001"         #(Required) The name of the virtual network.
    virtual_network_location                = "westus2"                   #(Required) The location/region where the virtual network is created.
    virtual_network_resource_group_name     = "ploceusrg000001"           #(Required) The name of the resource group in which to create the virtual network.
    virtual_network_address_space           = ["10.0.0.0/16"]             #(Required) The address space that is used the virtual network.
    virtual_network_dns_servers             = null                        #(Optional) List of IP addresses of DNS servers.Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it.
    virtual_network_flow_timeout_in_minutes = null                        #(Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = null                        #(Optional) The BGP community attribute in format <as-number>:<community-value>.The as-number segment is the Microsoft ASN, which is always 12076 for now.
    virtual_network_edge_zone               = null                        #(Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_ddos_protection_plan = {                              #(Optional block) provide true for virtual_network_ddos_protection_enable incase ddos_protection needs to be enabled.
      virtual_network_ddos_protection_enable    = false                   #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = "ploceusddosplan000001" #(Required) Needed for ddos protection plan id.Provide the name of the ddos protection plan if above enable is true
    }

    virtual_network_subnet = null
    virtual_network_tags = { #(Optional) A mapping of tags which should be assigned to the virtual network.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
#SUBNET
subnet_variables = {
  "subnet_1" = {
    subnet_name                                           = "ploceussubnet000001"              # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                            = "ploceusrg000001"                  #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                               = ["10.0.3.0/24"]                    #(Required) The address prefixes to use for the subnet.
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
  }
}

# LOAD BALANCER
load_balancers_variables = {
  "lb1" = {
    load_balancer_edge_zone = null #(Optional) Specifies the Edge Zone within the Azure Region where this Load Balancer should exist. Changing this forces a new Load Balancer to be created.
    load_balancer_frontend_ip_configuration = {
      "config1" = {
        frontend_ip_configuration_gateway_load_balancer_frontend_ip_configuration_id = { #(Optional) The Frontend IP Configuration ID of a Gateway SKU Load Balancer.
          gateway_load_balancer_name                = null                               # gateway load balancer name
          gateway_load_balancer_resource_group_name = null                               # gateway load balancer resource group name
        }
        frontend_ip_configuration_name                          = "ploceuslbfe000001" #(Required) Specifies the name of the frontend IP configuration.
        frontend_ip_configuration_private_ip_address            = "10.0.3.7"          # (Optional) Private IP Address to assign to the Load Balancer. The last one and first four IPs in any range are reserved and cannot be manually assigned.
        frontend_ip_configuration_private_ip_address_allocation = "Static"            #(Optional) The allocation method for the Private IP Address used by this Load Balancer. Possible values as Dynamic and Static.
        frontend_ip_configuration_private_ip_address_version    = "IPv4"              #The version of IP that the Private IP Address is. Possible values are IPv4 or IPv6.
        frontend_ip_configuration_public_ip_address_id = {                            #(Optional) The ID of a Public IP Address which should be associated with the Load Balancer.
          public_ip_name                = null                                        # public ip name
          public_ip_resource_group_name = null                                        # public ip resource group name
        }
        frontend_ip_configuration_public_ip_prefix_id = { #(Optional) The ID of a Public IP Prefix which should be associated with the Load Balancer. Public IP Prefix can only be used with outbound rules.
          public_ip_prefix_name                = null     # public ip prefix name
          public_ip_prefix_resource_group_name = null     # public ip prefix resource group name
        }
        frontend_ip_configuration_subnet = {
          subnet_name                    = "ploceussubnet000001" # Subnet name
          subnet_virtual_network_name    = "ploceusvnet000001"   # virtual network name where subnet resides.
          virtual_network_resource_group = "ploceusrg000001"     # Resource group name where the virtual network resides.
        }
        frontend_ip_configuration_zones = null #(Optional) Specifies a list of Availability Zones in which the IP Address for this Load Balancer should be located. Changing this forces a new Load Balancer to be created.
      }
    }
    load_balancer_location            = "westus2"         # (Required) Specifies the supported Azure Region where the Load Balancer should be created.
    load_balancer_name                = "ploceuslb000001" # (Required) Specifies the name of the Load Balancer.
    load_balancer_resource_group_name = "ploceusrg000001" # (Required) The name of the Resource Group in which to create the Load Balancer.
    load_balancer_sku                 = "Gateway"         # (Optional) The SKU of the Azure Load Balancer. Accepted values are Basic, Standard and Gateway. Defaults to Basic.
    load_balancer_sku_tier            = "Regional"        # (Optional) sku_tier - (Optional) The SKU tier of this Load Balancer. Possible values are Global and Regional. Defaults to Regional. Changing this forces a new resource to be created.
    load_balancer_tags = {
      "Created_By" = "Ploceus"
      Department   = "CIS"
    }
  },
  "lb2" = {
    load_balancer_edge_zone = null #(Optional) Specifies the Edge Zone within the Azure Region where this Load Balancer should exist. Changing this forces a new Load Balancer to be created.
    load_balancer_frontend_ip_configuration = {
      "config1" = {
        frontend_ip_configuration_gateway_load_balancer_frontend_ip_configuration_id = { #(Optional) The Frontend IP Configuration ID of a Gateway SKU Load Balancer.
          gateway_load_balancer_name                = null                               # gateway load balancer name
          gateway_load_balancer_resource_group_name = null                               # gateway load balancer resource group name
        }
        frontend_ip_configuration_name                          = "ploceuslbfe000002" #(Required) Specifies the name of the frontend IP configuration.
        frontend_ip_configuration_private_ip_address            = null                # (Optional) Private IP Address to assign to the Load Balancer. The last one and first four IPs in any range are reserved and cannot be manually assigned.
        frontend_ip_configuration_private_ip_address_allocation = "Dynamic"           #(Optional) The allocation method for the Private IP Address used by this Load Balancer. Possible values as Dynamic and Static.
        frontend_ip_configuration_private_ip_address_version    = "IPv4"              #The version of IP that the Private IP Address is. Possible values are IPv4 or IPv6.
        frontend_ip_configuration_public_ip_address_id = {                            #(Optional) The ID of a Public IP Address which should be associated with the Load Balancer.
          public_ip_name                = null                                        # public ip name
          public_ip_resource_group_name = null                                        # public ip resource group name
        }
        frontend_ip_configuration_public_ip_prefix_id = { #(Optional) The ID of a Public IP Prefix which should be associated with the Load Balancer. Public IP Prefix can only be used with outbound rules.
          public_ip_prefix_name                = null     # public ip prefix name
          public_ip_prefix_resource_group_name = null     # public ip prefix resource group name
        }
        frontend_ip_configuration_subnet = {
          subnet_name                    = "ploceussubnet000001" # Subnet name
          subnet_virtual_network_name    = "ploceusvnet000001"   # virtual network name where subnet resides.
          virtual_network_resource_group = "ploceusrg000001"     # Resource group name where the virtual network resides.
        }
        frontend_ip_configuration_zones = null #(Optional) Specifies a list of Availability Zones in which the IP Address for this Load Balancer should be located. Changing this forces a new Load Balancer to be created.
      }
    }
    load_balancer_location            = "westus2"         # (Required) Specifies the supported Azure Region where the Load Balancer should be created.
    load_balancer_name                = "ploceuslb000002" # (Required) Specifies the name of the Load Balancer.
    load_balancer_resource_group_name = "ploceusrg000001" # (Required) The name of the Resource Group in which to create the Load Balancer.
    load_balancer_sku                 = "Gateway"         # (Optional) The SKU of the Azure Load Balancer. Accepted values are Basic, Standard and Gateway. Defaults to Basic.
    load_balancer_sku_tier            = "Regional"        # (Optional) sku_tier - (Optional) The SKU tier of this Load Balancer. Possible values are Global and Regional. Defaults to Regional. Changing this forces a new resource to be created.
    load_balancer_tags = {
      "Created_By" = "Ploceus"
      Department   = "CIS"
    }
  }
}

# LOAD BALANCER PROBE
load_balancer_probe_variables = {
  "load_balancer_probe_1" = {
    load_balancer_probe_load_balancer_name                = "ploceuslb000002"      #(Required) Loadbalancer name for fetching the ID of the LoadBalancer in which to create the NAT Rule.
    load_balancer_probe_load_balancer_resource_group_name = "ploceusrg000001"      #(Required) Loadbalancer resource group name for fetching the ID of the LoadBalancer in which to create the NAT Rule.
    load_balancer_probe_name                              = "ploceuslbprobe000001" #(Required) Specifies the name of the Probe.
    load_balancer_probe_port                              = 3389                   #(Required) Port on which the Probe queries the backend endpoint. Possible values range from 1 to 65535, inclusive.
    load_balancer_probe_protocol                          = "Tcp"                  #(Optional) Specifies the protocol of the end point. Possible values are Http, Https or Tcp. If TCP is specified, a received ACK is required for the probe to be successful. If HTTP is specified, a 200 OK response from the specified URI is required for the probe to be successful.
    load_balancer_probe_request_path                      = null                   #(Optional) The URI used for requesting health status from the backend endpoint. Required if protocol is set to Http or Https. Otherwise, it is not allowed.
    load_balancer_probe_interval_in_seconds               = 5                      #(Optional) The interval, in seconds between probes to the backend endpoint for health status. The default value is 15, the minimum value is 5.
    load_balancer_probe_number_of_probes                  = 2                      #(Optional) The number of failed probe attempts after which the backend endpoint is removed from rotation. The default value is 2. NumberOfProbes multiplied by intervalInSeconds value must be greater or equal to 10.Endpoints are returned to rotation when at least one probe is successful.
  }
}

#LOAD BALANCER BACKEND POOL
load_balancer_backendpool_variables = {
  backendpool_1 = {
    load_balancer_backendpool_name                      = "ploceuslbbp000001" #(Required) Specifies the name of the Backend Address Pool.
    load_balancer_name                                  = "ploceuslb000001"   #(Required) Load balancer name
    load_balancer_resource_group_name                   = "ploceusrg000001"   # Name of the load balancer resource group
    load_balancer_backendpool_tunnel_interface_required = true                #(Optional) One or more tunnel_interface blocks as defined below.
    load_balancer_backendpool_tunnel_interface_variables = {
      "tunnel_1" = {
        load_balancer_backendpool_tunnel_interface_identifier = 900        #(Required) The unique identifier of this Gateway Lodbalancer Tunnel Interface.
        load_balancer_backendpool_tunnel_interface_type       = "External" #(Required) The traffic type of this Gateway Lodbalancer Tunnel Interface. Possible values are Internal and External.
        load_balancer_backendpool_tunnel_interface_protocol   = "VXLAN"    #(Required) The protocol used for this Gateway Lodbalancer Tunnel Interface. Possible values are Native and VXLAN.
        load_balancer_backendpool_tunnel_interface_port       = 15000      #(Required) The port number that this Gateway Lodbalancer Tunnel Interface listens to.
      }
      "tunnel_2" = {
        load_balancer_backendpool_tunnel_interface_identifier = 901        #(Required) The unique identifier of this Gateway Lodbalancer Tunnel Interface.
        load_balancer_backendpool_tunnel_interface_type       = "Internal" #(Required) The traffic type of this Gateway Lodbalancer Tunnel Interface. Possible values are Internal and External.
        load_balancer_backendpool_tunnel_interface_protocol   = "VXLAN"    #(Required) The protocol used for this Gateway Lodbalancer Tunnel Interface. Possible values are Native and VXLAN.
        load_balancer_backendpool_tunnel_interface_port       = 15001      #(Required) The port number that this Gateway Lodbalancer Tunnel Interface listens to.
      }
    }
  }
  backendpool_2 = {
    load_balancer_backendpool_name                      = "ploceuslbbp000002" #(Required) Specifies the name of the Backend Address Pool.
    load_balancer_name                                  = "ploceuslb000002"   #(Required) Load balancer name
    load_balancer_resource_group_name                   = "ploceusrg000001"   # Name of the load balancer resource group
    load_balancer_backendpool_tunnel_interface_required = true                #(Optional) One or more tunnel_interface blocks as defined below.
    load_balancer_backendpool_tunnel_interface_variables = {
      "tunnel_1" = {
        load_balancer_backendpool_tunnel_interface_identifier = 902        #(Required) The unique identifier of this Gateway Lodbalancer Tunnel Interface.
        load_balancer_backendpool_tunnel_interface_type       = "External" #(Required) The traffic type of this Gateway Lodbalancer Tunnel Interface. Possible values are Internal and External.
        load_balancer_backendpool_tunnel_interface_protocol   = "VXLAN"    #(Required) The protocol used for this Gateway Lodbalancer Tunnel Interface. Possible values are Native and VXLAN.
        load_balancer_backendpool_tunnel_interface_port       = 15001      #(Required) The port number that this Gateway Lodbalancer Tunnel Interface listens to.
      }
      "tunnel_2" = {
        load_balancer_backendpool_tunnel_interface_identifier = 903        #(Required) The unique identifier of this Gateway Lodbalancer Tunnel Interface.
        load_balancer_backendpool_tunnel_interface_type       = "Internal" #(Required) The traffic type of this Gateway Lodbalancer Tunnel Interface. Possible values are Internal and External.
        load_balancer_backendpool_tunnel_interface_protocol   = "VXLAN"    #(Required) The protocol used for this Gateway Lodbalancer Tunnel Interface. Possible values are Native and VXLAN.
        load_balancer_backendpool_tunnel_interface_port       = 15002      #(Required) The port number that this Gateway Lodbalancer Tunnel Interface listens to.
      }
    }
  }
}

#LOAD BALANCER RULES
load_balancer_rule_variables = {
  loadbalancerrules1 = {
    load_balancer_rule_load_balancer_name                = "ploceuslb000001"     #(Required) To fetch the ID of the Load Balancer in which to create the Rule.
    load_balancer_rule_load_balancer_resource_group_name = "ploceusrg000001"     #(Required) To fecth the ID of the Load Balancer in which to create the Rule.
    load_balancer_rule_load_balancer_subscription_id     = null                  #Mark as null if load_balancer_rule_probe_name is null
    load_balancer_rule_name                              = "ploceuslbrule000001" #(Required) Specifies the name of the LB Rule.
    load_balancer_rule_protocol                          = "All"                 #(Required) The transport protocol for the external endpoint. Possible values are Tcp, Udp or All.
    load_balancer_rule_frontend_port                     = "0"                   #(Required) The port for the external endpoint. Port numbers for each Rule must be unique within the Load Balancer. Possible values range between 0 and 65534, inclusive.
    load_balancer_rule_backend_port                      = "0"                   #(Required) The port used for internal connections on the endpoint. Possible values range between 0 and 65535, inclusive.
    load_balancer_rule_frontend_ip_configuration_name    = "ploceuslbfe000001"   #(Required) The name of the frontend IP configuration to which the rule is associated.
    load_balancer_rule_backend_pool_names                = ["ploceuslbbp000001"] #(Optional) Needed for fetching backend pool ids- A list of reference to a Backend Address Pool over which this Load Balancing Rule operates.
    load_balancer_rule_probe_name                        = null                  #Optional, mark as null if not needed
    load_balancer_rule_load_distribution                 = "SourceIPProtocol"    #(Optional) Specifies the load balancing distribution type to be used by the Load Balancer. Possible values are: Default – The load balancer is configured to use a 5 tuple hash to map traffic to available servers. SourceIP – The load balancer is configured to use a 2 tuple hash to map traffic to available servers. SourceIPProtocol – The load balancer is configured to use a 3 tuple hash to map traffic to available servers. Also known as Session Persistence, where the options are called None, Client IP and Client IP and Protocol respectively.
    load_balancer_rule_idle_timeout_in_minutes           = 4                     #(Optional) Specifies the idle timeout in minutes for TCP connections. Valid values are between 4 and 30 minutes. Defaults to 4 minutes.
    load_balancer_rule_enable_floating_ip                = false                 #(Optional) Are the Floating IPs enabled for this Load Balncer Rule? A "floating” IP is reassigned to a secondary server in case the primary server fails. Required to configure a SQL AlwaysOn Availability Group. Defaults to false.
    load_balancer_rule_disable_outbound_snat             = false                 #(Optional) Is snat enabled for this Load Balancer Rule? Default false.
    load_balancer_rule_enable_tcp_reset                  = false                 #(Optional) Is TCP Reset enabled for this Load Balancer Rule? Defaults to false.
  }
  loadbalancerrules2 = {
    load_balancer_rule_load_balancer_name                = "ploceuslb000002"        #(Required) To fetch the ID of the Load Balancer in which to create the Rule.
    load_balancer_rule_load_balancer_resource_group_name = "ploceusrg000001"        #(Required) To fecth the ID of the Load Balancer in which to create the Rule.
    load_balancer_rule_load_balancer_subscription_id     = "xxxxxxxxxxxxxxxxxxxxxx" #Provide the subscription id or mark as null if load_balancer_rule_probe_name is null
    load_balancer_rule_name                              = "ploceuslbrule000002"    #(Required) Specifies the name of the LB Rule.
    load_balancer_rule_protocol                          = "All"                    #(Required) The transport protocol for the external endpoint. Possible values are Tcp, Udp or All.
    load_balancer_rule_frontend_port                     = "0"                      #(Required) The port for the external endpoint. Port numbers for each Rule must be unique within the Load Balancer. Possible values range between 0 and 65534, inclusive.
    load_balancer_rule_backend_port                      = "0"                      #(Required) The port used for internal connections on the endpoint. Possible values range between 0 and 65535, inclusive.
    load_balancer_rule_frontend_ip_configuration_name    = "ploceuslbfe000002"      #(Required) The name of the frontend IP configuration to which the rule is associated.
    load_balancer_rule_backend_pool_names                = ["ploceuslbbp000002"]    #(Optional) Needed for fetching backend pool ids- A list of reference to a Backend Address Pool over which this Load Balancing Rule operates.
    load_balancer_rule_probe_name                        = "ploceuslbprobe000001"   #Optional, mark as null if not needed
    load_balancer_rule_load_distribution                 = "SourceIPProtocol"       #(Optional) Specifies the load balancing distribution type to be used by the Load Balancer. Possible values are: Default – The load balancer is configured to use a 5 tuple hash to map traffic to available servers. SourceIP – The load balancer is configured to use a 2 tuple hash to map traffic to available servers. SourceIPProtocol – The load balancer is configured to use a 3 tuple hash to map traffic to available servers. Also known as Session Persistence, where the options are called None, Client IP and Client IP and Protocol respectively.
    load_balancer_rule_idle_timeout_in_minutes           = 4                        #(Optional) Specifies the idle timeout in minutes for TCP connections. Valid values are between 4 and 30 minutes. Defaults to 4 minutes.
    load_balancer_rule_enable_floating_ip                = false                    #(Optional) Are the Floating IPs enabled for this Load Balncer Rule? A "floating” IP is reassigned to a secondary server in case the primary server fails. Required to configure a SQL AlwaysOn Availability Group. Defaults to false.
    load_balancer_rule_disable_outbound_snat             = false                    #(Optional) Is snat enabled for this Load Balancer Rule? Default false.
    load_balancer_rule_enable_tcp_reset                  = false                    #(Optional) Is TCP Reset enabled for this Load Balancer Rule? Defaults to false.
  }
}