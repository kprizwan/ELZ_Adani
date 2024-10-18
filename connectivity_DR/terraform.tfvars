# Connectivity Subscription 

#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "sd-plz-connectivity-dr-rg-01" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location = "South India"             #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_managed_by = null #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DR",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}

#VIRTUAL NETWORK 
virtual_network_variables = {
  "virtual_network_1" = {
    virtual_network_name                    = "sd-plz-dr-Connectivity-Hub-VNET"                                                                                                                                                                                                         #(Required) The name of the virtual network.
    virtual_network_location                = "South India"                                                                                                                                                                                                                        #(Required) The location/region where the virtual network is created.
    virtual_network_resource_group_name     = "sd-plz-connectivity-dr-rg-01"                                                                                                                                                                                                            #(Required) The name of the resource group in which to create the virtual network.
    virtual_network_address_space           = ["10.249.6.0/24", "10.249.7.0/24", "10.249.8.0/24", "10.249.9.0/24", "10.249.10.0/24", "10.249.11.0/24", "10.249.12.0/24", "10.249.13.0/24", "10.249.14.0/24", "10.249.15.0/24", "10.249.16.0/24", "10.249.17.0/24"] #(Required) The address space that is used the virtual network.
    virtual_network_dns_servers             = null                                                                                                                                                                                                                                   #(Optional) List of IP addresses of DNS servers.Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it.
    virtual_network_flow_timeout_in_minutes = null                                                                                                                                                                                                                                   #(Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = null                                                                                                                                                                                                                                   #(Optional) The BGP community attribute in format <as-number>:<community-value>.The as-number segment is the Microsoft ASN, which is always 12076 for now.
    virtual_network_edge_zone               = null                                                                                                                                                                                                                                   #(Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_ddos_protection_plan = {                                                                                                                                                                                                                                         #(Optional block) provide true for virtual_network_ddos_protection_enable incase ddos_protection needs to be enabled.
      virtual_network_ddos_protection_enable    = false                                                                                                                                                                                                                              #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = null                                                                                                                                                                                                                               #(Required) Needed for ddos protection plan id.Provide the name of the ddos protection plan if above enable is true
    }
    virtual_network_encryption = [
      {
        virtual_network_encryption_enforcement = "AllowUnencrypted"
      }
    ]
    virtual_network_subnet = null #(Optional) Can be specified multiple times to define multiple subnets
    virtual_network_tags = {      #(Optional) A mapping of tags which should be assigned to the virtual network.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DR",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}
#SUBNET
subnet_variables = {
  "subnet_1" = {
    subnet_name                                          = "sd-plz-dr-Connectivity-Hub-VNET-FW-UnTrust-SNET-01" # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "sd-plz-connectivity-dr-rg-01"                #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.249.6.0/26"]                          #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "sd-plz-dr-Connectivity-Hub-VNET"             #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled = null                                       # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled     = null                                       # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_service_endpoint_policy_ids                   = null                                       #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                             = null                                       #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation                                           = null /* [{
      delegation_name            = "delegation000001"                                                                                                                                                                                                #(Required) A name for this delegation.
      service_delegation_name    = "Microsoft.Sql/managedInstances"                                                                                                                                                                                  # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"] #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }]*/
  },
  "subnet_2" = {
    subnet_name                                          = "sd-plz-dr-Connectivity-Hub-VNET-FW-NAT-SNET-01" # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "sd-plz-connectivity-dr-rg-01"                    #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.249.7.0/26"]                            #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "sd-plz-dr-Connectivity-Hub-VNET"                 #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled = null                                           # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled     = null                                           # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_service_endpoint_policy_ids                   = null                                           #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                             = null                                           #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation                                           = null /* [{
      delegation_name            = "delegation000001"                                                                                                                                                                                                #(Required) A name for this delegation.
      service_delegation_name    = "Microsoft.Sql/managedInstances"                                                                                                                                                                                  # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"] #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }]*/
  },
  "subnet_3" = {
    subnet_name                                          = "sd-plz-dr-Connectivity-Hub-VNET-FW-Mgmt-SNET-01" # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "sd-plz-connectivity-dr-rg-01"                       #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.249.8.0/26"]                                 #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "sd-plz-dr-Connectivity-Hub-VNET"                    #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled = null                                              # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled     = null                                              # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_service_endpoint_policy_ids                   = null                                              #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                             = null                                              #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation                                           = null /* [{
      delegation_name            = "delegation000001"                                                                                                                                                                                                #(Required) A name for this delegation.
      service_delegation_name    = "Microsoft.Sql/managedInstances"                                                                                                                                                                                  # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"] #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }]*/
  },
  "subnet_4" = {
    subnet_name                                          = "sd-plz-dr-Connectivity-Hub-VNET-FW-Trust-SNET-01" # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "sd-plz-connectivity-dr-rg-01"                       #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.249.9.0/26"]                                #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "sd-plz-dr-Connectivity-Hub-VNET"                    #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled = null                                              # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled     = null                                              # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_service_endpoint_policy_ids                   = null                                              #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                             = null                                              #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation                                           = null /* [{
      delegation_name            = "delegation000001"                                                                                                                                                                                                #(Required) A name for this delegation.
      service_delegation_name    = "Microsoft.Sql/managedInstances"                                                                                                                                                                                  # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"] #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }]*/
  },
  "subnet_5" = {
    subnet_name                                          = "GatewaySubnet"                                   # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "sd-plz-connectivity-dr-rg-01"                    #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.249.10.0/26"]                                #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "sd-plz-dr-Connectivity-Hub-VNET"                   #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled = null                                             # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled     = null                                             # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_service_endpoint_policy_ids                   = null                                             #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                             = null                                             #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation                                           = null /* [{
      delegation_name            = "delegation000001"                                                                                                                                                                                                #(Required) A name for this delegation.
      service_delegation_name    = "Microsoft.Sql/managedInstances"                                                                                                                                                                                  # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"] #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }]*/
  },
  "subnet_6" = {
    subnet_name                                          = "sd-plz-dr-Connectivity-Hub-VNET-FW-Trust-LB-SNET-01" # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "sd-plz-connectivity-dr-rg-01"                     #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.249.12.0/26"]                              #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "sd-plz-dr-Connectivity-Hub-VNET"                  #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled = null                                            # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled     = null                                            # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_service_endpoint_policy_ids                   = null                                            #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                             = null                                            #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation                                           = null /* [{
      delegation_name            = "delegation000001"                                                                                                                                                                                                #(Required) A name for this delegation.
      service_delegation_name    = "Microsoft.Sql/managedInstances"                                                                                                                                                                                  # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"] #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }]*/
  },
  "subnet_7" = {
    subnet_name                                          = "sd-plz-dr-Connectivity-Hub-VNET-AGW-SNET-01" # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "sd-plz-connectivity-dr-rg-01"                           #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.249.15.0/24"]                                     #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "sd-plz-dr-Connectivity-Hub-VNET"                        #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled = null                                                  # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled     = null                                                  # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_service_endpoint_policy_ids                   = null                                                  #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                             = null                                                  #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation                                           = null /* [{
      delegation_name            = "delegation000001"                                                                                                                                                                                                #(Required) A name for this delegation.
      service_delegation_name    = "Microsoft.Sql/managedInstances"                                                                                                                                                                                  # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"] #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }]*/
  }
}

#NETWORK INTERFACE
network_interface_variables = {
  "network_interface_1" = {
    network_interface_name                          = "sd-plz-sdlvmfwp01-untrust-nic" #The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_location                      = "South India"                 #The location where the Network Interface should exist. Changing this forces a new resource to be created.
    network_interface_resource_group_name           = "sd-plz-connectivity-dr-rg-01"     #The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.
    network_interface_auxiliary_mode                = null                            # (Optional) Specifies the auxiliary mode used to enable network high-performance feature on Network Virtual Appliances (NVAs). Possible values are AcceleratedConnections and Floating.
    network_interface_auxiliary_sku                 = null                            # (Optional) Specifies the SKU used for the network high-performance feature on Network Virtual Appliances (NVAs). Possible values are A1, A2, A4 and A8.
    network_interface_dns_servers                   = []                              #if provided, it will override the DNS server value defined in vnet module
    network_interface_edge_zone                     = null                            #Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created
    network_interface_enable_ip_forwarding          = false                           #Enable only if IP Forwarding is required
    network_interface_enable_accelerated_networking = false                           #Enable only if accelerated networking is required
    network_interface_internal_dns_label            = null                            #The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.
    network_interface_ip_configuration = {
      "ip_configuration_1" = {
        ip_configuration_name                          = "privateconfig1" #A name used for this IP Configuration. Changing this forces a new resource to be created
        ip_configuration_private_ip_address_allocation = "Dynamic"        #Possible values are Dynamic and Static
        #ip_configuration_private_ip_address            = "10.0.3.11"                #When private_ip_address_allocation is set to Static, The Static IP Address which should be used
        ip_configuration_private_ip_address         = null
        ip_configuration_private_ip_address_version = "IPv4" #The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.
        ip_configuration_subnet = ({
          subnet_virtual_network_name                = "sd-plz-Connectivity-Hub-VNET"                    #When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID
          subnet_name                                = "sd-plz-Connectivity-Hub-VNET-FW-UnTrust-SNET-01" #When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID
          subnet_virtual_network_resource_group_name = "sd-plz-connectivity-dr-rg-01"                       #When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID
        })
        ip_configuration_public_ip     = null
        ip_configuration_primary       = true #Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false.Must be true for the first ip_configuration when multiple are specified
        ip_configuration_load_balancer = null
      }
    }
    network_interface_tags = { #(Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DR",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  },
  "network_interface_2" = {
    network_interface_name                          = "sd-plz-sdlvmfwp01-trust-nic" #The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_location                      = "South India"               #The location where the Network Interface should exist. Changing this forces a new resource to be created.
    network_interface_resource_group_name           = "sd-plz-connectivity-dr-rg-01"   #The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.
    network_interface_auxiliary_mode                = null                          # (Optional) Specifies the auxiliary mode used to enable network high-performance feature on Network Virtual Appliances (NVAs). Possible values are AcceleratedConnections and Floating.
    network_interface_auxiliary_sku                 = null                          # (Optional) Specifies the SKU used for the network high-performance feature on Network Virtual Appliances (NVAs). Possible values are A1, A2, A4 and A8.
    network_interface_dns_servers                   = []                            #if provided, it will override the DNS server value defined in vnet module
    network_interface_edge_zone                     = null                          #Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created
    network_interface_enable_ip_forwarding          = false                         #Enable only if IP Forwarding is required
    network_interface_enable_accelerated_networking = false                         #Enable only if accelerated networking is required
    network_interface_internal_dns_label            = null                          #The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.
    network_interface_ip_configuration = {
      "ip_configuration_1" = {
        ip_configuration_name                          = "privateconfig1" #A name used for this IP Configuration. Changing this forces a new resource to be created
        ip_configuration_private_ip_address_allocation = "Dynamic"        #Possible values are Dynamic and Static
        #ip_configuration_private_ip_address            = "10.0.3.11"                #When private_ip_address_allocation is set to Static, The Static IP Address which should be used
        ip_configuration_private_ip_address         = null
        ip_configuration_private_ip_address_version = "IPv4" #The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.
        ip_configuration_subnet = ({
          subnet_virtual_network_name                = "sd-plz-Connectivity-Hub-VNET"                   #When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID
          subnet_name                                = "ssd-plz-Connectivity-Hub-VNET-FW-Trust-SNET-01" #When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID
          subnet_virtual_network_resource_group_name = "sd-plz-connectivity-dr-rg-01"                      #When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID
        })
        ip_configuration_public_ip     = null
        ip_configuration_primary       = true #Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false.Must be true for the first ip_configuration when multiple are specified
        ip_configuration_load_balancer = null
      }
    }
    network_interface_tags = { #(Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DR",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  },
  "network_interface_3" = {
    network_interface_name                          = "sd-plz-sdlvmfwp01-mgmt-nic" #The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_location                      = "South India"              #The location where the Network Interface should exist. Changing this forces a new resource to be created.
    network_interface_resource_group_name           = "sd-plz-connectivity-dr-rg-01"  #The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.
    network_interface_auxiliary_mode                = null                         # (Optional) Specifies the auxiliary mode used to enable network high-performance feature on Network Virtual Appliances (NVAs). Possible values are AcceleratedConnections and Floating.
    network_interface_auxiliary_sku                 = null                         # (Optional) Specifies the SKU used for the network high-performance feature on Network Virtual Appliances (NVAs). Possible values are A1, A2, A4 and A8.
    network_interface_dns_servers                   = []                           #if provided, it will override the DNS server value defined in vnet module
    network_interface_edge_zone                     = null                         #Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created
    network_interface_enable_ip_forwarding          = false                        #Enable only if IP Forwarding is required
    network_interface_enable_accelerated_networking = false                        #Enable only if accelerated networking is required
    network_interface_internal_dns_label            = null                         #The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.
    network_interface_ip_configuration = {
      "ip_configuration_1" = {
        ip_configuration_name                          = "privateconfig1" #A name used for this IP Configuration. Changing this forces a new resource to be created
        ip_configuration_private_ip_address_allocation = "Dynamic"        #Possible values are Dynamic and Static
        #ip_configuration_private_ip_address            = "10.0.3.11"                #When private_ip_address_allocation is set to Static, The Static IP Address which should be used
        ip_configuration_private_ip_address         = null
        ip_configuration_private_ip_address_version = "IPv4" #The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.
        ip_configuration_subnet = ({
          subnet_virtual_network_name                = "sd-plz-Connectivity-Hub-VNET"                 #When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID
          subnet_name                                = "sd-plz-Connectivity-Hub-VNET-FW-Mgmt-SNET-01" #When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID
          subnet_virtual_network_resource_group_name = "sd-plz-connectivity-dr-rg-01"                    #When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID
        })
        ip_configuration_public_ip     = null
        ip_configuration_primary       = true #Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false.Must be true for the first ip_configuration when multiple are specified
        ip_configuration_load_balancer = null
      }
    }
    network_interface_tags = { #(Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DR",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  },
  "network_interface_4" = {
    network_interface_name                          = "sd-plz-sdlvmfwp02-untrust-nic" #The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_location                      = "South India"                 #The location where the Network Interface should exist. Changing this forces a new resource to be created.
    network_interface_resource_group_name           = "sd-plz-connectivity-dr-rg-01"     #The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.
    network_interface_auxiliary_mode                = null                            # (Optional) Specifies the auxiliary mode used to enable network high-performance feature on Network Virtual Appliances (NVAs). Possible values are AcceleratedConnections and Floating.
    network_interface_auxiliary_sku                 = null                            # (Optional) Specifies the SKU used for the network high-performance feature on Network Virtual Appliances (NVAs). Possible values are A1, A2, A4 and A8.
    network_interface_dns_servers                   = []                              #if provided, it will override the DNS server value defined in vnet module
    network_interface_edge_zone                     = null                            #Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created
    network_interface_enable_ip_forwarding          = false                           #Enable only if IP Forwarding is required
    network_interface_enable_accelerated_networking = false                           #Enable only if accelerated networking is required
    network_interface_internal_dns_label            = null                            #The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.
    network_interface_ip_configuration = {
      "ip_configuration_1" = {
        ip_configuration_name                          = "privateconfig1" #A name used for this IP Configuration. Changing this forces a new resource to be created
        ip_configuration_private_ip_address_allocation = "Dynamic"        #Possible values are Dynamic and Static
        #ip_configuration_private_ip_address            = "10.0.3.11"                #When private_ip_address_allocation is set to Static, The Static IP Address which should be used
        ip_configuration_private_ip_address         = null
        ip_configuration_private_ip_address_version = "IPv4" #The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.
        ip_configuration_subnet = ({
          subnet_virtual_network_name                = "sd-plz-Connectivity-Hub-VNET"                    #When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID
          subnet_name                                = "sd-plz-Connectivity-Hub-VNET-FW-UnTrust-SNET-02" #When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID
          subnet_virtual_network_resource_group_name = "sd-plz-connectivity-dr-rg-01"                       #When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID
        })
        ip_configuration_public_ip     = null
        ip_configuration_primary       = true #Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false.Must be true for the first ip_configuration when multiple are specified
        ip_configuration_load_balancer = null
      }
    }
    network_interface_tags = { #(Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DR",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  },
  "network_interface_5" = {
    network_interface_name                          = "sd-plz-sdlvmfwp02-trust-nic" #The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_location                      = "South India"               #The location where the Network Interface should exist. Changing this forces a new resource to be created.
    network_interface_resource_group_name           = "sd-plz-connectivity-dr-rg-01"   #The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.
    network_interface_auxiliary_mode                = null                          # (Optional) Specifies the auxiliary mode used to enable network high-performance feature on Network Virtual Appliances (NVAs). Possible values are AcceleratedConnections and Floating.
    network_interface_auxiliary_sku                 = null                          # (Optional) Specifies the SKU used for the network high-performance feature on Network Virtual Appliances (NVAs). Possible values are A1, A2, A4 and A8.
    network_interface_dns_servers                   = []                            #if provided, it will override the DNS server value defined in vnet module
    network_interface_edge_zone                     = null                          #Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created
    network_interface_enable_ip_forwarding          = false                         #Enable only if IP Forwarding is required
    network_interface_enable_accelerated_networking = false                         #Enable only if accelerated networking is required
    network_interface_internal_dns_label            = null                          #The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.
    network_interface_ip_configuration = {
      "ip_configuration_1" = {
        ip_configuration_name                          = "privateconfig1" #A name used for this IP Configuration. Changing this forces a new resource to be created
        ip_configuration_private_ip_address_allocation = "Dynamic"        #Possible values are Dynamic and Static
        #ip_configuration_private_ip_address            = "10.0.3.11"                #When private_ip_address_allocation is set to Static, The Static IP Address which should be used
        ip_configuration_private_ip_address         = null
        ip_configuration_private_ip_address_version = "IPv4" #The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.
        ip_configuration_subnet = ({
          subnet_virtual_network_name                = "sd-plz-Connectivity-Hub-VNET"                  #When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID
          subnet_name                                = "sd-plz-Connectivity-Hub-VNET-FW-Trust-SNET-02" #When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID
          subnet_virtual_network_resource_group_name = "sd-plz-connectivity-dr-rg-01"                     #When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID
        })
        ip_configuration_public_ip     = null
        ip_configuration_primary       = true #Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false.Must be true for the first ip_configuration when multiple are specified
        ip_configuration_load_balancer = null
      }
    }
    network_interface_tags = { #(Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DR",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  },
  "network_interface_6" = {
    network_interface_name                          = "sd-plz-sdlvmfwp02-mgmt-nic" #The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_location                      = "South India"              #The location where the Network Interface should exist. Changing this forces a new resource to be created.
    network_interface_resource_group_name           = "sd-plz-connectivity-dr-rg-01"  #The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.
    network_interface_auxiliary_mode                = null                         # (Optional) Specifies the auxiliary mode used to enable network high-performance feature on Network Virtual Appliances (NVAs). Possible values are AcceleratedConnections and Floating.
    network_interface_auxiliary_sku                 = null                         # (Optional) Specifies the SKU used for the network high-performance feature on Network Virtual Appliances (NVAs). Possible values are A1, A2, A4 and A8.
    network_interface_dns_servers                   = []                           #if provided, it will override the DNS server value defined in vnet module
    network_interface_edge_zone                     = null                         #Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created
    network_interface_enable_ip_forwarding          = false                        #Enable only if IP Forwarding is required
    network_interface_enable_accelerated_networking = false                        #Enable only if accelerated networking is required
    network_interface_internal_dns_label            = null                         #The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.
    network_interface_ip_configuration = {
      "ip_configuration_1" = {
        ip_configuration_name                          = "privateconfig1" #A name used for this IP Configuration. Changing this forces a new resource to be created
        ip_configuration_private_ip_address_allocation = "Dynamic"        #Possible values are Dynamic and Static
        #ip_configuration_private_ip_address            = "10.0.3.11"                #When private_ip_address_allocation is set to Static, The Static IP Address which should be used
        ip_configuration_private_ip_address         = null
        ip_configuration_private_ip_address_version = "IPv4" #The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.
        ip_configuration_subnet = ({
          subnet_virtual_network_name                = "sd-plz-Connectivity-Hub-VNET"                 #When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID
          subnet_name                                = "sd-plz-Connectivity-Hub-VNET-FW-Mgmt-SNET-01" #When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID
          subnet_virtual_network_resource_group_name = "sd-plz-connectivity-dr-rg-01"                    #When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID
        })
        ip_configuration_public_ip     = null
        ip_configuration_primary       = true #Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false.Must be true for the first ip_configuration when multiple are specified
        ip_configuration_load_balancer = null
      }
    }
    network_interface_tags = { #(Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DR",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}


#APPLICATION GATEWAY 
application_gateway_variables = {
  "application_gateway_1" = {
    application_gateway_name                              = "sd-plz-appgw-01"                          #(Required) The name of the Application Gateway. Changing this forces a new resource to be created.                    
    application_gateway_resource_group_name               = "sd-plz-connectivity-dr-rg-01"                #(Required) The name of the resource group in which to the Application Gateway should exist. Changing this forces a new resource to be created.                 
    application_gateway_location                          = "South India"                            #(Required) The Azure region where the Application Gateway should exist. Changing this forces a new resource to be created.                 
    application_gateway_sku_capacity                      = 2                                          #(Required) The Capacity of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32, and 1 to 125 for a V2 SKU. This property is optional if autoscale_configuration is set.                 
    application_gateway_vnet_name                         = "sd-plz-Connectivity-Hub-VNET"             #Name of the virtual network to be associated with Application Gateway               
    application_gateway_vnet_resource_group_name          = "sd-plz-connectivity-dr-rg-01"                #name of the virtual network resource group name
    application_gateway_subnet_name                       = "sd-plz-Connectivity-Hub-VNET-AGW-SNET-01" #Name of the subnet to be associated with Application Gateway                 
    application_gateway_frontend_port                     = 80                                         #(Required) The port used for this Frontend Port.                 
    application_gateway_is_private_frontend_ip_required   = false                                      #(Optional) The Private IP Address to use for the Application Gateway.              
    application_gateway_is_public_frontend_ip_required    = true                                       #(Optional) The ID of a Public IP Address which the Application Gateway should use. The allocation method for the Public IP Address depends on the sku of this Application Gateway. Please refer to the Azure documentation for public IP addresses for details.
    application_gateway_is_waf_policy_required            = false                                      #(Optional) A waf_configuration block                 
    application_gateway_waf_policy_name                   = null                                       #Name of the waf Policy                  
    application_gateway_waf_policy_resource_group_name    = null                                       #Resource Group of the waf policy                
    application_gateway_public_ip_name                    = "sd-plz-connectivity-pip-agw-01"           #(Optional) The public IP Address which the Application Gateway should use. The allocation method for the Public IP Address depends on the sku of this Application Gateway. Please refer to the Azure documentation for public IP addresses for details.
    application_gateway_fips_enabled                      = false                                      #(Optional) Is FIPS enabled on the Application Gateway?               
    application_gateway_identity                          = null                                       #(Optional)
    application_gateway_zones                             = null                                       #(Optional) Specifies a list of Availability Zones in which this Application Gateway should be located. Changing this forces a new Application Gateway to be created.
    application_gateway_trusted_client_certificate        = null                                       #(Optional) Is client certificate required?
    application_gateway_authentication_certificate        = null                                       #(Optional) One or more authentication_certificate blocks
    application_gateway_trusted_root_certificate          = null                                       #(Optional)A root certifcate block
    application_gateway_keyvault_cert_configuration       = null                                       #(Optional) One or more authentication_certificate blocks
    application_gateway_custom_error_configuration        = null                                       #(Optional) One or more custom_error_configuration blocks
    application_gateway_force_firewall_policy_association = false                                      # Is the Firewall Policy associated with the Application Gateway?  #(Optional) Is the Firewall Policy associated with the Application Gateway?
    application_gateway_enable_http2                      = false                                      #(Optional) Is HTTP2 enabled on the application gateway resource? Defaults to false.

    application_gateway_sku = {    #(Required) A sku block as defined below.
      sku_name     = "Standard_v2" #(Required) The Name of the SKU to use for this Application Gateway. Possible values are Standard_Small, Standard_Medium, Standard_Large, Standard_v2, WAF_Medium, WAF_Large, and WAF_v2.
      sku_tier     = "Standard_v2" #(Required) The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard_v2, WAF and WAF_v2.
      sku_capacity = 2             #(Required) The Capacity of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32, and 1 to 125 for a V2 SKU. This property is optional if autoscale_configuration is set.
    }

    application_gateway_gateway_ip_configuration = [ #A frontend_ip_configuration block supports the following
      {
        gateway_ip_configuration_name        = "appgateway-gicconfig"                     #(Required) The name of the Frontend IP Configuration.
        gateway_ip_configuration_subnet_name = "sd-plz-Connectivity-Hub-VNET-AGW-SNET-01" #" #(Required) The Name of the Subnet which the Application Gateway should be connected to.
    }]

    application_gateway_waf_configuration = null /*{                   #A waf_configuration block supports the following
      waf_configuration_firewall_mode            = "Prevention" #(Required) The Web Application Firewall Mode. Possible values are Detection and Prevention.
      waf_configuration_rule_set_type            = "OWASP"      #(Required) The Type of the Rule Set used for this Web Application Firewall. Currently, only OWASP is supported.
      waf_configuration_rule_set_version         = "3.2"        #(Required) The Version of the Rule Set used for this Web Application Firewall. Possible values are 2.2.9, 3.0, 3.1, and 3.2.
      waf_configuration_file_upload_limit_mb     = "100"        #(Optional) The File Upload Limit in MB. Accepted values are in the range 1MB to 750MB for the WAF_v2 SKU, and 1MB to 500MB for all other SKUs. Defaults to 100MB.
      waf_configuration_max_request_body_size_kb = "127"        #(Optional) The Maximum Request Body Size in KB. Accepted values are in the range 1KB to 128KB. Defaults to 128KB.
      waf_configuration_request_body_check       = true         #(Optional) Is Request Body Inspection enabled? Defaults to true
      waf_configuration_enabled                  = true         #(Required) Is the Web Application Firewall enabled?
      waf_configuration_disabled_rule_group = {                 #A disabled_rule_group block supports the following:
        disabled_rule_group_rule_group_name = "General"         #(Required) The rule group where specific rules should be disabled. Accepted values are: crs_20_protocol_violations, crs_21_protocol_anomalies, crs_23_request_limits, crs_30_http_policy, crs_35_bad_robots, crs_40_generic_attacks, crs_41_sql_injection_attacks, crs_41_xss_attacks, crs_42_tight_security, crs_45_trojans, General, REQUEST-911-METHOD-ENFORCEMENT, REQUEST-913-SCANNER-DETECTION, REQUEST-920-PROTOCOL-ENFORCEMENT, REQUEST-921-PROTOCOL-ATTACK, REQUEST-930-APPLICATION-ATTACK-LFI, REQUEST-931-APPLICATION-ATTACK-RFI, REQUEST-932-APPLICATION-ATTACK-RCE, REQUEST-933-APPLICATION-ATTACK-PHP, REQUEST-941-APPLICATION-ATTACK-XSS, REQUEST-942-APPLICATION-ATTACK-SQLI, REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION
        disabled_rule_group_rules = null #(Optional) A list of rules which should be disabled in that group. Disables all rules in the specified group if rules is not specified.
      }
      waf_configuration_exclusion = {                            #A exclusion block supports the following:
        exclusion_match_variable          = "RequestHeaderNames" #(Required) Match variable of the exclusion rule to exclude header, cookie or GET arguments. Possible values are RequestArgKeys, RequestArgNames, RequestArgValues, RequestCookieKeys, RequestCookieNames, RequestCookieValues, RequestHeaderKeys, RequestHeaderNames and RequestHeaderValues
        exclusion_selector_match_operator = "StartsWith"         #(Optional) Operator which will be used to search in the variable content. Possible values are Contains, EndsWith, Equals, EqualsAny and StartsWith. If empty will exclude all traffic on this match_variable
        exclusion_selector                = "RequestHeaderNames" #(Optional) String value which will be used for the filter operation. If empty will exclude all traffic on this match_variable
      }
    } */
    application_gateway_frontend_ports = [
      {
        frontend_ports_name = "appgateway-feport" #(Required) The name of the Frontend Port.
        frontend_ports_port = 80                  #(Required) The port used for this Frontend Port.
      }
    ]

    application_gateway_backend_address_pools = [ #A backend_address_pool block supports the following:
      {
        backend_address_pools_name         = "appgateway-beap" #(Required) The name of the Backend Address Pool.
        backend_address_pools_fqdns        = null              #(Optional) A list of FQDN's which should be part of the Backend Address Pool.
        backend_address_pools_ip_addresses = null              #(Optional) A list of IP Addresses which should be part of the Backend Address Pool.
      }
    ]

    application_gateway_autoscale_configuration = null /*{ #A autoscale_configuration block supports the following:
      autoscale_configuration_min_capacity = 1      #(Required) Minimum capacity for autoscaling. Accepted values are in the range 0 to 100.
      autoscale_configuration_max_capacity = 2      #(Optional) Maximum capacity for autoscaling. Accepted values are in the range 2 to 125.
    } */
    application_gateway_backend_http_settings = [ #A backend_http_settings block supports the following:
      {
        backend_http_settings_name                                = "appgateway-be-http" #(Required) The name of the Backend HTTP Settings Collection.   
        backend_http_settings_path                                = "/path1/"            #(Optional) The Path which should be used as a prefix for all HTTP requests.
        backend_http_settings_port                                = 80                   #(Required) The port which should be used for this Backend HTTP Settings Collection.
        backend_http_settings_protocol                            = "Http"               #(Required) The Protocol which should be used. Possible values are Http and Https.
        backend_http_settings_cookie_based_affinity               = "Disabled"           #(Required) Is Cookie-Based Affinity enabled? Possible values are Enabled and Disabled.
        backend_http_settings_affinity_cookie_name                = null                 #(Optional) The name of the affinity cookie.
        backend_http_settings_request_timeout                     = 60                   #(Required) The request timeout in seconds, which must be between 1 and 86400 seconds.
        backend_http_settings_probe_name                          = null                 #(Optional) The name of an associated HTTP Probe
        backend_http_settings_host_name                           = null                 #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true.
        backend_http_settings_pick_host_name_from_backend_address = false                #(Optional) Whether host header should be picked from the host name of the backend server. Defaults to false.
        backend_http_settings_trusted_root_certificate_names      = null                 //["pappcert"]  #(Optional) A list of trusted_root_certificate names.
        backend_http_settings_authentication_certificate          = null                 #A authentication_certificate block supports the following:
        backend_http_settings_connection_draining                 = null
      }
    ]
    application_gateway_frontend_ip_configuration = [{                              #A frontend_ip_configuration block supports the following: 
      frontend_ip_configuration_name                            = "appgateway-feip" #(Required) The name of the Frontend IP Configuration.
      frontend_ip_configuration_private_ip_address              = null              #(Optional) The Private IP Address to use for the Application Gateway.  
      frontend_ip_configuration_private_ip_address_allocation   = null              #(Optional) The Allocation Method for the Private IP Address. Possible values are Dynamic and Static.
      frontend_ip_configuration_private_link_configuration_name = null              #(Optional) The name of the private link configuration to use for this frontend IP configuration.
      frontend_ip_configuration_is_private_frontend_ip_required = false             #if private frontend ip is required or not.
      frontend_ip_configuration_is_public_frontend_ip_required  = true              #if public frontend ip is required or not.
    }]
    application_gateway_http_listener = [ #A http_listener block supports the following:
      {
        http_listener_name                           = "appgateway-httplstn" #(Required) The Name of the HTTP Listener.
        http_listener_frontend_ip_configuration_name = "appgateway-feip"     #(Required) The Name of the Frontend IP Configuration used for this HTTP Listener.
        http_listener_frontend_port_name             = "appgateway-feport"   #(Required) The Name of the Frontend Port use for this HTTP Listener.
        http_listener_protocol                       = "Http"                #(Required) The Protocol to use for this HTTP Listener. Possible values are Http and Https.
        http_listener_ssl_certificate_name           = null                  //"pappcert"   #(Optional) The name of the associated SSL Certificate which should be used for this HTTP Listener.
        http_listener_sni_required                   = false                 #(Optional) Should Server Name Indication be Required? Defaults to false.
        http_listener_listener_type                  = null                  # MultiSite or Basic
        http_listener_host_name                      = null                  #Required if listener_type = MultiSite and host_names = null
        http_listener_host_names                     = null                  #Required if listener_type = MultiSite and host_name = null
        http_listener_ssl_profile_name               = null                  #(Optional) The name of the associated SSL Profile which should be used for this HTTP Listener.
        http_listener_custom_error_configuration     = null
      }
    ]
    application_gateway_request_routing_rules = [ #A request_routing_rule block exports the following:
      {
        request_routing_rules_name                        = "appgateway-rqrt"     #(Required) The Name of this Request Routing Rule.
        request_routing_rules_rule_type                   = "Basic"               #(Required) The Type of Routing that should be used for this Rule. Possible values are Basic and PathBasedRouting.
        request_routing_rules_listener_name               = "appgateway-httplstn" #(Required) The Name of the HTTP Listener which should be used for this Routing Rule.
        request_routing_rules_backend_address_pool_name   = "appgateway-beap"     #(Optional) The Name of the Backend Address Pool which should be used for this Routing Rule. Cannot be set if redirect_configuration_name is set.
        request_routing_rules_backend_http_settings_name  = "appgateway-be-http"  #(Optional) The Name of the Backend HTTP Settings Collection which should be used for this Routing Rule. Cannot be set if redirect_configuration_name is set.
        request_routing_rules_rewrite_rule_set_name       = null                  #(Optional) The Name of the Rewrite Rule Set which should be used for this Routing Rule. Only valid for v2 SKUs.
        request_routing_rules_redirect_configuration_name = null                  #(Optional) The Name of the Redirect Configuration which should be used for this Routing Rule. Cannot be set if either backend_address_pool_name or backend_http_settings_name is set.
        request_routing_rules_priority                    = "9"                   #(Optional) Rule evaluation order can be dictated by specifying an integer value from 1 to 20000 with 1 being the highest priority and 20000 being the lowest priority.
        request_routing_rules_url_path_map_name           = null                  #(Optional) The Name of the URL Path Map which should be associated with this Routing Rule.

      }
    ]
    application_gateway_global                                  = null #(Optional) A global block.
    application_gateway_url_path_maps                           = [] /* [{                                   #A url_path_map block supports the following:
      url_path_maps_name                                = "urlpathbasedmaps" #(Required) The Name of the URL Path Map.  
      url_path_maps_default_backend_http_settings_name  = null               #(Optional) The Name of the Default Backend Address Pool which should be used for this URL Path Map. Cannot be set if default_redirect_configuration_name is set.
      url_path_maps_default_backend_address_pool_name   = null               #(Optional) The Name of the Default Backend HTTP Settings Collection which should be used for this URL Path Map. Cannot be set if default_redirect_configuration_name is set.
      url_path_maps_default_redirect_configuration_name = "appgateway-rdrcfg"       #(Optional) The Name of the Default Redirect Configuration which should be used for this URL Path Map. Cannot be set if either default_backend_address_pool_name or default_backend_http_settings_name is set.
      url_path_maps_default_rewrite_rule_set_name       = null               #(Optional) The Name of the Default Rewrite Rule Set which should be used for this URL Path Map. Only valid for v2 SKUs.
      url_path_maps_path_rules = [{                                          #(Required) One or more path_rule blocks as defined above.
        path_rules_name                        = "mytheartrule"              #(Required) The Name of the Path Rule.
        path_rules_paths                       = ["/*"]                      #(Required) A list of Paths used in this Path Rule.
        path_rules_backend_http_settings_name  = null                        #(Optional) The Name of the Backend HTTP Settings Collection to use for this Path Rule. Cannot be set if redirect_configuration_name is set.
        path_rules_backend_address_pool_name   = null                        #(Optional) The Name of the Backend Address Pool to use for this Path Rule. Cannot be set if redirect_configuration_name is set.
        path_rules_redirect_configuration_name = "appgateway-rdrcfg"                #(Optional) The Name of a Redirect Configuration to use for this Path Rule. Cannot be set if backend_address_pool_name or backend_http_settings_name is set.
        path_rules_rewrite_rule_set_name       = null                        #(Optional) The Name of the Rewrite Rule Set which should be used for this URL Path Map. Only valid for v2 SKUs.
      }]
    }] */
    application_gateway_private_link_configuration              = null
    application_gateway_probe                                   = null /* [ #A probe block support the following:
      {
        probe_name                                      = "http-bc-prob"   #(Required) The Name of the Probe.  
        probe_path                                      = "/"              #(Required) The Path used for this Probe.
        probe_protocol                                  = "Http"           #(Required) The Protocol used for this Probe. Possible values are Http and Https.
        probe_host                                      = "hostname.com"   #(Optional) The Hostname used for this Probe. If the Application Gateway is configured for a single site, by default the Host name should be specified as ‘127.0.0.1’, unless otherwise configured in custom probe. Cannot be set if pick_host_name_from_backend_http_settings is set to true.
        probe_port                                      = "80"             #(Optional) Custom port which will be used for probing the backend servers. The valid value ranges from 1 to 65535. In case not set, port from HTTP settings will be used. This property is valid for Standard_v2 and WAF_v2 only.
        probe_minimum_servers                           = "4"              #(Optional) The minimum number of servers that are always marked as healthy. Defaults to 0.
        probe_interval                                  = null             #(Required) The Interval between two consecutive probes in seconds. Possible values range from 1 second to a maximum of 86,400 seconds.
        probe_timeout                                   = null             #(Required) The Timeout used for this Probe, which indicates when a probe becomes unhealthy. Possible values range from 1 second to a maximum of 86,400 seconds.
        probe_unhealthy_threshold                       = null             #(Required) The Unhealthy Threshold for this Probe, which indicates the amount of retries which should be attempted before a node is deemed unhealthy. Possible values are from 1 to 20.
        probe_pick_host_name_from_backend_http_settings = false            #(Optional) Whether the host header should be picked from the backend HTTP settings. Defaults to false.
        probe_match = [{                                                   #(Optional) A match block as defined above.
          match_body        = "Error occured due to autherization failure" #A snippet from the Response Body which must be present in the Response.
          match_status_code = ["403"]                                      ##(Required) A list of allowed status codes for this Health Probe.
        }]
      }
    ] */
    application_gateway_redirect_configurations                 = [] /*[ #A redirect_configuration block supports the following:
      {
        redirect_configurations_name                 = "appgateway-rdrcfg"    #(Required) Unique name of the redirect configuration block
        redirect_configurations_redirect_type        = "Permanent"     #(Required) The type of redirect. Possible values are Permanent, Temporary, Found and SeeOther
        redirect_configurations_target_listener_name = "appgateway-httplstn" #(Optional) The name of the listener to redirect to. Cannot be set if target_url is set.
        redirect_configurations_target_url           = null            #(Optional) The Url to redirect the request to. Cannot be set if target_listener_name is set.
        redirect_configurations_include_path         = true            #(Optional) Whether or not to include the path in the redirected Url. Defaults to false
        redirect_configurations_include_query_string = true            #(Optional) Whether or not to include the query string in the redirected Url. Default to false
      }
    ] */
    application_gateway_disabled_ssl_protocols                  = null #disable ssl protocol or not, either true or false
    application_gateway_key_vault_with_private_endpoint_enabled = true #accepts true or false
    application_gateway_ssl_profile                             = null #accepts true or false
    application_gateway_ssl_policy                              = null
    # [{
    #   ssl_policy_name                 = "AppGwSslPolicy20220101"       #(Required) The name of the SSL Profile that is unique within this Application Gateway.
    #   ssl_policy_policy_type          = "Predefined"       #(Optional) The Type of the Policy. Possible values are Predefined and Custom.
    #   ssl_policy_cipher_suites        = [] #(Optional) A List of accepted cipher suites. Possible values are: TLS_DHE_DSS_WITH_AES_128_CBC_SHA, TLS_DHE_DSS_WITH_AES_128_CBC_SHA256, TLS_DHE_DSS_WITH_AES_256_CBC_SHA, TLS_DHE_DSS_WITH_AES_256_CBC_SHA256, TLS_DHE_RSA_WITH_AES_128_CBC_SHA, TLS_DHE_RSA_WITH_AES_128_GCM_SHA256, TLS_DHE_RSA_WITH_AES_256_CBC_SHA, TLS_DHE_RSA_WITH_AES_256_GCM_SHA384, TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA, TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256, TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256, TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA, TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384, TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384, TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA, TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256, TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA, TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384, TLS_RSA_WITH_3DES_EDE_CBC_SHA, TLS_RSA_WITH_AES_128_CBC_SHA, TLS_RSA_WITH_AES_128_CBC_SHA256, TLS_RSA_WITH_AES_128_GCM_SHA256, TLS_RSA_WITH_AES_256_CBC_SHA, TLS_RSA_WITH_AES_256_CBC_SHA256 and TLS_RSA_WITH_AES_256_GCM_SHA384.
    #   ssl_policy_min_protocol_version = null       #(Optional) The minimal TLS version. Possible values are TLSv1_0, TLSv1_1 and TLSv1_2.
    #   ssl_policy_disabled_protocols   = []       #(Optional) A list of SSL Protocols which should be disabled on this Application Gateway. Possible values are TLSv1_0, TLSv1_1, TLSv1_2 and TLSv1_3.
    # }]                                               #accepts true or false
    application_gateway_ssl_certificate  = null #accepts true or false
    application_gateway_rewrite_rule_set = null #accepts true or false

    application_gateway_application_gateway_tags = { #(Optional) A mapping of tags to assign to the resource. 
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DR",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}

#LINUX VM
linux_virtual_machine_variables = {
  "linux_virtual_machine_1" = {
    linux_virtual_machine_admin_username = "palovm1"       #(Required) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created.
    linux_virtual_machine_location       = "South India" #(Required) The Azure location where the Linux Virtual Machine should exist. Changing this forces a new resource to be created.
    linux_virtual_machine_license_type   = null            #(Optional) Specifies the BYOL Type for this Virtual Machine. Possible values are RHEL_BYOS and SLES_BYOS.
    linux_virtual_machine_name           = "SDLVMFWP01"    #(Required) The name of the Linux Virtual Machine. Changing this forces a new resource to be created.
    linux_virtual_machine_os_disk = {                      #(Required) A os_disk block as defined below.
      os_disk_caching              = null                  #(Required) The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite.
      os_disk_storage_account_type = "Standard_LRS"        #(Required) The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS. Changing this forces a new resource to be created.
      os_disk_diff_disk_settings = {                       #(Optional) A diff_disk_settings block as defined above. Changing this forces a new resource to be created.
        diff_disk_settings_option    = "Local"             # (Required) Specifies the Ephemeral Disk Settings for the OS Disk. At this time the only possible value is Local. Changing this forces a new resource to be created.
        diff_disk_settings_placement = null                #(Optional) Specifies where to store the Ephemeral Disk. Possible values are CacheDisk and ResourceDisk. Defaults to CacheDisk. Changing this forces a new resource to be created.
      }
      os_disk_disk_size_gb              = 120                  #(Optional) The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from.
      os_disk_name                      = "SDLVMFWP01-disk-01" #(Optional) The name which should be used for the Internal OS Disk. Changing this forces a new resource to be created.
      os_disk_security_encryption_type  = null                 #(Optional) Encryption Type when the Virtual Machine is a Confidential VM. Possible values are VMGuestStateOnly and DiskWithVMGuestState. Changing this forces a new resource to be created.
      os_disk_write_accelerator_enabled = false                #(Optional) Should Write Accelerator be Enabled for this OS Disk? Defaults to false.
    }
    linux_virtual_machine_resource_group_name = "sd-plz-connectivity-dr-rg-01" #(Required) The name of the Resource Group in which the Linux Virtual Machine should be exist. Changing this forces a new resource to be created.
    linux_virtual_machine_size                = "Standard_D3_v2"            #(Required) The SKU which should be used for this Virtual Machine, such as Standard_F2.
    linux_virtual_machine_additional_capabilities = {                       #(Optional) A additional_capabilities block as defined below.
      additional_capabilities_ultra_ssd_enabled = false                     #(Optional) Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine? Defaults to false.
    }
    linux_virtual_machine_allow_extension_operations            = false        #(Optional) Should Extension Operations be allowed on this Virtual Machine?
    linux_virtual_machine_boot_diagnostics_storage_account_name = null         # Provide storage account name value if linux_virtual_machine_is_storage_blob_required or linux_virtual_machine_is_boot_diagnostics_required is set to true
    linux_virtual_machine_computer_name                         = "SDLVMFWP01" #(Optional) Specifies the Hostname which should be used for this Virtual Machine. If unspecified this defaults to the value for the name field. If the value of the name field is not a valid computer_name, then you must specify computer_name. Changing this forces a new resource to be created.
    linux_virtual_machine_custom_data                           = null         #(Optional) The Base64-Encoded Custom Data which should be used for this Virtual Machine. Changing this forces a new resource to be created.
    linux_virtual_machine_disable_password_authentication       = false        #(Optional) Should Password Authentication be disabled on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created.
    linux_virtual_machine_edge_zone                             = null         #(Optional) Specifies the Edge Zone within the Azure Region where this Linux Virtual Machine should exist. Changing this forces a new Linux Virtual Machine to be created.
    linux_virtual_machine_encryption_at_host_enabled            = false        #(Optional) Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?
    linux_virtual_machine_eviction_policy                       = null         #(Optional) Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance. Possible values are Deallocate and Delete. Changing this forces a new resource to be created.
    linux_virtual_machine_extensions_time_budget                = null         #(Optional) Specifies the duration allocated for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. Defaults to 90 minutes (PT1H30M).
    linux_virtual_machine_gallery_application                   = null         #(Optional) A gallery_application block as defined below.
    /* Sample Code {
      #gallery_application_configuration_blob_uri = string                               #(Optional) Specifies the URI to an Azure Blob that will replace the default configuration for the package if provided.
      gallery_application_order                  = 1                               #(Optional) Specifies the order in which the packages have to be installed. Possible values are between 0 and 2,147,483,647.
      gallery_application_tag                    = null                               #(Optional) Specifies a passthrough value for more generic context. This field can be any valid string value.
    }  */
    linux_virtual_machine_identity = {                                  #(Optional)
      identity_type                                  = "SystemAssigned" #(Required) The type of Managed Service Identity that is configured on this Disk Encryption Set. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      linux_virtual_machine_user_assigned_identities = null /* [{
        user_assigned_identities_name                = "puai000001" #(Required)Name of the user assigned identity
        user_assigned_identities_resource_group_name = "prg000001"  #(Required)Resource group name of the user assigned identity
      }]*/
    }
    linux_virtual_machine_patch_assessment_mode = null           #(Optional) Specifies the mode of VM Guest Patching for the Virtual Machine. Possible values are AutomaticByPlatform or ImageDefault. Defaults to ImageDefault.
    linux_virtual_machine_patch_mode            = "ImageDefault" # (Optional) Specifies the mode of in-guest patching to this Linux Virtual Machine. Possible values are AutomaticByPlatform and ImageDefault. Defaults to ImageDefault. For more information on patch modes please see the product documentation.
    linux_virtual_machine_max_bid_price         = "-1"           #(Optional) The maximum price you're willing to pay for this Virtual Machine, in US Dollars; which must be greater than the current spot price. If this bid price falls below the current spot price the Virtual Machine will be evicted using the eviction_policy. Defaults to -1, which means that the Virtual Machine should not be evicted for price reasons.
    linux_virtual_machine_plan = [{
      plan_name      = "byol"             #(Required) Specifies the Name of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
      plan_product   = "panorama"         #(Required) Specifies the Product of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
      plan_publisher = "paloaltonetworks" #(Optional) A plan block as defined below. Changing this forces a new resource to be created.
    }]
    linux_virtual_machine_platform_fault_domain = null      #(Optional) Specifies the Platform Fault Domain in which this Linux Virtual Machine should be created. Defaults to -1, which means this will be automatically assigned to a fault domain that best maintains balance across the available fault domains. Changing this forces a new Linux Virtual Machine to be created.
    linux_virtual_machine_priority              = "Regular" #(Optional) Specifies the priority of this Virtual Machine. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created.
    linux_virtual_machine_provision_vm_agent    = false     #(Optional) Should the Azure VM Agent be provisioned on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created.
    linux_virtual_machine_secure_boot_enabled   = false     #(Optional) Specifies whether secure boot should be enabled on the virtual machine. Changing this forces a new resource to be created.
    linux_virtual_machine_source_image_reference = {        #Optional) A source_image_reference block as defined below. Changing this forces a new resource to be created.
      source_image_reference_publisher = "paloaltonetworks" #(Optional) Specifies the publisher of the image used to create the virtual machines.
      source_image_reference_offer     = "panorama"         #(Optional) Specifies the offer of the image used to create the virtual machines.
      source_image_reference_sku       = "byol"             #(Optional) Specifies the SKU of the image used to create the virtual machines.
      source_image_reference_version   = "latest"           #(Optional) Specifies the version of the image used to create the virtual machines.
    }
    linux_virtual_machine_termination_notification = null /* [{ #(Optional) A termination_notification block as defined below.
      termination_notification_enabled = true           #(Required) Should the termination notification be enabled on this Virtual Machine? Defaults to false.
      termination_notification_timeout = "PT10M"        #(Optional) Length of time (in minutes, between 5 and 15) a notification to be sent to the VM on the instance metadata server till the VM gets deleted. The time duration should be specified in ISO 8601 format.
    }]*/
    linux_virtual_machine_user_data                = null  #(Optional) The Base64-Encoded User Data which should be used for this Virtual Machine.
    linux_virtual_machine_vtpm_enabled             = false #(Optional) Specifies whether vTPM should be enabled on the virtual machine. Changing this forces a new resource to be created.
    linux_virtual_machine_zone                     = null  #(Optional) Specifies the Availability Zones in which this Linux Virtual Machine should be located. Changing this forces a new Linux Virtual Machine to be created.
    linux_virtual_machine_tags = {
      BU             = "ELZ",
      Role           = "Palo Alto VM",
      Environment    = "PLZ-DR",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }

    linux_virtual_machine_use_existing_vm_username                   = false             #(Required)should be set true if existing user name is used
    linux_virtual_machine_generate_new_admin_password                = true              #(Required)admin_password should be generated if disable_password_authentication is false
    linux_virtual_machine_generate_new_ssh_key                       = true              #(Required)Should be true/false if linux_virtual_machine_disable_password_authentication is true
    linux_virtual_machine_admin_login_key_vault_name                 = "sdplzmgmtdckv01" #"existingkeyvaultscenario"
    linux_virtual_machine_tls_private_key_algorithm                  = "RSA"             #Provide Algorithm used for TLS private key if linux_virtual_machine_generate_new_ssh_key is true
    linux_virtual_machine_tls_private_key_rsa_bits                   = 2048              #Provide number if bits for TLS private key if linux_virtual_machine_generate_new_ssh_key is true
    linux_virtual_machine_admin_ssh_key_vault_secret_expiration_date = null
    linux_virtual_machine_admin_ssh_key_vault_secret_content_type    = null
    linux_virtual_machine_admin_ssh_key_vault_secret_name            = "SDLVMFWP01-sshkey" #Key vault secret name to store the ssh key if linux_virtual_machine_generate_new_ssh_key is true
    linux_virtual_machine_is_disk_encryption_set_required            = false               #(Required)Boolean value if disk encryption set is required or not
    linux_virtual_machine_is_storage_blob_required                   = false               #(Required)Boolean value if blob storage is required
    linux_virtual_machine_storage_blob_name                          = null                #Provide blob storage name value if linux_virtual_machine_is_storage_blob_required is set to true.
    linux_virtual_machine_storage_account_name                       = null                #Provide storage account name value if linux_virtual_machine_is_storage_blob_required or linux_virtual_machine_is_boot_diagnostics_required is set to true
    linux_virtual_machine_storage_container_name                     = null                #Provide storage container name value if linux_virtual_machine_is_storage_blob_required is set to true.
    linux_virtual_machine_is_gallery_application_id_required         = false               #(Required)Boolean value if gallery application id is required
    linux_virtual_machine_gallery_application_version_name           = null                #Provide version name if linux_virtual_machine_is_gallery_application_id_required is set to true
    linux_virtual_machine_shared_image_gallery_name                  = null                #Name of the shared image gallery. #Provide value if linux_virtual_machine_is_gallery_application_id_required is set to true
    linux_virtual_machine_gallery_application_name                   = null                #Name of gallery application. #Provide value if linux_virtual_machine_is_gallery_application_id_required is set to true
    linux_virtual_machine_is_capacity_reservation_group_id_required  = false               #(Required)Boolean value if capacity reservation group id is required
    linux_virtual_machine_capacity_reservation_group_name            = null                #Provide capacity reservation group name if linux_virtual_machine_is_capacity_reservation_group_id_required is set to true
    linux_virtual_machine_is_key_vault_certificate_url_required      = false               #(Required)Boolean value if key vault certificate url is required
    linux_virtual_machine_key_vault_certificate_name                 = null                #Provide key vault certificate name if linux_virtual_machine_is_key_vault_certificate_url_required is set to true
    linux_virtual_machine_is_vmss_id_required                        = false               #(Required)Boolean value if VMSS id is required
    linux_virtual_machine_network_interface = {                                            #(Required) Map of object for network interface
      "nic1" = {
        network_interface_name                = "sd-plz-sdlvmfwp01-untrust-nic" #(Required)Name of the network interface
        network_interface_resource_group_name = "sd-plz-connectivity-dr-rg-01"     #(Required)Resource group name of network interface
      },
      "nic2" = {
        network_interface_name                = "sd-plz-sdlvmfwp01-trust-nic" #(Required)Name of the network interface
        network_interface_resource_group_name = "sd-plz-connectivity-dr-rg-01"   #(Required)Resource group name of network interface
      },
      "nic3" = {
        network_interface_name                = "sd-plz-sdlvmfwp01-mgmt-nic" #(Required)Name of the network interface
        network_interface_resource_group_name = "sd-plz-connectivity-dr-rg-01"  #(Required)Resource group name of network interface
      }
    }
    linux_virtual_machine_is_secret_required                                     = false                 #(Required)Boolean value if secret is required or not
    linux_virtual_machine_disk_encryption_set_name                               = null                  #Name of the disk encryption set. Provide value if linux_virtual_machine_is_disk_encryption_set_required is set to true
    linux_virtual_machine_is_boot_diagnostics_required                           = false                 #(Required)Boolean value if boot diagnostics required
    linux_virtual_machine_bypass_platform_safety_checks_on_user_schedule_enabled = false                 #(Optional) Specifies whether to skip platform scheduled patching when a user schedule is associated with the VM. Defaults to false.Can only be set to true when patch_mode is set to AutomaticByPlatform.
    linux_virtual_machine_is_availability_set_id_required                        = false                 #(Required)Boolean value if availability set id required
    linux_virtual_machine_is_proximity_placement_group_id_required               = false                 #(Required)Boolean value if proximity placement group id required
    linux_virtual_machine_reboot_setting                                         = null                  # (Optional) Specifies the reboot setting for platform scheduled patching. Possible values are Always, IfRequired and Never. can only be set when patch_mode is set to AutomaticByPlatform.
    linux_virtual_machine_is_dedicated_host_group_id_required                    = false                 #(Required)Boolean value if dedicated host group id required
    linux_virtual_machine_is_dedicated_host_id_required                          = false                 #(Required)Boolean value if dedicated host id required
    linux_virtual_machine_deploy_vm_using_source_image_reference                 = true                  #(Required)Boolean value if VM should be deployed using source image reference
    linux_virtual_machine_availability_set_name                                  = null                  # Provide availability set name if linux_virtual_machine_is_availability_set_id_required is set true
    linux_virtual_machine_availability_set_resource_group_name                   = null                  # Provide availability set resource group name if linux_virtual_machine_is_availability_set_id_required is set true
    linux_virtual_machine_dedicated_host_group_name                              = null                  # Provide host group name if linux_virtual_machine_is_dedicated_host_group_id_required is set true
    linux_virtual_machine_dedicated_host_group_resource_group_name               = null                  # Provide host group resource group name if linux_virtual_machine_is_dedicated_host_group_id_required is set true
    linux_virtual_machine_dedicated_host_name                                    = null                  # Provide host name if linux_virtual_machine_is_dedicated_host_id_required is set true
    linux_virtual_machine_dedicated_host_resource_group_name                     = null                  # Provide host resource group name if linux_virtual_machine_is_dedicated_host_id_required is set true
    linux_virtual_machine_proximity_placement_group_name                         = null                  # Provide proximity palcement group name if linux_virtual_machine_is_proximity_placement_group_id_required is set true
    linux_virtual_machine_proximity_placement_group_resource_group_name          = null                  # Provide proximity palcement group resource group name if linux_virtual_machine_is_proximity_placement_group_id_required is set true
    linux_virtual_machine_generated_admin_password_secret_name                   = "SDLVMFWP01-password" #Provide Key vault secret name to store random password if linux_virtual_machine_generate_new_admin_password is true
    linux_virtual_machine_generated_admin_password_secret_expiration_date        = null
    linux_virtual_machine_generated_admin_password_secret_content_type           = null
    linux_virtual_machine_existing_admin_password_secret_name                    = null                   #Provide Key vault secret name where the existing password exists if linux_virtual_machine_generate_new_admin_password is false
    linux_virtual_machine_virtual_machine_scale_set_name                         = null                   #Provide Vm scale set name if linux_virtual_machine_is_vmss_id_required is true
    linux_virtual_machine_virtual_machine_scale_set_resource_group_name          = null                   #Provide VM scale set resource group name if linux_virtual_machine_is_vmss_id_required is true
    linux_virtual_machine_source_image_type                                      = "PlatformImage"        #Provide image type if linux_virtual_machine_deploy_vm_using_source_image_reference is set to false. If you are using existing vm image make image type as "VMImage" if you are using share image give as "SharedImage"
    linux_virtual_machine_shared_image_name                                      = null                   #Provide image name if linux_virtual_machine_source_image_type is "SharedImage"
    linux_virtual_machine_shared_image_resource_group_name                       = null                   #Provide image resource group name if linux_virtual_machine_source_image_type is "SharedImage"
    linux_virtual_machine_existing_image_name                                    = null                   #Provide image name if linux_virtual_machine_source_image_type is "VMImage"
    linux_virtual_machine_existing_image_resource_group_name                     = null                   #Provide existing image resource group name if image type is "VMImage"
    linux_virtual_machine_admin_key_vault_resource_group_name                    = "sd-plz-management-rg" #Provide key vault resource group name to store credentials
    linux_virtual_machine_storage_account_resource_group_name                    = null                   #Provide value if linux_virtual_machine_is_boot_diagnostics_required is set to true
    linux_virtual_machine_disk_encryption_set_resource_group_name                = null                   #Resource group name of the disk encryption set. Provide value if linux_virtual_machine_is_disk_encryption_set_required is set to true
    linux_virtual_machine_existing_admin_username_secret_name                    = null                   #Provide Key vault secret name to store admin username. Provide value if linux_virtual_machine_use_existing_vm_username is set to true.
  },
  "linux_virtual_machine_2" = {
    linux_virtual_machine_admin_username = "palovm2"       #(Required) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created.
    linux_virtual_machine_location       = "South India" #(Required) The Azure location where the Linux Virtual Machine should exist. Changing this forces a new resource to be created.
    linux_virtual_machine_license_type   = null            #(Optional) Specifies the BYOL Type for this Virtual Machine. Possible values are RHEL_BYOS and SLES_BYOS.
    linux_virtual_machine_name           = "SDLVMFWP02"    #(Required) The name of the Linux Virtual Machine. Changing this forces a new resource to be created.
    linux_virtual_machine_os_disk = {                      #(Required) A os_disk block as defined below.
      os_disk_caching              = null                  #(Required) The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite.
      os_disk_storage_account_type = "Standard_LRS"        #(Required) The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS. Changing this forces a new resource to be created.
      os_disk_diff_disk_settings = {                       #(Optional) A diff_disk_settings block as defined above. Changing this forces a new resource to be created.
        diff_disk_settings_option    = "Local"             # (Required) Specifies the Ephemeral Disk Settings for the OS Disk. At this time the only possible value is Local. Changing this forces a new resource to be created.
        diff_disk_settings_placement = null                #(Optional) Specifies where to store the Ephemeral Disk. Possible values are CacheDisk and ResourceDisk. Defaults to CacheDisk. Changing this forces a new resource to be created.
      }
      os_disk_disk_size_gb              = 120                  #(Optional) The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from.
      os_disk_name                      = "SDLVMFWP02-disk-01" #(Optional) The name which should be used for the Internal OS Disk. Changing this forces a new resource to be created.
      os_disk_security_encryption_type  = null                 #(Optional) Encryption Type when the Virtual Machine is a Confidential VM. Possible values are VMGuestStateOnly and DiskWithVMGuestState. Changing this forces a new resource to be created.
      os_disk_write_accelerator_enabled = false                #(Optional) Should Write Accelerator be Enabled for this OS Disk? Defaults to false.
    }
    linux_virtual_machine_resource_group_name = "sd-plz-connectivity-dr-rg-01" #(Required) The name of the Resource Group in which the Linux Virtual Machine should be exist. Changing this forces a new resource to be created.
    linux_virtual_machine_size                = "Standard_D3_v2"            #(Required) The SKU which should be used for this Virtual Machine, such as Standard_F2.
    linux_virtual_machine_additional_capabilities = {                       #(Optional) A additional_capabilities block as defined below.
      additional_capabilities_ultra_ssd_enabled = false                     #(Optional) Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine? Defaults to false.
    }
    linux_virtual_machine_allow_extension_operations            = false #(Optional) Should Extension Operations be allowed on this Virtual Machine?
    linux_virtual_machine_boot_diagnostics_storage_account_name = null  # Provide storage account name value if linux_virtual_machine_is_storage_blob_required or linux_virtual_machine_is_boot_diagnostics_required is set to true
    linux_virtual_machine_computer_name                         = null  #(Optional) Specifies the Hostname which should be used for this Virtual Machine. If unspecified this defaults to the value for the name field. If the value of the name field is not a valid computer_name, then you must specify computer_name. Changing this forces a new resource to be created.
    linux_virtual_machine_custom_data                           = null  #(Optional) The Base64-Encoded Custom Data which should be used for this Virtual Machine. Changing this forces a new resource to be created.
    linux_virtual_machine_disable_password_authentication       = false #(Optional) Should Password Authentication be disabled on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created.
    linux_virtual_machine_edge_zone                             = null  #(Optional) Specifies the Edge Zone within the Azure Region where this Linux Virtual Machine should exist. Changing this forces a new Linux Virtual Machine to be created.
    linux_virtual_machine_encryption_at_host_enabled            = false #(Optional) Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?
    linux_virtual_machine_eviction_policy                       = null  #(Optional) Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance. Possible values are Deallocate and Delete. Changing this forces a new resource to be created.
    linux_virtual_machine_extensions_time_budget                = null  #(Optional) Specifies the duration allocated for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. Defaults to 90 minutes (PT1H30M).
    linux_virtual_machine_gallery_application                   = null  #(Optional) A gallery_application block as defined below.
    /* Sample Code {
      #gallery_application_configuration_blob_uri = string                               #(Optional) Specifies the URI to an Azure Blob that will replace the default configuration for the package if provided.
      gallery_application_order                  = 1                               #(Optional) Specifies the order in which the packages have to be installed. Possible values are between 0 and 2,147,483,647.
      gallery_application_tag                    = null                               #(Optional) Specifies a passthrough value for more generic context. This field can be any valid string value.
    }  */
    linux_virtual_machine_identity = {                                  #(Optional)
      identity_type                                  = "SystemAssigned" #(Required) The type of Managed Service Identity that is configured on this Disk Encryption Set. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      linux_virtual_machine_user_assigned_identities = null /* [{
        user_assigned_identities_name                = "puai000001" #(Required)Name of the user assigned identity
        user_assigned_identities_resource_group_name = "prg000001"  #(Required)Resource group name of the user assigned identity
      }]*/
    }
    linux_virtual_machine_patch_assessment_mode = null           #(Optional) Specifies the mode of VM Guest Patching for the Virtual Machine. Possible values are AutomaticByPlatform or ImageDefault. Defaults to ImageDefault.
    linux_virtual_machine_patch_mode            = "ImageDefault" # (Optional) Specifies the mode of in-guest patching to this Linux Virtual Machine. Possible values are AutomaticByPlatform and ImageDefault. Defaults to ImageDefault. For more information on patch modes please see the product documentation.
    linux_virtual_machine_max_bid_price         = "-1"           #(Optional) The maximum price you're willing to pay for this Virtual Machine, in US Dollars; which must be greater than the current spot price. If this bid price falls below the current spot price the Virtual Machine will be evicted using the eviction_policy. Defaults to -1, which means that the Virtual Machine should not be evicted for price reasons.
    linux_virtual_machine_plan = [{
      plan_name      = "byol"             #(Required) Specifies the Name of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
      plan_product   = "panorama"         #(Required) Specifies the Product of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
      plan_publisher = "paloaltonetworks" #(Optional) A plan block as defined below. Changing this forces a new resource to be created.
    }]
    linux_virtual_machine_platform_fault_domain = null      #(Optional) Specifies the Platform Fault Domain in which this Linux Virtual Machine should be created. Defaults to -1, which means this will be automatically assigned to a fault domain that best maintains balance across the available fault domains. Changing this forces a new Linux Virtual Machine to be created.
    linux_virtual_machine_priority              = "Regular" #(Optional) Specifies the priority of this Virtual Machine. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created.
    linux_virtual_machine_provision_vm_agent    = false     #(Optional) Should the Azure VM Agent be provisioned on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created.
    linux_virtual_machine_secure_boot_enabled   = false     #(Optional) Specifies whether secure boot should be enabled on the virtual machine. Changing this forces a new resource to be created.
    linux_virtual_machine_source_image_reference = {        #Optional) A source_image_reference block as defined below. Changing this forces a new resource to be created.
      source_image_reference_publisher = "paloaltonetworks" #(Optional) Specifies the publisher of the image used to create the virtual machines.
      source_image_reference_offer     = "panorama"         #(Optional) Specifies the offer of the image used to create the virtual machines.
      source_image_reference_sku       = "byol"             #(Optional) Specifies the SKU of the image used to create the virtual machines.
      source_image_reference_version   = "latest"           #(Optional) Specifies the version of the image used to create the virtual machines.
    }
    linux_virtual_machine_termination_notification = null /* [{ #(Optional) A termination_notification block as defined below.
      termination_notification_enabled = true           #(Required) Should the termination notification be enabled on this Virtual Machine? Defaults to false.
      termination_notification_timeout = "PT10M"        #(Optional) Length of time (in minutes, between 5 and 15) a notification to be sent to the VM on the instance metadata server till the VM gets deleted. The time duration should be specified in ISO 8601 format.
    }]*/
    linux_virtual_machine_user_data                = null  #(Optional) The Base64-Encoded User Data which should be used for this Virtual Machine.
    linux_virtual_machine_vtpm_enabled             = false #(Optional) Specifies whether vTPM should be enabled on the virtual machine. Changing this forces a new resource to be created.
    linux_virtual_machine_zone                     = null  #(Optional) Specifies the Availability Zones in which this Linux Virtual Machine should be located. Changing this forces a new Linux Virtual Machine to be created.
    linux_virtual_machine_tags = {
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DR",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }

    linux_virtual_machine_use_existing_vm_username                   = false             #(Required)should be set true if existing user name is used
    linux_virtual_machine_generate_new_admin_password                = true              #(Required)admin_password should be generated if disable_password_authentication is false
    linux_virtual_machine_generate_new_ssh_key                       = true              #(Required)Should be true/false if linux_virtual_machine_disable_password_authentication is true
    linux_virtual_machine_admin_login_key_vault_name                 = "sdplzmgmtdckv01" #"existingkeyvaultscenario"
    linux_virtual_machine_tls_private_key_algorithm                  = "RSA"             #Provide Algorithm used for TLS private key if linux_virtual_machine_generate_new_ssh_key is true
    linux_virtual_machine_tls_private_key_rsa_bits                   = 2048              #Provide number if bits for TLS private key if linux_virtual_machine_generate_new_ssh_key is true
    linux_virtual_machine_admin_ssh_key_vault_secret_expiration_date = null
    linux_virtual_machine_admin_ssh_key_vault_secret_content_type    = null
    linux_virtual_machine_admin_ssh_key_vault_secret_name            = "SDLVMFWP02-sshkey" #Key vault secret name to store the ssh key if linux_virtual_machine_generate_new_ssh_key is true
    linux_virtual_machine_is_disk_encryption_set_required            = false               #(Required)Boolean value if disk encryption set is required or not
    linux_virtual_machine_is_storage_blob_required                   = false               #(Required)Boolean value if blob storage is required
    linux_virtual_machine_storage_blob_name                          = null                #Provide blob storage name value if linux_virtual_machine_is_storage_blob_required is set to true.
    linux_virtual_machine_storage_account_name                       = null                #Provide storage account name value if linux_virtual_machine_is_storage_blob_required or linux_virtual_machine_is_boot_diagnostics_required is set to true
    linux_virtual_machine_storage_container_name                     = null                #Provide storage container name value if linux_virtual_machine_is_storage_blob_required is set to true.
    linux_virtual_machine_is_gallery_application_id_required         = false               #(Required)Boolean value if gallery application id is required
    linux_virtual_machine_gallery_application_version_name           = null                #Provide version name if linux_virtual_machine_is_gallery_application_id_required is set to true
    linux_virtual_machine_shared_image_gallery_name                  = null                #Name of the shared image gallery. #Provide value if linux_virtual_machine_is_gallery_application_id_required is set to true
    linux_virtual_machine_gallery_application_name                   = null                #Name of gallery application. #Provide value if linux_virtual_machine_is_gallery_application_id_required is set to true
    linux_virtual_machine_is_capacity_reservation_group_id_required  = false               #(Required)Boolean value if capacity reservation group id is required
    linux_virtual_machine_capacity_reservation_group_name            = null                #Provide capacity reservation group name if linux_virtual_machine_is_capacity_reservation_group_id_required is set to true
    linux_virtual_machine_is_key_vault_certificate_url_required      = false               #(Required)Boolean value if key vault certificate url is required
    linux_virtual_machine_key_vault_certificate_name                 = null                #Provide key vault certificate name if linux_virtual_machine_is_key_vault_certificate_url_required is set to true
    linux_virtual_machine_is_vmss_id_required                        = false               #(Required)Boolean value if VMSS id is required
    linux_virtual_machine_network_interface = {                                            #(Required) Map of object for network interface
      "nic1" = {
        network_interface_name                = "sd-plz-sdlvmfwp02-untrust-nic" #(Required)Name of the network interface
        network_interface_resource_group_name = "sd-plz-connectivity-dr-rg-01"     #(Required)Resource group name of network interface
      },
      "nic2" = {
        network_interface_name                = "sd-plz-sdlvmfwp02-trust-nic" #(Required)Name of the network interface
        network_interface_resource_group_name = "sd-plz-connectivity-dr-rg-01"   #(Required)Resource group name of network interface
      },
      "nic3" = {
        network_interface_name                = "sd-plz-sdlvmfwp02-mgmt-nic" #(Required)Name of the network interface
        network_interface_resource_group_name = "sd-plz-connectivity-dr-rg-01"  #(Required)Resource group name of network interface
      }
    }
    linux_virtual_machine_is_secret_required                                     = false                 #(Required)Boolean value if secret is required or not
    linux_virtual_machine_disk_encryption_set_name                               = null                  #Name of the disk encryption set. Provide value if linux_virtual_machine_is_disk_encryption_set_required is set to true
    linux_virtual_machine_is_boot_diagnostics_required                           = false                 #(Required)Boolean value if boot diagnostics required
    linux_virtual_machine_bypass_platform_safety_checks_on_user_schedule_enabled = false                 #(Optional) Specifies whether to skip platform scheduled patching when a user schedule is associated with the VM. Defaults to false.Can only be set to true when patch_mode is set to AutomaticByPlatform.
    linux_virtual_machine_is_availability_set_id_required                        = false                 #(Required)Boolean value if availability set id required
    linux_virtual_machine_is_proximity_placement_group_id_required               = false                 #(Required)Boolean value if proximity placement group id required
    linux_virtual_machine_reboot_setting                                         = null                  # (Optional) Specifies the reboot setting for platform scheduled patching. Possible values are Always, IfRequired and Never. can only be set when patch_mode is set to AutomaticByPlatform.
    linux_virtual_machine_is_dedicated_host_group_id_required                    = false                 #(Required)Boolean value if dedicated host group id required
    linux_virtual_machine_is_dedicated_host_id_required                          = false                 #(Required)Boolean value if dedicated host id required
    linux_virtual_machine_deploy_vm_using_source_image_reference                 = true                  #(Required)Boolean value if VM should be deployed using source image reference
    linux_virtual_machine_availability_set_name                                  = null                  # Provide availability set name if linux_virtual_machine_is_availability_set_id_required is set true
    linux_virtual_machine_availability_set_resource_group_name                   = null                  # Provide availability set resource group name if linux_virtual_machine_is_availability_set_id_required is set true
    linux_virtual_machine_dedicated_host_group_name                              = null                  # Provide host group name if linux_virtual_machine_is_dedicated_host_group_id_required is set true
    linux_virtual_machine_dedicated_host_group_resource_group_name               = null                  # Provide host group resource group name if linux_virtual_machine_is_dedicated_host_group_id_required is set true
    linux_virtual_machine_dedicated_host_name                                    = null                  # Provide host name if linux_virtual_machine_is_dedicated_host_id_required is set true
    linux_virtual_machine_dedicated_host_resource_group_name                     = null                  # Provide host resource group name if linux_virtual_machine_is_dedicated_host_id_required is set true
    linux_virtual_machine_proximity_placement_group_name                         = null                  # Provide proximity palcement group name if linux_virtual_machine_is_proximity_placement_group_id_required is set true
    linux_virtual_machine_proximity_placement_group_resource_group_name          = null                  # Provide proximity palcement group resource group name if linux_virtual_machine_is_proximity_placement_group_id_required is set true
    linux_virtual_machine_generated_admin_password_secret_name                   = "SDLVMFWP02-password" #Provide Key vault secret name to store random password if linux_virtual_machine_generate_new_admin_password is true
    linux_virtual_machine_generated_admin_password_secret_expiration_date        = null
    linux_virtual_machine_generated_admin_password_secret_content_type           = null
    linux_virtual_machine_existing_admin_password_secret_name                    = null                   #Provide Key vault secret name where the existing password exists if linux_virtual_machine_generate_new_admin_password is false
    linux_virtual_machine_virtual_machine_scale_set_name                         = null                   #Provide Vm scale set name if linux_virtual_machine_is_vmss_id_required is true
    linux_virtual_machine_virtual_machine_scale_set_resource_group_name          = null                   #Provide VM scale set resource group name if linux_virtual_machine_is_vmss_id_required is true
    linux_virtual_machine_source_image_type                                      = "PlatformImage"        #Provide image type if linux_virtual_machine_deploy_vm_using_source_image_reference is set to false. If you are using existing vm image make image type as "VMImage" if you are using share image give as "SharedImage"
    linux_virtual_machine_shared_image_name                                      = null                   #Provide image name if linux_virtual_machine_source_image_type is "SharedImage"
    linux_virtual_machine_shared_image_resource_group_name                       = null                   #Provide image resource group name if linux_virtual_machine_source_image_type is "SharedImage"
    linux_virtual_machine_existing_image_name                                    = null                   #Provide image name if linux_virtual_machine_source_image_type is "VMImage"
    linux_virtual_machine_existing_image_resource_group_name                     = null                   #Provide existing image resource group name if image type is "VMImage"
    linux_virtual_machine_admin_key_vault_resource_group_name                    = "sd-plz-management-rg" #Provide key vault resource group name to store credentials
    linux_virtual_machine_storage_account_resource_group_name                    = null                   #Provide value if linux_virtual_machine_is_boot_diagnostics_required is set to true
    linux_virtual_machine_disk_encryption_set_resource_group_name                = null                   #Resource group name of the disk encryption set. Provide value if linux_virtual_machine_is_disk_encryption_set_required is set to true
    linux_virtual_machine_existing_admin_username_secret_name                    = null                   #Provide Key vault secret name to store admin username. Provide value if linux_virtual_machine_use_existing_vm_username is set to true.
  }
}


#SOURCE VIRTUAL NETWORK PEERING
source_virtual_network_peering_variables = {
  "source_virtual_network_peering_1" = {
    virtual_network_peering_name                             = "sd-plz-Connectivity-Hub-VNET-sd-plz-management-vnet" # (Required) The name of the source virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_destination_resource_group_name  = "sd-plz-management-rg"                                # (Required) The name of the destination virtual network resource group and in which to create the virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_destination_virtual_network_name = "sd-plz-management-vnet"                              # (Required) The name of the destination virtual network name.
    virtual_network_peering_resource_group_name              = "sd-plz-connectivity-dr-rg-01"                           # (Required) The name of the source virtual network resource group and in which to create the virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_virtual_network_name             = "sd-plz-Connectivity-Hub-VNET"                        # (Required) The name of the source virtual network name.
    virtual_network_peering_allow_virtual_network_access     = true                                                  # (Optional) Controls if the VMs in the remote virtual network can access VMs in the local virtual network. Defaults to true.
    virtual_network_peering_allow_forwarded_traffic          = true                                                  # (Optional) Controls if forwarded traffic from VMs in the remote virtual network is allowed. Defaults to false.
    virtual_network_peering_use_remote_gateways              = false                                                 #  (Optional) Controls if remote gateways can be used on the local virtual network. If the flag is set to true, and allow_gateway_transit on the remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway. Defaults to false.
    virtual_network_peering_allow_gateway_transit            = false                                                 # (Optional) Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network.
    virtual_network_peering_triggers                         = null                                                  # (Optional) A mapping of key values pairs that can be used to sync network routes from the remote virtual network to the local virtual network. See the trigger example for an example on how to set it up.
  }
}

#DESTINATION VIRTUAL NETWORK PEERING
destination_virtual_network_peering_variables = {
  "destination_virtual_network_peering_1" = {
    virtual_network_peering_name                             = "sd-plz-management-vnet-sd-plz-Connectivity-Hub-VNET" # (Required) The name of the source virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_destination_resource_group_name  = "sd-plz-connectivity-dr-rg-01"                           # (Required) The name of the destination virtual network resource group and in which to create the virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_destination_virtual_network_name = "sd-plz-Connectivity-Hub-VNET"                        # (Required) The name of the destination virtual network name.
    virtual_network_peering_resource_group_name              = "sd-plz-management-rg"                                # (Required) The name of the source virtual network resource group and in which to create the virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_virtual_network_name             = "sd-plz-management-vnet"                              # (Required) The name of the source virtual network name.
    virtual_network_peering_allow_virtual_network_access     = true                                                  # (Optional) Controls if the VMs in the remote virtual network can access VMs in the local virtual network. Defaults to true.
    virtual_network_peering_allow_forwarded_traffic          = true                                                  # (Optional) Controls if forwarded traffic from VMs in the remote virtual network is allowed. Defaults to false.
    virtual_network_peering_use_remote_gateways              = false                                                 #  (Optional) Controls if remote gateways can be used on the local virtual network. If the flag is set to true, and allow_gateway_transit on the remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway. Defaults to false.
    virtual_network_peering_allow_gateway_transit            = true                                                  # (Optional) Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network.
    virtual_network_peering_triggers                         = null                                                  # (Optional) A mapping of key values pairs that can be used to sync network routes from the remote virtual network to the local virtual network. See the trigger example for an example on how to set it up.
  }
}

#PUBLIC IP
public_ip_variables = {
  "public_ip_1" = {
    public_ip_name                                     = "sd-plz-connectivity-pip-agw-01" # (Required) Specifies the name of the Public IP. 
    public_ip_resource_group_name                      = "sd-plz-connectivity-dr-rg-01"      # (Required) The name of the Resource Group where this Public IP should exist. 
    public_ip_location                                 = "South India"                  # (Required) Specifies the supported Azure location where the Public IP should exist. 
    public_ip_ip_version                               = "IPv4"                           # (Optional) The IP Version to use, IPv6 or IPv4.
    public_ip_allocation_method                        = "Static"                         # (Required) Defines the allocation method for this IP address. Possible values are Static or Dynamic.
    public_ip_sku                                      = "Standard"                       # (Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic.
    public_ip_sku_tier                                 = "Regional"                       # (Optional) The SKU Tier that should be used for the Public IP. Possible values are Regional and Global. Defaults to Regional.
    public_ip_domain_name_label                        = null                             # (Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system.
    public_ip_prefix_id                                = null                             #  (Optional) If specified then public IP address allocated will be provided from the public IP prefix resource.
    public_ip_idle_timeout_in_minutes                  = "30"                             # (Optional) Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes.
    public_ip_zones                                    = null                             # (Optional) A collection containing the availability zone to allocate the Public IP in.
    public_ip_edge_zone                                = null                             # (Optional) Specifies the Edge Zone within the Azure Region where this Public IP should exist. 
    public_ip_reverse_fqdn                             = null                             # (Optional) A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN.
    public_ip_ip_tags                                  = null                             # (Optional) A mapping of IP tags to assign to the public IP.
    public_ip_is_ddos_protection_plan_enabled          = false                            # (Required) True if ddos_protection_plan enabled, else false
    public_ip_ddos_protection_plan_name                = null                             # (Optional) The Name of DDoS protection plan associated with the public IP.
    public_ip_ddos_protection_plan_resource_group_name = null                             # (Optional) The Resource group name of DDoS protection plan associated with the public IP.
    public_ip_ddos_protection_mode                     = null                             # (Optional) The DDoS protection mode of the public IP. Possible values are Disabled, Enabled, and VirtualNetworkInherited. Defaults to VirtualNetworkInherited.
    public_ip_tags = {                                                                    # (Optional) Public IP tags
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DR",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  },
  "public_ip_2" = {
    public_ip_name                                     = "sd-plz-connectivity-pip-natgw-01" # (Required) Specifies the name of the Public IP. 
    public_ip_resource_group_name                      = "sd-plz-connectivity-dr-rg-01"        # (Required) The name of the Resource Group where this Public IP should exist. 
    public_ip_location                                 = "South India"                    # (Required) Specifies the supported Azure location where the Public IP should exist. 
    public_ip_ip_version                               = "IPv4"                             # (Optional) The IP Version to use, IPv6 or IPv4.
    public_ip_allocation_method                        = "Static"                           # (Required) Defines the allocation method for this IP address. Possible values are Static or Dynamic.
    public_ip_sku                                      = "Standard"                         # (Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic.
    public_ip_sku_tier                                 = "Regional"                         # (Optional) The SKU Tier that should be used for the Public IP. Possible values are Regional and Global. Defaults to Regional.
    public_ip_domain_name_label                        = null                               # (Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system.
    public_ip_prefix_id                                = null                               #  (Optional) If specified then public IP address allocated will be provided from the public IP prefix resource.
    public_ip_idle_timeout_in_minutes                  = "30"                               # (Optional) Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes.
    public_ip_zones                                    = null                            # (Optional) A collection containing the availability zone to allocate the Public IP in.
    public_ip_edge_zone                                = null                               # (Optional) Specifies the Edge Zone within the Azure Region where this Public IP should exist. 
    public_ip_reverse_fqdn                             = null                               # (Optional) A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN.
    public_ip_ip_tags                                  = null                               # (Optional) A mapping of IP tags to assign to the public IP.
    public_ip_is_ddos_protection_plan_enabled          = false                              # (Required) True if ddos_protection_plan enabled, else false
    public_ip_ddos_protection_plan_name                = null                               # (Optional) The Name of DDoS protection plan associated with the public IP.
    public_ip_ddos_protection_plan_resource_group_name = null                               # (Optional) The Resource group name of DDoS protection plan associated with the public IP.
    public_ip_ddos_protection_mode                     = null                               # (Optional) The DDoS protection mode of the public IP. Possible values are Disabled, Enabled, and VirtualNetworkInherited. Defaults to VirtualNetworkInherited.
    public_ip_tags = {                                                                      # (Optional) Public IP tags
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DR",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}

#LB
lb_variables = {
  "lb_1" = {
    lb_edge_zone = null #(Optional) Specifies the Edge Zone within the Azure Region where this Load Balancer should exist. Changing this forces a new Load Balancer to be created.
    lb_frontend_ip_configuration = {
      "config1" = {
        frontend_ip_configuration_gateway_lb_frontend_ip_configuration_id = { #(Optional) The Frontend IP Configuration ID of a Gateway SKU Load Balancer.
          gateway_lb_name                = null                               # gateway load balancer name
          gateway_lb_resource_group_name = null                               # gateway load balancer resource group name
        }
        frontend_ip_configuration_name                          = "frontend-ip-config" #(Required) Specifies the name of the frontend IP configuration.
        frontend_ip_configuration_private_ip_address            = null                 # (Optional) Private IP Address to assign to the Load Balancer. The last one and first four IPs in any range are reserved and cannot be manually assigned.
        frontend_ip_configuration_private_ip_address_allocation = null                 #(Optional) The allocation method for the Private IP Address used by this Load Balancer. Possible values as Dynamic and Static.
        frontend_ip_configuration_private_ip_address_version    = null                 #The version of IP that the Private IP Address is. Possible values are IPv4 or IPv6.
        frontend_ip_configuration_public_ip_address_id = {                             #(Optional) The ID of a Public IP Address which should be associated with the Load Balancer.
          public_ip_name                = null                                         # public ip name
          public_ip_resource_group_name = null                                         # public ip resource group name
        }
        frontend_ip_configuration_public_ip_prefix_id = { #(Optional) The ID of a Public IP Prefix which should be associated with the Load Balancer. Public IP Prefix can only be used with outbound rules.
          public_ip_prefix_name                = null     # public ip prefix name
          public_ip_prefix_resource_group_name = null     # public ip prefix resource group name
        }
        frontend_ip_configuration_subnet = {
          subnet_name                    = "sd-plz-Connectivity-Hub-VNET-FW-Intranet-LB-SNET-01" # Subnet name
          subnet_virtual_network_name    = "sd-plz-Connectivity-Hub-VNET"                        # virtual network name where subnet resides.
          virtual_network_resource_group = "sd-plz-connectivity-dr-rg-01"                           # Resource group name where the virtual network resides.
        }
        frontend_ip_configuration_zones = null #(Optional) Specifies a list of Availability Zones in which the IP Address for this Load Balancer should be located. Changing this forces a new Load Balancer to be created.
      }
    }
    lb_location            = "South India"               # (Required) Specifies the supported Azure Region where the Load Balancer should be created.
    lb_name                = "sd-connectivity-fw-trust-lb" #(Required) Specifies the name of the Load Balancer.
    lb_resource_group_name = "sd-plz-connectivity-dr-rg-01"   # (Required) The name of the Resource Group in which to create the Load Balancer.
    lb_sku                 = "Standard"                    #(Optional) The SKU of the Azure Load Balancer. Accepted values are Basic, Standard and Gateway. Defaults to Basic.
    lb_sku_tier            = "Regional"                    #(Optional) sku_tier - (Optional) The SKU tier of this Load Balancer. Possible values are Global and Regional. Defaults to Regional. Changing this forces a new resource to be created.
    lb_tags = {
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DR",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }

}

#VPN GATEWAY VARIABLES
vpn_gateway_variables = {
  "vpn_gateway_1" = {
    vpn_gateway_name                                  = "ngw000001"                 #(Required) The Name which should be used for this VPN Gateway. Changing this forces a new resource to be created.
    vpn_gateway_location                              = "South India"             #(Required) The Azure location where this VPN Gateway should be created. Changing this forces a new resource to be created.
    vpn_gateway_resource_group_name                   = "sd-plz-connectivity-dr-rg-01" #(Required) The Name of the Resource Group in which this VPN Gateway should be created. Changing this forces a new resource to be created.
    vpn_gateway_virtual_hub_name                      = "hub000001"                 # The Name of the virtual hub
    vpn_gateway_bgp_route_translation_for_nat_enabled = true                        #(Optional) Is BGP route translation for NAT on this VPN Gateway enabled? Defaults to false
    vpn_gateway_bgp_settings_enabled                  = true                        #(Optional) A bgp_settings block as defined below.
    vpn_gateway_bgp_settings = {
      vpn_gateway_bgp_settings_asn                                       = 65515 #(Required) The ASN of the BGP Speaker. Changing this forces a new resource to be created.
      vpn_gateway_bgp_settings_peer_weight                               = 1     #(Required) The weight added to Routes learned from this BGP Speaker. Changing this forces a new resource to be created.
      vpn_gateway_bgp_settings_instance_0_bgp_peering_address_custom_ips = []    #(Optional) An instance_bgp_peering_address block as defined below.
      vpn_gateway_bgp_settings_instance_1_bgp_peering_address_custom_ips = []    #(Optional) An instance_bgp_peering_address block as defined below.
    }
    vpn_gateway_scale_unit         = 1                   #(Optional) The Scale Unit for this VPN Gateway. Defaults to 1.                        
    vpn_gateway_routing_preference = "Microsoft Network" #(Optional) Azure routing preference lets you to choose how your traffic routes between Azure and the internet. You can choose to route traffic either via the Microsoft network (default value, Microsoft Network), or via the ISP network (public internet, set to Internet). More context of the configuration can be found in the Microsoft Docs to create a VPN Gateway. Changing this forces a new resource to be created.
    vpn_gateway_tags = {                                 #(Optional) A mapping of tags to assign to the VPN Gateway.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DR",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}


#NAT GATEWAY
nat_gateway_variables = {
  "nat_gateway_1" = {
    nat_gateway_idle_timeout_in_minutes = "4"                         #(Optional) The idle timeout which should be used in minutes. Defaults to 4.
    nat_gateway_name                    = "sd-connectivity-natgw-01"  #(Required) Specifies the name of the NAT Gateway. Changing this forces a new resource to be created.
    nat_gateway_location                = "South India"             #(Optional) Specifies the supported Azure location where the NAT Gateway should exist. Changing this forces a new resource to be created.
    nat_gateway_resource_group_name     = "sd-plz-connectivity-dr-rg-01" #(Required) Specifies the name of the Resource Group in which the NAT Gateway should exist. Changing this forces a new resource to be created.
    nat_gateway_sku_name                = "Standard"                  #(Optional) The SKU which should be used. At this time the only supported value is Standard. Defaults to Standard.
    nat_gateway_zones                   = null                       #(Optional) Specifies a list of Availability Zones in which this NAT Gateway should be located. Changing this forces a new NAT Gateway to be created.
    nat_gateway_tags = {                                              #(Optional) A mapping of tags to assign to the resource. Changing this forces a new resource to be created.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DR",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}

#NAT GATEWAY PUBLIC IP ASSOCIATION
nat_gateway_public_ip_association_variables = {
  "nat_gateway_public_ip_association_1" = {
    public_ip_name                  = "sd-plz-connectivity-pip-natgw-01" #(Required) Specifies the name of the Public IP.
    public_ip_resource_group_name   = "sd-plz-connectivity-dr-rg-01"        #(Required) The name of the Resource Group where this Public IP should exist.
    nat_gateway_name                = "sd-connectivity-natgw-01"         #(Required) Specifies the name of the NAT Gateway. Changing this forces a new resource to be created.
    nat_gateway_resource_group_name = "sd-plz-connectivity-dr-rg-01"        #(Required) Specifies the name of the Resource Group in which the NAT Gateway should exist.
  }
}

#NETWORK SECURITY GROUP
network_security_group_variables = {
  "network_security_group_1" = {
    network_security_group_name                = "sd-plz-connectivtity-nsg-01" # (Required) Specifies the name of the network security group
    network_security_group_resource_group_name = "sd-plz-connectivity-dr-rg-01"   # (Required) The name of the resource group in which to create the network security group
    network_security_group_location            = "South India"               # (Required) Specifies the supported Azure location where the resource exists
    network_security_group_security_rule = {                                   # (Optional) Map of objects representing security rules
      "nsg_rule_01" = {
        security_rule_name                                           = "nsgrule01"       # (Required) The name of the security rule
        security_rule_application_security_group_resource_group_name = null              # (Optional) The resource group name of the application security group
        security_rule_priority                                       = 100               # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
        security_rule_direction                                      = "Inbound"         # (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.
        security_rule_access                                         = "Deny"            # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.
        security_rule_protocol                                       = "Tcp"             # (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
        security_rule_source_port_range                              = "*"               # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified
        security_rule_source_port_ranges                             = null              # (Optional) List of source ports or port ranges. This is required if source_port_range is not specified
        security_rule_destination_port_range                         = "*"               # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
        security_rule_destination_port_ranges                        = null              # (Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified
        security_rule_source_address_prefix                          = "*"               # (Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified.
        security_rule_source_address_prefixes                        = null              # (Optional) List of source address prefixes. Tags may not be used. This is required if source_address_prefix is not specified.
        security_rule_destination_address_prefix                     = "*"               # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if destination_address_prefixes is not specified.
        security_rule_destination_address_prefixes                   = null              # (Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified.
        security_rule_description                                    = "InboundAllow100" # (Optional) A description for this rule. Restricted to 140 characters
        security_rule_source_application_security_group_names        = null              # (Optional) A List of source Application Security Group names
        security_rule_destination_application_security_group_names   = null              # (Optional) A List of destination Application Security Group names
    } }
    network_security_group_tags = { #(Optional) A mapping of tags which should be assigned to the Network Security Group.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DR",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  },
  "network_security_group_2" = {
    network_security_group_name                = "sd-plz-connectivtity-nsg-02" # (Required) Specifies the name of the network security group
    network_security_group_resource_group_name = "sd-plz-connectivity-dr-rg-01"   # (Required) The name of the resource group in which to create the network security group
    network_security_group_location            = "South India"               # (Required) Specifies the supported Azure location where the resource exists
    network_security_group_security_rule = {                                   # (Optional) Map of objects representing security rules
      "nsg_rule_01" = {
        security_rule_name                                           = "nsgrule01"       # (Required) The name of the security rule
        security_rule_application_security_group_resource_group_name = null              # (Optional) The resource group name of the application security group
        security_rule_priority                                       = 100               # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
        security_rule_direction                                      = "Inbound"         # (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.
        security_rule_access                                         = "Deny"            # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.
        security_rule_protocol                                       = "Tcp"             # (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
        security_rule_source_port_range                              = "*"               # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified
        security_rule_source_port_ranges                             = null              # (Optional) List of source ports or port ranges. This is required if source_port_range is not specified
        security_rule_destination_port_range                         = "*"               # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
        security_rule_destination_port_ranges                        = null              # (Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified
        security_rule_source_address_prefix                          = "*"               # (Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified.
        security_rule_source_address_prefixes                        = null              # (Optional) List of source address prefixes. Tags may not be used. This is required if source_address_prefix is not specified.
        security_rule_destination_address_prefix                     = "*"               # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if destination_address_prefixes is not specified.
        security_rule_destination_address_prefixes                   = null              # (Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified.
        security_rule_description                                    = "InboundAllow100" # (Optional) A description for this rule. Restricted to 140 characters
        security_rule_source_application_security_group_names        = null              # (Optional) A List of source Application Security Group names
        security_rule_destination_application_security_group_names   = null              # (Optional) A List of destination Application Security Group names
    } }
    network_security_group_tags = { #(Optional) A mapping of tags which should be assigned to the Network Security Group.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DR",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}

network_security_group_association_variables = {
  "network_security_group_association_1" = {
    network_interface_security_group_association = [ # (Optional) The block for security group association with network interface
      {
        network_security_group_association_network_interface_name                     = "pnic000001" # (Required) The name of the network interface
        network_security_group_association_network_security_group_name                = "pnsg000001" # (Required) The name of the network security group name to associate with network interface
        network_security_group_association_network_interface_resource_group_name      = "prg000001"  # (Required) The resource group name which contains network interface
        network_security_group_association_network_security_group_resource_group_name = "prg000001"  # (Required) The resource group name which contains security group
      }
    ]
    subnet_security_group_association = null # (Optional) The block for security group association with subnet
  },
  "network_security_group_association_2" = {
    network_interface_security_group_association = null # (Optional) The block for security group association with network interface
    subnet_security_group_association = [
      {
        network_security_group_association_network_security_group_name                = "g000001"     # (Required)  The name of network_security_group_name to assiciate with subnet
        network_security_group_association_network_security_group_resource_group_name = "rg000001"    # (Required) The resource group name of security group.
        network_security_group_association_subnet_name                                = "sn000001"    # (Required) The name subnet which needs to be associated with network security group
        network_security_group_association_virtual_network_name                       = "pvnet000001" # (Required) The name of the virtual network where subnets are created
        network_security_group_association_virtual_network_resource_group_name        = "prg000002"   # (Required) The resource group name of the virtual network
      }
    ]
  },
  "network_security_group_association_3" = {
    network_interface_security_group_association = [
      {
        network_security_group_association_network_interface_name                     = "pnic000002" # (Required) The name of the network interface
        network_security_group_association_network_security_group_name                = "pnsg000002" # (Required) The name of the network security group name to associate with network interface
        network_security_group_association_network_interface_resource_group_name      = "prg000001"  # (Required) The resource group name which contains network interface
        network_security_group_association_network_security_group_resource_group_name = "prg000001"  # (Required) The resource group name which contains security group
      }
    ],
    subnet_security_group_association = [
      {
        network_security_group_association_network_security_group_name                = "pnsg000002"  # (Required)  The name of network_security_group_name to assiciate with subnet
        network_security_group_association_network_security_group_resource_group_name = "prg000001"   # (Required) The resource group name of security group.
        network_security_group_association_subnet_name                                = "psn000002"   # (Required) The name subnet which needs to be associated with network security group
        network_security_group_association_virtual_network_name                       = "pvnet000001" # (Required) The name of the virtual network where subnets are created
        network_security_group_association_virtual_network_resource_group_name        = "prg000002"   # (Required) The resource group name of the virtual network
      }
    ]
  }
}



