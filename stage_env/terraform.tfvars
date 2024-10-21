# Stage Subscription 

#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "sd-common-stage-rg" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location = "Central India"             #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_managed_by = null #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-stage",
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
    virtual_network_name                    = "sd-common-stage-vnet-01"                                                                                                                                                                                                         #(Required) The name of the virtual network.
    virtual_network_location                = "Central India"                                                                                                                                                                                                                        #(Required) The location/region where the virtual network is created.
    virtual_network_resource_group_name     = "sd-common-stage-rg"                                                                                                                                                                                                            #(Required) The name of the resource group in which to create the virtual network.
    virtual_network_address_space           = ["10.248.96.0/20"] #(Required) The address space that is used the virtual network.
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
      Environment    = "Stage",
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
    subnet_name                                          = "sd-common-stage-vnet-aks-snet-01" # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "sd-common-stage-rg"                #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.248.100.0/26"]                          #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "sd-common-stage-vnet-01"             #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
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
    subnet_name                                          = "sd-common-stage-vnet-pe-snet-01" # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "sd-common-stage-rg"                    #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.248.101.0/27"]                            #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "sd-common-stage-vnet-01"                 #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
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
    subnet_name                                          = "sd-common-stage-vnet-aks-pod-snet-01" # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "sd-common-stage-rg"                       #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.248.96.0/22"]                                 #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "sd-common-stage-vnet-01"                    #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled = null                                              # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled     = null                                              # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_service_endpoint_policy_ids                   = null                                              #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                             = null                                              #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation                                           = null  /*[{
      delegation_name            = "delegation000001"                                                                                                                                                                                                #(Required) A name for this delegation.
      service_delegation_name    = "Microsoft.Sql/managedInstances"                                                                                                                                                                                  # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"] #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }]*/
  }
}
#KUBERNETES CLUSTER
kubernetes_cluster_variables = {
  "aks_1" = {
    kubernetes_cluster_name                                                            = "sdstageaks01"       #(Required) The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created.
    kubernetes_cluster_location                                                        = "Central India"        #(Required) The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created.
    kubernetes_cluster_resource_group_name                                             = "sd-common-stage-rg" # (Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_key_vault_name                                                  = null                   #(Optional) Incase if any secret value is passed for linux_profile, windows_profile, azure_active_directory_role_based_access_control(azure_active_directory_role_based_access_control_server_app_secret) or service_principal(client_secret). Pass null if not required
    kubernetes_cluster_key_vault_resource_group_name                                   = null                   #(Optional) To be provided for the kubernetes_cluster_key_vault_name  resource group
    kubernetes_cluster_key_vault_certificate_name                                      = null                   #(Optional) Specifies the name of the Key Vault Certificate which contain the list of up to 10 base64 encoded CAs that will be added to the trust store on nodes with the custom_ca_trust_enabled feature enabled.
    kubernetes_cluster_default_node_pool_name                                          = "sdstagepool"
    kubernetes_cluster_default_node_pool_capacity_reservation_group_name               = null             #(Optional) provide the linux kubernetes_cluster capacity reservation group name
    kubernetes_cluster_default_node_pool_capacity_reservation_resource_group_name      = null             #(Optional) provide the capacity reservation group resource group name
    kubernetes_cluster_default_node_pool_vm_size                                       = "Standard_D8_v3" #(Required) The size of the Virtual Machine, such as Standard_DS2_v2. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_custom_ca_trust_enabled                       = false            #(Optional) Specifies whether to trust a Custom CA.
    kubernetes_cluster_default_node_pool_key_vault_certificate_name                    = null             #(Optional) Specifies the name of the Key Vault Certificate. If kubernetes_cluster_default_node_pool_custom_ca_trust_enabled = true, then this is Required.
    kubernetes_cluster_default_node_pool_enable_auto_scaling                           = false            #(Optional) Should the Kubernetes Auto Scaler be enabled for this Node Pool? Defaults to false. This requires that the type is set to VirtualMachineScaleSets
    kubernetes_cluster_default_node_pool_workload_runtime                              = null             #(Optional) Specifies the workload runtime used by the node pool. Possible values are OCIContainer and KataMshvVmIsolation.
    kubernetes_cluster_default_node_pool_enable_host_encryption                        = false            #(Optional) Should the nodes in the Default Node Pool have host encryption enabled? Defaults to false
    kubernetes_cluster_default_node_pool_enable_node_public_ip                         = false            #(Optional) Should nodes in this Node Pool have a Public IP Address? Defaults to false. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_kubelet_config                                = null
    kubernetes_cluster_default_node_pool_linux_os_config                               = null
    kubernetes_cluster_default_node_pool_fips_enabled                                  = false #(Optional) Should the nodes in this Node Pool have Federal Information Processing Standard enabled? Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_kubelet_disk_type                             = "OS"  #(Optional) The type of disk used by kubelet. Possible values are OS and Temporary.
    kubernetes_cluster_default_node_pool_max_pods                                      = 30    # (Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created.
    kubernetes_cluster_message_of_the_day                                              = null  # (Optional) A base64-encoded string which will be written to /etc/motd after decoding. This allows customization of the message of the day for Linux nodes. It cannot be specified for Windows nodes and must be a static string (i.e. will be printed raw and not executed as a script). Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_node_public_ip_prefix_name                    = null  #(Optional) Resource ID for the Public IP Addresses Prefix for the nodes in this Node Pool. enable_node_public_ip should be true. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_node_public_ip_prefix_resource_group_name     = null
    kubernetes_cluster_default_node_pool_is_host_group_id_required                     = false                             #(Required)Boolean value if host group id required
    kubernetes_cluster_default_node_pool_dedicated_host_group_name                     = null                              #(Optional) Specifies the Name of the Host Group within which this AKS Cluster should be created.
    kubernetes_cluster_default_node_pool_dedicated_host_group_resource_group_name      = null                              #(Optional) Specifies the Resource Group Name of the Host Group
    kubernetes_cluster_default_node_pool_node_labels                                   = null                              #(Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool.
    kubernetes_cluster_default_node_pool_only_critical_addons_enabled                  = false                             #(Optional) Enabling this option will taint default node pool with CriticalAddonsOnly=true:NoSchedule taint. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_orchestrator_version                          = "1.29.0"                          #(Optional) Version of Kubernetes used for the Agents. If not specified, the default node pool will be created with the version specified by kubernetes_version. If both are unspecified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). This version must be supported by the Kubernetes Cluster - as such the version of Kubernetes used on the Cluster/Control Plane may need to be upgraded first.
    kubernetes_cluster_default_node_pool_os_disk_size_gb                               = 128                               #(Optional) The size of the OS Disk which should be used for each agent in the Node Pool. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_os_disk_type                                  = "Managed"                         #(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_os_sku                                        = "Ubuntu"                          #(Optional) OsSKU to be used to specify Linux OSType. Not applicable to Windows OSType. Possible values include: Ubuntu, CBLMariner. Defaults to Ubuntu. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_is_proximity_placement_group_id_required      = false                             #(Required)Boolean value if proximity placement group id required
    kubernetes_cluster_default_node_pool_proximity_placement_group_name                = null                              #(Optional) Provide proximity placement group name if kubernetes_cluster_is_proximity_placement_group_id_required is set to true
    kubernetes_cluster_default_node_pool_proximity_placement_group_resource_group_name = null                              #(Optional) Provide proximity placement group resource group name if kubernetes_cluster_is_proximity_placement_group_id_required is set to true
    kubernetes_cluster_default_node_pool_pod_virtual_network_name                      = "sd-common-stage-vnet-01"          #(Optional) The name of the Subnet where the pods in the default Node Pool should exist.
    kubernetes_cluster_default_node_pool_pod_subnet_name                               = "sd-common-stage-vnet-aks-snet-01" #(Optional) The name of the Subnet where the pods in the default Node Pool should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_pod_scale_down_mode                           = "Delete"                          #(Optional) Specifies the autoscaling behaviour of the Kubernetes Cluster. Allowed values are Delete and Deallocate. Defaults to Delete.
    kubernetes_cluster_default_node_pool_is_snapshot_id_required                       = false                             #(Required)Boolean value if snapshot id required
    kubernetes_cluster_default_node_pool_snapshot_name                                 = null                              #(Optional) Provide snapshot name if kubernetes_cluster_default_node_pool_is_snapshot_id_required is set to true
    kubernetes_cluster_default_node_pool_snapshot_resource_group_name                  = null                              #(Optional) Provide snapshot resource group name if kubernetes_cluster_default_node_pool_is_snapshot_id_required is set to true
    kubernetes_cluster_default_node_pool_temporary_name_for_rotation                   = null                              #(Optional) Specifies the name of the temporary node pool used to cycle the default node pool for VM resizing.
    kubernetes_cluster_default_node_pool_pod_virtual_network_resource_group_name       = "sd-common-stage-rg"            #(Optional) The name of the resource_group where the pods in the default Node Pool should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_type                                          = "VirtualMachineScaleSets"         #(Optional) The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets. Defaults to VirtualMachineScaleSets.
    kubernetes_cluster_default_node_pool_tags = {
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-Stage",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
    kubernetes_cluster_default_node_pool_ultra_ssd_enabled                   = false #(Optional) Used to specify whether the UltraSSD is enabled in the Default Node Pool. Defaults to false
    kubernetes_cluster_node_network_profile                                  = null  #(Optional) Node Network Profile for Kubernetes Cluster
    kubernetes_cluster_default_node_pool_upgrade_settings                    = null
    kubernetes_cluster_default_node_pool_virtual_network_name                = "sd-common-stage-vnet-01" #(Optional) Name of VNet for assigning default node pool to a subnet
    kubernetes_cluster_default_node_pool_virtual_network_resource_group_name = "sd-common-stage-rg"
    kubernetes_cluster_default_node_pool_subnet_name                         = "sd-common-stage-vnet-aks-pod-snet-01" #(Optional) Name of Subnet for assigning default node pool to a subnet . A Route Table must be configured on this Subnet.
    kubernetes_cluster_default_node_pool_max_count                           = 9                                #(Optional) The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000.
    kubernetes_cluster_default_node_pool_min_count                           = 3                                 #(Optional) The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000
    kubernetes_cluster_default_node_pool_node_count                          = 3                                    #(Optional) The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 and between min_count and max_count.
    kubernetes_cluster_default_node_pool_availability_zones                  = null                                 #(Optional) Specifies a list of Availability Zones in which this Kubernetes Cluster should be located. Changing this forces a new Kubernetes Cluster to be created.
    kubernetes_cluster_dns_prefix                                            = "sdstageaks01"                     #(Optional) DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created. One of dns_prefix or dns_prefix_private_cluster must be specified. The dns_prefix must contain between 3 and 45 characters, and can contain only letters, numbers, and hyphens. It must start with a letter and must end with a letter or a number.
    kubernetes_cluster_dns_prefix_private_cluster                            = null                                 #(Optional) Specifies the DNS prefix to use with private clusters. Changing this forces a new resource to be created. One of dns_prefix or dns_prefix_private_cluster must be specified. The dns_prefix must contain between 3 and 45 characters, and can contain only letters, numbers, and hyphens. It must start with a letter and must end with a letter or a number.
    kubernetes_cluster_aci_connector_linux                                   = null
    kubernetes_cluster_automatic_channel_upgrade                             = null #(Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, node-image and stable. Omitting this field sets this value to none. Cluster Auto-Upgrade will update the Kubernetes Cluster (and its Node Pools) to the latest GA version of Kubernetes automatically and will not update to Preview versions.
    kubernetes_cluster_api_server_authorized_ip_ranges                       = null # (Optional) The IP ranges to allow for incoming traffic to the server nodes.
    kubernetes_cluster_api_server_access_profile                             = null
    kubernetes_cluster_auto_scaler_profile                                   = null
    kubernetes_cluster_confidential_computing                                = null
    kubernetes_cluster_azure_active_directory_role_based_access_control      = null
    kubernetes_cluster_azure_policy_enabled                                  = false #(Optional) Should the Azure Policy Add-On be enabled
    kubernetes_cluster_disk_encryption_set_name                              = null  #(Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes. Set to null if not required.
    kubernetes_cluster_disk_encryption_set_resource_group_name               = null
    kubernetes_cluster_edge_zone                                             = null  #(Optional) Specifies the Edge Zone within the Azure Region where this Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_http_application_routing_enabled                      = true  #(Optional) Should HTTP Application Routing be enabled
    kubernetes_cluster_image_cleaner_enabled                                 = false #(Optional) Specifies whether Image Cleaner is enabled.
    kubernetes_cluster_image_cleaner_interval_hours                          = null  #(Optional) Specifies the interval in hours when images should be cleaned up. Defaults to 48.
    kubernetes_cluster_http_proxy_config                                     = null
    kubernetes_cluster_identity = {    #One of either identity or service_principal must be specified. Assign null if not required. Defines the kubernetes cluster identity to be used
      identity_type = "SystemAssigned" #(Required) Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      identity_ids  = null /*[{
        identity_name = "5bcd79c7-7094-44fc-b87a-f9c2f24f517c"
      identity_resource_group_name = "sd-common-stage-node-rg" }]*/
    }
    kubernetes_cluster_ingress_application_gateway = null
    kubernetes_cluster_key_management_service      = null
    kubernetes_cluster_key_vault_secrets_provider  = null
    kubernetes_cluster_kubelet_identity            = null
    kubernetes_cluster_kubernetes_version          = "1.29.0" #(Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). AKS does not require an exact patch version to be specified, minor version aliases such as 1.22 are also supported. - The minor version's latest GA patch is automatically chosen in that case.
    kubernetes_cluster_linux_profile               = null

    // {                                  #(Optional) Pass as null if not required. Changing any parameter forces a new resource to be created.
    //   linux_profile_admin_username_key_vault_secret_name = null           #(Required) Pass the secret name where the adminuser name is stored. Pass null if not stored in key vault
    //   linux_profile_admin_username                       = "adminuser"    #(Optional) The Admin Username for the Cluster if it is not present in key vault
    //   linux_profile_ssh_key_secret_exist                 = false          #(Required) Set true if the public key is present in key vault. Set false where a new public and private key is generated. Public key will be stored in name provided in linux_profile_ssh_key_secret_name, private key will be stored in the same secret name appended with private. Keys generated using RSA algo with 4096 rsa bits
    //   linux_profile_ssh_key_secret_name                  = "secretsshkey" #(Required) If linux_profile_ssh_key_secret_exist is true then the secret is fetched from the given secret name else the new public key generated is stored in given secret name
    // }
    kubernetes_cluster_local_account_disabled          = false #(Optional) If true local accounts will be disabled. Defaults to false. If local_account_disabled is set to true, it is required to enable Kubernetes RBAC and AKS-managed Azure AD integration.
    kubernetes_cluster_maintenance_window              = null
    kubernetes_cluster_maintenance_window_auto_upgrade = null
    kubernetes_cluster_maintenance_window_node_os      = null
    kubernetes_cluster_microsoft_defender              = null
    kubernetes_cluster_monitor_metrics                 = null #(Optional) Specifies a Prometheus add-on profile for the Kubernetes Cluster.
    kubernetes_cluster_network_profile = {
      network_profile_network_plugin        = "azure"        #(Required) Network plugin to use for networking. Currently supported values are azure, kubenet and none. Changing this forces a new resource to be created.When network_plugin is set to azure - the vnet_subnet_id field in the default_node_pool block must be set and pod_cidr must not be set.
      network_profile_network_mode          = null           #(Optional) Network mode to be used with Azure CNI. Possible values are bridge and transparent. Changing this forces a new resource to be created. network_mode can only be set to bridge for existing Kubernetes Clusters and cannot be used to provision new Clusters - this will be removed by Azure in the future. This property can only be set when network_plugin is set to azure
      network_profile_network_policy        = null           #(Optional) Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created. When network_policy is set to azure, the network_plugin field can only be set to azure.
      network_profile_dns_service_ip        = "10.0.0.10"    #(Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created.
      network_profile_ebpf_data_plane       = null           #(Optional) Specifies the eBPF data plane used for building the Kubernetes network. Possible value is cilium. Disabling this forces a new resource to be created.
      network_profile_network_plugin_mode   = null           #(Optional) Specifies the network plugin mode used for building the Kubernetes network. Possible value is overlay.
      network_profile_outbound_type         = "loadBalancer" #(Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer, userDefinedRouting, managedNATGateway and userAssignedNATGateway. Defaults to loadBalancer.
      network_profile_pod_cidr              = null           #(Optional) The CIDR to use for pod IP addresses. This field can only be set when network_plugin is set to kubenet. Changing this forces a new resource to be created.
      network_profile_pod_cidrs             = null           # (Optional) A list of CIDRs to use for pod IP addresses. For single-stack networking a single IPv4 CIDR is expected. For dual-stack networking an IPv4 and IPv6 CIDR are expected. Changing this forces a new resource to be created.
      network_profile_service_cidr          = "10.0.0.0/16"  #(Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created. This range should not be used by any network element on or connected to this VNet. Service address CIDR must be smaller than /12. docker_bridge_cidr, dns_service_ip and service_cidr should all be empty or all should be set.
      network_profile_service_cidrs         = null           # (Optional) A list of CIDRs to use for Kubernetes services. For single-stack networking a single IPv4 CIDR is expected. For dual-stack networking an IPv4 and IPv6 CIDR are expected. Changing this forces a new resource to be created.
      network_profile_ip_versions           = ["IPv4"]       #(Optional) Specifies a list of IP versions the Kubernetes Cluster will use to assign IP addresses to its nodes and pods. Possible values are IPv4 and/or IPv6. IPv4 must always be specified. Changing this forces a new resource to be created. To configure dual-stack networking ip_versions should be set to ["IPv4", "IPv6"]
      network_profile_load_balancer_sku     = "standard"     #(Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard. Defaults to standard. (Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard. Defaults to standard. Changing this forces a new resource to be created.
      network_profile_load_balancer_profile = null
      network_profile_nat_gateway_profile   = null
    }
    kubernetes_cluster_node_os_channel_upgrade              = "None"                      #(Optional) The upgrade channel for this Kubernetes Cluster Nodes' OS Image. Possible values are Unmanaged, SecurityPatch, NodeImage and None.
    kubernetes_cluster_node_resource_group_name             = "sd-common-stage-node-rg" #(Optional) The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created. Azure requires that a new, non-existent Resource Group is used, as otherwise the provisioning of the Kubernetes Service will fail.
    kubernetes_cluster_oidc_issuer_enabled                  = false                       #(Required) Enable or Disable the OIDC issuer URL
    kubernetes_cluster_oms_agent                            = null
    kubernetes_cluster_service_mesh_profile                 = null
    kubernetes_cluster_open_service_mesh_enabled            = false #(Optional) Open Service Mesh needs to be enabled
    kubernetes_cluster_private_cluster_enabled              = true  #(Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created.
    kubernetes_cluster_private_dns_zone_name                = null  #"private.eastus2.azmk8s.io"  #(Optional)Use when kubernetes_cluster_private_cluster_enabled is set to true. Either the Name of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None. In case of None you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning. Changing this forces a new resource to be created.
    kubernetes_cluster_private_dns_zone_resource_group_name = null  #(Optional)Resource Group name for kubernetes_cluster_private_dns_zone_name.
    kubernetes_cluster_private_cluster_public_fqdn_enabled  = true  #(Optional) Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to false.
    kubernetes_cluster_workload_autoscaler_profile          = null
    # {                                      #(Optional) A workload_autoscaler_profile block defined below.
    #   workload_autoscaler_profile_keda_enabled = false                                        #(Optional) Specifies whether KEDA Autoscaler can be used for workloads.
    #   workload_autoscaler_profile_vertical_pod_autoscaler_enabled = bool #(Optional) Specifies whether Vertical Pod Autoscaler should be enabled.

    # }
    kubernetes_cluster_workload_identity_enabled         = false #(Optional) Specifies whether Azure AD Workload Identity should be enabled for the Cluster. Defaults to false
    kubernetes_cluster_public_network_access_enabled     = false #(Optional) Whether public network access is allowed for this Kubernetes Cluster. Defaults to true. Changing this forces a new resource to be created. When public_network_access_enabled is set to true, 0.0.0.0/32 must be added to api_server_authorized_ip_ranges
    kubernetes_cluster_role_based_access_control_enabled = true  #(Optional) - Whether Role Based Access Control for the Kubernetes Cluster should be enabled. Defaults to true. Changing this forces a new resource to be created.
    kubernetes_cluster_run_command_enabled               = true  #(Optional) Whether to enable run command for the cluster or not. Defaults to true
    kubernetes_cluster_service_principal                 = null
    kubernetes_cluster_storage_profile                   = null
    kubernetes_cluster_sku_tier                          = "Standard" #Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free.
    kubernetes_cluster_tags = {
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-Stage",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
    kubernetes_cluster_web_app_routing = null /*(Optional) A web_app_routing block as defined below
      web_app_routing_dns_zone_name = "dns000001"                      #(Required) Specifies the ID of the DNS Zone in which DNS entries are created for applications deployed to the cluster when Web App Routing is enabled.
      web_app_routing_dns_zone_resource_group = "rg000001"             #(Required) Specifies the ID of the DNS Zone in which DNS entries are created for applications deployed to the cluster when Web App Routing is enabled.
    }*/
    kubernetes_cluster_windows_profile = null /*{                                          #(Optional) Pass as null if not required. Changing any parameter forces a new resource to be created.
      windows_profile_admin_username_key_vault_secret_name = "keyvaultsecret000001" #(Required) Pass the secret name where the adminuser name is stored. Pass null if not stored in key vault
      windows_profile_admin_username                       = "admin123"             #(Optional) The Admin Username for the Windows VMs if not present in key vault
      windows_profile_admin_password_secret_exist          = false                  #(Required) Set true if the password is present in key vault else new password will be generated
      windows_profile_admin_password_secret_name           = "akssecret111"         #(Required) If windows_profile_admin_password_secret_exist is true then the Admin Password is read from given secret else the new generated password is stored in the given secret. Length must be between 14 and 123 characters.
      windows_profile_admin_password_length                = 14                     #(Required) Password Length. Length must be between 14 and 123 characters. Password generated will contain minimum of 4 lower case, 4 upper case, 2 numeric and 2 special character
      windows_profile_license                              = "Windows_Server"       #(Optional) Specifies the type of on-premise license which should be used for Node Pool Windows Virtual Machine. At this time the only possible value is Windows_Server
      kubernetes_cluster_gmsa                              = null
          gmsa_dns_server       =   #(Required) Specifies the DNS server for Windows gMSA. Set this to an empty string if you have configured the DNS server in the VNet which was used to create the managed cluster.
          gmsa_root_domain      =   #(Required) Specifies the root domain name for Windows gMSA. Set this to an empty string if you have configured the DNS server in the VNet which was used to create the managed cluster.
        }
    }*/
  } 
}

