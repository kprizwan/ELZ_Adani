#RESOURCE GROUP VARIABLES
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

}

# LOAD BALANCER PROBE
variable "load_balancer_probe_variables" {
  type = map(object({
    load_balancer_probe_load_balancer_name                = string #(Required) Loadbalancer name for fetching the ID of the LoadBalancer in which to create the NAT Rule.
    load_balancer_probe_load_balancer_resource_group_name = string #(Required) Loadbalancer resource group name for fetching the ID of the LoadBalancer in which to create the NAT Rule.
    load_balancer_probe_name                              = string #(Required) Specifies the name of the Probe.
    load_balancer_probe_port                              = number #(Required) Port on which the Probe queries the backend endpoint. Possible values range from 1 to 65535, inclusive.
    load_balancer_probe_protocol                          = string #(Optional) Specifies the protocol of the end point. Possible values are Http, Https or Tcp. If TCP is specified, a received ACK is required for the probe to be successful. If HTTP is specified, a 200 OK response from the specified URI is required for the probe to be successful.
    load_balancer_probe_request_path                      = string #(Optional) The URI used for requesting health status from the backend endpoint. Required if protocol is set to Http or Https. Otherwise, it is not allowed.
    load_balancer_probe_interval_in_seconds               = number #(Optional) The interval, in seconds between probes to the backend endpoint for health status. The default value is 15, the minimum value is 5.
    load_balancer_probe_number_of_probes                  = number #(Optional) The number of failed probe attempts after which the backend endpoint is removed from rotation. The default value is 2. NumberOfProbes multiplied by intervalInSeconds value must be greater or equal to 10.Endpoints are returned to rotation when at least one probe is successful.
  }))
}
variable "load_balancer_backendpool_variables" {
  type = map(object({
    load_balancer_backendpool_name                      = string #(Required) Specifies the name of the Backend Address Pool.
    load_balancer_name                                  = string #(Required) Load balancer name
    load_balancer_resource_group_name                   = string # Name of the load balancer resource group
    load_balancer_backendpool_tunnel_interface_required = bool   #(Optional) One or more tunnel_interface blocks as defined below.
    load_balancer_backendpool_tunnel_interface_variables = map(object({
      load_balancer_backendpool_tunnel_interface_identifier = string #(Required) The unique identifier of this Gateway Lodbalancer Tunnel Interface.
      load_balancer_backendpool_tunnel_interface_type       = string #(Required) The traffic type of this Gateway Lodbalancer Tunnel Interface. Possible values are Internal and External.
      load_balancer_backendpool_tunnel_interface_protocol   = string #(Required) The protocol used for this Gateway Lodbalancer Tunnel Interface. Possible values are Native and VXLAN.
      load_balancer_backendpool_tunnel_interface_port       = string #(Required) The port number that this Gateway Lodbalancer Tunnel Interface listens to.
    }))
  }))
  description = "Map containing load balancer backend address pools"
  default     = {}
}
#LOAD BALANCER RULES
variable "load_balancer_rule_variables" {
  type = map(object({
    load_balancer_rule_load_balancer_name                = string       #(Required) To fetch the ID of the Load Balancer in which to create the Rule.
    load_balancer_rule_load_balancer_resource_group_name = string       #(Required) To fecth the ID of the Load Balancer in which to create the Rule.
    load_balancer_rule_load_balancer_subscription_id     = string       #Mark as null if load_balancer_rule_probe_name is null
    load_balancer_rule_name                              = string       #(Required) Specifies the name of the LB Rule.
    load_balancer_rule_protocol                          = string       #(Required) The transport protocol for the external endpoint. Possible values are Tcp, Udp or All.
    load_balancer_rule_frontend_port                     = string       #(Required) The port for the external endpoint. Port numbers for each Rule must be unique within the Load Balancer. Possible values range between 0 and 65534, inclusive.
    load_balancer_rule_backend_port                      = string       #(Required) The port used for internal connections on the endpoint. Possible values range between 0 and 65535, inclusive.
    load_balancer_rule_frontend_ip_configuration_name    = string       #(Required) The name of the frontend IP configuration to which the rule is associated.
    load_balancer_rule_backend_pool_names                = list(string) #(Optional) Needed for fetching backend pool ids- A list of reference to a Backend Address Pool over which this Load Balancing Rule operates.
    load_balancer_rule_probe_name                        = string       #Optional, mark as null if not needed
    load_balancer_rule_load_distribution                 = string       #(Optional) Specifies the load balancing distribution type to be used by the Load Balancer. Possible values are: Default – The load balancer is configured to use a 5 tuple hash to map traffic to available servers. SourceIP – The load balancer is configured to use a 2 tuple hash to map traffic to available servers. SourceIPProtocol – The load balancer is configured to use a 3 tuple hash to map traffic to available servers. Also known as Session Persistence, where the options are called None, Client IP and Client IP and Protocol respectively.
    load_balancer_rule_idle_timeout_in_minutes           = number       #(Optional) Specifies the idle timeout in minutes for TCP connections. Valid values are between 4 and 30 minutes. Defaults to 4 minutes.
    load_balancer_rule_enable_floating_ip                = bool         #(Optional) Are the Floating IPs enabled for this Load Balncer Rule? A "floating” IP is reassigned to a secondary server in case the primary server fails. Required to configure a SQL AlwaysOn Availability Group. Defaults to false.
    load_balancer_rule_disable_outbound_snat             = bool         #(Optional) Is snat enabled for this Load Balancer Rule? Default false.
    load_balancer_rule_enable_tcp_reset                  = bool         #(Optional) Is TCP Reset enabled for this Load Balancer Rule? Defaults to false.
  }))
  description = "Map containing load balancer rule and probe parameters"
  default     = {}
}
