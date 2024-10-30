#RESOURCE GROUP VARIABLES
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

#RESORCE GROUP VARIABLE KEY VAULT
variable "resource_group_key_vault_variables" {
  description = "Map of Resource groups"
  type = map(object({
    resource_group_name     = string
    resource_group_location = string
    resource_group_tags     = map(string)
  }))
  default = {}
}

#VNET variable
variable "virtual_network_variables" {
  description = "Map of vnet objects. name, vnet_address_space, and dns_server supported"
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
  default = {}
}

#Subnet Variables
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
  description = "Map of Variables for Subnet"
  default     = {}
}

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
  default = {
  }
}

#KEY VAULT ACCESS POLICY VARIABLES
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

# KAY VAULT KEY VARIABLES
variable "key_vault_key_variables" {
  description = "Map of object of key vault key variables"
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
    key_vault_key_tags            = map(string)
  }))
  default = {}
}

#CosmosDB Account Variables
variable "cosmosdb_account_variables" {
  type = map(object({
    cosmosdb_account_name                                  = string       #(Required) Specifies the name of the CosmosDB Account. Changing this forces a new resource to be created.
    cosmosdb_account_resource_group_name                   = string       #(Required) The name of the resource group in which the CosmosDB Account is created. Changing this forces a new resource to be created.
    cosmosdb_account_location                              = string       #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    cosmosdb_account_tags                                  = map(string)  #(Optional) A mapping of tags to assign to the resource.
    cosmosdb_account_offer_type                            = string       #(Required) Specifies the Offer Type to use for this CosmosDB Account - currently this can only be set to Standard.
    cosmosdb_account_create_mode                           = string       #(Optional) The creation mode for the CosmosDB Account. Possible values are Default and Restore. Changing this forces a new resource to be created.
    cosmosdb_account_default_identity_type                 = string       #(Optional) The default identity for accessing Key Vault. Possible values are FirstPartyIdentity, SystemAssignedIdentity or start with UserAssignedIdentity. Defaults to FirstPartyIdentity.
    cosmosdb_account_kind                                  = string       #(Optional) Specifies the Kind of CosmosDB to create - possible values are GlobalDocumentDB, MongoDB and Parse. Defaults to GlobalDocumentDB. Changing this forces a new resource to be created.  
    cosmosdb_account_ip_range_filter                       = string       #(Optional) CosmosDB Firewall Support: This value specifies the set of IP addresses or IP address ranges in CIDR form to be included as the allowed list of client IP's for a given database account. IP addresses/ranges must be comma separated and must not contain any spaces.
    cosmosdb_account_enable_free_tier                      = bool         #(Optional) Enable Free Tier pricing option for this Cosmos DB account. Defaults to false. Changing this forces a new resource to be created.
    cosmosdb_account_analytical_storage_enabled            = bool         #(Optional) Enable Analytical Storage option for this Cosmos DB account. Defaults to false. Changing this forces a new resource to be created.
    cosmosdb_account_enable_automatic_failover             = bool         #(Optional) Enable automatic fail over for this Cosmos DB account.
    cosmosdb_account_public_network_access_enabled         = bool         #(Optional) Whether or not public network access is allowed for this CosmosDB account.
    cosmosdb_account_is_virtual_network_filter_enabled     = bool         #(Optional) Enables virtual network filtering for this Cosmos DB account.
    cosmosdb_account_key_vault_name                        = string       #(Optional) Key vault name for key_vault_key_id
    cosmosdb_account_key_vault_resource_group_name         = string       #(Optional) Key RG name for key_vault_key_id
    cosmosdb_account_key_vault_key_name                    = string       #(Optional) Key vault key name for key_vault_key_id
    cosmosdb_account_subnet_name                           = string       #(Optional) Subnet name for virtual_network_rule
    cosmosdb_account_subnet_virtual_network_name           = string       #(Optional) Vnet name for virtual_network_rule
    cosmosdb_account_subnet_resource_group_name            = string       #(Optional) Subnet RG name for virtual_network_rule
    cosmosdb_account_enable_multiple_write_locations       = bool         #(Optional) Enable multiple write locations for this Cosmos DB account.
    cosmosdb_account_access_key_metadata_writes_enabled    = bool         #(Optional) Is write operations on metadata resources (databases, containers, throughput) via account keys enabled? Defaults to true.
    cosmosdb_account_mongo_server_version                  = number       #(Optional) The Server Version of a MongoDB account. Possible values are 4.2, 4.0, 3.6, and 3.2.
    cosmosdb_account_network_acl_bypass_for_azure_services = bool         #(Optional) If Azure services can bypass ACLs. Defaults to false.
    cosmosdb_account_network_acl_bypass_ids                = list(string) #(Optional) The list of resource Ids for Network Acl Bypass for this Cosmos DB account.
    cosmosdb_account_local_authentication_disabled         = bool         #(Optional) Disable local authentication and ensure only MSI and AAD can be used exclusively for authentication. Defaults to false. Can be set only when using the SQL API.
    cosmosdb_account_enable_restore                        = bool         #(Optional) Whether to enable restore or no
    cosmosdb_account_virtual_network_rule = object({                      #(Optional) Specifies a virtual_network_rules resource, used to define which subnets are allowed to access this CosmosDB account.
      virtual_network_rule_ignore_missing_vnet_service_endpoint = bool    #(Optional) If set to true, the specified subnet will be added as a virtual network rule even if its CosmosDB service endpoint is not active. Defaults to false.
    })
    cosmosdb_account_capabilities = list(object({ #(Optional) The capabilities which should be enabled for this Cosmos DB account. Value is a capabilities block as defined below. Changing this forces a new resource to be created.
      capabilities_name = string                  #(Required) The capability to enable - Possible values are AllowSelfServeUpgradeToMongo36, DisableRateLimitingResponses, EnableAggregationPipeline, EnableCassandra, EnableGremlin, EnableMongo, EnableMongo16MBDocumentSupport, EnableTable, EnableServerless, MongoDBv3.4 and mongoEnableDocLevelTTL.
    }))
    cosmosdb_account_analytical_storage = object({ #(Optional) An analytical_storage block as defined below.
      analytical_storage_schema_type = string      #(Required) The schema type of the Analytical Storage for this Cosmos DB account. Possible values are FullFidelity and WellDefined.
    })
    cosmosdb_account_capacity = object({       # (Optional) A capacity block as defined below.
      capacity_total_throughput_limit = number #(Required) The total throughput limit imposed on this Cosmos DB account (RU/s). Possible values are at least -1. -1 means no limit.
    })
    cosmosdb_account_geo_location = list(object({ ##(Required) Specifies a geo_location resource, used to define where data should be replicated with the failover_priority 0 specifying the primary location. Value is a geo_location block as defined below.
      geo_location_location          = string     #(Required) The name of the Azure region to host replicated data.
      geo_location_failover_priority = number     #(Required) The failover priority of the region. A failover priority of 0 indicates a write region. The maximum value for a failover priority = (total number of regions - 1). Failover priority values must be unique for each of the regions in which the database account exists. Changing this causes the location to be re-provisioned and cannot be changed for the location with failover priority 0.
      geo_location_is_zone_redundant = bool       #(Optional) Should zone redundancy be enabled for this region? Defaults to false.
    }))
    cosmosdb_account_consistency_policy = list(object({   ##(Required) Specifies a consistency_policy resource, used to define the consistency policy for this CosmosDB account.
      consistency_policy_consistency_level       = string #(Required) The Consistency Level to use for this CosmosDB Account - can be either BoundedStaleness, Eventual, Session, Strong or ConsistentPrefix.
      consistency_policy_max_interval_in_seconds = number #(Optional) When used with the Bounded Staleness consistency level, this value represents the time amount of staleness (in seconds) tolerated. Accepted range for this value is 5 - 86400 (1 day). Defaults to 5. Required when consistency_level is set to BoundedStaleness.
      consistency_policy_max_staleness_prefix    = number #(Optional) When used with the Bounded Staleness consistency level, this value represents the number of stale requests tolerated. Accepted range for this value is 10 – 2147483647. Defaults to 100. Required when consistency_level is set to BoundedStaleness.
    }))
    cosmosdb_account_backup = object({    #(Optional) A backup block as defined below.
      backup_type                = string #(Required) The type of the backup. Possible values are Continuous and Periodic. Defaults to Periodic. Migration of Periodic to Continuous is one-way, changing Continuous to Periodic forces a new resource to be created.
      backup_interval_in_minutes = number #(Optional) The interval in minutes between two backups. This is configurable only when type is Periodic. Possible values are between 60 and 1440.
      backup_retention_in_hours  = number #(Optional) The time in hours that each backup is retained. This is configurable only when type is Periodic. Possible values are between 8 and 720.
      backup_storage_redundancy  = string #(Optional) The storage redundancy which is used to indicate type of backup residency. This is configurable only when type is Periodic. Possible values are Geo, Local and Zone.
    })
    cosmosdb_account_cors_rule = object({         #(Optional) A cors_rule block as defined below.
      cors_rule_allowed_headers    = list(string) #(Required) A list of headers that are allowed to be a part of the cross-origin request.
      cors_rule_allowed_methods    = list(string) #(Required) A list of HTTP headers that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
      cors_rule_allowed_origins    = list(string) #(Required) A list of origin domains that will be allowed by CORS.
      cors_rule_exposed_headers    = list(string) #(Required) A list of response headers that are exposed to CORS clients.
      cors_rule_max_age_in_seconds = number       #(Required) The number of seconds the client should cache a preflight response.
    })
    cosmosdb_account_identity = object({                        #(Optional) An identity block as defined below.
      cosmosdb_account_identity_type = string                   #(Required) The Type of Managed Identity assigned to this Cosmos account. Possible values are SystemAssigned, UserAssigned and SystemAssigned, UserAssigned.
      cosmosdb_account_user_assigned_identities = list(object({ #(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Cosmos Account. If type = UserAssigned or SystemAssigned, UserAssigned, then fill below values as mark this block as null
        identity_name                = string                   #(Required) Identity name for Identity ids
        identity_resource_group_name = string                   #(Required) Identity RG name for Identity ids
      }))
    })
    cosmosdb_account_restore = object({           #(Optional) A restore block as defined below
      restore_source_cosmosdb_account_id = string #(Required) The resource ID of the restorable database account from which the restore has to be initiated. The example is /subscriptions/{subscriptionId}/providers/Microsoft.DocumentDB/locations/{location}/restorableDatabaseAccounts/{restorableDatabaseAccountName}. Changing this forces a new resource to be created.
      restore_restore_timestamp_in_utc   = string #(Required) The creation time of the database or the collection (Datetime Format RFC 3339). Changing this forces a new resource to be created.
      restore_database = object({
        database_name             = string       #(Required) The database name for the restore request. Changing this forces a new resource to be created.
        database_collection_names = list(string) # (Optional) A list of the collection names for the restore request. Changing this forces a new resource to be created.
      })
    })
  }))
  description = "Map of CosmosDB Account variables"
  default     = {}
}