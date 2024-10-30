#KEY VAULT VARIABLES
variable "key_vault_variables" {
  type = map(object({
    key_vault_name                                  = string       #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_resource_group_name                   = string       #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_location                              = string       #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_enabled_for_disk_encryption           = bool         #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = bool         #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = bool         # (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = bool         #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = string       #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = bool         #(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
    key_vault_sku_name                              = string       #(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium
    key_vault_access_container_agent_name           = string       #(Optional) Self hosted conatiner agent name.
    key_vault_access_policy_application_id          = string       #(Optional) The object ID of an Application in Azure Active Directory.
    key_vault_public_network_access_enabled         = bool         #(Optional) key_vault_public_network_access_enabled
    key_vault_access_policy_key_permissions         = list(string) #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey.
    key_vault_access_policy_secret_permissions      = list(string) #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = list(string) #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = list(string) #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update
    key_vault_tags                                  = map(string)  #(Optional) A mapping of tags which should be assigned to the key vault.
    key_vault_network_acls_enabled                  = bool         #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass                   = string       #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action           = string       # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
    key_vault_network_acls_ip_rules                 = list(string) # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.
    #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
    key_vault_network_acls_virtual_networks = list(object({
      key_vault_network_acls_virtual_networks_virtual_network_name    = string #(Required) Vitural Network name to be associated.
      key_vault_network_acls_virtual_networks_subnet_name             = string #(Required) Subnet Name to be associated.
      key_vault_network_acls_virtual_networks_subscription_id         = string #(Required) Subscription Id where Vnet is created.
      key_vault_network_acls_virtual_networks_virtual_network_rg_name = string #(Required) Resource group where Vnet is created.
    }))
    key_vault_contact_information_enabled = bool   #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email               = string #(Required) E-mail address of the contact.
    key_vault_contact_name                = string #(Optional) Name of the contact.
    key_vault_contact_phone               = string #(Optional) Phone number of the contact.
  }))
  description = "Map of Variables for Key Vault details"
  default = {
  }
}

#PRIVATE DNS ZONE VARIABLES
variable "private_dns_zone_variables" {
  type = map(object({
    private_dns_zone_name                = string #(Required) The name of the Private DNS Zone. Must be a valid domain name.
    private_dns_zone_resource_group_name = string #(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.
    private_dns_zone_soa_record = list(object({   #(Optional) An soa_record block as defined below. Changing this forces a new resource to be created.
      soa_record_email         = string           #(Required) The email contact for the SOA record.
      soa_record_expire_time   = number           #(Optional) The expire time for the SOA record. Defaults to 2419200.
      soa_record_minimum_ttl   = number           #(Optional) The minimum Time To Live for the SOA record. By convention, it is used to determine the negative caching duration. Defaults to 10.
      soa_record_refresh_time  = number           #(Optional) The refresh time for the SOA record. Defaults to 3600.
      soa_record_retry_time    = number           #(Optional) The retry time for the SOA record. Defaults to 300.
      soa_record_serial_number = number           #(optional) The serial number for the SOA record.
      soa_record_ttl           = number           #(Optional) The Time To Live of the SOA Record in seconds. Defaults to 3600.
      soa_record_tags          = map(string)      #(Optional) A mapping of tags to assign to the Record Set.
    }))
    private_dns_zone_tags = map(string)
  }))
  description = "Map of private dns zone"
  default     = {}
}

#PRIVATE ENDPOINT VARIABLES
variable "private_endpoint_variables" {
  type = map(object({
    private_endpoint_name                                = string #(Required) Specifies the Name of the Private Endpoint. Changing this forces a new resource to be created.
    private_endpoint_resource_group_name                 = string #(Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created.
    private_endpoint_location                            = string #(Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created.
    private_endpoint_virtual_network_name                = string #The name of the network interface associated with the private_endpoint
    private_endpoint_virtual_network_resource_group_name = string #(Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created.

    private_endpoint_subnet_name  = string #(Required) subnet in which private endpoint is hosting
    custom_network_interface_name = string #(Optional) The custom name of the network interface attached to the private endpoint. Changing this forces a new resource to be created.

    private_endpoint_private_dns_zone_group = object({    #(Optional) A private_dns_zone_group block as defined below.
      private_dns_zone_group_name          = string       #(Required) Specifies the Name of the Private DNS Zone Group.
      private_dns_zone_names               = list(string) #(Required) Specifies the list of Private DNS Zones names to include within the private_dns_zone_group.These names will be fetched by the data resource of private_dns_zone name.
      private_dns_zone_resource_group_name = string       #(Required) Specifies the resource group name of Private DNS Zones to include within the private_dns_zone_group.This will be fetched by the data resource of private_dns_zone resource group name.
    })

    private_endpoint_private_service_connection = object({           #(Required) A private_service_connection block as defined below.
      private_service_connection_name                 = string       #(Required) Specifies the Name of the Private Service Connection. Changing this forces a new resource to be created.
      private_service_connection_is_manual_connection = bool         #(Required) set true if resource_alias != null
      private_connection_resource_name                = string       #(Optional) The Service Name of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
      private_connection_resource_resource_group_name = string       #(Optional) The Service Resource Group Name of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
      private_connection_resource_alias               = string       #(Optional) The Service Alias of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
      request_message                                 = string       #(Optional) Should be enabled if the is_manual_connection is set as true.  A message passed to the owner of the remote resource
      subresource_names                               = list(string) # (Optional) A list of subresource names which the Private Endpoint is able to connect to.
    })

    private_endpoint_ip_configuration = map(object({ # (Optional) One or more ip_configuration blocks as defined below. This allows a static IP address to be set for this Private Endpoint, otherwise an address is dynamically allocated from the Subnet.
      ip_configuration_name               = string   #(Required) Specifies the Name of the IP Configuration. Changing this forces a new resource to be created.
      ip_configuration_private_ip_address = string   #(Required) Specifies the static IP address within the private endpoint's subnet to be used. Changing this forces a new resource to be created.
      ip_configuration_subresource_name   = string   #(Optional) A list of subresource names which the Private Endpoint is able to connect to.
      ip_configuration_member_name        = string   #(Optional) Specifies the member name this IP address applies to. If it is not specified, it will use the value of subresource_name. Changing this forces a new resource to be created.
    }))


    private_endpoint_tags = map(string) #(Optional)A mapping of tags to assign to the resource.
  }))
  description = "Map of private endpoint objects. name, subnet_id, is_manual_connection, private_connection_resource_id and subresource_names supported"
  default     = {}
}


