#resource group variables
variable "resource_group_variables" {
  type = map(object({
    resource_group_name     = string      #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_tags     = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups"
  default = {
  }
}

#key valut resource group variables
variable "key_vault_resource_group_variables" {
  type = map(object({
    resource_group_name     = string      #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_tags     = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups"
  default = {
  }
}

#vnet variable
variable "virtual_network_variables" {
  type = map(object({
    virtual_network_name                    = string       #(Required) the name of the virtual network. Changing this forces a new resource to be created.
    virtual_network_location                = string       #(Required) the location/region where the virtual network is created. Changing this forces a new resource to be created.
    virtual_network_resource_group_name     = string       #(Required) the name of the resource group in which to create the virtual network.
    virtual_network_address_space           = list(string) #(Required) the address space that is used the virtual network. You can supply more than one address space.
    virtual_network_dns_servers             = list(string) #(Optional) list of IP addresses of DNS servers.Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it.
    virtual_network_flow_timeout_in_minutes = number       #(Optional) the flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = string       #(Optional) the BGP community attribute in format <as-number>:<community-value>.
    virtual_network_ddos_protection_plan = object({        #(Optional) block for ddos protection
      virtual_network_ddos_protection_enable    = bool     #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = string   #(Required) for the ID of DDoS Protection Plan.
    })
    virtual_network_edge_zone = string                                           #(Optional) specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_subnet = list(object({                                       #(Optional) for the subnet block config. Set to null if not required
      virtual_network_subnet_name                                       = string #(Required) the subnet name to attach to vnet
      virtual_network_subnet_address_prefix                             = string #(Required) the address prefix to use for the subnet.
      virtual_network_subnet_network_security_group_name                = string #(Optional) the Network Security Group Name to associate with the subnet.
      virtual_network_subnet_network_security_group_resource_group_name = string #(Optional) the Network Security Group Resource Group to associate with the subnet.
    }))
    virtual_network_tags = map(string) #(Optional)a mapping of tags to assign to the resource.
  }))
  description = "Map of vnet objects. name, vnet_address_space, and dns_server supported"
  default     = {}
}

#subnet Variables
variable "subnet_variables" {
  type = map(object({
    subnet_name                                           = string       # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                            = string       #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_virtual_network_name                           = string       #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                               = list(string) #(Required) The address prefixes to use for the subnet.
    subnet_private_link_service_network_policies_enabled  = bool         # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled      = bool         # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_service_endpoints                              = list(string) #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    subnet_enforce_private_link_endpoint_network_policies = bool         #(Optional) Enable or Disable network policies for the private link endpoint on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false.
    subnet_enforce_private_link_service_network_policies  = bool         #(Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false.
    subnet_service_endpoint_policy_ids                    = list(string) #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    delegation = list(object({
      delegation_name            = string       #(Required) A name for this delegation.
      service_delegation_name    = string       # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = list(string) #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }))
  }))
  default     = {}
  description = "Map of variables for Subnet"
}

#key vault variables
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
    key_vault_purge_protection_enabled              = bool         # (Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
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
  default     = {}
}

#key vault access policy variables
variable "key_vault_access_policy_variables" {
  type = map(object({
    key_vault_access_policy_key_permissions         = list(string) #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.
    key_vault_access_policy_secret_permissions      = list(string) #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = list(string) #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = list(string) #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_name                                  = string       #(Required) Specifies the name of the Key Vault resource.
    key_vault_resource_group_name                   = string       #(Required) Specifies the resource group name where the key vault resides in.
    key_vault_access_resource_name                  = string       #(Required) Specifies the resource name that needs the access policy to the key vault. Possible values are username, group name, service principal name and application name 
    key_vault_access_resource_type                  = string       #(Required) Specifies the type of resource that needs the access policy to the key vault. Possible values are User, SPN, Group, Application
  }))
  description = "Map of variables for key vault access policies"
  default     = {}
}

# key vault key variables
variable "key_vault_key_variables" {
  type = map(object({
    key_vault_name                = string       #(Required) The name of the Key Vault where the Key should be created.
    key_vault_resource_group_name = string       #(Required) The resource group name of the Key Vault where the Key should be created.
    key_vault_key_name            = string       #(Required) Specifies the name of the Key Vault Key.
    key_vault_key_key_type        = string       #(Required) Specifies the Key Type to use for this Key Vault Key. Possible values are EC (Elliptic Curve), EC-HSM, RSA and RSA-HSM.
    key_vault_key_key_size        = number       #(Optional) Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048. Note: This field is required if key_type is RSA or RSA-HSM.
    key_vault_key_curve           = string       #(Optional) Specifies the curve to use when creating an EC key. Possible values are P-256, P-256K, P-384, and P-521. This field will be required in a future release if key_type is EC or EC-HSM. The API will default to P-256 if nothing is specified.
    key_vault_key_key_opts        = list(string) #(Required) A list of JSON web key operations. Possible values include: decrypt, encrypt, sign, unwrapKey, verify and wrapKey. Please note these values are case sensitive.
    key_vault_key_not_before_date = string       #(Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_key_expiration_date = string       #(Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_key_tags            = map(string)  #(Optional) A mapping of tags to assign to the resource.
  }))
  default     = {}
  description = "Map of object of key vault key variables"
}

# Key Vault Secret
variable "key_vault_secret_variables" {
  type = map(object({
    key_vault_name                       = string
    key_vault_secret_name                = string
    key_vault_secret_value               = string
    key_vault_secret_content_type        = string
    key_vault_secret_not_before_date     = string
    key_vault_secret_expiration_date     = string
    key_vault_secret_resource_group_name = string
    key_vault_secret_tags                = map(string)
    key_vault_secret_min_upper           = number
    key_vault_secret_min_lower           = number
    key_vault_secret_min_numeric         = number
    key_vault_secret_min_special         = number
    key_vault_secret_length              = number
  }))
}

#User Assigned Identity VARIABLES
variable "user_assigned_identity_variables" {
  type = map(object({
    user_assigned_identity_name                = string      #(Required) Specifies the name of this User Assigned Identity. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_location            = string      # (Required) The Azure Region where the User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_resource_group_name = string      #Required) Specifies the name of the Resource Group within which this User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_tags                = map(string) #(Optional) A mapping of tags which should be assigned to the User Assigned Identity
  }))
  description = "Map of User Assigned Identities"
  default     = {}
}

#app service plan variables
variable "app_service_plan_variables" {
  type = map(object({
    app_service_plan_name                          = string      #(Required) The name which should be used for this Service Plan. Changing this forces a new AppService to be created.
    app_service_plan_location                      = string      #(Required) The Azure Region where the Service Plan should exist. Changing this forces a new AppService to be created.
    app_service_plan_os_type                       = string      #(Required) The O/S type for the App Services to be hosted in this plan. Possible values include Windows, Linux, and WindowsContainer.
    app_service_plan_resource_group_name           = string      #(Required) The name of the Resource Group where the AppService should exist. Changing this forces a new AppService to be created.
    app_service_plan_sku_name                      = string      #(Required) The SKU for the plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, WS3, and Y1.#Isolated SKUs (I1, I2, I3, I1v2, I2v2, and I3v2) can only be used with App Service Environments #Elastic and Consumption SKUs (Y1, EP1, EP2, and EP3) are for use with Function Apps.
    app_service_plan_maximum_elastic_worker_count  = number      #(Optional) The maximum number of workers to use in an Elastic SKU Plan. Cannot be set unless using an Elastic SKU.
    app_service_plan_worker_count                  = number      #(Optional) The number of Workers (instances) to be allocated.
    app_service_plan_per_site_scaling_enabled      = bool        #(Optional) Should Per Site Scaling be enabled. Defaults to false.
    app_service_plan_zone_balancing_enabled        = bool        #(Optional) Should the Service Plan balance across Availability Zones in the region. Defaults to false. If this setting is set to true and the worker_count value is specified, it should be set to a multiple of the number of availability zones in the region. Please see the Azure documentation for the number of Availability Zones in your region.
    app_service_plan_tags                          = map(string) #(Optional) A mapping of tags which should be assigned to the AppService.
    app_service_environment_v3_name                = string      #(Optional) Name of the app service environemnt v3 Requires an Isolated SKU. Use one of I1, I2, I3 for azurerm_app_service_environment, or I1v2, I2v2, I3v2 for azurerm_app_service_environment_v3
    app_service_environment_v3_resource_group_name = string      #(Optional) Resource Group Name of the app service environemnt v3
    app_service_environment_name                   = string      #(Optional) Name of the app service environemnt Requires an Isolated SKU. Use one of I1, I2, I3 for azurerm_app_service_environment, or I1v2, I2v2, I3v2 for azurerm_app_service_environment_v3
    app_service_environment_resource_group_name    = string      #(Optional) Resource Group Name of the app service environemnt
  }))
  description = "Map of App Service Plans"
  default     = {}
}

#storage account variables
variable "storage_account_variables" {
  type = map(object({
    storage_account_key_vault_name                                     = string #(Required) The name of the Key Vault.
    storage_account_key_vault_resource_group_name                      = string #(Required) The resource group name of the Key Vault.
    storage_account_key_vault_key_name                                 = string #(Required) The name of the Key Vault key required for customer managed key.
    storage_account_user_assigned_identity_name_for_cmk                = string #(Required) The name of a user assigned identity for customer managed key.
    storage_account_user_assigned_identity_resource_group_name_for_cmk = string #(Required) The resource group name of a user assigned identity for customer managed key.
    storage_account_identity_type_for_cmk                              = string #(Required) The identity type of a user assigned identity for customer managed key. Possible values could be "UserAssigned", "SystemAssigned", "SystemAssigned, UserAssigned".
    storage_account_name                                               = string #(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed.This must be unique across the entire Azure service, not just within the resource group.
    storage_account_resource_group_name                                = string #(Required) The name of the resource group in which to create the storage account.
    storage_account_location                                           = string #(Required) Specifies the supported Azure location where the resource exists. 
    storage_account_account_kind                                       = string #(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2.
    storage_account_account_tier                                       = string #(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    storage_account_account_replication_type                           = string #(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa.
    storage_account_cross_tenant_replication_enabled                   = bool   #(Optional) Should cross Tenant replication be enabled? Defaults to true.
    storage_account_access_tier                                        = string #(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot.
    storage_account_edge_zone                                          = string #(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist.
    storage_account_enable_https_traffic_only                          = bool   #(Optional) Boolean flag which forces HTTPS if enabled. Defaults to true.
    storage_account_min_tls_version                                    = string #(Optional) The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts.
    storage_account_allow_nested_items_to_be_public                    = bool   #Allow or disallow nested items within this Account to opt into being public. Defaults to true.
    storage_account_shared_access_key_enabled                          = bool   #Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true.
    storage_account_public_network_access_enabled                      = bool   #(Optional) Whether the public network access is enabled? Defaults to true.
    storage_account_default_to_oauth_authentication                    = bool   #(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false
    storage_account_is_hns_enabled                                     = bool   #(Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2.
    storage_account_nfsv3_enabled                                      = bool   #(Optional) Is NFSv3 protocol enabled? Defaults to false.
    storage_account_large_file_share_enabled                           = bool   #(Optional) Is Large File Share Enabled?
    storage_account_queue_encryption_key_type                          = string #(Optional) The encryption type of the queue service. Possible values are Service and Account.Default value is Service.
    storage_account_table_encryption_key_type                          = string #(Optional) The encryption type of the table service. Possible values are Service and Account. Default value is Service.
    storage_account_infrastructure_encryption_enabled                  = bool   #(Optional) Is infrastructure encryption enabled? Defaults to false.

    storage_account_custom_domain = object({
      custom_domain_name          = string #(Required) The Custom Domain Name to use for the Storage Account, which will be validated by Azure.
      custom_domain_use_subdomain = bool   #(Optional) Should the Custom Domain Name be validated by using indirect CNAME validation?
    })

    storage_account_identity = object({
      storage_account_identity_type = string # Possible values could be "UserAssigned", "SystemAssigned", "SystemAssigned, UserAssigned"
      storage_account_user_assigned_identity_ids = list(object({
        identity_name                = string
        identity_resource_group_name = string
      }))
    })

    storage_account_blob_properties = object({
      versioning_enabled            = bool   #(Optional) Is versioning enabled? Default to false.
      change_feed_enabled           = bool   #(Optional) Is the blob service properties for change feed events enabled? Default to false.
      change_feed_retention_in_days = number #(Optional) The duration of change feed events retention in days. The possible values are between 1 and 146000 days (400 years). Setting this to null (or omit this in the configuration file) indicates an infinite retention of the change feed.
      default_service_version       = string #(Optional) The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version. Defaults to 2020-06-12.
      last_access_time_enabled      = bool   #(Optional) Is the last access time based tracking enabled? Default to false.

      cors_enabled = bool #(optional) Should cross origin resource sharing be enabled
      cors_rule = object({
        allowed_headers    = list(string) #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = list(string) #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = list(string) #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = list(string) #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = number       #(Required) The number of seconds the client should cache a preflight response.
      })

      delete_retention_policy = object({
        delete_retention_policy_days = string #(Optional) Specifies the number of days that the blob should be retained, between 1 and 365 days. Defaults to 7.
      })

      container_delete_retention_policy = object({
        container_delete_retention_policy_days = string #(Optional) Specifies the number of days that the container should be retained, between 1 and 365 days. Defaults to 7.
      })
    })

    storage_account_queue_properties = object({
      cors_enabled = bool #(optional) Should cross origin resource sharing be enabled.
      cors_rule = object({
        allowed_headers    = list(string) #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = list(string) #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = list(string) #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = list(string) #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = number       #(Required) The number of seconds the client should cache a preflight response.
      })

      logging_enabled = bool #Should storage account queue properties logging be enabled.
      logging = object({
        delete                = bool   #(Required) Indicates whether all delete requests should be logged. 
        read                  = bool   #(Required) Indicates whether all read requests should be logged. 
        version               = string #(Required) The version of storage analytics to configure.
        write                 = bool   #(Required) Indicates whether all write requests should be logged.
        retention_policy_days = number #(Optional) Specifies the number of days that logs will be retained.
      })

      minute_metrics = object({
        enabled               = bool   #(Required) Indicates whether minute metrics are enabled for the Queue service. 
        version               = string #(Required) The version of storage analytics to configure. 
        include_apis          = bool   #(Optional) Indicates whether metrics should generate summary statistics for called API operations.
        retention_policy_days = number #(Optional) Specifies the number of days that logs will be retained.
      })

      hour_metrics = object({
        enabled               = bool   #(Required) Indicates whether minute metrics are enabled for the Queue service. 
        version               = string #(Required) The version of storage analytics to configure. 
        include_apis          = bool   #(Optional) Indicates whether metrics should generate summary statistics for called API operations.
        retention_policy_days = number #(Optional) Specifies the number of days that logs will be retained.
      })
    })

    storage_account_static_website = object({
      index_document     = string #Optional) The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive.
      error_404_document = string #(Optional) The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file.
    })

    storage_account_share_properties = object({
      cors_enabled = bool #(optional) Should cross origin resource sharing be enabled.
      cors_rule = object({
        allowed_headers    = list(string) #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = list(string) #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = list(string) #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = list(string) #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = number       #(Required) The number of seconds the client should cache a preflight response.
      })

      retention_policy = object({
        retention_policy_days = number #(Optional) Specifies the number of days that the azurerm_storage_share should be retained, between 1 and 365 days. Defaults to 7.
      })

      smb = object({
        smb_versions                        = set(string) #(Optional) A set of SMB protocol versions. Possible values are SMB2.1, SMB3.0, and SMB3.1.1.
        smb_authentication_types            = set(string) #(Optional) A set of SMB authentication methods. Possible values are NTLMv2, and Kerberos.
        smb_kerberos_ticket_encryption_type = set(string) #(Optional) A set of Kerberos ticket encryption. Possible values are RC4-HMAC, and AES-256.
        smb_channel_encryption_type         = set(string) #(Optional) A set of SMB channel encryption. Possible values are AES-128-CCM, AES-128-GCM, and AES-256-GCM.
        smb_multichannel_enabled            = bool        #(Optional) Indicates whether multichannel is enabled. Defaults to false. This is only supported on Premium storage accounts.
      })
    })

    storage_account_network_rules = object({
      default_action = string       #(Required) Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow.
      bypass         = list(string) #(Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None.
      ip_rules       = list(string) #(Optional) List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed.

      storage_account_network_rules_vnet_subnets = list(object({
        storage_account_network_rules_virtual_network_name = string #(Required) Vitural Network name to be associated.
        storage_account_network_rules_subnet_name          = string #(Required) Subnet Name to be associated.
        storage_account_network_rules_vnet_subscription_id = string #(Required) Subscription Id where Vnet is created.
        storage_account_network_rules_vnet_rg_name         = string #(Required) Resource group where Vnet is created.
      }))

      private_link_access = map(object({
        endpoint_resource_id = string
        endpoint_tenant_id   = string
      }))
    })

    storage_account_azure_files_authentication = object({
      directory_type = string #(Required) Specifies the directory service used. Possible values are AADDS and AD.
      active_directory = object({
        storage_sid         = string #(Required) Specifies the security identifier (SID) for Azure Storage.
        domain_name         = string #(Required) Specifies the primary domain that the AD DNS server is authoritative for.
        domain_sid          = string #(Required) Specifies the security identifier (SID).
        domain_guid         = string #(Required) Specifies the domain GUID.
        forest_name         = string #(Required) Specifies the Active Directory forest.
        netbios_domain_name = string #(Required) Specifies the NetBIOS domain name.
      })
    })

    storage_account_routing = object({
      publish_internet_endpoints  = bool   #(Optional) Should internet routing storage endpoints be published? Defaults to false.
      publish_microsoft_endpoints = bool   #(Optional) Should Microsoft routing storage endpoints be published? Defaults to false.
      choice                      = string #(Optional) Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting. Defaults to MicrosoftRouting.
    })

    storage_account_immutability_policy = object({
      allow_protected_append_writes = bool   #(Required) When enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted.
      state                         = string #(Required) Defines the mode of the policy. Disabled state disables the policy, Unlocked state allows increase and decrease of immutability retention time and also allows toggling allowProtectedAppendWrites property, Locked state only allows the increase of the immutability retention time. A policy can only be created in a Disabled or Unlocked state and can be toggled between the two states. Only a policy in an Unlocked state can transition to a Locked state which cannot be reverted.
      period_since_creation_in_days = number #(Required) The immutability period for the blobs in the container since the policy creation, in days.
    })

    storage_account_sas_policy = object({
      expiration_period = string #(Required) The SAS expiration period in format of DD.HH:MM:SS.
      expiration_action = string #(Optional) The SAS expiration action. The only possible value is Log at this moment. Defaults to Log.
    })

    storage_account_tags = map(string) #(Optional) A mapping of tags to assign to the resource.
  }))
  description = "Map of object of storage account variables"
  default     = {}
}

#linux web app variables
variable "linux_web_app_variables" {
  type = map(object({
    linux_web_app_name                       = string      #(Required) The name which should be used for this Linux Web App. Changing this forces a new Linux Web App to be created.
    linux_web_app_location                   = string      #(Required) The Azure Region where the Linux Web App should exist. Changing this forces a new Linux Web App to be created.
    linux_web_app_resource_group_name        = string      #(Required) The name of the Resource Group where the Linux Web App should exist. Changing this forces a new Linux Web App to be created.
    linux_web_app_client_affinity_enabled    = bool        #(Optional) Should Client Affinity be enabled?
    linux_web_app_client_certificate_enabled = string      #(Optional) Should Client Certificates be enabled?
    linux_web_app_client_certificate_mode    = string      # (Optional) The Client Certificate mode. Possible values are Required, Optional, and OptionalInteractiveUser. This property has no effect when client_certificate_enabled is false
    linux_web_app_app_settings               = map(string) # (Optional) A map of key-value pairs of App Settings.
    linux_web_app_enabled                    = bool        #Defaults to true
    linux_web_app_https_only                 = bool        #(Optional) Should the Linux Web App require HTTPS connections. 
    linux_web_app_app_settings_enabled       = bool        #(Optional) A auth_settings block as defined below.
    linux_web_app_zip_deploy_file            = string      # (Optional) The local path and filename of the Zip packaged application to deploy to this Linux Web App.
    key_vault_reference_identity_id          = string      #(Optional) The User Assigned Identity ID used for accessing KeyVault secrets. The identity must be assigned to the application in the identity block. For more information see - Access vaults with a user-assigned identit
    linux_web_app_sticky_settings = list(object({          #(Optional) A sticky_settings block as defined below.
      sticky_settings_app_setting_names       = string     # (Optional) A list of app_setting names that the Linux Web App will not swap between Slots when a swap operation is triggered.
      sticky_settings_connection_string_names = string     #(Optional) A list of connection_string names that the Linux Web App will not swap between Slots when a swap operation is triggered.
    }))
    linux_web_app_connection_string = list(object({ # block supports the following:
      connection_string_name  = string              #Required) The name of the Connection String.
      connection_string_type  = string              # (Required) Type of database. Possible values include: MySQL, SQLServer, SQLAzure, Custom, NotificationHub, ServiceBus, EventHub, APIHub, DocDb, RedisCache, and PostgreSQL.
      connection_string_value = string              #(Required) The connection string value.
    }))
    linux_web_app_storage_account = list(object({ #- (Optional) One or more storage_account blocks as defined below.
      storage_account_name       = string         #(Required) The Name of the Storage Account.
      storage_account_share_name = string         #(Required) The Name of the File Share or Container Name for Blob storage
      storage_account_type       = string         #(Required) The Azure Storage Type. Possible values include AzureFiles and AzureBlob
      storage_account_mount_path = string         # (Optional) The path at which to mount the storage share.
    }))
    linux_web_app_logs = list(object({      # (Optional) A logs block as defined below.
      logs_detailed_error_messages = string #(Optional) Should detailed error messages be enabled?
      logs_failed_request_tracing  = string # (Optional) Should the failed request tracing be enabled?
      http_logs = list(object({
        azure_blob_storage = list(object({              # (Optional) A azure_blob_storage block as defined above.
          azure_blob_storage_retention_in_days = string # (Optional) A file_system block as defined above.
        }))
        file_system = list(object({          #block supports the following:
          content_retention_in_days = string #(Required) The retention period in days. A value of 0 means no retention.
          content_retention_in_mb   = string #(Required) The maximum size in megabytes that log files can use.
        }))
      }))
      linux_web_app_application_logs = list(object({
        file_system_level = string                      #Possible values include Error, Warning, Information, Verbose and Off
        azure_blob_storage = list(object({              #block supports the following:
          azure_blob_storage_level             = string # (Required) Log level. Possible values include: Verbose, Information, Warning, and Error.
          azure_blob_storage_retention_in_days = string ##(Required) The retention period in days. A value of 0 means no retention.
        }))
      }))
    }))
    linux_web_app_auth_settings = object({                          #block supports the following:
      auth_settings_enabled                          = bool         # (Required) Should the Authentication / Authorization feature be enabled for the Linux Web App?
      auth_settings_additional_login_parameters      = map(string)  #(Optional) Specifies a map of login Parameters to send to the OpenID Connect authorization endpoint when a user logs in.
      auth_settings_allowed_external_redirect_urls   = list(string) #(Optional) Specifies a list of External URLs that can be redirected to as part of logging in or logging out of the Linux Web App.
      auth_settings_unauthenticated_client_action    = string       #Possible values include: RedirectToLoginPage, AllowAnonymous.
      default_auth_provider                          = string       #Possible values include: BuiltInAuthenticationProviderAzureActiveDirectory, BuiltInAuthenticationProviderFacebook, BuiltInAuthenticationProviderGoogle, BuiltInAuthenticationProviderMicrosoftAccount, BuiltInAuthenticationProviderTwitter, BuiltInAuthenticationProviderGithub
      auth_settings_issuer                           = string       # (Optional) The action to take when an unauthenticated client attempts to access the app. Possible values include: RedirectToLoginPage, AllowAnonymous.
      multiple_auth_providers_configured             = bool         #(Optional) The OpenID Connect Issuer URI that represents the entity that issues access tokens for this Linux Web App.
      auth_settings_runtime_version                  = string       #(Optional) The RuntimeVersion of the Authentication / Authorization feature in use for the Linux Web App.
      token_refresh_extension_errors                 = string       # (Optional) The number of hours after session token expiration that a session token can be used to call the token refresh API. Defaults to 72 hours.
      auth_settings_token_store_enabled              = bool         #- (Optional) Should the Linux Web App durably store platform-specific security tokens that are obtained during login flows? Defaults to false.
      auth_settings_linux_web_app_ad_secret_required = bool         # make it false if auth_settings_active_directory=null
      auth_settings_active_directory = list(object({                #block supports the following:
        auth_settings_active_directory_client_id     = string       #(Required) The ID of the Client to use to authenticate with Azure Active Directory.
        auth_settings_active_directory_client_secret = string       # (Optional) The Client Secret for the Client ID. Cannot be used with client_secret_setting_name.
        auth_settings_allowed_audiences              = list(string) #(Optional) Specifies a list of Allowed audience values to consider when validating JWTs issued by Azure Active Directory.
        linux_web_app_ad_client_secret_setting_name  = string       # (Optional) The App Setting name that contains the client secret of the Client. Cannot be used with client_secret.
      }))
      linux_web_app_facebook_secret_required = bool                   # make it false if auth_settings_facebook=null
      auth_settings_facebook = list(object({                          # block supports the following:
        facebook_app_id                                = string       #(Required) The App ID of the Facebook app used for login.
        facebook_app_secret                            = string       # (Optional) The App Secret of the Facebook app used for Facebook login. Cannot be specified with app_secret_setting_name.
        facebook_oauth_scopes                          = list(string) # (Optional) Specifies a list of OAuth 2.0 scopes to be requested as part of Facebook login authentication.
        linux_web_app_facebook_app_secret_setting_name = string       # (Optional) The app setting name that contains the app_secret value used for Facebook login. Cannot be specified with app_secret.
      }))
      linux_web_app_github_secret_required = bool # make it false if auth_settings_github=null
      auth_settings_github = list(object({
        github_client_id                                = string       # (Required) The ID of the GitHub app used for login.
        github_client_secret                            = string       # (Optional) The Client Secret of the GitHub app used for GitHub login. Cannot be specified with client_secret_setting_name.
        github_oauth_scopes                             = list(string) #(Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of GitHub login authentication.
        linux_web_app_github_client_secret_setting_name = string       # (Optional) The app setting name that contains the client_secret value used for GitHub login. Cannot be specified with client_secret.
      }))
      linux_web_app_google_secret_required = bool # make it false if auth_settings_google=null
      auth_settings_google = list(object({
        google_client_id                                = string       #(Required) The OpenID Connect Client ID for the Google web application.
        google_client_secret                            = string       # (Optional) The client secret associated with the Google web application. Cannot be specified with client_secret_setting_name.
        google_oauth_scopes                             = list(string) # (Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of Google Sign-In authentication. If not specified, openid, profile, and email are used as default scopes.
        linux_web_app_google_client_secret_setting_name = string       #- (Optional) The app setting name that contains the client_secret value used for Google login. Cannot be specified with client_secret.  
      }))
      linux_web_app_microsoft_secret_required = bool # make it false if auth_settings_microsoft=null
      auth_settings_microsoft = list(object({
        microsoft_client_id                                = string       # (Required) The OAuth 2.0 client ID that was created for the app used for authentication.
        microsoft_client_secret                            = string       #(Optional) The OAuth 2.0 client secret that was created for the app used for authentication. Cannot be specified with client_secret_setting_name.
        linux_web_app_microsoft_client_secret_setting_name = string       # (Optional) The app setting name containing the OAuth 2.0 client secret that was created for the app used for authentication. Cannot be specified with client_secret.
        microsoft_oauth_scopes                             = list(string) #(Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of Microsoft Account authentication. If not specified, "wl.basic" is used as the default scope.
      }))
      linux_web_app_twitter_secret_required = bool # make it false if auth_settings_twitter=null
      auth_settings_twitter = list(object({
        twitter_consumer_secret                            = string #(Optional) The OAuth 1.0a consumer secret of the Twitter application used for sign-in. Cannot be specified with consumer_secret_setting_name.
        twitter_consumer_key                               = string # (Required) The OAuth 1.0a consumer key of the Twitter application used for sign-in.
        linux_web_app_twitter_consumer_secret_setting_name = string #(Optional) The app setting name that contains the OAuth 1.0a consumer secret of the Twitter application used for sign-in. Cannot be specified with consumer_secret.
      }))
    })
    linux_web_app_backup = list(object({
      backup_name                  = string              # (Required) The name which should be used for this Backup.
      linux_web_app_backup_enabled = string              #(Optional) Should this backup job be enabled?
      schedule = list(object({                           #(Required) A schedule block as defined below.
        backup_schedule_frequency_interval      = string #(Required) How often the backup should be executed (e.g. for weekly backup, this should be set to 7 and frequency_unit should be set to Day).
        backup_schedule_frequency_unit          = string # (Required) The unit of time for how often the backup should take place. Possible values include: Day, Hour
        backup_schedule_retention_period_days   = string #(Optional) After how many days backups should be deleted. 
        backup_schedule_start_time              = string #(Optional) When the schedule should start working in RFC-3339 format.
        backup_schedule_keep_atleast_one_backup = string # (Optional) Should the service keep at least one backup, regardless of the age of backup? Defaults to false.
      }))
    }))
    linux_web_app_identity = object({                        #(Optional) An identity block as defined below. 
      linux_web_app_identity_type = string                   # (Required) Specifies the type of Managed Service Identity that should be configured on this Linux Web App. Possible values are SystemAssigned, UserAssigned, and SystemAssigned, UserAssigned (to enable both).
      linux_web_app_user_assigned_identities = list(object({ #(Optional) A list of User Assigned Managed Identity IDs to be assigned to this Linux Web App.
        user_identity_name                = string           #(Optional) if linux web app user assigned identities vlaues are passed then name of the user_identity_name should be provided
        user_identity_resource_group_name = string           #(Optional) if linux web app user assigned identities vlaues are passed then name of the user_identity_name resource group should be provided
      }))
    })
    linux_web_app_site_config = list(object({                                  #(Required) A site_config block as defined below.
      site_config_always_on                                     = bool         # (Optional) If this Linux Web App is Always On enabled. Defaults to true.
      site_config_api_definition_url                            = string       # (Optional) The URL to the API Definition for this Linux Web App.
      site_config_api_management_api_id                         = string       #(Optional) The API Management API ID this Linux Web App is associated with.
      site_config_ftps_state                                    = string       # (Optional) The State of FTP / FTPS service. Possible values include AllAllowed, FtpsOnly, and Disabled.
      site_config_app_command_line                              = string       # (Optional) The App command line to launch.
      site_config_health_check_path                             = string       # (Optional) The path to the Health Check.
      site_config_health_check_eviction_time_in_min             = string       # (Optional) The amount of time in minutes that a node can be unhealthy before being removed from the load balancer. Possible values are between 2 and 10. Only valid in conjunction with health_check_path.
      site_config_http2_enabled                                 = bool         # (Optional) Should the HTTP2 be enabled?
      auto_heal_enabled                                         = bool         #(Optional) Should Auto heal rules be enabled? Required with auto_heal_setting.
      local_mysql_enabled                                       = bool         # (Optional) Use Local MySQL. Defaults to false.
      websockets_enabled                                        = bool         # (Optional) Should Web Sockets be enabled? Defaults to false.
      vnet_route_all_enabled                                    = bool         #(Optional) Should all outbound traffic have NAT Gateways, Network Security Groups and User Defined Routes applied? Defaults to false.
      scm_minimum_tls_version                                   = string       #Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
      scm_use_main_ip_restriction                               = string       #  (Optional) One or more ip_restriction blocks as defined above.
      site_config_use_32_bit_worker                             = string       #(Optional) Should the Linux Web App use a 32-bit worker? Defaults to true.
      site_config_default_documents                             = list(string) # (Optional) Specifies a list of Default Documents for the Linux Web App.
      site_config_load_balancing_mode                           = string       # (Optional) The Site load balancing. Possible values include: WeightedRoundRobin, LeastRequests, LeastResponseTime, WeightedTotalTraffic, RequestHash, PerSiteRoundRobin. Defaults to LeastRequests if omitted.
      site_config_managed_pipeline_mode                         = string       # (Optional) Managed pipeline mode. Possible values include Integrated, and Classic.
      site_config_minimum_tls_version                           = string       # (Optional) The configures the minimum version of TLS required for SSL requests. Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
      site_config_remote_debugging_enabled                      = bool         #(Optional) Should Remote Debugging be enabled? Defaults to false.
      site_config_remote_debugging_version                      = string       # (Optional) The Remote Debugging Version. Possible values include VS2017 and VS2019
      site_config_worker_count                                  = string       # (Optional) The number of Workers for this Linux App Service.
      site_config_container_registry_managed_identity_client_id = string       # (Optional) The Client ID of the Managed Service Identity to use for connections to the Azure Container Registry.
      site_config_container_registry_use_managed_identity       = string       #(Optional) Should connections for Azure Container Registry use Managed Identity.
      site_config_cors = list(object({                                         #block supports the following:
        site_config_cors_allowed_origins     = string                          #(Required) Specifies a list of origins that should be allowed to make cross-origin calls.
        site_config_cors_support_credentials = string                          # (Optional) Whether CORS requests with credentials are allowed. Defaults to false
      }))
      site_config_ip_restriction = list(object({
        ip_restriction_action                    = string #(Optional) The action to take. Possible values are Allow or Deny.
        ip_restriction_service_tag               = string #(Optional) The Service Tag used for this IP Restriction.
        ip_restriction_name                      = string #(Optional) The name which should be used for this ip_restriction.
        ip_restriction_priority                  = string # (Optional) The priority value of this ip_restriction.
        ip_restriction_ip_address                = string #(Optional) The CIDR notation of the IP or IP Range to match. For example: 10.0.0.0/24 or 192.168.10.1/32
        ip_restriction_virtual_network_subnet_id = string #(Optional) The Virtual Network Subnet ID used for this IP Restriction.
        ip_restriction_headers = list(object({            #(Optional) A headers block as defined above.
          headers_x_azure_fdid      = string              # (Optional) Specifies a list of Azure Front Door IDs.
          headers_x_fd_health_probe = string              #(Optional) Specifies if a Front Door Health Probe should be expected.
          headers_x_forwarded_for   = string              #(Optional) Specifies a list of addresses for which matching should be applied. Omitting this value means allow any.
          headers_x_forwarded_host  = string              # (Optional) Specifies a list of Hosts for which matching should be applied.
        }))
      }))
      site_config_scm_ip_restriction = list(object({          # block supports the following:
        scm_ip_restriction_action                    = string # (Optional) The action to take. Possible values are Allow or Deny.
        scm_ip_restriction_service_tag               = string # (Optional) The Service Tag used for this IP Restriction.
        scm_ip_restriction_name                      = string #(Optional) The name which should be used for this ip_restriction.
        scm_ip_restriction_priority                  = string #(Optional) The priority value of this ip_restriction.
        scm_ip_restriction_ip_address                = string # (Optional) The CIDR notation of the IP or IP Range to match. For example: 10.0.0.0/24 or 192.168.10.1/32
        scm_ip_restriction_virtual_network_subnet_id = string #(Optional) The Virtual Network Subnet ID used for this IP Restriction.
        scm_ip_restriction_headers = list(object({            #(Optional) A headers block as defined above.
          headers_x_azure_fdid      = string                  # (Optional) Specifies a list of Azure Front Door IDs.
          headers_x_fd_health_probe = string                  #(Optional) Specifies if a Front Door Health Probe should be expected.
          headers_x_forwarded_for   = string                  # (Optional) Specifies a list of addresses for which matching should be applied. Omitting this value means allow any.
          headers_x_forwarded_host  = string                  #(Optional) Specifies a list of Hosts for which matching should be applied.
        }))
      }))
      site_config_application_stack = list(object({                #block supports the following:
        site_config_application_stack_docker_image        = string #(Optional) The Docker image reference, including repository host as needed.
        site_config_application_stack_docker_image_tag    = string # (Optional) The image Tag to use. e.g. latest.
        site_config_application_stack_dotnet_version      = string # (Optional) The version of .NET to use. Possible values include 3.1, 5.0, 6.0 and 7.0.
        site_config_application_stack_java_server         = string # (Optional) The Java server type. Possible values include JAVA, TOMCAT, and JBOSSEAP.
        site_config_application_stack_java_server_version = string # (Optional) The Version of the java_server to use.
        site_config_application_stack_java_version        = string #(Optional) The Version of Java to use. Supported versions of Java vary depending on the java_server and java_server_version, as well as security and fixes to major versions. Please see Azure documentation for the latest information.
        site_config_application_stack_node_version        = string #Possible values include 12-lts, 14-lts, and 16-lts. This property conflicts with java_version.
        site_config_application_stack_php_version         = string #Possible values include 7.4, and 8.0.
        site_config_application_stack_python_version      = string #Possible values include 3.7, 3.8, and 3.9.
        site_config_application_stack_ruby_version        = string # Possible values include 2.6 and 2.7.
      }))
      site_config_auto_heal_setting = list(object({
        auto_heal_setting_action = list(object({         #(Optional) A action block as defined above.
          action_action_type                    = string # (Required) Predefined action to be taken to an Auto Heal trigger. Possible values include: Recycle.
          action_minimum_process_execution_time = string #(Optional) The minimum amount of time in hh:mm:ss the Linux Web App must have been running before the defined action will be run in the event of a trigger.
        }))
        auto_heal_setting_trigger = list(object({ #(Optional) A trigger block as defined below.
          trigger_requests = list(object({        #block supports the following:
            requests_count    = string            #(Required) The number of requests in the specified interval to trigger this rule.
            requests_interval = string            #(Required) The interval in hh:mm:ss.
          }))
          trigger_slow_request = list(object({ # block supports the following:
            slow_request_count      = string   #(Required) The number of Slow Requests in the time interval to trigger this rule.
            slow_request_interval   = string   #(Required) The time interval in the form hh:mm:ss.
            slow_request_time_taken = string   # (Required) The threshold of time passed to qualify as a Slow Request in hh:mm:ss.
            slow_request_path       = string   #(Optional) The path for which this slow request rule applies.
          }))
          trigger_status_code = list(object({      #block supports the following:
            status_code_count             = string #(Required) The number of occurrences of the defined status_code in the specified interval on which to trigger this rule.
            status_code_interval          = string #(Required) The time interval in the form hh:mm:ss.
            status_code_status_code_range = string #(Required) The status code for this rule, accepts single status codes and status code ranges. e.g. 500 or 400-499. Possible values are integers between 101 and 599
            status_code_path              = string #(Optional) The path to which this rule status code applies.
            status_code_sub_status        = string # (Optional) The Request Sub Status of the Status Code.
            status_code_win32_status      = string #(Optional) The Win32 Status Code of the Request.
          }))
        }))
      }))
    }))
    linux_web_app_subnet_required                = bool   #(Optional) if subnet is required then pass the value has true and provide the value for the below.
    linux_web_app_virtual_network_name           = string #(Optional) if subnet is passed true then we need virtual network name for the subnet.
    linux_web_app_subnet_name                    = string #(Optional) if subnet required true then pass the subnet name
    linux_web_app_subnet_resource_group_name     = string #(Optional) if subnet required true then resource group name should be provided.
    key_vault_name                               = string #(optional) key valut name should be provided for key_vault_reference_identity_id
    key_vault_resource_group_name                = string #(optional) key valut resource group name should be provided for key_vault_reference_identity_id
    app_service_plan_name                        = string #(Required) The name of the Service Plan that this Linux App Service will be created in for the service plan id .
    app_service_plan_resource_group_name         = string #(Required) The service plan resource group name  that this Linux App Service will be created in for the service plan id .
    linux_web_app_storage_account_required       = bool   #(Optional) storage account is required pass true value
    user_storage_account_name                    = string #(Optional) if storage account name is provided true than storage account name should be provided
    storage_account_resource_group_name          = string #(optional) if storage account resource group name is provided true than storage account name should be provided 
    linux_web_app_storage_account_sas_start_time = string #(optional) storage account sas start time should be pass here
    linux_web_app_storage_account_sas_end_time   = string #(optional) storage account sas end time should be pass here
    linux_web_app_tags                           = map(string)
  }))
  description = "Map of variables for Linux Web App"
  default     = {}
}