#SOURCE VIRTUAL NETWORK PEERING
/*source_virtual_network_peering_variables = {
  "source_virtual_network_peering_1" = {
    virtual_network_peering_name                             = "sd-plz-Connectivity-Hub-VNET-sd-plz-management-vnet" # (Required) The name of the source virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_destination_resource_group_name  = "sd-plz-management-rg"                                # (Required) The name of the destination virtual network resource group and in which to create the virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_destination_virtual_network_name = "sd-plz-management-vnet"                              # (Required) The name of the destination virtual network name.
    virtual_network_peering_resource_group_name              = "sd-plz-connectivity-rg-01"                           # (Required) The name of the source virtual network resource group and in which to create the virtual network peering. Changing this forces a new resource to be created.
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
    virtual_network_peering_destination_resource_group_name  = "sd-plz-connectivity-rg-01"                           # (Required) The name of the destination virtual network resource group and in which to create the virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_destination_virtual_network_name = "sd-plz-Connectivity-Hub-VNET"                        # (Required) The name of the destination virtual network name.
    virtual_network_peering_resource_group_name              = "sd-plz-management-rg"                                # (Required) The name of the source virtual network resource group and in which to create the virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_virtual_network_name             = "sd-plz-management-vnet"                              # (Required) The name of the source virtual network name.
    virtual_network_peering_allow_virtual_network_access     = true                                                  # (Optional) Controls if the VMs in the remote virtual network can access VMs in the local virtual network. Defaults to true.
    virtual_network_peering_allow_forwarded_traffic          = true                                                  # (Optional) Controls if forwarded traffic from VMs in the remote virtual network is allowed. Defaults to false.
    virtual_network_peering_use_remote_gateways              = false                                                 #  (Optional) Controls if remote gateways can be used on the local virtual network. If the flag is set to true, and allow_gateway_transit on the remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway. Defaults to false.
    virtual_network_peering_allow_gateway_transit            = true                                                  # (Optional) Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network.
    virtual_network_peering_triggers                         = null                                                  # (Optional) A mapping of key values pairs that can be used to sync network routes from the remote virtual network to the local virtual network. See the trigger example for an example on how to set it up.
  }
}*/