# CONTAINER REGISTRY VARIABLES
variable "container_registry_variables" {
  type = map(object({
    container_registry_name                   = string #  (Required) Specifies the name of the Container Registry. Only Alphanumeric characters allowed. Changing this forces a new resource to be created.
    container_registry_resource_group_name    = string #   (Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created.
    container_registry_location               = string # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    container_registry_sku                    = string # (Required) The SKU name of the container registry. Possible values are Basic, Standard and Premium.
    container_registry_admin_enabled          = bool   # (Optional) Specifies whether the admin user is enabled. Defaults to false.
    container_registry_georeplication_enabled = bool   #(Required) Whether georeplications should be enabled for the container registry.If the this is true, Provide values to georeplications block
    container_registry_georeplications = list(object({
      georeplications_location                  = string      # (Required) A location where the container registry should be geo-replicated.
      georeplications_regional_endpoint_enabled = bool        # (Optional) Whether regional endpoint is enabled for this Container Registry? Defaults to false.
      georeplications_zone_redundancy_enabled   = bool        # (Optional) Whether zone redundancy is enabled for this replication location? Defaults to false.
      georeplications_tags                      = map(string) # (Optional) A mapping of tags to assign to this replication location.
    }))
    container_registry_network_rule_set_enabled = bool #(Required) Whether network rule set to be enabled for the container registry. if the value is true, Provide values to container_registry_network_rule_set block.
    container_registry_network_rule_set = object({
      network_rule_set_default_action = string #  (Optional) The behaviour for requests matching no rules. Either Allow or Deny. Defaults to Allow
      network_rule_set_ip_rule = list(object({ #(Optional) Block for ip_rue set.  set to null if ip rules are not required
        ip_rule_action   = string              # (Required) The behaviour for requests matching this rule. At this time the only supported value is Allow
        ip_rule_ip_range = string              # (Required) The CIDR block from which requests will match the rule.
      }))
      network_rule_set_virtual_network = list(object({ #(Optional) Block for ip_rue set.  set to null if network_rule_set rules are not required
        virtual_network_action               = string  # (Required) The behaviour for requests matching this rule. At this time the only supported value is Allow
        virtual_network_virtual_network_name = string  # (Required) The name of  virtual network name 
        virtual_network_subnet_name          = string  # (Required) The name of subnet
        virtual_network_resource_group_name  = string  # (Required) The resource group name of Virtual network
      }))
    })
    container_registry_public_network_access_enabled = bool # (Optional) Whether public network access is allowed for the container registry. Defaults to true.
    container_registry_quarantine_policy_enabled     = bool # (Optional) Boolean value that indicates whether quarantine policy is enabled. Defaults to false.
    container_registry_retention_policy = object({
      retention_policy_days    = number # (Optional) The number of days to retain an untagged manifest after which it gets purged. Default is 7.
      retention_policy_enabled = bool   # (Optional) Boolean value that indicates whether the policy is enabled.

    })
    container_registry_trust_policy = object({
      trust_policy_enabled = bool #  (Optional) Boolean value that indicates whether the policy is enabled.
    })
    container_registry_zone_redundancy_enabled = bool # (Optional) Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created. Defaults to false.
    container_registry_export_policy_enabled   = bool # (Optional) Boolean value that indicates whether export policy is enabled. Defaults to true. In order to set it to false, make sure the public_network_access_enabled is also set to false.
    container_registry_identity = object({
      identity_type = string # (Required) Specifies the type of Managed Service Identity that should be configured on this Container Registry. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      identity_identity_ids = list(object({
        identity_ids_identity_name                = string # (Required) The Name of the managed identity
        identity_ids_identity_resource_group_name = string # (Required) The name of resource group where identity is created.
      }))
    })

    container_registry_encryption = object({
      encryption_enabled                      = bool   #  (Required) Boolean value that indicates whether encryption is enabled. Set to false, if customer managed encryption is not required.
      encryption_identity_name                = string # (Required) The Name of the managed identity
      encryption_identity_resource_group_name = string # (Required) The name of resource group where identity is created.
      encryption_keyvault_name                = string # (Required)The name of the KeyVault where key is stored
      encryption_keyvault_key_name            = string # (Required) # The name of the keyvault key name
      encryption_keyvault_resource_group_name = string #(Required) # Resource group of the KeyVault
    })
    container_registry_anonymous_pull_enabled = bool # (Optional) Whether allows anonymous (unauthenticated) pull access to this Container Registry? Defaults to false. This is only supported on resources with the Standard or Premium SKU.
    container_registry_data_endpoint_enabled  = bool # (Optional) Whether to enable dedicated data endpoints for this Container Registry? Defaults to false. This is only supported on resources with the Premium SKU.

    container_registry_network_rule_bypass_option = string # (Optional) Whether to allow trusted Azure services to access a network restricted Container Registry? Possible values are None and AzureServices. Defaults to AzureServices.

    container_registry_tags = map(string) # (Optional) A mapping of tags to assign to the resource.
  }))
  description = "Map of object of container registry variables."
  default     = {}
}

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

