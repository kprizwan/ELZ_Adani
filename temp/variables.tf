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

#AKS CLUSTER VARIABLE
variable "aks_cluster_variables" {
  type = map(object({
    vnet_name                                                = string
    resource_group_name                                      = string
    subnet_name                                              = string
    disk_encryption_set_name                                 = string
    is_subnet_required                                       = bool
    is_disk_encryption_set_required                          = bool
    aks_name                                                 = string
    location                                                 = string
    dns_prefix                                               = string
    node_resource_group_name                                 = string
    sku_tier                                                 = string
    dns_prefix_private_cluster                               = string
    private_cluster_enabled                                  = bool
    private_dns_zone_id                                      = string
    api_server_authorized_ip_ranges                          = list(string)
    kubernetes_version                                       = string
    automatic_channel_upgrade                                = string
    default_node_pool_name                                   = string
    default_node_pool_node_count                             = number
    default_node_pool_vm_size                                = string
    default_node_pool_type                                   = string
    default_node_pool_availability_zones                     = list(string)
    default_node_pool_enable_auto_scaling                    = bool
    default_node_pool_max_count                              = number
    default_node_pool_min_count                              = number
    default_node_pool_enable_host_encryption                 = bool
    default_node_pool_enable_node_public_ip                  = bool
    default_node_pool_max_pods                               = number
    default_node_pool_node_labels                            = map(string)
    default_node_pool_os_disk_size_gb                        = number
    azure_active_directory_role_based_access_control_enabled = bool
    aad_managed                                              = bool
    aad_tenant_id                                            = string
    aad_admin_group_object_ids                               = list(string)
    aad_azure_rbac_enabled                                   = bool
    aad_client_app_id                                        = string
    aad_server_app_id                                        = string
    aad_server_app_secret                                    = string
    balance_similar_node_groups                              = bool
    expander                                                 = string
    max_graceful_termination_sec                             = number
    max_node_provisioning_time                               = string
    max_unready_nodes                                        = number
    max_unready_percentage                                   = number
    new_pod_scale_up_delay                                   = string
    scale_down_delay_after_add                               = string
    scale_down_delay_after_delete                            = string
    scale_down_delay_after_failure                           = string
    scan_interval                                            = string
    scale_down_unneeded                                      = string
    scale_down_unready                                       = string
    scale_down_utilization_threshold                         = number
    empty_bulk_delete_max                                    = number
    skip_nodes_with_local_storage                            = bool
    skip_nodes_with_system_pods                              = bool
    network_plugin                                           = string
    network_policy                                           = string
    dns_service_ip                                           = string
    docker_bridge_cidr                                       = string
    outbound_type                                            = string
    pod_cidr                                                 = string
    service_cidr                                             = string
    # load_balancer_sku                        = string
    # lb_outbound_ports_allocated              = string
    # lb_idle_timeout_in_minutes               = string
    # lb_managed_outbound_ip_count             = string
    # lb_outbound_ip_prefix_ids                = list(string)
    # lb_outbound_ip_address_ids               = list(string)
    identity_type                              = string
    azure_policy_enabled                       = bool
    ingress_application_gateway                = bool
    application_gateway_name                   = string
    http_application_routing_enabled           = bool
    oms_agent_enabled                          = bool
    log_analytics_workspace_name               = string
    user_identity_name                         = string
    http_proxy                                 = string
    https_proxy                                = string
    no_proxy                                   = list(string)
    trusted_ca                                 = string
    open_service_mesh_enabled                  = bool
    local_account_disabled                     = bool
    maintenance_window_enabled                 = bool
    maintenance_window_allow_time_enabled      = bool
    maintenance_window_allow_time_day          = string
    maintenance_window_allow_time_hours        = list(number)
    maintenance_window_block_time_enabled      = bool
    maintenance_window_block_starttime         = string
    maintenance_window_block_endtime           = string
    windows_profile_enabled                    = bool
    windows_profile_admin_password             = string
    windows_profile_admin_username             = string
    windows_profile_license                    = string
    kubelet_identity_enabled                   = bool
    kubelet_identity_client_id                 = string
    kubelet_identity_object_id                 = string
    kubelet_identity_user_assigned_identity_id = string
    linux_profile_enabled                      = bool
    linux_profile_admin_username               = string
    linux_profile_ssh_key                      = string
    aks_cluster_tags                           = map(string)
  }))
}