#KEY VAULT
key_vault_variables = {
  "key_vault_1" = {
    key_vault_name                                  = "sdplzmgmtdckv01"                                                                                                                                                                               #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_location                              = "Central India"                                                                                                                                                                                 #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_resource_group_name                   = "sd-plz-management-rg"                                                                                                                                                                          #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_enabled_for_disk_encryption           = true                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = true                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = true                                                                                                                                                                                            # (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = false                                                                                                                                                                                           #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = "7"                                                                                                                                                                                             #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = false                                                                                                                                                                                           #(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
    key_vault_sku_name                              = "standard"                                                                                                                                                                                      #(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium
    key_vault_access_container_agent_name           = "SDLADOVM01"                                                                                                                                                                                    #(Optional) Self hosted conatiner agent name.
    key_vault_access_policy_application_id          = null                                                                                                                                                                                            #(Optional) The object ID of an Application in Azure Active Directory.
    key_vault_public_network_access_enabled         = true                                                                                                                                                                                           #(Optional) key_vault_public_network_access_enabled
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                    #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                              #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"] # (Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    #(Optional) A mapping of tags which should be assigned to the key vault.
    key_vault_tags = { #(Optional) A mapping of tags which should be assigned to the key vault.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-Stage",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
    key_vault_network_acls_enabled        = false           #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass         = "AzureServices" #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action = null            # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
    key_vault_network_acls_ip_rules       = null            # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.

    #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
    key_vault_network_acls_virtual_networks = null /* [ #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
      {
        key_vault_network_acls_virtual_networks_virtual_network_name    =  null                    #(Required) Vitural Network name to be associated.
        key_vault_network_acls_virtual_networks_subnet_name             =  null                    #(Required) Subnet Name to be associated.
        key_vault_network_acls_virtual_networks_subscription_id         =  null                    #(Required) Subscription Id where Vnet is created.
        key_vault_network_acls_virtual_networks_virtual_network_rg_name =  null                    #(Required) Resource group where Vnet is created.
      }
    ]*/
    key_vault_contact_information_enabled   = false #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email                 = null  #(Required) E-mail address of the contact.
    key_vault_contact_name                  = null  #(Optional) Name of the contact.
    key_vault_contact_phone                 = null  #(Optional) Phone number of the contact.

  }
}

#PRIVATE_DNS_ZONE
private_dns_zone_variables = {
  "dnszone1" = {
    private_dns_zone_name                = "privatelink.vaultcore.azure.net" #(Required) The name of the Private DNS Zone. Must be a valid domain name.
    private_dns_zone_resource_group_name = "sd-plz-management-rg"            #(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.
    private_dns_zone_soa_record          = null                              ##(Optional) An soa_record block as defined below. Changing this forces a new resource to be created.
    private_dns_zone_tags = {
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-Stage",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }

}

#PRIVATE ENDPOINT
private_endpoint_variables = {
  "private_endpoint_1" = {

    private_endpoint_name                                = "sdplzmgmtdckv01-vault-pep"         # (Required) private endpoint name
    private_endpoint_resource_group_name                 = "sd-plz-management-rg"              # (Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created.
    private_endpoint_location                            = "Central India"                     #  (Required) The supported Azure location where the resource exists. Changing this forces a new resource to be created.
    private_endpoint_virtual_network_name                = "sd-plz-management-vnet"            #The name of the network interface associated with the private_endpoint
    private_endpoint_virtual_network_resource_group_name = "sd-plz-management-rg"              #(Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created.
    private_endpoint_subnet_name                         = "sd-plz-management-vnet-pe-snet-01" # (Required) subnet in which private endpoint is hosting
    custom_network_interface_name                        = "sdplzmgmtdckv01-vault-pep-nic-01"  #(Optional) The custom name of the network interface attached to the private endpoint. Changing this forces a new resource to be created.
    private_endpoint_private_dns_zone_group = {                                                #(Optional) A private_dns_zone_group block as defined below.  
      private_dns_zone_group_name          = "default"                                         #(Required) Specifies the Name of the Private DNS Zone Group.
      private_dns_zone_names               = ["privatelink.vaultcore.azure.net"]               #(Required) Specifies the list of Private DNS Zones names to include within the private_dns_zone_group.These names will be fetched by the data resource of private_dns_zone name.
      private_dns_zone_resource_group_name = "sd-plz-management-rg"                            #(Required) Specifies the resource group name of Private DNS Zones to include within the private_dns_zone_group.This will be fetched by the data resource of private_dns_zone resource group name.
    }
    private_endpoint_private_service_connection = {                                 #(Required) A private_service_connection block as defined below.
      private_service_connection_name                 = "sdplzmgmtdckv01-vault-pep" #(Required) Specifies the Name of the Private Service Connection. Changing this forces a new resource to be created.
      private_service_connection_is_manual_connection = false                       #(Required) set true if resource_alias != null
      private_connection_resource_name                = "sdplzmgmtdckv01"           #(Optional) The Service Name of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
      private_connection_resource_resource_group_name = "sd-plz-management-rg"      #(Optional) The Service Resource Group Name of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
      private_connection_resource_alias               = null                        #(Optional) The Service Alias of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
      request_message                                 = null                        #(Optional) Should be enabled if the is_manual_connection is set as true.  A message passed to the owner of the remote resource
      subresource_names                               = ["vault"]                   # (Optional) A list of subresource names which the Private Endpoint is able to connect to.
    }
    private_endpoint_ip_configuration = null
    private_endpoint_tags = { #(Optional)A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-Stage",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}