#EVENTHUB NAMESPACE VARIABLES
variable "eventhub_namespace_variables" {
  type = map(object({
    eventhub_namespace_name                                 = string   # (Required) Specifies the name of the EventHub Namespace resource. Changing this forces a new resource to be created.
    eventhub_namespace_location                             = string   # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    eventhub_namespace_resource_group_name                  = string   # (Required) The name of the resource group in which to create the namespace. Changing this forces a new resource to be created.
    eventhub_namespace_sku                                  = string   # (Required) Defines which tier to use. Valid options are Basic, Standard, and Premium. Please note that setting this field to Premium will force the creation of a new resource.
    eventhub_namespace_capacity                             = number   # (Optional) Specifies the Capacity / Throughput Units for a Standard SKU namespace. Default capacity has a maximum of 2, but can be increased in blocks of 2 on a committed purchase basis.
    eventhub_namespace_auto_inflate_enabled                 = bool     # (Optional) Is Auto Inflate enabled for the EventHub Namespace?
    eventhub_namespace_maximum_throughput_units             = number   # (Optional) Specifies the maximum number of throughput units when Auto Inflate is Enabled. Valid values range from 1 - 20.
    eventhub_namespace_zone_redundant                       = string   # (Optional) Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). Changing this forces a new resource to be created. Defaults to false.
    eventhub_namespace_dedicated_eventhub_cluster_name      = string   # (Optional) Specifies the name of the EventHub Cluster resource. Required, when the namespace needs a dedicated eventhub_cluster
    eventhub_namespace_eventhub_cluster_resource_group_name = string   # (Optional) The name of the resource group in which the EventHub Cluster exists. Required, when the namespace needs a dedicated eventhub_cluster
    eventhub_namespace_local_authentication_enabled         = bool     # (Optional) Is SAS authentication enabled for the EventHub Namespace?
    eventhub_namespace_public_network_access_enabled        = bool     # (Optional) Is public network access enabled for the EventHub Namespace? Defaults to true.
    eventhub_namespace_minimum_tls_version                  = string   # (Optional) Specifies the maximum number of throughput units when Auto Inflate is Enabled. Valid values range from 1 - 20.
    eventhub_namespace_identity = object({                             # (Optional) An identity block
      eventhub_namespace_identity_type = string                        # (Required) Specifies the type of Managed Service Identity that should be configured on this Eventhub Namespace. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      eventhub_namespace_user_assigned_identities = list(object({      # (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Eventhub Namespace.
        user_assigned_identities_identity_name                = string # (Optional) Specifies  User Assigned Managed Identity name
        user_assigned_identities_identity_resource_group_name = string # (Optional) Specifies  User Assigned Managed Identity resource group name
      }))
    })
    eventhub_namespace_network_rulesets = map(object({                                # (Optional) A network_rulesets block as defined below.
      network_rulesets_default_action                 = string                        # (Required) The default action to take when a rule is not matched. Possible values are Allow and Deny.
      network_rulesets_trusted_service_access_enabled = bool                          # (Optional) Whether Trusted Microsoft Services are allowed to bypass firewall.
      network_rulesets_public_network_access_enabled  = bool                          # (Optional) Is public network access enabled for the EventHub Namespace? Defaults to true.
      network_rulesets_virtual_network_rule = object({                                # (Optional) One or more virtual_network_rule blocks as defined below.
        virtual_network_rule_subnet_name                                     = string # (Required) The name of the subnet. Changing this forces a new resource to be created.
        virtual_network_rule_subnet_resource_group_name                      = string # (Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
        virtual_network_rule_subnet_virtual_network_name                     = string # (Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
        virtual_network_rule_ignore_missing_virtual_network_service_endpoint = bool   # (Optional) Are missing virtual network service endpoints ignored? Defaults to false.
      })
      network_rulesets_ip_rule = object({ #(Optional) One or more ip_rule blocks as defined below.
        ip_rule_ip_mask = string          #(Required) The IP mask to match on.
        ip_rule_action  = string          #(Optional) The action to take when the rule is matched. Possible values are Allow.
      })
    }))
    eventhub_namespace_tags = map(string) # (Optional) A mapping of tags to assign to the resource.
  }))
  description = "Map of EventHub Namespace Variables"
  default     = {}
}

