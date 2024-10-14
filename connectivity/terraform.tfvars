# Connectivity Subscription 

#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "sd-plz-connectivity-rg-01" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location = "Central India"             #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_managed_by = null #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
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
    virtual_network_name                    = "sd-plz-Connectivity-Hub-VNET"                                                                                                                                                                                                         #(Required) The name of the virtual network.
    virtual_network_location                = "Central India"                                                                                                                                                                                                                        #(Required) The location/region where the virtual network is created.
    virtual_network_resource_group_name     = "sd-plz-connectivity-rg-01"                                                                                                                                                                                                            #(Required) The name of the resource group in which to create the virtual network.
    virtual_network_address_space           = ["10.248.6.0/24", "10.248.7.0/24", "10.248.8.0/24", "10.248.9.0/24", "10.248.10.0/24", "10.248.11.0/24", "10.248.12.0/24", "10.248.13.0/24", "10.248.14.0/24", "10.248.15.0/24", "10.248.16.0/24", "10.248.17.0/24", "10.248.18.0/24"] #(Required) The address space that is used the virtual network.
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
      Environment    = "PLZ-DC",
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
    subnet_name                                          = "sd-plz-Connectivity-Hub-VNET-NAT-SNET-01" # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "sd-plz-connectivity-rg-01"                #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.248.6.0/26"]                          #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "sd-plz-Connectivity-Hub-VNET"             #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
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
    subnet_name                                          = "sd-plz-Connectivity-Hub-VNET-FW-Mgmt-SNET-01" # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "sd-plz-connectivity-rg-01"                    #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.248.7.128/27"]                            #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "sd-plz-Connectivity-Hub-VNET"                 #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
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
    subnet_name                                          = "sd-plz-Connectivity-Hub-VNET-FW-UnTrust-SNET-01" # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "sd-plz-connectivity-rg-01"                       #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.248.7.0/26"]                                 #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "sd-plz-Connectivity-Hub-VNET"                    #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
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
    subnet_name                                          = "sd-plz-Connectivity-Hub-VNET-FW-UnTrust-SNET-02" # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "sd-plz-connectivity-rg-01"                       #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.248.7.64/26"]                                #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "sd-plz-Connectivity-Hub-VNET"                    #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
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
    subnet_name                                          = "ssd-plz-Connectivity-Hub-VNET-FW-Trust-SNET-01" # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "sd-plz-connectivity-rg-01"                      #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.248.8.0/26"]                                #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "sd-plz-Connectivity-Hub-VNET"                   #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
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
    subnet_name                                          = "sd-plz-Connectivity-Hub-VNET-FW-Trust-SNET-02" # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "sd-plz-connectivity-rg-01"                     #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.248.8.64/26"]                              #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "sd-plz-Connectivity-Hub-VNET"                  #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
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
    subnet_name                                          = "sd-plz-Connectivity-Hub-VNET-FW-Intranet-LB-SNET-01" # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "sd-plz-connectivity-rg-01"                           #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.248.9.0/27"]                                     #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "sd-plz-Connectivity-Hub-VNET"                        #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled = null                                                  # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled     = null                                                  # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_service_endpoint_policy_ids                   = null                                                  #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                             = null                                                  #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation                                           = null /* [{
      delegation_name            = "delegation000001"                                                                                                                                                                                                #(Required) A name for this delegation.
      service_delegation_name    = "Microsoft.Sql/managedInstances"                                                                                                                                                                                  # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"] #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }]*/
  },
  "subnet_8" = {
    subnet_name                                          = "sd-plz-Connectivity-Hub-VNET-AGW-SNET-01" # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "sd-plz-connectivity-rg-01"                #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.248.10.0/24"]                         #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "sd-plz-Connectivity-Hub-VNET"             #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
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
  "subnet_9" = {
    subnet_name                                          = "GatewaySubnet"                # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "sd-plz-connectivity-rg-01"    #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.248.11.0/26"]             #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "sd-plz-Connectivity-Hub-VNET" #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled = null                           # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled     = null                           # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_service_endpoint_policy_ids                   = null                           #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                             = null                           #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation                                           = null /* [{
      delegation_name            = "delegation000001"                                                                                                                                                                                                #(Required) A name for this delegation.
      service_delegation_name    = "Microsoft.Sql/managedInstances"                                                                                                                                                                                  # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"] #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }]*/
  },
  "subnet_10" = {
    subnet_name                                          = "sd-plz-Connectivity-Hub-VNET-APIM-SNET-01" # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "sd-plz-connectivity-rg-01"                 #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.248.12.0/24"]                          #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "sd-plz-Connectivity-Hub-VNET"              #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled = null                                        # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled     = null                                        # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_service_endpoint_policy_ids                   = null                                        #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                             = null                                        #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
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
    network_interface_name                          = "sd-plz-palovm1-untrust-nic-01" #The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_location                      = "Central India"          #The location where the Network Interface should exist. Changing this forces a new resource to be created.
    network_interface_resource_group_name           = "sd-plz-connectivity-rg-01"  #The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.
    network_interface_auxiliary_mode                = null         # (Optional) Specifies the auxiliary mode used to enable network high-performance feature on Network Virtual Appliances (NVAs). Possible values are AcceleratedConnections and Floating.
    network_interface_auxiliary_sku                 = null              # (Optional) Specifies the SKU used for the network high-performance feature on Network Virtual Appliances (NVAs). Possible values are A1, A2, A4 and A8.
    network_interface_dns_servers                   = []                 #if provided, it will override the DNS server value defined in vnet module
    network_interface_edge_zone                     = null               #Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created
    network_interface_enable_ip_forwarding          = false              #Enable only if IP Forwarding is required
    network_interface_enable_accelerated_networking = false              #Enable only if accelerated networking is required
    network_interface_internal_dns_label            = null               #The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.
    network_interface_ip_configuration = {
      "ip_configuration_1" = {
        ip_configuration_name                          = "privateconfig1" #A name used for this IP Configuration. Changing this forces a new resource to be created
        ip_configuration_private_ip_address_allocation = "Dynamic"                  #Possible values are Dynamic and Static
        #ip_configuration_private_ip_address            = "10.0.3.11"                #When private_ip_address_allocation is set to Static, The Static IP Address which should be used
        ip_configuration_private_ip_address         = null
        ip_configuration_private_ip_address_version = "IPv4" #The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.
        ip_configuration_subnet = ({
          subnet_virtual_network_name                = "sd-plz-Connectivity-Hub-VNET"   #When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID
          subnet_name                                = "sd-plz-Connectivity-Hub-VNET-FW-UnTrust-SNET-01" #When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID
          subnet_virtual_network_resource_group_name = "sd-plz-connectivity-rg-01"     #When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID
        })
        ip_configuration_public_ip = null
        ip_configuration_primary = true #Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false.Must be true for the first ip_configuration when multiple are specified
        ip_configuration_load_balancer = null
      }
    }
    network_interface_tags = { #(Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  },
  "network_interface_2" = {
    network_interface_name                          = "sd-plz-palovm1-trust-nic-02" #The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_location                      = "Central India"          #The location where the Network Interface should exist. Changing this forces a new resource to be created.
    network_interface_resource_group_name           = "sd-plz-connectivity-rg-01"  #The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.
    network_interface_auxiliary_mode                = null         # (Optional) Specifies the auxiliary mode used to enable network high-performance feature on Network Virtual Appliances (NVAs). Possible values are AcceleratedConnections and Floating.
    network_interface_auxiliary_sku                 = null              # (Optional) Specifies the SKU used for the network high-performance feature on Network Virtual Appliances (NVAs). Possible values are A1, A2, A4 and A8.
    network_interface_dns_servers                   = []                 #if provided, it will override the DNS server value defined in vnet module
    network_interface_edge_zone                     = null               #Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created
    network_interface_enable_ip_forwarding          = false              #Enable only if IP Forwarding is required
    network_interface_enable_accelerated_networking = false              #Enable only if accelerated networking is required
    network_interface_internal_dns_label            = null               #The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.
    network_interface_ip_configuration = {
      "ip_configuration_1" = {
        ip_configuration_name                          = "privateconfig1" #A name used for this IP Configuration. Changing this forces a new resource to be created
        ip_configuration_private_ip_address_allocation = "Dynamic"                  #Possible values are Dynamic and Static
        #ip_configuration_private_ip_address            = "10.0.3.11"                #When private_ip_address_allocation is set to Static, The Static IP Address which should be used
        ip_configuration_private_ip_address         = null
        ip_configuration_private_ip_address_version = "IPv4" #The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.
        ip_configuration_subnet = ({
          subnet_virtual_network_name                = "sd-plz-Connectivity-Hub-VNET"   #When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID
          subnet_name                                = "ssd-plz-Connectivity-Hub-VNET-FW-Trust-SNET-01" #When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID
          subnet_virtual_network_resource_group_name = "sd-plz-connectivity-rg-01"     #When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID
        })
        ip_configuration_public_ip = null
        ip_configuration_primary = true #Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false.Must be true for the first ip_configuration when multiple are specified
        ip_configuration_load_balancer = null
      }
    }
    network_interface_tags = { #(Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  },
  "network_interface_3" = {
    network_interface_name                          = "sd-plz-palovm1-mgmt-nic-03" #The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_location                      = "Central India"          #The location where the Network Interface should exist. Changing this forces a new resource to be created.
    network_interface_resource_group_name           = "sd-plz-connectivity-rg-01"  #The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.
    network_interface_auxiliary_mode                = null         # (Optional) Specifies the auxiliary mode used to enable network high-performance feature on Network Virtual Appliances (NVAs). Possible values are AcceleratedConnections and Floating.
    network_interface_auxiliary_sku                 = null              # (Optional) Specifies the SKU used for the network high-performance feature on Network Virtual Appliances (NVAs). Possible values are A1, A2, A4 and A8.
    network_interface_dns_servers                   = []                 #if provided, it will override the DNS server value defined in vnet module
    network_interface_edge_zone                     = null               #Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created
    network_interface_enable_ip_forwarding          = false              #Enable only if IP Forwarding is required
    network_interface_enable_accelerated_networking = false              #Enable only if accelerated networking is required
    network_interface_internal_dns_label            = null               #The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.
    network_interface_ip_configuration = {
      "ip_configuration_1" = {
        ip_configuration_name                          = "privateconfig1" #A name used for this IP Configuration. Changing this forces a new resource to be created
        ip_configuration_private_ip_address_allocation = "Dynamic"                  #Possible values are Dynamic and Static
        #ip_configuration_private_ip_address            = "10.0.3.11"                #When private_ip_address_allocation is set to Static, The Static IP Address which should be used
        ip_configuration_private_ip_address         = null
        ip_configuration_private_ip_address_version = "IPv4" #The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.
        ip_configuration_subnet = ({
          subnet_virtual_network_name                = "sd-plz-Connectivity-Hub-VNET"   #When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID
          subnet_name                                = "sd-plz-Connectivity-Hub-VNET-FW-Mgmt-SNET-01" #When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID
          subnet_virtual_network_resource_group_name = "sd-plz-connectivity-rg-01"     #When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID
        })
        ip_configuration_public_ip = null
        ip_configuration_primary = true #Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false.Must be true for the first ip_configuration when multiple are specified
        ip_configuration_load_balancer = null
      }
    }
    network_interface_tags = { #(Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  },
  "network_interface_4" = {
    network_interface_name                          = "sd-plz-palovm2-untrust-nic-01" #The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_location                      = "Central India"          #The location where the Network Interface should exist. Changing this forces a new resource to be created.
    network_interface_resource_group_name           = "sd-plz-connectivity-rg-01"  #The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.
    network_interface_auxiliary_mode                = null         # (Optional) Specifies the auxiliary mode used to enable network high-performance feature on Network Virtual Appliances (NVAs). Possible values are AcceleratedConnections and Floating.
    network_interface_auxiliary_sku                 = null              # (Optional) Specifies the SKU used for the network high-performance feature on Network Virtual Appliances (NVAs). Possible values are A1, A2, A4 and A8.
    network_interface_dns_servers                   = []                 #if provided, it will override the DNS server value defined in vnet module
    network_interface_edge_zone                     = null               #Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created
    network_interface_enable_ip_forwarding          = false              #Enable only if IP Forwarding is required
    network_interface_enable_accelerated_networking = false              #Enable only if accelerated networking is required
    network_interface_internal_dns_label            = null               #The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.
    network_interface_ip_configuration = {
      "ip_configuration_1" = {
        ip_configuration_name                          = "privateconfig1" #A name used for this IP Configuration. Changing this forces a new resource to be created
        ip_configuration_private_ip_address_allocation = "Dynamic"                  #Possible values are Dynamic and Static
        #ip_configuration_private_ip_address            = "10.0.3.11"                #When private_ip_address_allocation is set to Static, The Static IP Address which should be used
        ip_configuration_private_ip_address         = null
        ip_configuration_private_ip_address_version = "IPv4" #The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.
        ip_configuration_subnet = ({
          subnet_virtual_network_name                = "sd-plz-Connectivity-Hub-VNET"   #When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID
          subnet_name                                = "sd-plz-Connectivity-Hub-VNET-FW-UnTrust-SNET-02" #When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID
          subnet_virtual_network_resource_group_name = "sd-plz-connectivity-rg-01"     #When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID
        })
        ip_configuration_public_ip = null
        ip_configuration_primary = true #Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false.Must be true for the first ip_configuration when multiple are specified
        ip_configuration_load_balancer = null
      }
    }
    network_interface_tags = { #(Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  },
  "network_interface_5" = {
    network_interface_name                          = "sd-plz-palovm2-trust-nic-02" #The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_location                      = "Central India"          #The location where the Network Interface should exist. Changing this forces a new resource to be created.
    network_interface_resource_group_name           = "sd-plz-connectivity-rg-01"  #The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.
    network_interface_auxiliary_mode                = null         # (Optional) Specifies the auxiliary mode used to enable network high-performance feature on Network Virtual Appliances (NVAs). Possible values are AcceleratedConnections and Floating.
    network_interface_auxiliary_sku                 = null              # (Optional) Specifies the SKU used for the network high-performance feature on Network Virtual Appliances (NVAs). Possible values are A1, A2, A4 and A8.
    network_interface_dns_servers                   = []                 #if provided, it will override the DNS server value defined in vnet module
    network_interface_edge_zone                     = null               #Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created
    network_interface_enable_ip_forwarding          = false              #Enable only if IP Forwarding is required
    network_interface_enable_accelerated_networking = false              #Enable only if accelerated networking is required
    network_interface_internal_dns_label            = null               #The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.
    network_interface_ip_configuration = {
      "ip_configuration_1" = {
        ip_configuration_name                          = "privateconfig1" #A name used for this IP Configuration. Changing this forces a new resource to be created
        ip_configuration_private_ip_address_allocation = "Dynamic"                  #Possible values are Dynamic and Static
        #ip_configuration_private_ip_address            = "10.0.3.11"                #When private_ip_address_allocation is set to Static, The Static IP Address which should be used
        ip_configuration_private_ip_address         = null
        ip_configuration_private_ip_address_version = "IPv4" #The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.
        ip_configuration_subnet = ({
          subnet_virtual_network_name                = "sd-plz-Connectivity-Hub-VNET"   #When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID
          subnet_name                                = "ssd-plz-Connectivity-Hub-VNET-FW-Trust-SNET-02" #When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID
          subnet_virtual_network_resource_group_name = "sd-plz-connectivity-rg-01"     #When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID
        })
        ip_configuration_public_ip = null
        ip_configuration_primary = true #Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false.Must be true for the first ip_configuration when multiple are specified
        ip_configuration_load_balancer = null
      }
    }
    network_interface_tags = { #(Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  },
  "network_interface_6" = {
    network_interface_name                          = "sd-plz-palovm2-mgmt-nic-01" #The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_location                      = "Central India"          #The location where the Network Interface should exist. Changing this forces a new resource to be created.
    network_interface_resource_group_name           = "sd-plz-connectivity-rg-01"  #The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.
    network_interface_auxiliary_mode                = null         # (Optional) Specifies the auxiliary mode used to enable network high-performance feature on Network Virtual Appliances (NVAs). Possible values are AcceleratedConnections and Floating.
    network_interface_auxiliary_sku                 = null              # (Optional) Specifies the SKU used for the network high-performance feature on Network Virtual Appliances (NVAs). Possible values are A1, A2, A4 and A8.
    network_interface_dns_servers                   = []                 #if provided, it will override the DNS server value defined in vnet module
    network_interface_edge_zone                     = null               #Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created
    network_interface_enable_ip_forwarding          = false              #Enable only if IP Forwarding is required
    network_interface_enable_accelerated_networking = false              #Enable only if accelerated networking is required
    network_interface_internal_dns_label            = null               #The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.
    network_interface_ip_configuration = {
      "ip_configuration_1" = {
        ip_configuration_name                          = "privateconfig1" #A name used for this IP Configuration. Changing this forces a new resource to be created
        ip_configuration_private_ip_address_allocation = "Dynamic"                  #Possible values are Dynamic and Static
        #ip_configuration_private_ip_address            = "10.0.3.11"                #When private_ip_address_allocation is set to Static, The Static IP Address which should be used
        ip_configuration_private_ip_address         = null
        ip_configuration_private_ip_address_version = "IPv4" #The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.
        ip_configuration_subnet = ({
          subnet_virtual_network_name                = "sd-plz-Connectivity-Hub-VNET"   #When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID
          subnet_name                                = "sd-plz-Connectivity-Hub-VNET-FW-Mgmt-SNET-01" #When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID
          subnet_virtual_network_resource_group_name = "sd-plz-connectivity-rg-01"     #When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID
        })
        ip_configuration_public_ip = null
        ip_configuration_primary = true #Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false.Must be true for the first ip_configuration when multiple are specified
        ip_configuration_load_balancer = null
      }
    }
    network_interface_tags = { #(Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}