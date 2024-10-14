resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000001"
    location = "westus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#VNET uncomment to create Vnet
vnets_variables = {
  "vnet_1" = {
    name                        = "ploceusvnet000001"
    location                    = "westus2"
    resource_group_name         = "ploceusrg000001"
    address_space               = ["10.0.0.0/16"]
    dns_servers                 = []
    flow_timeout_in_minutes     = null #possible values are between 4 and 30 minutes.
    bgp_community               = null
    edge_zone                   = null
    is_ddos_protection_required = false #Provide the value as true only if ddos_protection_plan is required
    ddos_protection_plan_name   = null  #Provide the name of the ddos protection plan if above value is true or else keep it as null. If new DDOS protection plan needs to be created uncomment from line 24 to 34
    vnet_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#SUBNET
subnet_variables = {
  "subnet_1" = {
    name                                           = "ploceussubnet000001"
    resource_group_name                            = "ploceusrg000001"
    address_prefixes                               = ["10.0.1.0/24"]
    virtual_network_name                           = "ploceusvnet000001"
    enforce_private_link_service_network_policies  = true
    enforce_private_link_endpoint_network_policies = true
    is_delegetion_required                         = false #update to true if delegation required and update delegation name,service_name,Service_actions
    service_endpoints                              = ["Microsoft.AzureActiveDirectory"]
    delegation_name                                = "delegation000001"
    service_name                                   = "Microsoft.Sql/managedInstances"
    service_actions                                = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
  }
}

#EVENTHUB CLUSTER
eventhub_cluster_variables = {
  eventhub_cluster_1 = {
    eventhub_cluster_name                = "ploceuseventhubcluster000001"
    eventhub_cluster_resource_group_name = "ploceusrg000001"
    eventhub_cluster_location            = "westus2"
    eventhub_cluster_sku_name            = "Dedicated_1" #The SKU name of the EventHub Cluster. The only supported value at this time is "Dedicated_1".
    eventhub_cluster_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
#Eventhub namespace
eventhub_namespace_variables = {
  "eventhub_namespace_1" = {
    eventhub_namespace_location                 = "westus2"
    eventhub_namespace_name                     = "ploceusasg000001"
    eventhub_namespace_resource_group_name      = "ploceusrg000001"
    eventhub_namespace_sku                      = "Standard"
    eventhub_namespace_capacity                 = "2"
    eventhub_namespace_auto_inflate_enabled     = true
    eventhub_namespace_maximum_throughput_units = 2
    eventhub_namespace_zone_redundant           = false
    eventhub_cluster_name                       = "ploceuscn000001"
    eventhub_cluster_resource_group_name        = "ploceuscrg000001"
    eventhub_namespace_identity = [

      {
        eventhub_namespace_identity_type = "SystemAssigned"
      }
    ]                                              #Specifies the type of Managed Service Identity that should be configured on this Event Hub Namespace. The only possible value is SystemAssigned.
    eventhub_namespace_network_rulesets     = null #network rule block with values default_action,trusted_service_access_enabled,virtual_network_rule & ip_rule needs to be defined
    eventhub_namespace_virtual_network_rule = null #One or more virtual_network_rule blocks can be defined using subnet_ID & ignore_missing_virtual_network_service_endpoint with default value false 
    eventhub_namespace_ip_rule              = null # One or more ip_rule blocks can be defined with ip_mask & action
    eventhub_namespace_dedicated_cluster_id = false
    eventhub_namespace_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
    eventhub_namespace_subnet_name                 = "ploceussubnet000001"
    eventhub_namespace_subnet_resource_group_name  = "ploceusrg000001"
    eventhub_namespace_subnet_virtual_network_name = "ploceusvnet000001"
    eventhub_cluster_name                          = "ploceuseventhubcluster000001"
    eventhub_cluster_resource_group_name           = "ploceusrg000001"
  }
}