#EVENTHUB VARIABLES
variable "eventhub_variables" {
  description = "Map of variables for eventhub"
  type = map(object({
    eventhub_name                                             = string #(Required) Specifies the name of the EventHub resource. Changing this forces a new resource to be created.
    eventhub_namespace_name                                   = string #(Required) Specifies the name of the EventHub Namespace. Changing this forces a new resource to be created.
    eventhub_resource_group_name                              = string #(Required) The name of the resource group in which the EventHub's parent Namespace exists. Changing this forces a new resource to be created.
    eventhub_partition_count                                  = number #(Required) Specifies the current number of shards on the Event Hub. Changing this will force-recreate the resource.
    eventhub_message_retention                                = number #(Required) Specifies the number of days to retain the events for this Event Hub.
    eventhub_status                                           = string #(Optional) Specifies the status of the Event Hub resource. Possible values are Active, Disabled and SendDisabled. Defaults to Active
    eventhub_storage_blob_storage_account_name                = string #(Optional) To fetch The ID of the Blob Storage Account where messages should be archived.
    eventhub_storage_blob_storage_container_name              = string #(Optional) The name of the Container within the Blob Storage Account where messages should be archived.
    eventhub_storage_blob_storage_account_resource_group_name = string #(Required) Specifies the name of the resource group the Storage Account is located in.
    eventhub_capture_description = object({                            #(Optional) A capture_description block supports the following
      capture_description_enabled             = bool                   #(Required) Specifies if the Capture Description is Enabled.
      capture_description_encoding            = string                 #(Required) Specifies the Encoding used for the Capture Description. Possible values are Avro and AvroDeflate.
      capture_description_interval_in_seconds = number                 #(Optional) Specifies the time interval in seconds at which the capture will happen. Values can be between 60 and 900 seconds. Defaults to 300 seconds.
      capture_description_size_limit_in_bytes = number                 #(Optional) Value should be between 10485760 and 524288000 bytes. Defaults to 314572800 bytes.
      capture_description_skip_empty_archives = bool                   #(Optional) Specifies if empty files should not be emitted if no events occur during the Capture time window. Defaults to false.
      capture_description_destination = object({                       #(Required) A destination block as defined below.
        capture_description_destination_name                = string   #(Required) The Name of the Destination where the capture should take place. At this time the only supported value is EventHubArchive.AzureBlockBlob.
        capture_description_destination_archive_name_format = string   #(Required) The Blob naming convention for archiving. e.g. {Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}. Here all the parameters (Namespace,EventHub .. etc) are mandatory irrespective of order
        capture_description_destination_blob_container_name = string   #(Required) The name of the Container within the Blob Storage Account where messages should be archived.
      })
    })
  }))
  default = {}
}

# NETWORK SECURITY GROUP VARIABLES
variable "network_security_group_variables" {
  type = map(object({
    network_security_group_name                = string                           # (Required) Specifies the name of the network security group
    network_security_group_resource_group_name = string                           # (Required) The name of the resource group in which to create the network security group
    network_security_group_location            = string                           # (Required) Specifies the supported Azure location where the resource exists
    network_security_group_security_rule = map(object({                           # (Optional) List of objects representing security rules
      security_rule_name                                           = string       # (Required) The name of the security rule
      security_rule_application_security_group_resource_group_name = string       # (Optional) The resource group name of the application security group
      security_rule_description                                    = string       # (Optional) A description for this rule. Restricted to 140 characters 
      security_rule_protocol                                       = string       # (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
      security_rule_source_port_range                              = string       # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified.
      security_rule_source_port_ranges                             = list(string) # (Optional) List of source ports or port ranges. This is required if source_port_range is not specified
      security_rule_destination_port_range                         = string       # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
      security_rule_destination_port_ranges                        = list(string) # (Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified.
      security_rule_source_address_prefix                          = string       # (Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified
      security_rule_source_address_prefixes                        = list(string) # (Optional) Tags may not be used. This is required if source_address_prefix is not specified.
      security_rule_source_application_security_group_names = map(object({
        application_security_group_name                = string
        application_security_group_resource_group_name = string
      }))                                                       # (Optional) A list of source application security group ids
      security_rule_destination_address_prefix   = string       # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if destination_address_prefixes is not specified.
      security_rule_destination_address_prefixes = list(string) # (Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified
      security_rule_destination_application_security_group_names = map(object({
        application_security_group_name                = string
        application_security_group_resource_group_name = string
      }))                              # (Optional) A list of destination application security group ids
      security_rule_access    = string # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny
      security_rule_priority  = string # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule
      security_rule_direction = string # (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound
    }))
    network_security_group_tags = map(string) #(Optional) A mapping of tags which should be assigned to the Network Security Group.
  }))
  description = "Map of object for network security group details"
  default     = {}
}

# Network security group association variable
variable "network_security_group_association_variables" {
  type = map(object({
    network_interface_security_group_association = list(object({                             # (Optional) The block for security group association with network interface
      network_security_group_association_network_interface_name                     = string # (Required) The name of the network interface
      network_security_group_association_network_security_group_name                = string # (Required) The name of the network security group name to associate with network interface
      network_security_group_association_network_interface_resource_group_name      = string # (Required) The resource group name which contains network interface
      network_security_group_association_network_security_group_resource_group_name = string # (Required) The resource group name which contains security group
    }))
    subnet_security_group_association = list(object({                                        # (Optional) The block for security group association with subnet
      network_security_group_association_virtual_network_name                       = string # (Required) The name of the virtual network where subnets are created
      network_security_group_association_subnet_name                                = string # (Required) The name subnet which needs to be associated with network security group
      network_security_group_association_network_security_group_name                = string # (Required)  The name of network_security_group_name to assiciate with subnet
      network_security_group_association_virtual_network_resource_group_name        = string # (Required) The resource group name of the virtual network
      network_security_group_association_network_security_group_resource_group_name = string # (Required) The resource group name of security group.
    }))
  }))
  description = "Map of object network security group association variables"
  default     = {}
}

