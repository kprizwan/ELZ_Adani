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


#APPLICATION GATEWAY 
application_gateway_variables = {
  "application_gateway_1" = {
    application_gateway_name                              = "sd-plz-appgw-01"     #(Required) The name of the Application Gateway. Changing this forces a new resource to be created.                    
    application_gateway_resource_group_name               = "sd-plz-connectivity-rg-01"       #(Required) The name of the resource group in which to the Application Gateway should exist. Changing this forces a new resource to be created.                 
    application_gateway_location                          = "Central India"                #(Required) The Azure region where the Application Gateway should exist. Changing this forces a new resource to be created.                 
    application_gateway_sku_capacity                      = 2                       #(Required) The Capacity of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32, and 1 to 125 for a V2 SKU. This property is optional if autoscale_configuration is set.                 
    application_gateway_vnet_name                         = "sd-plz-Connectivity-Hub-VNET"     #Name of the virtual network to be associated with Application Gateway               
    application_gateway_vnet_resource_group_name          = "sd-plz-connectivity-rg-01"       #name of the virtual network resource group name
    application_gateway_subnet_name                       = "sd-plz-Connectivity-Hub-VNET-AGW-SNET-01"   #Name of the subnet to be associated with Application Gateway                 
    application_gateway_frontend_port                     = 80                      #(Required) The port used for this Frontend Port.                 
    application_gateway_is_private_frontend_ip_required   = false                   #(Optional) The Private IP Address to use for the Application Gateway.              
    application_gateway_is_public_frontend_ip_required    = true                    #(Optional) The ID of a Public IP Address which the Application Gateway should use. The allocation method for the Public IP Address depends on the sku of this Application Gateway. Please refer to the Azure documentation for public IP addresses for details.
    application_gateway_is_waf_policy_required            = false                   #(Optional) A waf_configuration block                 
    application_gateway_waf_policy_name                   = null                    #Name of the waf Policy                  
    application_gateway_waf_policy_resource_group_name    = null                    #Resource Group of the waf policy                
    application_gateway_public_ip_name                    = "sd-plz-appgw-publicip-01" #(Optional) The ublic IP Address which the Application Gateway should use. The allocation method for the Public IP Address depends on the sku of this Application Gateway. Please refer to the Azure documentation for public IP addresses for details.
    application_gateway_fips_enabled                      = false                   #(Optional) Is FIPS enabled on the Application Gateway?               
    application_gateway_identity                          = null                    #(Optional)
    application_gateway_zones                             = null                    #(Optional) Specifies a list of Availability Zones in which this Application Gateway should be located. Changing this forces a new Application Gateway to be created.
    application_gateway_trusted_client_certificate        = null                    #(Optional) Is client certificate required?
    application_gateway_authentication_certificate        = null                    #(Optional) One or more authentication_certificate blocks
    application_gateway_trusted_root_certificate          = null                    #(Optional)A root certifcate block
    application_gateway_keyvault_cert_configuration       = null                    #(Optional) One or more authentication_certificate blocks
    application_gateway_custom_error_configuration        = null                    #(Optional) One or more custom_error_configuration blocks
    application_gateway_force_firewall_policy_association = false                   # Is the Firewall Policy associated with the Application Gateway?  #(Optional) Is the Firewall Policy associated with the Application Gateway?
    application_gateway_enable_http2                      = false                   #(Optional) Is HTTP2 enabled on the application gateway resource? Defaults to false.

    application_gateway_sku = {    #(Required) A sku block as defined below.
      sku_name     = "Standard_v2" #(Required) The Name of the SKU to use for this Application Gateway. Possible values are Standard_Small, Standard_Medium, Standard_Large, Standard_v2, WAF_Medium, WAF_Large, and WAF_v2.
      sku_tier     = "Standard_v2" #(Required) The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard_v2, WAF and WAF_v2.
      sku_capacity = 2             #(Required) The Capacity of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32, and 1 to 125 for a V2 SKU. This property is optional if autoscale_configuration is set.
    }

    application_gateway_gateway_ip_configuration = [ #A frontend_ip_configuration block supports the following
      {
        gateway_ip_configuration_name        = "appgateway-gicconfig" #(Required) The name of the Frontend IP Configuration.
        gateway_ip_configuration_subnet_name = "sd-plz-Connectivity-Hub-VNET-AGW-SNET-01"  #"ploceussubnet000001a"  #(Required) The Name of the Subnet which the Application Gateway should be connected to.
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
        backend_http_settings_name                                = "appgateway-be-htst" #(Required) The name of the Backend HTTP Settings Collection.   
        backend_http_settings_path                                = "/path1/"            #(Optional) The Path which should be used as a prefix for all HTTP requests.
        backend_http_settings_port                                = 80                   #(Required) The port which should be used for this Backend HTTP Settings Collection.
        backend_http_settings_protocol                            = "Http"               #(Required) The Protocol which should be used. Possible values are Http and Https.
        backend_http_settings_cookie_based_affinity               = "Disabled"           #(Required) Is Cookie-Based Affinity enabled? Possible values are Enabled and Disabled.
        backend_http_settings_affinity_cookie_name                = null                 #(Optional) The name of the affinity cookie.
        backend_http_settings_request_timeout                     = 60                   #(Required) The request timeout in seconds, which must be between 1 and 86400 seconds.
        backend_http_settings_probe_name                          = null                 #(Optional) The name of an associated HTTP Probe
        backend_http_settings_host_name                           = null                 #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true.
        backend_http_settings_pick_host_name_from_backend_address = false                #(Optional) Whether host header should be picked from the host name of the backend server. Defaults to false.
        backend_http_settings_trusted_root_certificate_names      = null                 //["ploceusappcert"]  #(Optional) A list of trusted_root_certificate names.
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
        http_listener_ssl_certificate_name           = null                  //"ploceusappcert"   #(Optional) The name of the associated SSL Certificate which should be used for this HTTP Listener.
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
        request_routing_rules_backend_http_settings_name  = "appgateway-be-htst"  #(Optional) The Name of the Backend HTTP Settings Collection which should be used for this Routing Rule. Cannot be set if redirect_configuration_name is set.
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
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}
