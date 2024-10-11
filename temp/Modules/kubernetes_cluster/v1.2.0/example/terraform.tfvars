
#RESOURCE GROUP For LOG ANALYTICS WORKSPACE
resource_group_log_analytics_workspace_oms_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000001" #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = "westus2"         #(Required) The Azure Region where the Resource Group should exist.
    resource_group_tags = {                     #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#GENERAL ROLE ASSIGNMENT VARIABLES
general_role_assignment_variables = {
  "general_role_assignment_1" = {
    general_role_assignment_role_definition_name                   = "Network Contributor"                                                                             # (Optional) A unique UUID/GUID for this Role Assignment - one will be generated if not specified. Changing this forces a new resource to be created.
    general_role_assignment_description                            = "Grants full access to manage all resources but does not allow you to assign roles in Azure RBAC" # (Optional) The description of the role
    general_role_assignment_target_resource_name                   = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"                                                      # (Required) The name of the resource to which we are assigning role
    general_role_assignment_target_resource_type                   = "Subscription"                                                                                    # (Required) Possible values are Subscription, ManagementGroup or AzureResource
    general_role_assignment_management_group_name                  = null
    general_role_assignment_resource_group_name                    = null               # (Optional) The name of the management group. Please make as null if scope is not set as ManagementGroup
    general_role_assignment_principal_type                         = "ServicePrincipal" # (Optional) Type of the principal id. It maybe User, Group or ServicePrincipal
    is_group_principal_id_exists                                   = false              # (Optional) Provide true when principal_type is "Group"
    general_role_assignment_group_principal_display_name           = null               # (Optional) give user_principal_name if is_group_principal_id_exists =true, and principal_type="Group".
    is_service_principal_id_exists                                 = true               # (Optional) Provide true when principal_type is "ServicePrincipal"
    general_role_assignment_service_principal_display_name         = "ploceusuai000001" # (Optional) give service_principal_display_name if is_service_principal_id_exists =true, and principal_type="ServicePrincipal".
    is_user_principal_id_exists                                    = false              # (Optional) Provide true when principle_type is "User" 
    general_role_assignment_user_principal_name                    = null               # (Optional) give user_principal_name if is_user_principal_id_exists =true, and principal_type="User".
    general_role_assignment_condition                              = null               # (Optional) The condition that limits the resources that the role can be assigned to. Changing this forces a new resource to be created.
    general_role_assignment_security_enabled                       = true               # (Optional) Required for fetching group principal
    general_role_assignment_condition_version                      = null               # (Optional) The version of the condition. Possible values are 1.0 or 2.0. Changing this forces a new resource to be created.  
    general_role_assignment_delegated_managed_identity_resource_id = null               # (Optional) The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created 
    general_role_assignment_skip_service_principal_aad_check       = false              # (Optional) If the principal_id is a newly provisioned Service Principal set this value to true to skip the Azure Active Directory check which may fail due to replication lag. This argument is only valid if the principal_id is a Service Principal identity. Defaults to false.
  }
}

#private_dns_zone
private_dns_zone_variable = {
  "dnszone1" = {
    private_dns_zone_name                = "privatelink.westus2.azmk8s.io" #(Required) The name of the DNS Zone. Must be a valid domain name.
    private_dns_zone_resource_group_name = "ploceusrg000003"               #(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.
    private_dns_zone_soa_record          = null                            #(Optional) An soa_record block as defined below. Changing this forces a new resource to be created.
    private_dns_zone_tags = {                                              #(Optional) A mapping of tags to assign to the Record Set.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#LOG ANALYTICS WORKSPACE
log_analytics_workspace_variables = {
  "log_analytics_workspace_1" = {
    log_analytics_workspace_name                                   = "ploceuslaw000001"      #(Required) Specifies the name of the Log Analytics Workspace. Workspace name should include 4-63 letters, digits or '-'. The '-' shouldn't be the first or the last symbol. Changing this forces a new resource to be created.
    log_analytics_workspace_resource_group_name                    = "ploceusrg000001"       #(Required) The name of the resource group in which the Log Analytics workspace is created. Changing this forces a new resource to be created.
    log_analytics_workspace_location                               = "westus2"               #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created
    log_analytics_workspace_sku                                    = "PerGB2018"             #(Optional) Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018 (new SKU as of 2018-04-03). Defaults to PerGB2018
    log_analytics_workspace_retention_in_days                      = null                    #(Optional) The workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730.
    log_analytics_workspace_daily_quota_gb                         = null                    #(Optional) The workspace daily quota for ingestion in GB. Defaults to -1 (unlimited) if omitted.
    log_analytics_workspace_cmk_for_query_forced                   = false                   #(Optional) Is Customer Managed Storage mandatory for query management?
    log_analytics_workspace_internet_ingestion_enabled             = null                    #(Optional) Should the Log Analytics Workspace support ingestion over the Public Internet? Defaults to true
    log_analytics_workspace_internet_query_enabled                 = null                    #(Optional) Should the Log Analytics Workspace support querying over the Public Internet? Defaults to true
    log_analytics_workspace_reservation_capacity_in_gb_per_day     = null                    #(Optional) The capacity reservation level in GB for this workspace. Must be in increments of 100 between 100 and 5000
    log_analytics_workspace_key_vault_name                         = "ploceuskeyvault000001" #(Required) specify the keyvault name to store the log analytics workspace keys.
    log_analytics_workspace_key_vault_resource_group_name          = "ploceusrg000002"       #(Required) The name of the resource group in which the keyvault is present.
    log_analytics_workspace_primary_shared_key_vault_secret_name   = "ploceuskvsn000001"     #(Required) The name of the keyvault secret where the primary shared key of log analytics workspace is stored
    log_analytics_workspace_secondary_shared_key_vault_secret_name = "ploceuskvsn000002"     #(Required) The name of the keyvault secret where the secondary shared key of log analytics workspace is stored 
    log_analytics_workspace_tags = {                                                         #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#RESOURCE GROUP For KEY VAULT
resource_group_key_vault_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000002" #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = "westus2"         #(Required) The Azure Region where the Resource Group should exist.
    resource_group_tags = {                     #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#KEY VAULT
key_vault_variables = {
  "key_vault_1" = {
    key_vault_name                                  = "ploceuskeyvault000001"                                                                                                                                                                         #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_location                              = "westus2"                                                                                                                                                                                       #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_resource_group_name                   = "ploceusrg000002"                                                                                                                                                                               #(Required) The name of the resource group in which to create the Key Vault.
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
      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_network_acls_enabled        = false           #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass         = "AzureServices" #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action = "Deny"          # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
    key_vault_network_acls_ip_rules       = null            # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.

    #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
    key_vault_network_acls_virtual_networks = null
    key_vault_contact_information_enabled   = false #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email                 = null  #(Required) E-mail address of the contact.
    key_vault_contact_name                  = null  #(Optional) Name of the contact.
    key_vault_contact_phone                 = null  #(Optional) Phone number of the contact.

  }
}

#KEY VAULT ACCESS POLICY
key_vault_access_policy_variables = {
  "key_vault_access_policy_1" = {
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                    #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge", "Set"]                                                                                                                       #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"] #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_name                                  = "ploceuskeyvault000001"                                                                                                                                                                         #(Required) Specifies the name of the Key Vault resource.
    key_vault_resource_group_name                   = "ploceusrg000002"                                                                                                                                                                               #(Required) Specifies the resource group name where the key vault resides in.
    key_vault_access_resource_name                  = "xxxxxxx@ploceus.com"                                                                                                                                                                           #(Required) Specifies the resource name that needs an access policy to the key vault. Possible values are username, group name, service principal name and application name
    key_vault_access_resource_type                  = "User"                                                                                                                                                                                          #(Required) Specifies the type of resource that needs the access policy to the key vault. Possible values are User, SPN, Group, Application
  }
}

#KEY VAULT SECRET
key_vault_secret_variables = {
  "key_vault_secret_1" = {
    key_vault_name                       = "ploceuskeyvault000001"       #(Required) Specifies the name of the Key Vault.
    key_vault_secret_value               = "ploceusvalue000001"          #(Required) Specifies the value of the Key Vault Secret
    key_vault_secret_content_type        = ""                            #(Optional) Specifies the content type for the Key Vault Secret
    key_vault_secret_not_before_date     = null                          #(Optional) Specifies that the key is not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_expiration_date     = null                          #(Optional) Specifies the expiration UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_resource_group_name = "ploceusrg000002"             #(Required) Specifies the name of the resource group, where the key_vault resides in
    key_vault_secret_name                = "ploceuskeyvaultsecret000001" #(Required) Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created
    key_vault_secret_tags = {                                            #(Optional) A mapping of tags which should be assigned to the key vault secret. 

      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_secret_min_upper   = 10 #(Optional)(Number) Minimum number of uppercase alphabet characters in the result. Default value is 0
    key_vault_secret_min_lower   = 5  #(Optional)(Number) Minimum number of lowercase alphabet characters in the result. Default value is 0
    key_vault_secret_min_numeric = 5  #(Optional)(Number) Minimum number of numeric characters in the result. Default value is 0
    key_vault_secret_min_special = 3  #(Optional)(Number) Minimum number of special characters in the result. Default value is 0
    key_vault_secret_length      = 32 #(Optional)(Number) The length of the string desired. The minimum value for length is 1 and, length must also be >= (min_upper + min_lower + min_numeric + min_special)
  }
}

#RESOURCE GROUP For AKS CLUSTER
resource_group_aks_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000003" #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = "westus2"         #(Required) The Azure Region where the Resource Group should exist.
    resource_group_tags = {                     #(Optional) A mapping of tags which should be assigned to the Resource Group.
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
    virtual_network_resource_group_name     = "ploceusrg000003"           #(Required) The name of the resource group in which to create the virtual network.
    virtual_network_address_space           = ["10.1.0.0/16"]             #(Required) The address space that is used the virtual network.
    virtual_network_dns_servers             = null                        #(Optional) List of IP addresses of DNS servers
    virtual_network_flow_timeout_in_minutes = null                        #(Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = null                        #(Optional) The BGP community attribute in format <as-number>:<community-value>.
    virtual_network_edge_zone               = null                        #(Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_ddos_protection_plan = {                              #(Optional block) Provide virtual_network_ddos_protection_enable as true if needed ddos protection
      virtual_network_ddos_protection_enable    = false                   #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = "ploceusddosplan000001" #(Required) Needed for ddos protection plan id.Provide the name of the ddos protection plan if above enable is true
    }
    virtual_network_subnet = null #(Optional) Can be specified multiple times to define multiple subnets
    virtual_network_tags = {      #(Optional) A mapping of tags which should be assigned to the virtual network.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#USER ASSIGNED IDENTITY
user_assigned_identity_variables = {
  "uai1" = {
    user_assigned_identity_name                = "ploceusuai000001" #(Required) Specifies the name of this User Assigned Identity. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_location            = "westus2"          #(Required) The Azure Region where the User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_resource_group_name = "ploceusrg000003"  #Required) Specifies the name of the Resource Group within which this User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#Subnets
subnet_variables = {
  "subnet_1" = {
    subnet_name                                           = "ploceussubnet000001" #(Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                            = "ploceusrg000003"     #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                               = ["10.1.0.0/24"]       #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                           = "ploceusvnet000001"   #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled  = true                  #(Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled      = null                  #(Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_enforce_private_link_endpoint_network_policies = true                  #(Optional) Enable or Disable network policies for the private link endpoint on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false.
    subnet_enforce_private_link_service_network_policies  = null                  #(Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false.
    subnet_service_endpoint_policy_ids                    = null                  #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                              = null                  #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation                                            = null
  }
}

#AKS CLUSTER
kubernetes_cluster_variables = {
  "aks_1" = {
    kubernetes_cluster_name                                                        = "ploceusaks000001"      #(Required) The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created.
    kubernetes_cluster_location                                                    = "westus2"               #(Required) The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created.
    kubernetes_cluster_resource_group_name                                         = "ploceusrg000003"       # (Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_key_vault_name                                              = "ploceuskeyvault000001" #(Optional) Incase if any secret value is passed for linux_profile, windows_profile, azure_active_directory_role_based_access_control(azure_active_directory_role_based_access_control_server_app_secret) or service_principal(client_secret). Pass null if not required
    kubernetes_cluster_key_vault_resource_group_name                               = "ploceusrg000002"       #(Optional) To be provided for the kubernetes_cluster_key_vault_name  resource group
    kubernetes_cluster_default_node_pool_name                                      = "pool000001"
    kubernetes_cluster_capacity_reservation_group_name                             = null                #(Optional) provide the linux kubernetes_cluster capacity reservation group name
    kubernetes_cluster_capacity_reservation_resource_group_name                    = null                #(Optional) provide the capacity reservation group resource group name
    kubernetes_cluster_default_node_pool_vm_size                                   = "standard_d2pds_v5" #(Required) The size of the Virtual Machine, such as Standard_DS2_v2. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_enable_auto_scaling                       = false               #(Optional) Should the Kubernetes Auto Scaler be enabled for this Node Pool? Defaults to false. This requires that the type is set to VirtualMachineScaleSets
    kubernetes_cluster_default_node_pool_enable_auto_scaling_workload_runtime      = "OCIContainer"      #(Optional) Specifies the workload runtime used by the node pool. Possible values are OCIContainer.
    kubernetes_cluster_default_node_pool_enable_host_encryption                    = false               #(Optional) Should the nodes in the Default Node Pool have host encryption enabled? Defaults to false
    kubernetes_cluster_default_node_pool_enable_node_public_ip                     = false               #(Optional) Should nodes in this Node Pool have a Public IP Address? Defaults to false. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_kubelet_config                            = null
    kubernetes_cluster_default_node_pool_linux_os_config                           = null
    kubernetes_cluster_default_node_pool_fips_enabled                              = false #(Optional) Should the nodes in this Node Pool have Federal Information Processing Standard enabled? Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_kubelet_disk_type                         = null  #(Optional) The type of disk used by kubelet. Possible values are OS and Temporary.
    kubernetes_cluster_default_node_pool_max_pods                                  = 30    # (Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created.
    kubernetes_cluster_message_of_the_day                                          = null  # (Optional) A base64-encoded string which will be written to /etc/motd after decoding. This allows customization of the message of the day for Linux nodes. It cannot be specified for Windows nodes and must be a static string (i.e. will be printed raw and not executed as a script). Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_node_public_ip_prefix_name                = null  #(Optional) Resource ID for the Public IP Addresses Prefix for the nodes in this Node Pool. enable_node_public_ip should be true. Changing this forces a new resource to be created. 
    kubernetes_cluster_default_node_pool_node_public_ip_prefix_resource_group_name = null
    kubernetes_cluster_default_node_pool_node_labels                               = null         #(Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool.
    kubernetes_cluster_default_node_pool_only_critical_addons_enabled              = false        #(Optional) Enabling this option will taint default node pool with CriticalAddonsOnly=true:NoSchedule taint. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_orchestrator_version                      = null         #(Optional) Version of Kubernetes used for the Agents. If not specified, the default node pool will be created with the version specified by kubernetes_version. If both are unspecified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). This version must be supported by the Kubernetes Cluster - as such the version of Kubernetes used on the Cluster/Control Plane may need to be upgraded first.
    kubernetes_cluster_default_node_pool_os_disk_size_gb                           = null         #(Optional) The size of the OS Disk which should be used for each agent in the Node Pool. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_os_disk_type                              = null         #(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_os_sku                                    = null         #(Optional) OsSKU to be used to specify Linux OSType. Not applicable to Windows OSType. Possible values include: Ubuntu, CBLMariner. Defaults to Ubuntu. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_pod_virtual_network_name                  = null         #(Optional) The name of the Subnet where the pods in the default Node Pool should exist.
    kubernetes_cluster_default_node_pool_pod_subnet_name                           = null         #(Optional) The name of the Subnet where the pods in the default Node Pool should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_pod_scale_down_mode                       = "Deallocate" #(Optional) Specifies the autoscaling behaviour of the Kubernetes Cluster. If not specified, it defaults to 'ScaleDownModeDelete'. Possible values include 'ScaleDownModeDelete' and 'ScaleDownModeDeallocate'. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_pod_virtual_network_resource_group_name   = null         #(Optional) The name of the resource_group where the pods in the default Node Pool should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_type                                      = null         #(Optional) The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets. Defaults to VirtualMachineScaleSets.
    kubernetes_cluster_default_node_pool_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
    kubernetes_cluster_default_node_pool_ultra_ssd_enabled                   = false #(Optional) Used to specify whether the UltraSSD is enabled in the Default Node Pool. Defaults to false
    kubernetes_cluster_default_node_pool_upgrade_settings                    = null
    kubernetes_cluster_default_node_pool_virtual_network_name                = "ploceusvnet000001" #(Optional) Name of VNet for assigning default node pool to a subnet
    kubernetes_cluster_default_node_pool_virtual_network_resource_group_name = "ploceusrg000003"
    kubernetes_cluster_default_node_pool_subnet_name                         = "ploceussubnet000001" #(Optional) Name of Subnet for assigning default node pool to a subnet . A Route Table must be configured on this Subnet.
    kubernetes_cluster_default_node_pool_max_count                           = null                  #(Optional) The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000.
    kubernetes_cluster_default_node_pool_min_count                           = null                  #(Optional) The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000
    kubernetes_cluster_default_node_pool_node_count                          = 2                     #(Optional) The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 and between min_count and max_count.
    kubernetes_cluster_default_node_pool_availability_zones                  = null                  #(Optional) Specifies a list of Availability Zones in which this Kubernetes Cluster should be located. Changing this forces a new Kubernetes Cluster to be created.  
    kubernetes_cluster_dns_prefix                                            = "ploceusdnsprefix"    #(Optional) DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created. One of dns_prefix or dns_prefix_private_cluster must be specified. The dns_prefix must contain between 3 and 45 characters, and can contain only letters, numbers, and hyphens. It must start with a letter and must end with a letter or a number.
    kubernetes_cluster_dns_prefix_private_cluster                            = null                  #"ploceus"      #(Optional) Specifies the DNS prefix to use with private clusters. Changing this forces a new resource to be created. One of dns_prefix or dns_prefix_private_cluster must be specified. The dns_prefix must contain between 3 and 45 characters, and can contain only letters, numbers, and hyphens. It must start with a letter and must end with a letter or a number.
    kubernetes_cluster_aci_connector_linux                                   = null
    kubernetes_cluster_automatic_channel_upgrade                             = null #(Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, node-image and stable. Omitting this field sets this value to none. Cluster Auto-Upgrade will update the Kubernetes Cluster (and its Node Pools) to the latest GA version of Kubernetes automatically and will not update to Preview versions.
    kubernetes_cluster_api_server_authorized_ip_ranges                       = null # (Optional) The IP ranges to allow for incoming traffic to the server nodes.
    kubernetes_cluster_auto_scaler_profile                                   = null
    kubernetes_cluster_azure_active_directory_role_based_access_control      = null
    kubernetes_cluster_azure_policy_enabled                                  = false #(Optional) Should the Azure Policy Add-On be enabled
    kubernetes_cluster_disk_encryption_set_name                              = null  #(Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes. Set to null if not required.
    kubernetes_cluster_disk_encryption_set_resource_group_name               = null
    kubernetes_cluster_edge_zone                                             = null  #(Optional) Specifies the Edge Zone within the Azure Region where this Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_http_application_routing_enabled                      = false #(Optional) Should HTTP Application Routing be enabled
    kubernetes_cluster_http_proxy_config                                     = null
    kubernetes_cluster_identity = {  #One of either identity or service_principal must be specified. Assign null if not required. Defines the kubernetes cluster identity to be used
      identity_type = "UserAssigned" #(Required) Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      identity_ids = [{
        identity_name = "ploceusuai000001"
      identity_resource_group_name = "ploceusrg000003" }]
    }
    kubernetes_cluster_ingress_application_gateway = null
    #  {                                  #(Optional) Assign null if not required. Defines AGIC ingress controller application gateway 
    #   ingress_application_gateway_exists                     = false                    #Required Assign true if the application gateway already exists. Assign false if new Application gateway needs to be created
    #   ingress_application_gateway_name                       = "ploceusapgwingressctrl" #Required  The name of the Application Gateway to be used or created in the Nodepool Resource Group, which in turn will be integrated with the ingress controller of this Kubernetes Cluster.
    #   ingress_application_gateway_resource_group_name        = "ploceusrg000001"
    #   ingress_application_gateway_subnet_exists              = false #Required. Assign true if the application gateway already exists. Assign false if new Application gateway needs to be created
    #   ingress_application_gateway_subnet_cidr                = null  #(Optional) The subnet CIDR to be used to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. Pass this value or either ingress_application_gateway_subnet_name
    #   ingress_application_gateway_subnet_name                = null  #(Optional) The name of the subnet on which to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. Pass this value or either ingress_application_gateway_subnet_cidr
    #   ingress_application_gateway_subnet_resource_group_name = null
    #   ingress_application_gateway_virtual_network_name       = null
    # }
    kubernetes_cluster_key_vault_secrets_provider = null
    kubernetes_cluster_kubelet_identity           = null
    kubernetes_cluster_kubernetes_version         = "1.25.5" #(Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). AKS does not require an exact patch version to be specified, minor version aliases such as 1.22 are also supported. - The minor version's latest GA patch is automatically chosen in that case. 
    kubernetes_cluster_linux_profile              = null

    // {                                  #(Optional) Pass as null if not required. Changing any parameter forces a new resource to be created.
    //   linux_profile_admin_username_key_vault_secret_name = null           #(Required) Pass the secret name where the adminuser name is stored. Pass null if not stored in key vault
    //   linux_profile_admin_username                       = "adminuser"    #(Optional) The Admin Username for the Cluster if it is not present in key vault 
    //   linux_profile_ssh_key_secret_exist                 = false          #(Required) Set true if the public key is present in key vault. Set false where a new public and private key is generated. Public key will be stored in name provided in linux_profile_ssh_key_secret_name, private key will be stored in the same secret name appended with private. Keys generated using RSA algo with 4096 rsa bits
    //   linux_profile_ssh_key_secret_name                  = "secretsshkey" #(Required) If linux_profile_ssh_key_secret_exist is true then the secret is fetched from the given secret name else the new public key generated is stored in given secret name
    // }
    kubernetes_cluster_local_account_disabled = false #(Optional) If true local accounts will be disabled. Defaults to false. If local_account_disabled is set to true, it is required to enable Kubernetes RBAC and AKS-managed Azure AD integration. 
    kubernetes_cluster_maintenance_window     = null
    kubernetes_cluster_microsoft_defender     = null
    kubernetes_cluster_network_profile = {
      network_profile_network_plugin        = "azure" #(Required) Network plugin to use for networking. Currently supported values are azure, kubenet and none. Changing this forces a new resource to be created.When network_plugin is set to azure - the vnet_subnet_id field in the default_node_pool block must be set and pod_cidr must not be set.
      network_profile_network_mode          = null    #(Optional) Network mode to be used with Azure CNI. Possible values are bridge and transparent. Changing this forces a new resource to be created. network_mode can only be set to bridge for existing Kubernetes Clusters and cannot be used to provision new Clusters - this will be removed by Azure in the future. This property can only be set when network_plugin is set to azure 
      network_profile_network_policy        = "azure" #(Optional) Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created. When network_policy is set to azure, the network_plugin field can only be set to azure.
      network_profile_dns_service_ip        = null    #(Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created.
      network_profile_docker_bridge_cidr    = null    #(Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created.
      network_profile_outbound_type         = null    #(Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer, userDefinedRouting, managedNATGateway and userAssignedNATGateway. Defaults to loadBalancer.
      network_profile_pod_cidr              = null    #(Optional) The CIDR to use for pod IP addresses. This field can only be set when network_plugin is set to kubenet. Changing this forces a new resource to be created.
      network_profile_pod_cidrs             = null    # (Optional) A list of CIDRs to use for pod IP addresses. For single-stack networking a single IPv4 CIDR is expected. For dual-stack networking an IPv4 and IPv6 CIDR are expected. Changing this forces a new resource to be created.
      network_profile_service_cidr          = null    #(Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created. This range should not be used by any network element on or connected to this VNet. Service address CIDR must be smaller than /12. docker_bridge_cidr, dns_service_ip and service_cidr should all be empty or all should be set.
      network_profile_service_cidrs         = null    # (Optional) A list of CIDRs to use for Kubernetes services. For single-stack networking a single IPv4 CIDR is expected. For dual-stack networking an IPv4 and IPv6 CIDR are expected. Changing this forces a new resource to be created.
      network_profile_ip_versions           = null    #(Optional) Specifies a list of IP versions the Kubernetes Cluster will use to assign IP addresses to its nodes and pods. Possible values are IPv4 and/or IPv6. IPv4 must always be specified. Changing this forces a new resource to be created. To configure dual-stack networking ip_versions should be set to ["IPv4", "IPv6"]
      network_profile_load_balancer_sku     = null    #(Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard. Defaults to standard.
      network_profile_load_balancer_profile = null
      network_profile_nat_gateway_profile   = null
    }
    kubernetes_cluster_node_resource_group_name             = null  #(Optional) The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created. Azure requires that a new, non-existent Resource Group is used, as otherwise the provisioning of the Kubernetes Service will fail.
    kubernetes_cluster_oidc_issuer_enabled                  = false #(Required) Enable or Disable the OIDC issuer URL
    kubernetes_cluster_oms_agent                            = null
    kubernetes_cluster_open_service_mesh_enabled            = false                           #(Optional) Open Service Mesh needs to be enabled
    kubernetes_cluster_private_cluster_enabled              = true                            #(Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created.
    kubernetes_cluster_private_dns_zone_name                = "privatelink.westus2.azmk8s.io" #"private.eastus2.azmk8s.io"  #(Optional)Use when kubernetes_cluster_private_cluster_enabled is set to true. Either the Name of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None. In case of None you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning. Changing this forces a new resource to be created.
    kubernetes_cluster_private_dns_zone_resource_group_name = "ploceusrg000003"               #(Optional)Resource Group name for kubernetes_cluster_private_dns_zone_name. 
    kubernetes_cluster_private_cluster_public_fqdn_enabled  = false                           #(Optional) Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to false.
    kubernetes_cluster_workload_autoscaler_profile          = null
    # {                                        #(Optional) A workload_autoscaler_profile block defined below.
    #   workload_autoscaler_profile_keda_enabled = false                                        #(Optional) Specifies whether KEDA Autoscaler can be used for workloads.
    # }
    kubernetes_cluster_workload_identity_enabled         = false #(Optional) Specifies whether Azure AD Workload Identity should be enabled for the Cluster. Defaults to false
    kubernetes_cluster_public_network_access_enabled     = false #(Optional) Whether public network access is allowed for this Kubernetes Cluster. Defaults to true. Changing this forces a new resource to be created. When public_network_access_enabled is set to true, 0.0.0.0/32 must be added to api_server_authorized_ip_ranges
    kubernetes_cluster_role_based_access_control_enabled = true  #(Optional) - Whether Role Based Access Control for the Kubernetes Cluster should be enabled. Defaults to true. Changing this forces a new resource to be created.
    kubernetes_cluster_run_command_enabled               = false #(Optional) Whether to enable run command for the cluster or not. Defaults to true
    kubernetes_cluster_service_principal                 = null
    kubernetes_cluster_sku_tier                          = "Free" #Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free.
    kubernetes_cluster_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
    kubernetes_cluster_web_app_routing = null #(Optional) A web_app_routing block as defined below
    #   web_app_routing_dns_zone_name = "ploceusdns000001"                      #(Required) Specifies the ID of the DNS Zone in which DNS entries are created for applications deployed to the cluster when Web App Routing is enabled.
    #   web_app_routing_dns_zone_resource_group = "ploceusrg000001"             #(Required) Specifies the ID of the DNS Zone in which DNS entries are created for applications deployed to the cluster when Web App Routing is enabled.
    # }
    kubernetes_cluster_windows_profile = {                                                 #(Optional) Pass as null if not required. Changing any parameter forces a new resource to be created.
      windows_profile_admin_username_key_vault_secret_name = "ploceuskeyvaultsecret000001" #(Required) Pass the secret name where the adminuser name is stored. Pass null if not stored in key vault
      windows_profile_admin_username                       = "admin123"                    #(Optional) The Admin Username for the Windows VMs if not present in key vault
      windows_profile_admin_password_secret_exist          = false                         #(Required) Set true if the password is present in key vault else new password will be generated 
      windows_profile_admin_password_secret_name           = "akssecret111"                #(Required) If windows_profile_admin_password_secret_exist is true then the Admin Password is read from given secret else the new generated password is stored in the given secret. Length must be between 14 and 123 characters.
      windows_profile_admin_password_length                = 14                            #(Required) Password Length. Length must be between 14 and 123 characters. Password generated will contain minimum of 4 lower case, 4 upper case, 2 numeric and 2 special character
      windows_profile_license                              = "Windows_Server"              #(Optional) Specifies the type of on-premise license which should be used for Node Pool Windows Virtual Machine. At this time the only possible value is Windows_Server
      kubernetes_cluster_gmsa                              = null
      #     gmsa_dns_server       =   #(Required) Specifies the DNS server for Windows gMSA. Set this to an empty string if you have configured the DNS server in the VNet which was used to create the managed cluster.
      #     gmsa_root_domain      =   #(Required) Specifies the root domain name for Windows gMSA. Set this to an empty string if you have configured the DNS server in the VNet which was used to create the managed cluster.
      #   }
    }
  }

}

key_vault_subscription_id              = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
key_vault_tenant_id                    = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
kubernetes_cluster_subscription_id     = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
kubernetes_cluster_tenant_id           = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
log_analytics_oms_subscription_id      = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
log_analytics_oms_tenant_id            = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
log_analytics_defender_subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
log_analytics_defender_tenant_id       = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
private_dns_zone_subscription_id       = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
private_dns_zone_tenant_id             = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"