#LINUX VM VARIABLES
variable "linux_virtual_machine_variables" {
  type = map(object({
    linux_virtual_machine_admin_username = string #(Required) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created.
    linux_virtual_machine_location       = string #(Required) The Azure location where the Linux Virtual Machine should exist. Changing this forces a new resource to be created.
    linux_virtual_machine_license_type   = string #(Optional) Specifies the BYOL Type for this Virtual Machine. Possible values are RHEL_BYOS and SLES_BYOS.
    linux_virtual_machine_name           = string #(Required) The name of the Linux Virtual Machine. Changing this forces a new resource to be created.
    linux_virtual_machine_os_disk = object({      #(Required) A os_disk block as defined below.
      os_disk_caching              = string       #(Required) The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite.
      os_disk_storage_account_type = string       #(Required) The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS. Changing this forces a new resource to be created.
      os_disk_diff_disk_settings = object({       #(Optional) A diff_disk_settings block as defined above. Changing this forces a new resource to be created.
        diff_disk_settings_option    = string     # (Required) Specifies the Ephemeral Disk Settings for the OS Disk. At this time the only possible value is Local. Changing this forces a new resource to be created.
        diff_disk_settings_placement = string     #(Optional) Specifies where to store the Ephemeral Disk. Possible values are CacheDisk and ResourceDisk. Defaults to CacheDisk. Changing this forces a new resource to be created.
      })
      os_disk_disk_size_gb              = number #(Optional) The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from.
      os_disk_name                      = string #(Optional) The name which should be used for the Internal OS Disk. Changing this forces a new resource to be created.
      os_disk_security_encryption_type  = string #(Optional) Encryption Type when the Virtual Machine is a Confidential VM. Possible values are VMGuestStateOnly and DiskWithVMGuestState. Changing this forces a new resource to be created.
      os_disk_write_accelerator_enabled = bool   #(Optional) Should Write Accelerator be Enabled for this OS Disk? Defaults to false.
    })
    linux_virtual_machine_resource_group_name = string       #(Required) The name of the Resource Group in which the Linux Virtual Machine should be exist. Changing this forces a new resource to be created.
    linux_virtual_machine_size                = string       #(Required) The SKU which should be used for this Virtual Machine, such as Standard_F2.
    linux_virtual_machine_additional_capabilities = object({ #(Optional) A additional_capabilities block as defined below.
      additional_capabilities_ultra_ssd_enabled = bool       #(Optional) Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine? Defaults to false.
    })
    linux_virtual_machine_allow_extension_operations      = bool   #(Optional) Should Extension Operations be allowed on this Virtual Machine?
    linux_virtual_machine_computer_name                   = string #(Optional) Specifies the Hostname which should be used for this Virtual Machine. If unspecified this defaults to the value for the name field. If the value of the name field is not a valid computer_name, then you must specify computer_name. Changing this forces a new resource to be created.
    linux_virtual_machine_custom_data                     = string #(Optional) The Base64-Encoded Custom Data which should be used for this Virtual Machine. Changing this forces a new resource to be created.
    linux_virtual_machine_disable_password_authentication = bool   #(Optional) Should Password Authentication be disabled on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created.
    linux_virtual_machine_edge_zone                       = string #(Optional) Specifies the Edge Zone within the Azure Region where this Linux Virtual Machine should exist. Changing this forces a new Linux Virtual Machine to be created.
    linux_virtual_machine_encryption_at_host_enabled      = bool   #(Optional) Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?
    linux_virtual_machine_eviction_policy                 = string #(Optional) Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance. Possible values are Deallocate and Delete. Changing this forces a new resource to be created.
    linux_virtual_machine_extensions_time_budget          = string #(Optional) Specifies the duration allocated for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. Defaults to 90 minutes (PT1H30M).
    linux_virtual_machine_gallery_application = object({           #(Optional) A gallery_application block as defined below.
      gallery_application_order = number                           #(Optional) Specifies the order in which the packages have to be installed. Possible values are between 0 and 2,147,483,647.
      gallery_application_tag   = string                           #(Optional) Specifies a passthrough value for more generic context. This field can be any valid string value.
    })
    linux_virtual_machine_identity = object({                        #(Optional)
      identity_type = string                                         #(Required) Other values could be "UserAssigned", "SystemAssigned".If given as "SystemAssigned" , then give below parameter as null      
      linux_virtual_machine_user_assigned_identities = list(object({ #(Optional)
        user_assigned_identities_name                = string        #(Required)Name of the user assigned identity
        user_assigned_identities_resource_group_name = string        #(Required)Resource group name of the user assigned identity
      }))
    })
    linux_virtual_machine_patch_assessment_mode = string #(Optional) Specifies the mode of VM Guest Patching for the Virtual Machine. Possible values are AutomaticByPlatform or ImageDefault. Defaults to ImageDefault.
    linux_virtual_machine_patch_mode            = string # (Optional) Specifies the mode of in-guest patching to this Linux Virtual Machine. Possible values are AutomaticByPlatform and ImageDefault. Defaults to ImageDefault. For more information on patch modes please see the product documentation.
    linux_virtual_machine_max_bid_price         = string #(Optional) The maximum price you're willing to pay for this Virtual Machine, in US Dollars; which must be greater than the current spot price. If this bid price falls below the current spot price the Virtual Machine will be evicted using the eviction_policy. Defaults to -1, which means that the Virtual Machine should not be evicted for price reasons.
    linux_virtual_machine_plan = list(object({           #(Optional) A plan block as defined below. Changing this forces a new resource to be created.
      plan_name      = string                            #(Required) Specifies the Name of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
      plan_product   = string                            #(Required) Specifies the Product of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
      plan_publisher = string                            #(Required) Specifies the Publisher of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
    }))
    linux_virtual_machine_platform_fault_domain = string    #(Optional) Specifies the Platform Fault Domain in which this Linux Virtual Machine should be created. Defaults to -1, which means this will be automatically assigned to a fault domain that best maintains balance across the available fault domains. Changing this forces a new Linux Virtual Machine to be created.
    linux_virtual_machine_priority              = string    #(Optional) Specifies the priority of this Virtual Machine. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created.
    linux_virtual_machine_provision_vm_agent    = bool      #(Optional) Should the Azure VM Agent be provisioned on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created.
    linux_virtual_machine_secure_boot_enabled   = bool      #(Optional) Specifies whether secure boot should be enabled on the virtual machine. Changing this forces a new resource to be created.
    linux_virtual_machine_source_image_reference = object({ #Optional) A source_image_reference block as defined below. Changing this forces a new resource to be created.
      source_image_reference_publisher = string             #(Optional) Specifies the publisher of the image used to create the virtual machines.
      source_image_reference_offer     = string             #(Optional) Specifies the offer of the image used to create the virtual machines.
      source_image_reference_sku       = string             #(Optional) Specifies the SKU of the image used to create the virtual machines.
      source_image_reference_version   = string             #(Optional) Specifies the version of the image used to create the virtual machines.
    })
    linux_virtual_machine_termination_notification = list(object({ #(Optional) A termination_notification block as defined below.
      termination_notification_enabled = bool                      #(Required) Should the termination notification be enabled on this Virtual Machine? Defaults to false.
      termination_notification_timeout = string                    #(Optional) Length of time (in minutes, between 5 and 15) a notification to be sent to the VM on the instance metadata server till the VM gets deleted. The time duration should be specified in ISO 8601 format.
    }))
    linux_virtual_machine_user_data    = string      #(Optional) The Base64-Encoded User Data which should be used for this Virtual Machine.
    linux_virtual_machine_vtpm_enabled = bool        #(Optional) Specifies whether vTPM should be enabled on the virtual machine. Changing this forces a new resource to be created.
    linux_virtual_machine_zone         = string      #(Optional) Specifies the Availability Zones in which this Linux Virtual Machine should be located. Changing this forces a new Linux Virtual Machine to be created.
    linux_virtual_machine_tags         = map(string) #(Optional) A mapping of tags which should be assigned to this Virtual Machine.

    linux_virtual_machine_use_existing_vm_username        = bool   #(Required)should be set true if existing user name is used
    linux_virtual_machine_generate_new_admin_password     = bool   #(Required)admin_password should be generated if disable_password_authentication is false
    linux_virtual_machine_generate_new_ssh_key            = bool   #(Required)Should be true/false if linux_virtual_machine_disable_password_authentication is true
    linux_virtual_machine_admin_login_key_vault_name      = string #"existingkeyvaultscenario"
    linux_virtual_machine_tls_private_key_algorithm       = string #Provide Algorithm used for TLS private key if linux_virtual_machine_generate_new_ssh_key is true
    linux_virtual_machine_tls_private_key_rsa_bits        = number #Provide number if bits for TLS private key if linux_virtual_machine_generate_new_ssh_key is true
    linux_virtual_machine_admin_ssh_key_vault_secret_name = string #Key vault secret name to store the ssh key if linux_virtual_machine_generate_new_ssh_key is true

    linux_virtual_machine_is_disk_encryption_set_required = bool #(Required)Boolean value if disk encryption set is required or not
    linux_virtual_machine_is_vmss_id_required             = bool #(Required)Boolean value if VMSS id is required
    linux_virtual_machine_network_interface = map(object({       #(Required) Map of object for network interface
      network_interface_name                = string             #(Required)Name of the network interface
      network_interface_resource_group_name = string             #(Required)Resource group name of network interface
    }))
    linux_virtual_machine_is_secret_required                                     = bool   #(Required)Boolean value if secret is required or not
    linux_virtual_machine_is_storage_blob_required                               = bool   #(Required)Boolean value if blob storage is required
    linux_virtual_machine_storage_blob_name                                      = string #Provide blob storage name value if linux_virtual_machine_is_storage_blob_required is set to true.
    linux_virtual_machine_storage_account_name                                   = string #Provide storage account name value if linux_virtual_machine_is_storage_blob_required or linux_virtual_machine_is_boot_diagnostics_required is set to true
    linux_virtual_machine_storage_container_name                                 = string #Provide storage container name value if linux_virtual_machine_is_storage_blob_required is set to true.
    linux_virtual_machine_is_gallery_application_id_required                     = bool   #(Required)Boolean value if gallery application id is required
    linux_virtual_machine_gallery_application_version_name                       = string #Provide version name if linux_virtual_machine_is_gallery_application_id_required is set to true
    linux_virtual_machine_shared_image_gallery_name                              = string #Name of the shared image gallery. #Provide value if linux_virtual_machine_is_gallery_application_id_required is set to true
    linux_virtual_machine_gallery_application_name                               = string #Name of gallery application. #Provide value if linux_virtual_machine_is_gallery_application_id_required is set to true
    linux_virtual_machine_is_capacity_reservation_group_id_required              = bool   #(Required)Boolean value if capacity reservation group id is required
    linux_virtual_machine_capacity_reservation_group_name                        = string #Provide capacity reservation group name if linux_virtual_machine_is_capacity_reservation_group_id_required is set to true
    linux_virtual_machine_is_key_vault_certificate_url_required                  = bool   #(Required)Boolean value if key vault certificate url is required
    linux_virtual_machine_key_vault_certificate_name                             = string #Provide key vault certificate name if linux_virtual_machine_is_key_vault_certificate_url_required is set to true
    linux_virtual_machine_disk_encryption_set_name                               = string #Name of the disk encryption set. Provide value if linux_virtual_machine_is_disk_encryption_set_required is set to true
    linux_virtual_machine_is_boot_diagnostics_required                           = bool   #(Required)Boolean value if boot diagnostics required
    linux_virtual_machine_bypass_platform_safety_checks_on_user_schedule_enabled = bool   #(Optional) Specifies whether to skip platform scheduled patching when a user schedule is associated with the VM. Defaults to false.Can only be set to true when patch_mode is set to AutomaticByPlatform.
    linux_virtual_machine_is_availability_set_id_required                        = bool   #(Required)Boolean value if availability set id required
    linux_virtual_machine_is_proximity_placement_group_id_required               = bool   #(Required)Boolean value if proximity placement group id required
    linux_virtual_machine_reboot_setting                                         = string # (Optional) Specifies the reboot setting for platform scheduled patching. Possible values are Always, IfRequired and Never. can only be set when patch_mode is set to AutomaticByPlatform.
    linux_virtual_machine_is_dedicated_host_group_id_required                    = bool   #(Required)Boolean value if dedicated host group id required
    linux_virtual_machine_is_dedicated_host_id_required                          = bool   #(Required)Boolean value if dedicated host id required
    linux_virtual_machine_boot_diagnostics_storage_account_name                  = string # Provide storage account name value if linux_virtual_machine_is_storage_blob_required or linux_virtual_machine_is_boot_diagnostics_required is set to true
    linux_virtual_machine_deploy_vm_using_source_image_reference                 = bool   #(Required)Boolean value if VM should be deployed using source image reference
    linux_virtual_machine_availability_set_name                                  = string # Provide availability set name if linux_virtual_machine_is_availability_set_id_required is set true
    linux_virtual_machine_availability_set_resource_group_name                   = string # Provide availability set resource group name if linux_virtual_machine_is_availability_set_id_required is set true
    linux_virtual_machine_dedicated_host_group_name                              = string # Provide host group name if linux_virtual_machine_is_dedicated_host_group_id_required is set true
    linux_virtual_machine_dedicated_host_group_resource_group_name               = string # Provide host group resource group name if linux_virtual_machine_is_dedicated_host_group_id_required is set true
    linux_virtual_machine_dedicated_host_name                                    = string # Provide host name if linux_virtual_machine_is_dedicated_host_id_required is set true
    linux_virtual_machine_dedicated_host_resource_group_name                     = string # Provide host resource group name if linux_virtual_machine_is_dedicated_host_id_required is set true
    linux_virtual_machine_proximity_placement_group_name                         = string # Provide proximity palcement group name if linux_virtual_machine_is_proximity_placement_group_id_required is set true
    linux_virtual_machine_proximity_placement_group_resource_group_name          = string # Provide proximity palcement group resource group name if linux_virtual_machine_is_proximity_placement_group_id_required is set true
    linux_virtual_machine_generated_admin_password_secret_name                   = string #Provide Key vault secret name to store random password if linux_virtual_machine_generate_new_admin_password is true
    linux_virtual_machine_existing_admin_password_secret_name                    = string #Provide Key vault secret name where the existing password exists if linux_virtual_machine_generate_new_admin_password is false
    linux_virtual_machine_virtual_machine_scale_set_name                         = string #Provide Vm scale set name if linux_virtual_machine_is_vmss_id_required is true
    linux_virtual_machine_virtual_machine_scale_set_resource_group_name          = string #Provide VM scale set resource group name if linux_virtual_machine_is_vmss_id_required is true
    linux_virtual_machine_source_image_type                                      = string #if you are using existing vm image make image type as "VMImage" if you are using share image give as "SharedImage"
    linux_virtual_machine_shared_image_name                                      = string #Provide image name if linux_virtual_machine_source_image_type is "SharedImage"
    linux_virtual_machine_shared_image_resource_group_name                       = string #Provide image resource group name if linux_virtual_machine_source_image_type is "SharedImage"
    linux_virtual_machine_existing_image_name                                    = string #Provide image name if linux_virtual_machine_source_image_type is "VMImage"
    linux_virtual_machine_existing_image_resource_group_name                     = string #Provide existing image resource group name if image type is "VMImage"
    linux_virtual_machine_admin_key_vault_resource_group_name                    = string #Provide key vault resource group name to store credentials
    linux_virtual_machine_storage_account_resource_group_name                    = string #Provide value if linux_virtual_machine_is_boot_diagnostics_required is set to true
    linux_virtual_machine_disk_encryption_set_resource_group_name                = string #Resource group name of the disk encryption set. Provide value if linux_virtual_machine_is_disk_encryption_set_required is set to true
    linux_virtual_machine_existing_admin_username_secret_name                    = string #Provide Key vault secret name to store admin username. Provide value if linux_virtual_machine_use_existing_vm_username is set to true.
    linux_virtual_machine_generated_admin_password_secret_expiration_date        = string
    linux_virtual_machine_generated_admin_password_secret_content_type           = string
    linux_virtual_machine_admin_ssh_key_vault_secret_expiration_date             = string
    linux_virtual_machine_admin_ssh_key_vault_secret_content_type                = string
  }))
  description = "Map of object of Linux virtual machine variables"
  default     = {}
}

