#KEY VAULT
key_vault_variables = {
  "key_vault_1" = {
    key_vault_name                                  = "sdplzmgmtdckv01"                                                                                                                                                                         #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_location                              = "Central India"                                                                                                                                                                                       #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_resource_group_name                   = "sd-plz-management-rg"                                                                                                                                                                               #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_enabled_for_disk_encryption           = true                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = true                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = true                                                                                                                                                                                            # (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = false                                                                                                                                                                                           #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = "7"                                                                                                                                                                                             #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = false                                                                                                                                                                                           #(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
    key_vault_sku_name                              = "standard"                                                                                                                                                                                      #(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium
    key_vault_access_container_agent_name           = null                                                                                                                                                                                            #(Optional) Self hosted conatiner agent name.
    key_vault_access_policy_application_id          = null                                                                                                                                                                                            #(Optional) The object ID of an Application in Azure Active Directory.
    key_vault_public_network_access_enabled         = true                                                                                                                                                                                            #(Optional) key_vault_public_network_access_enabled
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                    #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                              #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"] # (Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    #(Optional) A mapping of tags which should be assigned to the key vault.
    key_vault_tags = { #(Optional) A mapping of tags which should be assigned to the key vault.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
    key_vault_network_acls_enabled        = true            #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass         = "AzureServices" #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action = "Deny"          # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
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
    key_vault_contact_information_enabled = false #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email               = null  #(Required) E-mail address of the contact.
    key_vault_contact_name                = null  #(Optional) Name of the contact.
    key_vault_contact_phone               = null  #(Optional) Phone number of the contact.

  }
}

#PRIVATE_DNS_ZONE
private_dns_zone_variables = {
  "dnszone1" = {
    private_dns_zone_name                = "privatelink.vault.core.windows.net" #(Required) The name of the Private DNS Zone. Must be a valid domain name.
    private_dns_zone_resource_group_name = "sd-management-vault-pdz-01"                 #(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.
    private_dns_zone_soa_record          = null                              ##(Optional) An soa_record block as defined below. Changing this forces a new resource to be created.
    private_dns_zone_tags = {
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

#PRIVATE ENDPOINT
private_endpoint_variables = {
  "private_endpoint_1" = {

    private_endpoint_name                                = "sd-management-vault-pep-01" # (Required) private endpoint name
    private_endpoint_resource_group_name                 = "sd-plz-management-rg"              # (Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created.
    private_endpoint_location                            = "Central India"                       #  (Required) The supported Azure location where the resource exists. Changing this forces a new resource to be created.
    private_endpoint_virtual_network_name                = "sd-plz-management-vnet"            #The name of the network interface associated with the private_endpoint
    private_endpoint_virtual_network_resource_group_name = "sd-plz-management-rg1"              #(Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created.
    private_endpoint_subnet_name                         = "sd-plz-management-vnet-pe-snet-01"          # (Required) subnet in which private endpoint is hosting
    custom_network_interface_name                        = "sd-management-vault-pep-nic-01"    #(Optional) The custom name of the network interface attached to the private endpoint. Changing this forces a new resource to be created.
    private_endpoint_private_dns_zone_group              = null                           #(Optional) A private_dns_zone_group block as defined below.
    #   {
    #   private_dns_zone_group_name          = ""                                 #(Required) Specifies the Name of the Private DNS Zone Group.
    #   private_dns_zone_names               = ["dnszone000001.com", "zone000002.com"] #(Required) Specifies the list of Private DNS Zones names to include within the private_dns_zone_group.These names will be fetched by the data resource of private_dns_zone name.
    #   private_dns_zone_resource_group_name = "rg000001"                                          #(Required) Specifies the resource group name of Private DNS Zones to include within the private_dns_zone_group.This will be fetched by the data resource of private_dns_zone resource group name.
    # }
    private_endpoint_private_service_connection = {                        #(Required) A private_service_connection block as defined below.
      private_service_connection_name                 = "sd-management-vault-pep-01" #(Required) Specifies the Name of the Private Service Connection. Changing this forces a new resource to be created.
      private_service_connection_is_manual_connection = false              #(Required) set true if resource_alias != null
      private_connection_resource_name                = "sdplzmgmtdckv01"  #(Optional) The Service Name of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
      private_connection_resource_resource_group_name = "sd-plz-management-rg"  #(Optional) The Service Resource Group Name of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
      private_connection_resource_alias               = null               #(Optional) The Service Alias of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
      request_message                                 = null               #(Optional) Should be enabled if the is_manual_connection is set as true.  A message passed to the owner of the remote resource
      subresource_names                               = null               # (Optional) A list of subresource names which the Private Endpoint is able to connect to.
    }
    private_endpoint_ip_configuration = { # (Optional) One or more ip_configuration blocks as defined below. This allows a static IP address to be set for this Private Endpoint, otherwise an address is dynamically allocated from the Subnet.
      "ip_connfig_1" = {
        ip_configuration_name               = "sd-management-vault-ip-cnf-01"  #(Required) Specifies the Name of the IP Configuration. Changing this forces a new resource to be created.
        ip_configuration_private_ip_address = "10.248.1.35"                    #(Required) Specifies the static IP address within the private endpoint's subnet to be used. Changing this forces a new resource to be created.
        ip_configuration_subresource_name   = "vault"                          #(Optional) A list of subresource names which the Private Endpoint is able to connect to.
        ip_configuration_member_name        = "default"                        #(Optional) Specifies the member name this IP address applies to. If it is not specified, it will use the value of subresource_name. Changing this forces a new resource to be created.
      }
    }
    private_endpoint_tags = { #(Optional)A mapping of tags to assign to the resource.
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



#CONTAINER REGISTRY
container_registry_variables = {
  "container_registry_1" = {
    container_registry_name                          = "sdplzmgmtdcacr01" #(Required) Specifies the name of the Container Registry. Only Alphanumeric characters allowed. Changing this forces a new resource to be created.
    container_registry_location                      = "Central India"          # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    container_registry_resource_group_name           = "sd-plz-management-rg"  # (Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created.
    container_registry_sku                           = "Premium"          # (Required) The SKU name of the container registry. Possible values are Basic, Standard and Premium.
    container_registry_admin_enabled                 = true               # (Optional) Specifies whether the admin user is enabled. Defaults to false.
    container_registry_export_policy_enabled         = true               # (Optional) Boolean value that indicates whether export policy is enabled. Defaults to true. In order to set it to false, make sure the public_network_access_enabled is also set to false.
    container_registry_public_network_access_enabled = true               # (Optional) Whether public network access is allowed for the container registry. Defaults to true.
    container_registry_quarantine_policy_enabled     = false              # (Optional) Boolean value that indicates whether quarantine policy is enabled. Defaults to false.
    container_registry_zone_redundancy_enabled       = false              # (Optional) Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created. Defaults to false.
    container_registry_anonymous_pull_enabled        = false              # (Optional) Whether allows anonymous (unauthenticated) pull access to this Container Registry? Defaults to false. This is only supported on resources with the Standard or Premium SKU.
    container_registry_retention_policy = {
      retention_policy_days    = 7    # (Optional) The number of days to retain an untagged manifest after which it gets purged. Default is 7.
      retention_policy_enabled = true # (Optional) Boolean value that indicates whether the policy is enabled.
    }
    container_registry_trust_policy = { # (Optional) Set to null if it is not required.
      trust_policy_enabled = false      #  (Optional) Boolean value that indicates whether the policy is enabled.
    }
    container_registry_georeplication_enabled = true #(Required) Whether georeplications should be enabled for the container registry.If the this is true, Provide values to georeplications block
    container_registry_georeplications = [{
      georeplications_location                  = "South India" # (Required) A location where the container registry should be geo-replicated.
      georeplications_regional_endpoint_enabled = false     # (Optional) Whether regional endpoint is enabled for this Container Registry? Defaults to false.
      georeplications_zone_redundancy_enabled   = false    # (Optional) Whether zone redundancy is enabled for this replication location? Defaults to false.
      georeplications_tags                      = null     # (Optional) A mapping of tags to assign to this replication location.
    }]
    container_registry_data_endpoint_enabled      = true            # (Optional) Whether to enable dedicated data endpoints for this Container Registry? Defaults to false. This is only supported on resources with the Premium SKU.
    container_registry_network_rule_bypass_option = "AzureServices" # (Optional) Whether to allow trusted Azure services to access a network restricted Container Registry? Possible values are None and AzureServices. Defaults to AzureServices.
    container_registry_encryption = {
      encryption_enabled                      = false                   #  (Required) Boolean value that indicates whether encryption is enabled. Set to false, if customer managed encryption is not required.
      encryption_keyvault_name                = "sdplzmgmtdckv01" # (Required)The name of the KeyVault where key is stored
      encryption_keyvault_key_name            = "enckey01"   # (Required) # The name of the keyvault key name
      encryption_keyvault_resource_group_name = "sd-plz-management-rg"       #(Required) # Resource group of the KeyVault
      encryption_identity_name                = "testid"      # (Required) The Name of the managed identity
      encryption_identity_resource_group_name = "sd-plz-management-rg"      # (Required) The name of resource group where identity is created.
    }
    container_registry_identity = null /*{                  #(Optional) Set to null if managed identity configuration is not required.
      identity_type = null # (Required) Specifies the type of Managed Service Identity that should be configured on this Container Registry. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      identity_identity_ids = [{
        identity_ids_identity_name                = null # (Required) The Name of the managed identity
        identity_ids_identity_resource_group_name = null  # (Required) The name of resource group where identity is created.
        }
      ]
    }*/
    container_registry_network_rule_set_enabled = false #(Required) Whether network rule set to be enabled for the container registry. if the value is true, Provide values to container_registry_network_rule_set block.
    container_registry_network_rule_set = {
      network_rule_set_default_action = null #  (Optional) The behaviour for requests matching no rules. Either Allow or Deny. Defaults to Allow
      network_rule_set_ip_rule = null /* [
        {
          ip_rule_action   = "Allow"       # (Required) The behaviour for requests matching this rule. At this time the only supported value is Allow
          ip_rule_ip_range = "10.0.1.0/24" # (Required) The CIDR block from which requests will match the rule.
        },
        {
          ip_rule_action   = "Allow"       # (Required) The behaviour for requests matching this rule. At this time the only supported value is Allow
          ip_rule_ip_range = "10.0.2.0/24" # (Required) The CIDR block from which requests will match the rule.
        }
      ] */
      network_rule_set_virtual_network = null /*[
        {
          virtual_network_action               = null            # (Required) The behaviour for requests matching this rule. At this time the only supported value is Allow
          virtual_network_virtual_network_name = null  # (Required) The name of  virtual network name
          virtual_network_subnet_name          = null   # (Required) The name of subnet
          virtual_network_resource_group_name  = null   # (Required) The resource group name of Virtual network
        }

      ]*/
    }
    container_registry_tags = { # (Optional) A mapping of tags to assign to the resource.
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

#AKS CLUSTER
/*aks_cluster_variables = {
  "aks_1" = {
    vnet_name                                                = "sd-plz-management-vnet" #Optional parameter - Use only if specific subnet needs to be defined for Kubernetes cluster, if not keep it as null
    resource_group_name                                      = "sd-plz-management-rg"
    subnet_name                                              = "sd-plz-management-vnet-elk-snet-01" #Optional parameter - Use only if specific subnet needs to be defined for Kubernetes cluster, If not keep it as null
    disk_encryption_set_name                                 = null
    is_subnet_required                                       = true #Optional parameter - Keep it true only if specific subnet needs to be defined, If not keep it false  
    is_disk_encryption_set_required                          = false
    aks_name                                                 = "sd-plz-management-aks-01"
    location                                                 = "Central India"
    dns_prefix                                               = "sdplzaksdns"
    node_resource_group_name                                 = "sd-plz-management-node-rg"
    sku_tier                                                 = "Free"
    dns_prefix_private_cluster                               = null
    private_cluster_enabled                                  = false
    private_dns_zone_id                                      = null
    api_server_authorized_ip_ranges                          = null
    kubernetes_version                                       = "1.23.8"
    automatic_channel_upgrade                                = null #"stable" This is in preview stage. Provide the value once this feature is in production
    default_node_pool_name                                   = "akspool"
    default_node_pool_node_count                             = 2
    default_node_pool_vm_size                                = "Standard_D2_v3"
    default_node_pool_type                                   = "VirtualMachineScaleSets"
    default_node_pool_availability_zones                     = ["1", "2", "3"]
    default_node_pool_enable_auto_scaling                    = true
    default_node_pool_max_count                              = 3
    default_node_pool_min_count                              = 2
    default_node_pool_enable_host_encryption                 = false
    default_node_pool_enable_node_public_ip                  = false
    default_node_pool_max_pods                               = 110
    default_node_pool_node_labels                            = null
    default_node_pool_os_disk_size_gb                        = 30
    azure_active_directory_role_based_access_control_enabled = false
    aad_managed                                              = false
    aad_tenant_id                                            = null                                     #Optional parameter - Use this parameter if you want to use the specific Azure AD application tenant ID, if not keep it null and it will use tenant ID of the current Subscription 
    aad_admin_group_object_ids                               = null                                     #Optional parameter - Use this parameter only if aad_managed is true. Keep it as null if no Admin groups is used for Admin Role on the cluster. 
    aad_azure_rbac_enabled                                   = null                                     #Optional parameter - Use this parameter only if aad_managed is true . Also Microsoft.ContainerService/EnableAzureRBACPreview feature flag should be enabled. Keep it as null if no azure_rabac is not required.
    aad_client_app_id                                        = null                                     #Optional parameter - If aad_managed is false, this fields should be provided
    aad_server_app_id                                        = null                                     #Optional parameter - If aad_managed is false, this fields should be provided
    aad_server_app_secret                                    = null                                     #Optional parameter - If aad_managed is false, this fields should be provided
    balance_similar_node_groups                              = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Possible values - true/false . Defaults to false. 
    expander                                                 = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Possible values - least-waste/priority/most-pods/random . Defaults to random
    max_graceful_termination_sec                             = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 600
    max_node_provisioning_time                               = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 15m
    max_unready_nodes                                        = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 3
    max_unready_percentage                                   = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 45
    new_pod_scale_up_delay                                   = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 10s
    scale_down_delay_after_add                               = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to scan_interval
    scale_down_delay_after_delete                            = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 3m
    scale_down_delay_after_failure                           = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 10s
    scan_interval                                            = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 10m
    scale_down_unneeded                                      = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 10m
    scale_down_unready                                       = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 20m
    scale_down_utilization_threshold                         = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 0.5
    empty_bulk_delete_max                                    = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 10
    skip_nodes_with_local_storage                            = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Possible values - true/false . Defaults to true
    skip_nodes_with_system_pods                              = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Possible values - true/false . Defaults to true
    network_plugin                                           = "azure"
    network_policy                                           = "azure"
    dns_service_ip                                           = "10.248.2.12"
    # docker_bridge_cidr                                       = "172.17.0.1/16"
    outbound_type                                            = null
    pod_cidr                                                 = null
    service_cidr                                             = "10.248.2.128/25"
    # load_balancer_sku                        = "Standard" #Defaults to "Standard", Provides LB profile if we are exclusively providing the load_balancer_sku. If not keep it to null
    # lb_outbound_ports_allocated              = null
    # lb_idle_timeout_in_minutes               = null
    # lb_managed_outbound_ip_count             = null
    # lb_outbound_ip_prefix_ids                = []
    # lb_outbound_ip_address_ids               = null
    identity_type                              = "SystemAssigned" #Best practise is to keep SystemAssigned since AKS creates a UserAssigned identity automatically to provide access to other resources & services. We need to provide access to that UserAssigned identity with necessary roles
    azure_policy_enabled                       = false
    ingress_application_gateway                = false
    application_gateway_name                   = "sd-plz-management-app-gw-01"
    http_application_routing_enabled           = true
    oms_agent_enabled                          = false               #If marked as true, then the OMS agent will be deployed along with a log analytics workspace ID.
    log_analytics_workspace_name               = "sd-plz-management-law-01" #Provide log analytics worksapce name if oms_agent_enabled is true. If not, keep it as null
    user_identity_name                         = null               #"ploceusaksuseridentity"
    http_proxy                                 = null               #Optional parameter - Use this parameter only if http proxy is used, if not keep it as null.
    https_proxy                                = null               #Optional parameter - Use this parameter only if https proxt is used, if not keep it as null.
    no_proxy                                   = []                 #Optional parameter - Use this parameter only if no proxy is used, if not keep it as null.
    trusted_ca                                 = null               #Optional parameter - Use this parameter only if a CA certificate is used, if not keep it as null.
    open_service_mesh_enabled                  = false              #Optional parameter - Use this parameter to enable Service Mesh
    local_account_disabled                     = false              #Optional parameter - Use this parameter to disable local accounts
    maintenance_window_enabled                 = false              # Optional parameter - Use this to enable the maintenance window
    maintenance_window_allow_time_enabled      = false              #  Optional parameter - Use this parameter to enable the allowed time for maintenance
    maintenance_window_allow_time_day          = "Monday"
    maintenance_window_allow_time_hours        = [1, 2, 3, 4]
    maintenance_window_block_time_enabled      = false                  #  Optional parameter - Use this parameter to enable feature for blocking maintenance
    maintenance_window_block_starttime         = "2006-01-02T15:04:05Z" #Put only as  RFC3339 format
    maintenance_window_block_endtime           = "2006-01-02T15:06:05Z" #Put only as  RFC3339 format
    windows_profile_enabled                    = false                  # Make it true to enable Windows profile
    windows_profile_admin_password             = "admin@123456"         # Required if windows profile is enabled
    windows_profile_admin_username             = "adminkubeconfig"      # Required if windows profile is enabled
    windows_profile_license                    = "Windows_Server"       # Only allowed value is Windows_Server
    kubelet_identity_enabled                   = false
    kubelet_identity_client_id                 = "string"
    kubelet_identity_object_id                 = "string"
    kubelet_identity_user_assigned_identity_id = "string"
    linux_profile_enabled                      = false
    linux_profile_admin_username               = "adminuser123"
    linux_profile_ssh_key                      = "string"
    aks_cluster_tags = {
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
}*/
