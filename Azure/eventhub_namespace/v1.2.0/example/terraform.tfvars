#RESOURCE GROUP 
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

    virtual_network_subnet = [] #(Optional) Can be specified multiple times to define multiple subnets
    virtual_network_tags = {    #(Optional) A mapping of tags which should be assigned to the virtual network.
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

#EVENTHUB CLUSTER
eventhub_cluster_variables = {
  eventhub_cluster_1 = {
    eventhub_cluster_name                = "ploceuseventhubcluster000001" # (Required) Specifies the name of the EventHub Cluster resource.
    eventhub_cluster_resource_group_name = "ploceusrg000001"              # (Required) The name of the resource group in which the EventHub Cluster exists.
    eventhub_cluster_location            = "westus2"                      # (Required) Specifies the supported Azure location where the resource exists.
    eventhub_cluster_sku_name            = "Dedicated_1"                  # (Required) The SKU name of the EventHub Cluster. The only supported value at this time is Dedicated_1.
    eventhub_cluster_tags = {                                             # (Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#Eventhub namespace
eventhub_namespace_variables = {
  "eventhub_namespace_1" = {
    eventhub_namespace_location                             = "westus2"          # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    eventhub_namespace_name                                 = "ploceusens000001" # (Required) Specifies the name of the EventHub Namespace resource. Changing this forces a new resource to be created.
    eventhub_namespace_resource_group_name                  = "ploceusrg000001"  # (Required) The name of the resource group in which to create the namespace. Changing this forces a new resource to be created.
    eventhub_namespace_sku                                  = "Standard"         # (Required) Defines which tier to use. Valid options are Basic, Standard, and Premium. Please note that setting this field to Premium will force the creation of a new resource.
    eventhub_namespace_capacity                             = "2"                # (Optional) Specifies the Capacity / Throughput Units for a Standard SKU namespace. Default capacity has a maximum of 2, but can be increased in blocks of 2 on a committed purchase basis.
    eventhub_namespace_auto_inflate_enabled                 = true               # (Optional) Is Auto Inflate enabled for the EventHub Namespace?
    eventhub_namespace_maximum_throughput_units             = 2                  # (Optional) Specifies the maximum number of throughput units when Auto Inflate is Enabled. Valid values range from 1 - 20.
    eventhub_namespace_zone_redundant                       = false              # (Optional) Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). Changing this forces a new resource to be created. Defaults to false.
    eventhub_namespace_dedicated_eventhub_cluster_name      = null               # (Optional) Specifies the name of the EventHub Cluster resource. Required, when the namespace needs a dedicated eventhub_cluster
    eventhub_namespace_eventhub_cluster_resource_group_name = null               # (Optional) The name of the resource group in which the EventHub Cluster exists. Required, when the namespace needs a dedicated eventhub_cluster 
    eventhub_namespace_local_authentication_enabled         = false              # (Optional) Is SAS authentication enabled for the EventHub Namespace?
    eventhub_namespace_public_network_access_enabled        = false              # (Optional) Is public network access enabled for the EventHub Namespace? Defaults to true.
    eventhub_namespace_identity = [                                              # (Optional) An identity block as defined below.
      {
        eventhub_namespace_identity_type = "SystemAssigned" #(Required) Specifies the type of Managed Service Identity that should be configured on this Event Hub Namespace. Possible values are SystemAssigned or UserAssigned.
      }
    ]
    eventhub_namespace_network_rulesets = { # (Optional) A network_rulesets block as defined below.
      "eventhub_namespace_network_rulesets_1" = {
        network_rulesets_default_action                 = "Deny"                                       # (Required) The default action to take when a rule is not matched. Possible values are Allow and Deny.
        network_rulesets_trusted_service_access_enabled = false                                        # (Optional) Whether Trusted Microsoft Services are allowed to bypass firewall.
        network_rulesets_public_network_access_enabled  = false                                        # (Optional) Is public network access enabled for the EventHub Namespace? Defaults to true.
        network_rulesets_virtual_network_rule = {                                                      # (Optional) One or more virtual_network_rule blocks can be defined using subnet_ID & ignore_missing_virtual_network_service_endpoint with default value false
          virtual_network_rule_subnet_name                                     = "ploceussubnet000001" # (Required) The name of the subnet. Changing this forces a new resource to be created.
          virtual_network_rule_subnet_resource_group_name                      = "ploceusrg000001"     # (Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
          virtual_network_rule_subnet_virtual_network_name                     = "ploceusvnet000001"   # (Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
          virtual_network_rule_ignore_missing_virtual_network_service_endpoint = true                  # (Optional) Are missing virtual network service endpoints ignored? Defaults to false.
        }
        network_rulesets_ip_rule = null # (Optional) One or more ip_rule blocks can be defined with ip_mask & action
      }
    }
    eventhub_namespace_tags = { # (Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}