#NETWORK INTERFACE VARIABLES
variable "network_interface_variables" {
  description = "Map of Network interface"
  type = map(object({
    network_interface_name                          = string       #(Required) The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_location                      = string       #(Required) The location where the Network Interface should exist. Changing this forces a new resource to be created.
    network_interface_resource_group_name           = string       #(Required) The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.
    network_interface_auxiliary_mode                = string       # (Optional) Specifies the auxiliary mode used to enable network high-performance feature on Network Virtual Appliances (NVAs). Possible values are AcceleratedConnections and Floating.
    network_interface_auxiliary_sku                 = string       # (Optional) Specifies the SKU used for the network high-performance feature on Network Virtual Appliances (NVAs). Possible values are A1, A2, A4 and A8.
    network_interface_dns_servers                   = list(string) #(Optional) A list of IP Addresses defining the DNS Servers which should be used for this Network Interface. 
    network_interface_edge_zone                     = string       #(Optional) Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created.
    network_interface_enable_ip_forwarding          = bool         #Optional)  Should IP Forwarding be enabled? Defaults to false
    network_interface_enable_accelerated_networking = bool         #(Optional) Should Accelerated Networking be enabled? Defaults to false
    network_interface_internal_dns_label            = string       #(Optional) The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.
    network_interface_ip_configuration = map(object({              #(Required) One or more ip_configuration blocks
      ip_configuration_name                          = string      #(Required) A name used for this IP Configuration. Changing this forces a new resource to be created.
      ip_configuration_private_ip_address_allocation = string      #(Required) The allocation method used for the Private IP Address. Possible values are Dynamic and Static.
      ip_configuration_private_ip_address            = string      #(Optional) When private_ip_address_allocation is set to Static, The Static IP Address which should be used
      ip_configuration_private_ip_address_version    = string      #(Optional) The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.
      ip_configuration_subnet = object({                           #(Required) When private_ip_address_version is set to IPv4,The ID of the Subnet where this Network Interface should be located in.
        subnet_virtual_network_name                = string        #(Required) When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID.
        subnet_name                                = string        #(Required) When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID.
        subnet_virtual_network_resource_group_name = string        #(Required) When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID.
      })
      ip_configuration_public_ip = object({    #(Optional) Reference to a Public IP Address to associate with this NIC
        public_ip_name                = string #(Optional) Reference to a Public IP Address Name to associate with this NIC
        public_ip_resource_group_name = string #(Optional) Reference to a Public IP Address Name Resource Group Name to associate with this NIC
      })
      ip_configuration_primary = bool              #(Optional) Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false
      ip_configuration_load_balancer = object({    #(Optional) The Frontend IP Configuration ID of a Gateway SKU Load Balancer.
        load_balancer_name                = string #(Optional) The Load Balancer name is required to fetch the Load Balancer ID.
        load_balancer_resource_group_name = string #(Optional) The Load Balancer Resource Group name is required to fetch the Load Balancer ID
      })
    }))
    network_interface_tags = map(string) #(Optional) A mapping of tags to assign to the resource.
  }))
  default = {}
}
#ROUTE TABLE VARIABLES
variable "route_table_variables" {
  description = "Map of Route Table object"
  type = map(object({
    route_table_name                          = string      #(Required) The name of the route table. 
    route_table_location                      = string      #(Required) The Azure location where the resource should exist.
    route_table_resource_group_name           = string      #(Required) The name of the resource group in which to create the route table.
    route_table_disable_bgp_route_propagation = bool        #(Optional) Boolean flag which controls propagation of routes learned by BGP on that route table. True means disable. Default value "false"
    route_table_tags                          = map(string) #(Optional) A mapping of tags to assign to the resource.
    route_table_route = list(object({                       #(Optional) List of objects representing routes.
      route_name                   = string                 #(Required) The name of the route.
      route_address_prefix         = string                 #(Required) The destination to which the route applies. Can be CIDR(such as 10.1.0.0/16) or Azure Service Tag (such as ApiManagement, AzureBackup or AzureMonitor) format.
      route_next_hop_type          = string                 #(Required) The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None.
      route_next_hop_in_ip_address = string                 #(Optional) Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance. Default value "null"
    }))
  }))
  default = {}
}