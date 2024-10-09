# Resource Group
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

#Virtual Network 
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

#Subnets
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

#Load Balancer
load_balancers_variables = {
  "lb1" = {
    load_balancer_edge_zone = null #(Optional) Specifies the Edge Zone within the Azure Region where this Load Balancer should exist. Changing this forces a new Load Balancer to be created.
    load_balancer_frontend_ip_configuration = {
      "config1" = {
        frontend_ip_configuration_gateway_load_balancer_frontend_ip_configuration_id = { #(Optional) The Frontend IP Configuration ID of a Gateway SKU Load Balancer.
          gateway_load_balancer_name                = null                               # gateway load balancer name
          gateway_load_balancer_resource_group_name = null                               # gateway load balancer resource group name
        }
        frontend_ip_configuration_name                          = "ploceusconfig000001" #(Required) Specifies the name of the frontend IP configuration.
        frontend_ip_configuration_private_ip_address            = "10.0.3.4"            # (Optional) Private IP Address to assign to the Load Balancer. The last one and first four IPs in any range are reserved and cannot be manually assigned.
        frontend_ip_configuration_private_ip_address_allocation = "Static"              #(Optional) The allocation method for the Private IP Address used by this Load Balancer. Possible values as Dynamic and Static.
        frontend_ip_configuration_private_ip_address_version    = "IPv4"                #The version of IP that the Private IP Address is. Possible values are IPv4 or IPv6.
        frontend_ip_configuration_public_ip_address_id = {                              #(Optional) The ID of a Public IP Address which should be associated with the Load Balancer.
          public_ip_name                = null                                          # public ip name
          public_ip_resource_group_name = null                                          # public ip resource group name
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
    load_balancer_sku                 = "Basic"           # (Optional) The SKU of the Azure Load Balancer. Accepted values are Basic, Standard and Gateway. Defaults to Basic.
    load_balancer_sku_tier            = "Regional"        # (Optional) sku_tier - (Optional) The SKU tier of this Load Balancer. Possible values are Global and Regional. Defaults to Regional. Changing this forces a new resource to be created.
    load_balancer_tags = {
      "Created_By" = "Ploceus"
      Department   = "CIS"
    }
  }
}

#Load Balancer Probe 
load_balancer_probe_variables = {
  "load_balancer_probe_1" = {
    load_balancer_probe_load_balancer_name                = "ploceuslb000001"      #(Required) Loadbalancer name for fetching the ID of the LoadBalancer in which to create the NAT Rule.
    load_balancer_probe_load_balancer_resource_group_name = "ploceusrg000001"      #(Required) Loadbalancer resource group name for fetching the ID of the LoadBalancer in which to create the NAT Rule.
    load_balancer_probe_name                              = "ploceuslbprobe000001" #(Required) Specifies the name of the Probe.
    load_balancer_probe_port                              = 3389                   #(Required) Port on which the Probe queries the backend endpoint. Possible values range from 1 to 65535, inclusive.
    load_balancer_probe_protocol                          = "Tcp"                  #(Optional) Specifies the protocol of the end point. Possible values are Http, Https or Tcp. If TCP is specified, a received ACK is required for the probe to be successful. If HTTP is specified, a 200 OK response from the specified URI is required for the probe to be successful.
    load_balancer_probe_request_path                      = null                   #(Optional) The URI used for requesting health status from the backend endpoint. Required if protocol is set to Http or Https. Otherwise, it is not allowed.
    load_balancer_probe_interval_in_seconds               = 5                      #(Optional) The interval, in seconds between probes to the backend endpoint for health status. The default value is 15, the minimum value is 5.
    load_balancer_probe_number_of_probes                  = 2                      #(Optional) The number of failed probe attempts after which the backend endpoint is removed from rotation. The default value is 2. NumberOfProbes multiplied by intervalInSeconds value must be greater or equal to 10.Endpoints are returned to rotation when at least one probe is successful.
  }
}
 