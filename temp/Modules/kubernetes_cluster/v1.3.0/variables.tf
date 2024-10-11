#KUBERNETES CLUSTER VARIABLES
variable "kubernetes_cluster_variables" {
  description = "Map of Kubernetes cluster variables"
  type = map(object({
    kubernetes_cluster_name                                                       = string #(Required) The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created.
    kubernetes_cluster_location                                                   = string #(Required) The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created.
    kubernetes_cluster_resource_group_name                                        = string #(Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_key_vault_name                                             = string #(Optional) Incase if any secret value is passed for linux_profile, windows_profile, azure_active_directory_role_based_access_control(azure_active_directory_role_based_access_control_server_app_secret) or service_principal(client_secret). Pass null if not required
    kubernetes_cluster_key_vault_resource_group_name                              = string #(Optional) To be provided for the kubernetes_cluster_key_vault_name  resource group
    kubernetes_cluster_key_vault_certificate_name                                 = string #(Optional) Specifies the name of the Key Vault Certificate which contain the list of up to 10 base64 encoded CAs that will be added to the trust store on nodes with the custom_ca_trust_enabled feature enabled.
    kubernetes_cluster_default_node_pool_name                                     = string #(Required) The name which should be used for the default Kubernetes Node Pool. Changing this forces a new resource to be created.must start with a lowercase letter, have max length of 12, and only have characters a-z0-9.
    kubernetes_cluster_default_node_pool_capacity_reservation_group_name          = string #(Optional) provide the linux kubernetes_cluster capacity reservation group name
    kubernetes_cluster_default_node_pool_capacity_reservation_resource_group_name = string #(Optional) provide the capacity reservation group resource group name
    kubernetes_cluster_default_node_pool_vm_size                                  = string #(Required) The size of the Virtual Machine, such as Standard_DS2_v2. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_custom_ca_trust_enabled                  = bool   #(Optional) Specifies whether to trust a Custom CA.
    kubernetes_cluster_default_node_pool_key_vault_certificate_name               = string #(Optional) Specifies the name of the Key Vault Certificate. If kubernetes_cluster_default_node_pool_custom_ca_trust_enabled is set to true, then this is Required.
    kubernetes_cluster_default_node_pool_enable_auto_scaling                      = bool   #(Optional) Should the Kubernetes Auto Scaler be enabled for this Node Pool? Defaults to false. This requires that the type is set to VirtualMachineScaleSets
    kubernetes_cluster_default_node_pool_workload_runtime                         = string #(Optional) Specifies the workload runtime used by the node pool. Possible values are OCIContainer and KataMshvVmIsolation.
    kubernetes_cluster_default_node_pool_enable_host_encryption                   = bool   #(Optional) Should the nodes in the Default Node Pool have host encryption enabled? Defaults to false
    kubernetes_cluster_default_node_pool_enable_node_public_ip                    = bool   #(Optional) Should nodes in this Node Pool have a Public IP Address? Defaults to false. Changing this forces a new resource to be created.
    kubernetes_cluster_workload_identity_enabled                                  = bool   #(Optional) Specifies whether Azure AD Workload Identity should be enabled for the Cluster. Defaults to false.
    kubernetes_cluster_default_node_pool_kubelet_config = object({                         #(Optional) Configures the nodes kublet service config. Assign as null if not required 
      kubelet_config_allowed_unsafe_sysctls    = list(string)                              #(Optional) Specifies the allow list of unsafe sysctls command or patterns (ending in *). Changing this forces a new resource to be created.
      kubelet_config_container_log_max_line    = number                                    #(Optional) Specifies the maximum number of container log files that can be present for a container. must be at least 2. Changing this forces a new resource to be created.
      kubelet_config_container_log_max_size_mb = string                                    #(Optional) Specifies the maximum size (e.g. 10MB) of container log file before it is rotated. Changing this forces a new resource to be created.
      kubelet_config_cpu_cfs_quota_enabled     = bool                                      #(Optional) Is CPU CFS quota enforcement for containers enabled? Changing this forces a new resource to be created.
      kubelet_config_cpu_cfs_quota_period      = number                                    #(Optional) Specifies the CPU CFS quota period value. Changing this forces a new resource to be created.
      kubelet_config_cpu_manager_policy        = string                                    #(Optional) Specifies the CPU Manager policy to use. Possible values are none and static, Changing this forces a new resource to be created.
      kubelet_config_image_gc_high_threshold   = number                                    #(Optional) Specifies the percent of disk usage above which image garbage collection is always run. Must be between 0 and 100. Changing this forces a new resource to be created.
      kubelet_config_image_gc_low_threshold    = number                                    #(Optional) Specifies the percent of disk usage lower than which image garbage collection is never run. Must be between 0 and 100. Changing this forces a new resource to be created.
      kubelet_config_pod_max_pid               = number                                    #(Optional) Specifies the maximum number of processes per pod. Changing this forces a new resource to be created.
      kubelet_config_topology_manager_policy   = string                                    #(Optional) Specifies the Topology Manager policy to use. Possible values are none, best-effort, restricted or single-numa-node. Changing this forces a new resource to be created.
    })
    kubernetes_cluster_default_node_pool_linux_os_config = object({ #Optional.  Assign as null if not required
      linux_os_config_swap_file_size_mb = number                    #(Optional) Specifies the size of swap file on each node in MB. Changing this forces a new resource to be created.
      sysctl_config = object({                                      #(Optional) A sysctl_config block as defined below. Assign as null if not required. Changing this forces a new resource to be created.
        sysctl_config_fs_aio_max_nr                      = number   #(Optional) The sysctl setting fs.aio-max-nr. Must be between 65536 and 6553500. 
        sysctl_config_fs_file_max                        = number   #(Optional) The sysctl setting fs.file-max. Must be between 8192 and 12000500. 
        sysctl_config_fs_inotify_max_user_watches        = number   #(Optional) The sysctl setting fs.inotify.max_user_watches. Must be between 781250 and 2097152. 
        sysctl_config_fs_nr_open                         = number   #(Optional) The sysctl setting fs.nr_open. Must be between 8192 and 20000500. 
        sysctl_config_kernel_threads_max                 = number   #(Optional) The sysctl setting kernel.threads-max. Must be between 20 and 513785. 
        sysctl_config_net_core_netdev_max_backlog        = number   #(Optional) The sysctl setting net.core.netdev_max_backlog. Must be between 1000 and 3240000. 
        sysctl_config_net_core_optmem_max                = number   #(Optional) The sysctl setting net.core.optmem_max. Must be between 20480 and 4194304. 
        sysctl_config_net_core_rmem_default              = number   #(Optional) The sysctl setting net.core.rmem_default. Must be between 212992 and 134217728. 
        sysctl_config_net_core_rmem_max                  = number   #(Optional) The sysctl setting net.core.rmem_max. Must be between 212992 and 134217728. 
        sysctl_config_net_core_somaxconn                 = number   #(Optional) The sysctl setting net.core.somaxconn. Must be between 4096 and 3240000. 
        sysctl_config_net_core_wmem_default              = number   #(Optional) The sysctl setting net.core.wmem_default. Must be between 212992 and 134217728. 
        sysctl_config_net_core_wmem_max                  = number   #(Optional) The sysctl setting net.core.wmem_max. Must be between 212992 and 134217728. 
        sysctl_config_net_ipv4_ip_local_port_range_max   = number   #(Optional) The sysctl setting net.ipv4.ip_local_port_range max value. Must be between 1024 and 60999. 
        sysctl_config_net_ipv4_ip_local_port_range_min   = number   #(Optional) The sysctl setting net.ipv4.ip_local_port_range min value. Must be between 1024 and 60999.
        sysctl_config_net_ipv4_neigh_default_gc_thresh1  = number   #(Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh1. Must be between 128 and 80000. 
        sysctl_config_net_ipv4_neigh_default_gc_thresh2  = number   #(Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh2. Must be between 512 and 90000. 
        sysctl_config_net_ipv4_neigh_default_gc_thresh3  = number   #(Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh3. Must be between 1024 and 100000. 
        sysctl_config_net_ipv4_tcp_fin_timeout           = number   #(Optional) The sysctl setting net.ipv4.tcp_fin_timeout. Must be between 5 and 120.
        sysctl_config_net_ipv4_tcp_keepalive_intvl       = number   #(Optional) The sysctl setting net.ipv4.tcp_keepalive_intvl. Must be between 10 and 75.
        sysctl_config_net_ipv4_tcp_keepalive_probes      = number   #(Optional) The sysctl setting net.ipv4.tcp_keepalive_probes. Must be between 1 and 15.
        sysctl_config_net_ipv4_tcp_keepalive_time        = number   #(Optional) The sysctl setting net.ipv4.tcp_keepalive_time. Must be between 30 and 432000
        sysctl_config_net_ipv4_tcp_max_syn_backlog       = number   #(Optional) The sysctl setting net.ipv4.tcp_max_syn_backlog. Must be between 128 and 3240000.
        sysctl_config_net_ipv4_tcp_max_tw_buckets        = number   #(Optional) The sysctl setting net.ipv4.tcp_max_tw_buckets. Must be between 8000 and 1440000.
        sysctl_config_net_ipv4_tcp_tw_reuse              = bool     #(Optional) The sysctl setting net.ipv4.tcp_tw_reuse. 
        sysctl_config_net_netfilter_nf_conntrack_buckets = number   #(Optional) The sysctl setting net.netfilter.nf_conntrack_buckets. Must be between 65536 and 147456
        sysctl_config_net_netfilter_nf_conntrack_max     = number   #(Optional) The sysctl setting net.netfilter.nf_conntrack_max. Must be between 131072 and 1048576
        sysctl_config_vm_max_map_count                   = number   #(Optional) The sysctl setting vm.max_map_count. Must be between 65530 and 262144. 
        sysctl_config_vm_swappiness                      = number   #(Optional) The sysctl setting vm.swappiness. Must be between 0 and 100.
        sysctl_config_vm_vfs_cache_pressure              = number   #(Optional) The sysctl setting vm.vfs_cache_pressure. Must be between 0 and 100
      })
      linux_os_config_transparent_huge_page_defrag  = string #(Optional) specifies the defrag configuration for Transparent Huge Page. Possible values are always, defer, defer+madvise, madvise and never. Changing this forces a new resource to be created.
      linux_os_config_transparent_huge_page_enabled = string #(Optional) Specifies the Transparent Huge Page enabled configuration. Possible values are always, madvise and never. Changing this forces a new resource to be created.
    })
    kubernetes_cluster_default_node_pool_fips_enabled                                  = bool        #(Optional) Should the nodes in this Node Pool have Federal Information Processing Standard enabled? Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_kubelet_disk_type                             = string      #(Optional) The type of disk used by kubelet. Possible values are OS and Temporary.
    kubernetes_cluster_default_node_pool_max_pods                                      = number      #(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created.
    kubernetes_cluster_message_of_the_day                                              = string      #(Optional) A base64-encoded string which will be written to /etc/motd after decoding. This allows customization of the message of the day for Linux nodes. It cannot be specified for Windows nodes and must be a static string (i.e. will be printed raw and not executed as a script). Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_node_public_ip_prefix_name                    = string      #(Optional) Resource name for the Public IP Addresses Prefix for the nodes in this Node Pool. enable_node_public_ip should be true. Changing this forces a new resource to be created. 
    kubernetes_cluster_default_node_pool_node_public_ip_prefix_resource_group_name     = string      #(Optional) Resource group name for the Public IP Addresses Prefix for the nodes in this Node Pool. enable_node_public_ip should be true. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_is_host_group_id_required                     = bool        #(Required)Boolean value if host group id required
    kubernetes_cluster_default_node_pool_dedicated_host_group_name                     = string      #(Optional) Specifies the Name of the Host Group within which this AKS Cluster should be created. Required if kubernetes_cluster_is_host_group_id_required is set to true.
    kubernetes_cluster_default_node_pool_dedicated_host_group_resource_group_name      = string      #(Optional) Specifies the Resource Group Name of the Host Group. Required if  kubernetes_cluster_is_host_group_id_required is set to true.
    kubernetes_cluster_default_node_pool_node_labels                                   = map(string) #(Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool.
    kubernetes_cluster_default_node_pool_only_critical_addons_enabled                  = bool        #(Optional) Enabling this option will taint default node pool with CriticalAddonsOnly=true:NoSchedule taint. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_orchestrator_version                          = string      #(Optional) Version of Kubernetes used for the Agents. If not specified, the default node pool will be created with the version specified by kubernetes_version. If both are unspecified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). This version must be supported by the Kubernetes Cluster - as such the version of Kubernetes used on the Cluster/Control Plane may need to be upgraded first.
    kubernetes_cluster_default_node_pool_os_disk_size_gb                               = number      #(Optional) The size of the OS Disk which should be used for each agent in the Node Pool. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_os_disk_type                                  = string      #(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_os_sku                                        = string      #(Optional) OsSKU to be used to specify Linux OSType. Not applicable to Windows OSType. Possible values include: Ubuntu, CBLMariner. Defaults to Ubuntu. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_is_proximity_placement_group_id_required      = bool        #(Required)Boolean value if proximity placement group id required
    kubernetes_cluster_default_node_pool_proximity_placement_group_name                = string      #(Optional) Provide proximity placement group name if kubernetes_cluster_is_proximity_placement_group_id_required is set to true
    kubernetes_cluster_default_node_pool_proximity_placement_group_resource_group_name = string      #(Optional) Provide proximity placement group resource group name if kubernetes_cluster_is_proximity_placement_group_id_required is set to true
    kubernetes_cluster_default_node_pool_pod_scale_down_mode                           = string      #(Optional) Specifies the autoscaling behaviour of the Kubernetes Cluster. Allowed values are Delete and Deallocate. Defaults to Delete.
    kubernetes_cluster_default_node_pool_is_snapshot_id_required                       = bool        #(Required)Boolean value if snapshot id required
    kubernetes_cluster_default_node_pool_snapshot_name                                 = string      #(Optional) Provide snapshot name if kubernetes_cluster_default_node_pool_is_snapshot_id_required is set to true
    kubernetes_cluster_default_node_pool_snapshot_resource_group_name                  = string      #(Optional) Provide snapshot resource group name if kubernetes_cluster_default_node_pool_is_snapshot_id_required is set to true
    kubernetes_cluster_default_node_pool_temporary_name_for_rotation                   = string      #(Optional) Specifies the name of the temporary node pool used to cycle the default node pool for VM resizing.
    kubernetes_cluster_default_node_pool_pod_virtual_network_name                      = string      #(Optional) The name of the Virtual Network where the pods in the default Node Pool should exist.
    kubernetes_cluster_default_node_pool_pod_subnet_name                               = string      #(Optional) The name of the Subnet where the pods in the default Node Pool should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_pod_virtual_network_resource_group_name       = string      #(Optional) The name of the Resource Group where the pods Virtual Network exist
    kubernetes_cluster_default_node_pool_type                                          = string      #(Optional) The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets. Defaults to VirtualMachineScaleSets.
    kubernetes_cluster_default_node_pool_tags                                          = map(string) #(Optional) A mapping of tags to assign to the Node Pool.
    kubernetes_cluster_default_node_pool_ultra_ssd_enabled                             = bool        #(Optional) Used to specify whether the UltraSSD is enabled in the Default Node Pool. Defaults to false
    kubernetes_cluster_node_network_profile = object({                                               #(Optional) Node Network Profile for Kubernetes Cluster
      node_network_profile_node_public_ip_tags = map(string)                                         #(Optional) Specifies a mapping of tags to the instance-level public IPs. Changing this forces a new resource to be created.                              
    })
    kubernetes_cluster_default_node_pool_upgrade_settings = object({ #(Optional) upgrade_settings
      upgrade_settings_max_surge = number                            #(Required) The maximum number or percentage of nodes which will be added to the Node Pool size during an upgrade.
    })
    kubernetes_cluster_default_node_pool_virtual_network_name                = string       #(Optional) Name of VNet for assigning default node pool to a subnet
    kubernetes_cluster_default_node_pool_virtual_network_resource_group_name = string       #(Optional) Name of VNet's resource group for assigning default node pool to a subnet
    kubernetes_cluster_default_node_pool_subnet_name                         = string       #(Optional) Name of Subnet for assigning default node pool to a subnet . A Route Table must be configured on this Subnet.
    kubernetes_cluster_default_node_pool_max_count                           = number       #(Optional) The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000.
    kubernetes_cluster_default_node_pool_min_count                           = number       #(Optional) The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000
    kubernetes_cluster_default_node_pool_node_count                          = number       #(Optional) The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 and between min_count and max_count.
    kubernetes_cluster_default_node_pool_availability_zones                  = list(string) #(Optional) Specifies a list of Availability Zones in which this Kubernetes Cluster should be located. Changing this forces a new Kubernetes Cluster to be created.  
    kubernetes_cluster_dns_prefix                                            = string       #(Optional) DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created. One of dns_prefix or dns_prefix_private_cluster must be specified. The dns_prefix must contain between 3 and 45 characters, and can contain only letters, numbers, and hyphens. It must start with a letter and must end with a letter or a number.
    kubernetes_cluster_dns_prefix_private_cluster                            = string       #(Optional) Specifies the DNS prefix to use with private clusters. Changing this forces a new resource to be created. One of dns_prefix or dns_prefix_private_cluster must be specified. The dns_prefix must contain between 3 and 45 characters, and can contain only letters, numbers, and hyphens. It must start with a letter and must end with a letter or a number.
    kubernetes_cluster_aci_connector_linux = object({                                       #(Optional) Set this up to use Virtual Nodes. Assign null if not required.
      aci_connector_linux_subnet_name = string                                              #(Required) The subnet name for the virtual nodes to run. AKS will add a delegation to the subnet named here. To prevent further runs from failing you should make sure that the subnet you create for virtual nodes has a delegation
    })
    kubernetes_cluster_automatic_channel_upgrade       = string       #(Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, node-image and stable. Omitting this field sets this value to none. Cluster Auto-Upgrade will update the Kubernetes Cluster (and its Node Pools) to the latest GA version of Kubernetes automatically and will not update to Preview versions.
    kubernetes_cluster_api_server_authorized_ip_ranges = list(string) # (Optional) The IP ranges to allow for incoming traffic to the server nodes.

    kubernetes_cluster_api_server_access_profile = object({               #(Optional) For API Server Access Profile setup. Assign null if not required
      api_server_access_profile_authorized_ip_ranges       = list(string) #(Optional) Set of authorized IP ranges to allow access to API server, e.g. ["198.51.100.0/24"].
      api_server_access_profile_vnet_integration_enabled   = bool         #(Optional) Should API Server VNet Integration be enabled?
      api_server_access_profile_subnet_exists              = bool         #(Required). Assign true if the Subnet where the API server endpoint is delegated to exists.
      api_server_access_profile_subnet_name                = string       #(Optional) The name of the subnet where the API server endpoint is delegated to.
      api_server_access_profile_subnet_resource_group_name = string       #(Optional) Name of the resource group where the subnet exist
      api_server_access_profile_virtual_network_name       = string       #(Optional) Name of the virtual network which the subnet belongs to
    })

    kubernetes_cluster_auto_scaler_profile = object({               #(Optional) For auto scaler setup. Assign null if not required
      auto_scaler_profile_balance_similar_node_groups      = bool   #Detect similar node groups and balance the number of nodes between them. Defaults to false
      auto_scaler_profile_expander                         = string #Expander to use. Possible values are least-waste, priority, most-pods and random. Defaults to random
      auto_scaler_profile_max_graceful_termination_sec     = number #Maximum number of seconds the cluster autoscaler waits for pod termination when trying to scale down a node. Defaults to 600
      auto_scaler_profile_max_node_provisioning_time       = string # Maximum time the autoscaler waits for a node to be provisioned. Defaults to 15m.
      auto_scaler_profile_max_unready_nodes                = number #Maximum Number of allowed unready nodes. Defaults to 3
      auto_scaler_profile_max_unready_percentage           = number #Maximum percentage of unready nodes the cluster autoscaler will stop if the percentage is exceeded. Defaults to 45
      auto_scaler_profile_new_pod_scale_up_delay           = string #For scenarios like burst/batch scale where you don't want CA to act before the kubernetes scheduler could schedule all the pods, you can tell CA to ignore unscheduled pods before they're a certain age. Defaults to 10s.
      auto_scaler_profile_scale_down_delay_after_add       = string #How long after the scale up of AKS nodes the scale down evaluation resumes. Defaults to 10m
      auto_scaler_profile_scale_down_delay_after_delete    = string #How long after node deletion that scale down evaluation resumes. Defaults to the value used for scan_interval
      auto_scaler_profile_scale_down_delay_after_failure   = string #How long after scale down failure that scale down evaluation resumes. Defaults to 3m
      auto_scaler_profile_scan_interval                    = string #How often the AKS Cluster should be re-evaluated for scale up/down. Defaults to 10s
      auto_scaler_profile_scale_down_unneeded              = string #How long a node should be unneeded before it is eligible for scale down. Defaults to 10m
      auto_scaler_profile_scale_down_unready               = string #How long an unready node should be unneeded before it is eligible for scale down. Defaults to 20m
      auto_scaler_profile_scale_down_utilization_threshold = number #Node utilization level, defined as sum of requested resources divided by capacity, below which a node can be considered for scale down. Defaults to 0.5.
      auto_scaler_profile_empty_bulk_delete_max            = number #Maximum number of empty nodes that can be deleted at the same time. Defaults to 10
      auto_scaler_profile_skip_nodes_with_local_storage    = bool   #If true cluster autoscaler will never delete nodes with pods with local storage, for example, EmptyDir or HostPath. Defaults to true
      auto_scaler_profile_skip_nodes_with_system_pods      = bool   #If true cluster autoscaler will never delete nodes with pods from kube-system (except for DaemonSet or mirror pods). Defaults to true
    })
    kubernetes_cluster_azure_active_directory_role_based_access_control = object({ #(Optional) Assign null if not required. Defines azure AD based RBAC settings 
      azure_active_directory_role_based_access_control_managed   = bool            #(Optional) Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration.
      azure_active_directory_role_based_access_control_tenant_id = string          #(Optional) The Tenant ID used for Azure Active Directory Application. If this isn't specified the Tenant ID of the current Subscription is used.
      # azure_active_directory_role_based_access_control_managed is set to true for using below properties
      azure_active_directory_role_based_access_control_admin_group_object_ids = list(string) #(Optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster.
      azure_active_directory_role_based_access_control_azure_rbac_enabled     = bool         #(Optional) Is Role Based Access Control based on Azure AD enabled
      # azure_active_directory_role_based_access_control_managed must be set to false to use below properties
      azure_active_directory_role_based_access_control_client_app_id          = string #(Required) The Client ID of an Azure Active Directory Application.
      azure_active_directory_role_based_access_control_server_app_id          = string #(Required) The Server ID of an Azure Active Directory Application.
      azure_active_directory_role_based_access_control_server_app_secret_name = string #(Required) The Server Secret of an Azure Active Directory Application.
    })

    kubernetes_cluster_confidential_computing = object({     #(Optional) A confidential_computing block as defined below
      confidential_computing_sgx_quote_helper_enabled = bool #(Required) Should the SGX quote helper be enabled?
    })

    kubernetes_cluster_workload_autoscaler_profile = object({            #(Optional) A workload_autoscaler_profile block defined below.
      workload_autoscaler_profile_keda_enabled                    = bool #(Optional) Specifies whether KEDA Autoscaler can be used for workloads.
      workload_autoscaler_profile_vertical_pod_autoscaler_enabled = bool #(Optional) Specifies whether Vertical Pod Autoscaler should be enabled.
    })
    kubernetes_cluster_azure_policy_enabled = bool #(Optional) Should the Azure Policy Add-On be enabled

    kubernetes_cluster_disk_encryption_set_name                = string #(Optional) The name of the Disk Encryption Set which should be used for the Nodes and Volumes. Set to null if not required.
    kubernetes_cluster_disk_encryption_set_resource_group_name = string #(Optional) The resource group of the Disk Encryption Set which should be used for the Nodes and Volumes. Set to null if not required.
    kubernetes_cluster_edge_zone                               = string #(Optional) Specifies the Edge Zone within the Azure Region where this Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_http_application_routing_enabled        = bool   #(Optional) Should HTTP Application Routing be enabled
    kubernetes_cluster_image_cleaner_enabled                   = bool   #(Optional) Specifies whether Image Cleaner is enabled.
    kubernetes_cluster_image_cleaner_interval_hours            = number #(Optional) Specifies the interval in hours when images should be cleaned up. Defaults to 48.
    kubernetes_cluster_http_proxy_config = object({                     #Optional. Pass as null if not required
      http_proxy_config_http_proxy  = string                            #(Optional) The proxy address to be used when communicating over HTTP.
      http_proxy_config_https_proxy = string                            #(Optional) The proxy address to be used when communicating over HTTPS.
      http_proxy_config_no_proxy    = string                            #(Optional) The list of domains that will not use the proxy for communication.
      http_proxy_trusted_ca         = string                            #(Optional) The base64 encoded alternative CA certificate content in PEM format.
    })
    kubernetes_cluster_identity = object({ #One of either identity or service_principal must be specified. Assign null if not required. Defines the kubernetes cluster identity to be used
      identity_type = string               #(Required) Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      identity_ids = list(object({         #(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster.    
        identity_name                = string
        identity_resource_group_name = string
      }))
    })
    kubernetes_cluster_web_app_routing = object({      #(Required) Specifies the ID of the DNS Zone in which DNS entries are created for applications deployed to the cluster when Web App Routing is enabled.
      web_app_routing_dns_zone_name           = string #(Required) Specifies the name of the DNS Zone in which DNS entries are created for applications deployed to the cluster when Web App Routing is enabled.  
      web_app_routing_dns_zone_resource_group = string #(Required) Specifies the resourec group of the DNS Zone in which DNS entries are created for applications deployed to the cluster when Web App Routing is enabled.
    })

    kubernetes_cluster_ingress_application_gateway = object({         #(Optional) Assign null if not required. Defines AGIC ingress controller application gateway 
      ingress_application_gateway_exists                     = bool   #(Required) Assign true if the application gateway already exists. Assign false if new Application gateway needs to be created
      ingress_application_gateway_resource_group_name        = string #(Optional) Name of the resource group where the ingress application gateway exists
      ingress_application_gateway_name                       = string #(Required)  The name of the Application Gateway to be used or created in the Nodepool Resource Group, which in turn will be integrated with the ingress controller of this Kubernetes Cluster.
      ingress_application_gateway_subnet_exists              = bool   #(Required). Assign true if the application gateway already exists. Assign false if new Application gateway needs to be created
      ingress_application_gateway_subnet_cidr                = string #(Optional) The subnet CIDR to be used to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. Pass this value or either ingress_application_gateway_subnet_name
      ingress_application_gateway_subnet_name                = string #(Optional) The name of the subnet on which to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. Pass this value or either ingress_application_gateway_subnet_cidr
      ingress_application_gateway_subnet_resource_group_name = string #(Optional) Name of the resource group where the subnet exist
      ingress_application_gateway_virtual_network_name       = string #(Optional) Name of the virtual network which the subnet belongs to
    })

    kubernetes_cluster_key_management_service = object({       #(Optional) Assign null if not required. refer https://learn.microsoft.com/en-us/azure/aks/use-kms-etcd-encryption for details 
      key_management_service_key_vault_key_name       = string #(Required) Name of Azure Key Vault key. When Azure Key Vault key management service is enabled, this field is required and must be a valid key identifier. When enabled is false, leave the field empty. 
      key_management_service_key_vault_network_access = string # (Optional) Network access of the key vault Network access of key vault. The possible values are Public and Private. Public means the key vault allows public access from all networks. Private means the key vault disables public access and enables private link. The default value is Public.
    })

    kubernetes_cluster_key_vault_secrets_provider = object({       #(Optional) Assign null if not required. refer https://learn.microsoft.com/en-us/azure/aks/csi-secrets-store-driver for details 
      key_vault_secrets_provider_secret_rotation_enabled  = bool   #(Optional) Should the secret store CSI driver on the AKS cluster be enabled?
      key_vault_secrets_provider_secret_rotation_interval = string #(Required) The interval to poll for secret rotation. This attribute is only set when secret_rotation is true and defaults to 2m
    })

    kubernetes_cluster_kubelet_identity = object({                    #Optional. Pass as null if not required. Block defines the identities to be assigned to kubelet
      kubelet_identity_client_id                             = string #(Required) The Client ID of the user-defined Managed Identity to be assigned to the Kubelets. If not specified a Managed Identity is created automatically.
      kubelet_identity_object_id                             = string #(Required) The Object ID of the user-defined Managed Identity assigned to the Kubelets.If not specified a Managed Identity is created automatically.
      kubelet_identity_user_assigned_identity_name           = string #(Required) The ID of the User Assigned Identity assigned to the Kubelets. If not specified a Managed Identity is created automatically.
      kubelet_identity_user_assigned_identity_resource_group = string #(Required) The ID of the User Assigned Identity assigned to the Kubelets. If not specified a Managed Identity is created automatically.
    })

    kubernetes_cluster_kubernetes_version = string                #(Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade).
    kubernetes_cluster_linux_profile = object({                   #(Optional) Pass as null if not required. Changing any parameter forces a new resource to be created.
      linux_profile_admin_username_key_vault_secret_name = string #(Required) Pass the secret name where the adminuser name is stored. Pass null if not stored in key vault
      linux_profile_admin_username                       = string #(Optional) The Admin Username for the Cluster if it is not present in key vault 
      linux_profile_ssh_key_secret_exist                 = bool   #(Required) Set true if the public key is present in key vault. Set false where a new public and private key is generated. Public key will be stored in name provided in linux_profile_ssh_key_secret_name, private key will be stored in the same secret name appended with private. Keys generated using RSA algo with 4096 rsa bits
      linux_profile_ssh_key_secret_name                  = string #(Required) If linux_profile_ssh_key_secret_exist is true then the secret is fetched from the given secret name else the new public key generated is stored in given secret name
    })
    kubernetes_cluster_local_account_disabled = bool #(Optional) If true local accounts will be disabled. Defaults to false. If local_account_disabled is set to true, it is required to enable Kubernetes RBAC and AKS-managed Azure AD integration. 
    kubernetes_cluster_maintenance_window = object({ #(Optional) Pass as null if not required.
      maintenance_window_allowed = list(object({     #(Optional) Pass as null if not required.
        allowed_day   = string                       #(Required) A day in a week. Possible values are Sunday, Monday, Tuesday, Wednesday, Thursday, Friday and Saturday.
        allowed_hours = number                       #(Required) An array of hour slots in a day. For example, specifying 1 will allow maintenance from 1:00am to 2:00am. Specifying 1, 2 will allow maintenance from 1:00am to 3:00m. Possible values are between 0 and 23.
      }))
      maintenance_window_not_allowed = list(object({ #(Optional) Pass as null if not required.
        not_allowed_end   = string                   #(Required) The end of a time span, formatted as an RFC3339 string.
        not_allowed_start = string                   #(Required) The start of a time span, formatted as an RFC3339 string.
      }))
    })

    kubernetes_cluster_maintenance_window_auto_upgrade = object({ #(Optional) Pass as null if not required.
      maintenance_window_auto_upgrade_frequency   = string        #(Required) Frequency of maintenance. Possible options are Weekly, AbsoluteMonthly and RelativeMonthly.
      maintenance_window_auto_upgrade_interval    = string        #(Required) The interval for maintenance runs. Depending on the frequency this interval is week or month based.
      maintenance_window_auto_upgrade_duration    = number        #(Required) The duration of the window for maintenance to run in hours.
      maintenance_window_auto_upgrade_day_of_week = string        #(Optional) The day of the week for the maintenance run. Options are Monday, Tuesday, Wednesday, Thurday, Friday, Saturday and Sunday. Required in combination with weekly frequency.
      maintenance_window_auto_upgrade_week_index  = string        #(Optional) The week in the month used for the maintenance run. Options are First, Second, Third, Fourth, and Last. Required in combination with relative monthly frequency.
      maintenance_window_auto_upgrade_start_time  = string        #(Optional) The time for maintenance to begin, based on the timezone determined by utc_offset. Format is HH:mm.
      maintenance_window_auto_upgrade_utc_offset  = string        #(Optional) Used to determine the timezone for cluster maintenance.
      maintenance_window_auto_upgrade_start_date  = string        #(Optional) The date on which the maintenance window begins to take effect.
      maintenance_window_auto_upgrade_not_allowed = list(object({ #(Optional) Pass as null if not required.
        not_allowed_end   = string                                #(Required) The end of a time span, formatted as an RFC3339 string.
        not_allowed_start = string                                #(Required) The start of a time span, formatted as an RFC3339 string.
      }))
    })

    kubernetes_cluster_maintenance_window_node_os = object({ #(Optional) Pass as null if not required.
      maintenance_window_node_os_frequency   = string        #(Required) Frequency of maintenance. Possible options are Weekly, AbsoluteMonthly and RelativeMonthly.
      maintenance_window_node_os_interval    = string        #(Required) The interval for maintenance runs. Depending on the frequency this interval is week or month based.
      maintenance_window_node_os_duration    = number        #(Required) The duration of the window for maintenance to run in hours.
      maintenance_window_node_os_day_of_week = string        #(Optional) The day of the week for the maintenance run. Options are Monday, Tuesday, Wednesday, Thurday, Friday, Saturday and Sunday. Required in combination with weekly frequency.
      maintenance_window_node_os_week_index  = string        #(Optional) The week in the month used for the maintenance run. Options are First, Second, Third, Fourth, and Last. Required in combination with relative monthly frequency.
      maintenance_window_node_os_start_time  = string        #(Optional) The time for maintenance to begin, based on the timezone determined by utc_offset. Format is HH:mm.
      maintenance_window_node_os_utc_offset  = string        #(Optional) Used to determine the timezone for cluster maintenance.
      maintenance_window_node_os_start_date  = string        #(Optional) The date on which the maintenance window begins to take effect.
      maintenance_window_node_os_not_allowed = list(object({ #(Optional) Pass as null if not required.
        not_allowed_end   = string                           #(Required) The end of a time span, formatted as an RFC3339 string.
        not_allowed_start = string                           #(Required) The start of a time span, formatted as an RFC3339 string.
      }))
    })

    kubernetes_cluster_microsoft_defender = object({                #(Optional) Pass as null if not required.
      microsoft_defender_log_analytics_workspace_name      = string #(Required) Specifies the name of the Log Analytics Workspace where the audit logs collected by Microsoft Defender should be sent to.
      microsoft_defender_log_analytics_resource_group_name = string ##(Required) Specifies the resource group name of the Log Analytics Workspace where the audit logs collected by Microsoft Defender should be sent to.
    })

    kubernetes_cluster_monitor_metrics = object({        #(Optional) Specifies a Prometheus add-on profile for the Kubernetes Cluster. 
      monitor_metrics_annotations_allowed = list(string) #(Optional) Specifies a comma-separated list of Kubernetes annotation keys that will be used in the resource's labels metric.
      monitor_metrics_labels_allowed      = list(string) #(Optional) Specifies a Comma-separated list of additional Kubernetes label keys that will be used in the resource's labels metric.
    })

    kubernetes_cluster_network_profile = object({                 #(Optional) Pass as null if not required.
      network_profile_network_plugin      = string                #(Required) Network plugin to use for networking. Currently supported values are azure, kubenet and none. Changing this forces a new resource to be created.When network_plugin is set to azure - the vnet_subnet_id field in the default_node_pool block must be set and pod_cidr must not be set.
      network_profile_network_mode        = string                #(Optional) Network mode to be used with Azure CNI. Possible values are bridge and transparent. Changing this forces a new resource to be created. network_mode can only be set to bridge for existing Kubernetes Clusters and cannot be used to provision new Clusters - this will be removed by Azure in the future. This property can only be set when network_plugin is set to azure 
      network_profile_network_policy      = string                #(Optional) Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created. When network_policy is set to azure, the network_plugin field can only be set to azure.
      network_profile_dns_service_ip      = string                #(Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created.
      network_profile_ebpf_data_plane     = string                #(Optional) Specifies the eBPF data plane used for building the Kubernetes network. Possible value is cilium. Disabling this forces a new resource to be created.
      network_profile_network_plugin_mode = string                #(Optional) Specifies the network plugin mode used for building the Kubernetes network. Possible value is overlay.
      network_profile_outbound_type       = string                #(Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer, userDefinedRouting, managedNATGateway and userAssignedNATGateway. Defaults to loadBalancer. Defaults to loadBalancer. Changing this forces a new resource to be created.
      network_profile_pod_cidr            = string                #(Optional) The CIDR to use for pod IP addresses. This field can only be set when network_plugin is set to kubenet. Changing this forces a new resource to be created.
      network_profile_pod_cidrs           = string                #(Optional) A list of CIDRs to use for pod IP addresses. For single-stack networking a single IPv4 CIDR is expected. For dual-stack networking an IPv4 and IPv6 CIDR are expected. Changing this forces a new resource to be created.
      network_profile_service_cidr        = string                #(Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created. This range should not be used by any network element on or connected to this VNet. Service address CIDR must be smaller than /12. docker_bridge_cidr, dns_service_ip and service_cidr should all be empty or all should be set.
      network_profile_service_cidrs       = list(string)          #(Optional) A list of CIDRs to use for Kubernetes services. For single-stack networking a single IPv4 CIDR is expected. For dual-stack networking an IPv4 and IPv6 CIDR are expected. Changing this forces a new resource to be created.
      network_profile_ip_versions         = list(string)          #(Optional) Specifies a list of IP versions the Kubernetes Cluster will use to assign IP addresses to its nodes and pods. Possible values are IPv4 and/or IPv6. IPv4 must always be specified. Changing this forces a new resource to be created. To configure dual-stack networking ip_versions should be set to ["IPv4", "IPv6"]
      network_profile_load_balancer_sku   = string                #(Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard. Defaults to standard. (Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard. Defaults to standard. Changing this forces a new resource to be created.
      network_profile_load_balancer_profile = object({            # (Optional) A load_balancer_profile block. This can only be specified when load_balancer_sku is set to standard. Pass as null if not required.
        load_balancer_profile_idle_timeout_in_minutes   = number  #(Optional) Desired outbound flow idle timeout in minutes for the cluster load balancer. Must be between 4 and 120 inclusive. Defaults to 30.
        load_balancer_profile_managed_outbound_ip_count = number  #(Optional) Count of desired managed outbound IPs for the cluster load balancer. Must be between 1 and 100 inclusive.
        load_balancer_profile_outbound_ip_address = list(object({ #(Optional) Pass as null if not required. 
          outbound_ip_address_name                = string        #(Optional) The names of the Public IP Addresses which should be used for outbound communication for the cluster load balancer.
          outbound_ip_address_resource_group_name = string        #(Optional) The names of the Public IP Addresses which should be used for outbound communication for the cluster load balancer.
        }))
        load_balancer_profile_outbound_ip_prefix_name                = string #(Optional) The name of the outbound Public IP Address Prefixes which should be used for the cluster load balancer.
        load_balancer_profile_outbound_ip_prefix_resource_group_name = string #(Optional) The resource group name of the outbound Public IP Address Prefixes which should be used for the cluster load balancer.
        load_balancer_profile_outbound_ports_allocated               = number #(Optional) Number of desired SNAT port for each VM in the clusters load balancer. Must be between 0 and 64000 inclusive. Defaults to 0.
        load_balancer_profile_managed_outbound_ipv6_count            = number # (Optional) The desired number of IPv6 outbound IPs created and managed by Azure for the cluster load balancer. Must be in the range of 1 to 100 (inclusive). The default value is 0 for single-stack and 1 for dual-stack. 
      })
      network_profile_nat_gateway_profile = object({           #(Optional) A nat_gateway_profile block. This can only be specified when load_balancer_sku is set to standard and outbound_type is set to managedNATGateway or userAssignedNATGateway.
        nat_gateway_profile_idle_timeout_in_minutes   = number #(Optional) Desired outbound flow idle timeout in minutes for the cluster load balancer. Must be between 4 and 120 inclusive. Defaults to 4.
        nat_gateway_profile_managed_outbound_ip_count = number #(Optional) Count of desired managed outbound IPs for the cluster load balancer. Must be between 1 and 100 inclusive.
      })
    })
    kubernetes_cluster_node_os_channel_upgrade  = string   #(Optional) The upgrade channel for this Kubernetes Cluster Nodes' OS Image. Possible values are Unmanaged, SecurityPatch, NodeImage and None.
    kubernetes_cluster_node_resource_group_name = string   #(Optional) The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created. Azure requires that a new, non-existent Resource Group is used, as otherwise the provisioning of the Kubernetes Service will fail.
    kubernetes_cluster_oidc_issuer_enabled      = bool     #Required) Enable or Disable the OIDC issuer URL
    kubernetes_cluster_oms_agent = object({                #(Optional) Pass as null if not required.
      oms_agent_log_analytics_workspace_name      = string #(Required) The Name of the Log Analytics Workspace which the OMS Agent should send data to.
      oms_agent_log_analytics_resource_group_name = string #(Required) The Resource Group of the Log Analytics Workspace which the OMS Agent should send data to.
      oms_agent_msi_auth_for_monitoring_enabled   = bool   #Is managed identity authentication for monitoring enabled?
    })

    kubernetes_cluster_service_mesh_profile = object({               #(Optional) Pass as null if not required.
      service_mesh_profile_mode                             = string #(Required) The mode of the service mesh. Possible value is Istio.
      service_mesh_profile_internal_ingress_gateway_enabled = bool   #(Optional) Is Istio Internal Ingress Gateway enabled?
      service_mesh_profile_external_ingress_gateway_enabled = bool   #(Optional) Is Istio External Ingress Gateway enabled?
    })

    kubernetes_cluster_open_service_mesh_enabled            = bool   #(Optional) Open Service Mesh needs to be enabled
    kubernetes_cluster_private_cluster_enabled              = bool   #(Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created.
    kubernetes_cluster_private_dns_zone_name                = string #(Optional)Use when kubernetes_cluster_private_cluster_enabled is set to true. Either the Name of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None. In case of None you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning. Changing this forces a new resource to be created.
    kubernetes_cluster_private_dns_zone_resource_group_name = string #(Optional)Resource Group name for kubernetes_cluster_private_dns_zone_name Assign null if not required.
    kubernetes_cluster_private_cluster_public_fqdn_enabled  = bool   #(Optional) Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to false.
    kubernetes_cluster_public_network_access_enabled        = bool   #(Optional) Whether public network access is allowed for this Kubernetes Cluster. Defaults to true. Changing this forces a new resource to be created. When public_network_access_enabled is set to true, 0.0.0.0/32 must be added to api_server_authorized_ip_ranges
    kubernetes_cluster_role_based_access_control_enabled    = bool   #(Optional) - Whether Role Based Access Control for the Kubernetes Cluster should be enabled. Defaults to true. Changing this forces a new resource to be created.
    kubernetes_cluster_run_command_enabled                  = bool   #(Optional) Whether to enable run command for the cluster or not. Defaults to true
    kubernetes_cluster_service_principal = object({                  #(Optional) A service_principal block as documented below. One of either identity or service_principal must be specified. Pass as null if not required
      service_principal_client_id          = string                  #(Required) The Client ID for the Service Principal.
      service_principal_client_secret_name = string                  #(Required) The Client Secret for the Service Principal.
    })

    kubernetes_cluster_storage_profile = object({          #(Optional) A storage_profile block as defined below.
      storage_profile_blob_driver_enabled         = bool   #(Optional) Is the Blob CSI driver enabled? Defaults to false.
      storage_profile_disk_driver_enabled         = bool   #(Optional) Is the Disk CSI driver enabled? Defaults to true.
      storage_profile_disk_driver_version         = string #(Optional) Disk CSI Driver version to be used. Possible values are v1 and v2. Defaults to v1.
      storage_profile_file_driver_enabled         = bool   #(Optional) Is the File CSI driver enabled? Defaults to true.
      storage_profile_snapshot_controller_enabled = bool   #(Optional) Is the Snapshot Controller enabled? Defaults to true.
    })

    kubernetes_cluster_sku_tier = string                            #(Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free.
    kubernetes_cluster_tags     = map(string)                       #(Optional) A mapping of tags to assign to the resource.   
    kubernetes_cluster_windows_profile = object({                   #(Optional) Pass as null if not required. Changing any parameter forces a new resource to be created.
      windows_profile_admin_username_key_vault_secret_name = string #(Required) Pass the secret name where the adminuser name is stored. Pass null if not stored in key vault
      windows_profile_admin_username                       = string #(Optional) The Admin Username for the Windows VMs if not present in key vault
      windows_profile_admin_password_secret_exist          = bool   #(Required) Set true if the password is present in key vault else new password will be generated 
      windows_profile_admin_password_secret_name           = string #(Required) If windows_profile_admin_password_secret_exist is true then the Admin Password is read from given secret else the new generated password is stored in the given secret. Length must be between 14 and 123 characters.
      windows_profile_admin_password_length                = number #(Required) Password Length. Length must be between 14 and 123 characters. Password generated will contain minimum of 4 lower case, 4 upper case, 2 numeric and 2 special character
      windows_profile_license                              = string #(Optional) Specifies the type of on-premise license which should be used for Node Pool Windows Virtual Machine. At this time the only possible value is Windows_Server
      kubernetes_cluster_gmsa = list(object({                       #(Optional) A gmsa block as defined below.
        gmsa_dns_server  = string                                   #(Required) Specifies the DNS server for Windows gMSA. Set this to an empty string if you have configured the DNS server in the VNet which was used to create the managed cluster.
        gmsa_root_domain = string                                   #(Required) Specifies the root domain name for Windows gMSA. Set this to an empty string if you have configured the DNS server in the VNet which was used to create the managed cluster.
      }))
    })
  }))
  default = {}
}
