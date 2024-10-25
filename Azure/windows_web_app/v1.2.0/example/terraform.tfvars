#Web App RESOURCE GROUP 
windows_web_app_resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000001" #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = "eastus2"         #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#Key Vault Resource Group 
key_vault_resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000002" #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = "eastus2"         #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#Storage Account Resource Group 
storage_account_resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000003" #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = "eastus2"         #(Required) The Azure Region where the Resource Group should exist.
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
    virtual_network_location                = "eastus2"                   #(Required) The location/region where the virtual network is created.
    virtual_network_resource_group_name     = "ploceusrg000001"           #(Required) The name of the resource group in which to create the virtual network.
    virtual_network_address_space           = ["11.0.0.0/16"]             #(Required) The address space that is used the virtual network.
    virtual_network_dns_servers             = null                        #(Optional) List of IP addresses of DNS servers
    virtual_network_flow_timeout_in_minutes = null                        #(Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = null                        #(Optional) The BGP community attribute in format <as-number>:<community-value>.
    virtual_network_edge_zone               = null                        #(Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_ddos_protection_plan = {                              #(Optional block) Provide virtual_network_ddos_protection_enable as true if needed ddos protection
      virtual_network_ddos_protection_enable    = false                   #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = "ploceusddosplan000001" #(Required) Needed for ddos protection plan id.Provide the name of the ddos protection plan if below enable is true
    }
    virtual_network_subnet = null #(Optional) Can be specified multiple times to define multiple subnets
    virtual_network_tags = {      #(Optional) A mapping of tags which should be assigned to the virtual network.
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
    subnet_address_prefixes                               = ["11.0.1.0/24"]                    #(Required) The address prefixes to use for the subnet.
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

#KEY VAULT
key_vault_variables = {
  "key_vault_1" = {
    key_vault_name                                  = "ploceuskeyvault000001"                                                                                                                                                                         #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_location                              = "eastus2"                                                                                                                                                                                       #(Required) Specifies the supported Azure location where the resource exists.
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
    key_vault_access_resource_name                  = "xxxxxxxx@ploceus.com"                                                                                                                                                                          #(Required) Specifies the resource name that needs an access policy to the key vault. Possible values are username, group name, service principal name and application name

    key_vault_access_resource_type = "User" #(Required) Specifies the type of resource that needs the access policy to the key vault. Possible values are User, SPN, Group, Application
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


    key_vault_secret_tags = { #(Optional) A mapping of tags which should be assigned to the key vault secret. 

      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_secret_min_upper   = 10 #(Optional)(Number) Minimum number of uppercase alphabet characters in the result. Default value is 0
    key_vault_secret_min_lower   = 5  #(Optional)(Number) Minimum number of lowercase alphabet characters in the result. Default value is 0
    key_vault_secret_min_numeric = 5  #(Optional)(Number) Minimum number of numeric characters in the result. Default value is 0
    key_vault_secret_min_special = 3  #(Optional)(Number) Minimum number of special characters in the result. Default value is 0
    key_vault_secret_length      = 32 #(Optional)(Number) The length of the string desired. The minimum value for length is 1 and, length must also be >= (min_upper + min_lower + min_numeric + min_special)
  }
  "key_vault_secret_2" = {
    key_vault_name                       = "ploceuskeyvault000001"                 #(Required) Specifies the name of the Key Vault.
    key_vault_secret_value               = "ploceusvalue000001"                    #(Required) Specifies the value of the Key Vault Secret
    key_vault_secret_content_type        = ""                                      #(Optional) Specifies the content type for the Key Vault Secret
    key_vault_secret_not_before_date     = null                                    #(Optional) Specifies that the key is not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_expiration_date     = null                                    #(Optional) Specifies the expiration UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_resource_group_name = "ploceusrg000002"                       #(Required) Specifies the name of the resource group, where the key_vault resides in
    key_vault_secret_name                = "ploceuskeyvaultconnectionstring000001" #(Required) Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created


    key_vault_secret_tags = { #(Optional) A mapping of tags which should be assigned to the key vault secret. 

      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_secret_min_upper   = 10 #(Optional)(Number) Minimum number of uppercase alphabet characters in the result. Default value is 0
    key_vault_secret_min_lower   = 5  #(Optional)(Number) Minimum number of lowercase alphabet characters in the result. Default value is 0
    key_vault_secret_min_numeric = 5  #(Optional)(Number) Minimum number of numeric characters in the result. Default value is 0
    key_vault_secret_min_special = 3  #(Optional)(Number) Minimum number of special characters in the result. Default value is 0
    key_vault_secret_length      = 32 #(Optional)(Number) The length of the string desired. The minimum value for length is 1 and, length must also be >= (min_upper + min_lower + min_numeric + min_special)
  }
  "key_vault_secret_3" = {
    key_vault_name                       = "ploceuskeyvault000001" #(Required) Specifies the name of the Key Vault.
    key_vault_secret_value               = "ploceusvalue000001"    #(Required) Specifies the value of the Key Vault Secret
    key_vault_secret_content_type        = ""                      #(Optional) Specifies the content type for the Key Vault Secret
    key_vault_secret_not_before_date     = null                    #(Optional) Specifies that the key is not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_expiration_date     = null                    #(Optional) Specifies the expiration UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_resource_group_name = "ploceusrg000002"       #(Required) Specifies the name of the resource group, where the key_vault resides in
    key_vault_secret_name                = "ploceusadsecret000001" #(Required) Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created


    key_vault_secret_tags = { #(Optional) A mapping of tags which should be assigned to the key vault secret. 

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

# STORAGE ACCOUNT
storage_account_variables = {
  "storage_account_01" = {
    storage_account_key_vault_name                                     = null               #(Required) The name of the Key Vault.
    storage_account_key_vault_resource_group_name                      = null               #(Required) The resource group name of the Key Vault.
    storage_account_key_vault_key_name                                 = null               #(Required) The name of the Key Vault key required for customer managed key.
    storage_account_user_assigned_identity_name_for_cmk                = null               #(Required) The name of a user assigned identity for customer managed key.
    storage_account_user_assigned_identity_resource_group_name_for_cmk = null               #(Required) The resource group name of a user assigned identity for customer managed key.
    storage_account_identity_type_for_cmk                              = null               #(Required) The identity type of a user assigned identity for customer managed key.Only Possible value could be "UserAssigned" in order to use customer managed key. Other Possible values are "SystemAssigned", "SystemAssigned, UserAssigned"
    storage_account_name                                               = "ploceusstg000001" #(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed.This must be unique across the entire Azure service, not just within the resource group.
    storage_account_resource_group_name                                = "ploceusrg000003"  #(Required) The name of the resource group in which to create the storage account.
    storage_account_location                                           = "eastus2"          #(Required) Specifies the supported Azure location where the resource exists. 
    storage_account_account_kind                                       = "StorageV2"        #(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2.
    storage_account_account_tier                                       = "Standard"         #(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    storage_account_account_replication_type                           = "LRS"              #(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa.
    storage_account_cross_tenant_replication_enabled                   = true               #(Optional) Should cross Tenant replication be enabled? Defaults to true.
    storage_account_access_tier                                        = "Hot"              #(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot.
    storage_account_edge_zone                                          = null               #(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist.
    storage_account_enable_https_traffic_only                          = true               #(Optional) Boolean flag which forces HTTPS if enabled. Defaults to true.
    storage_account_min_tls_version                                    = "TLS1_2"           #(Optional) The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts.
    storage_account_allow_nested_items_to_be_public                    = true               #Allow or disallow nested items within this Account to opt into being public. Defaults to true.
    storage_account_shared_access_key_enabled                          = true               #Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true.
    storage_account_public_network_access_enabled                      = true               #(Optional) Whether the public network access is enabled? Defaults to true.
    storage_account_default_to_oauth_authentication                    = false              #(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false
    storage_account_is_hns_enabled                                     = false              #(Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2.
    storage_account_nfsv3_enabled                                      = false              #(Optional) Is NFSv3 protocol enabled? Defaults to false.
    storage_account_large_file_share_enabled                           = false              #(Optional) Is Large File Share Enabled?
    storage_account_queue_encryption_key_type                          = "Service"          #(Optional) The encryption type of the queue service. Possible values are Service and Account.Default value is Service.
    storage_account_table_encryption_key_type                          = "Service"          #(Optional) The encryption type of the table service. Possible values are Service and Account. Default value is Service.
    storage_account_infrastructure_encryption_enabled                  = false              #(Optional) Is infrastructure encryption enabled? Defaults to false.
    storage_account_custom_domain                                      = null
    storage_account_identity                                           = null
    storage_account_blob_properties = {
      versioning_enabled            = true         #(Optional) Is versioning enabled? Default to false.
      change_feed_enabled           = true         #(Optional) Is the blob service properties for change feed events enabled? Default to false.
      change_feed_retention_in_days = 7            #(Optional) The duration of change feed events retention in days. The possible values are between 1 and 146000 days (400 years). Setting this to null (or omit this in the configuration file) indicates an infinite retention of the change feed.
      default_service_version       = "2020-06-12" #(Optional) The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version. Defaults to 2020-06-12.
      last_access_time_enabled      = true         #(Optional) Is the last access time based tracking enabled? Default to false.

      cors_enabled = true #(optional) Should cross origin resource sharing be enabled.
      cors_rule = {
        allowed_headers    = ["*"]                                                                 #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = ["DELETE", "GET", "HEAD", "MERGE", "POST", "OPTIONS", "PUT", "PATCH"] #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = ["*"]                                                                 #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = ["*", ]                                                               #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = 60                                                                    #(Required) The number of seconds the client should cache a preflight response.
      }

      delete_retention_policy = {
        delete_retention_policy_days = "7" #(Optional) Specifies the number of days that the blob should be retained, between 1 and 365 days. Defaults to 7.
      }

      container_delete_retention_policy = {
        container_delete_retention_policy_days = "7" #(Optional) Specifies the number of days that the container should be retained, between 1 and 365 days. Defaults to 7.
      }
    }
    storage_account_queue_properties = {
      cors_enabled = true #(optional) Should cross origin resource sharing be enabled.
      cors_rule = {
        allowed_headers    = ["*"]                                   #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = ["GET", "HEAD", "MERGE", "POST", "PUT"] #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = ["*"]                                   #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = ["*"]                                   #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = 60                                      #(Required) The number of seconds the client should cache a preflight response.
      }

      logging_enabled = true #Should storage account queue properties logging be enabled.
      logging = {
        delete                = true  #(Required) Indicates whether all delete requests should be logged. 
        read                  = true  #(Required) Indicates whether all read requests should be logged. 
        version               = "1.0" #(Required) The version of storage analytics to configure.
        write                 = true  #(Required) Indicates whether all write requests should be logged.
        retention_policy_days = 7     #(Optional) Specifies the number of days that logs will be retained.
      }

      minute_metrics = {
        enabled               = true  #(Required) Indicates whether minute metrics are enabled for the Queue service. 
        version               = "1.0" #(Required) The version of storage analytics to configure. 
        include_apis          = true  #(Optional) Indicates whether metrics should generate summary statistics for called API operations.
        retention_policy_days = 7     #(Optional) Specifies the number of days that logs will be retained.
      }

      hour_metrics = {
        enabled               = true  #(Required) Indicates whether minute metrics are enabled for the Queue service. 
        version               = "1.0" #(Required) The version of storage analytics to configure. 
        include_apis          = true  #(Optional) Indicates whether metrics should generate summary statistics for called API operations.
        retention_policy_days = 7     #(Optional) Specifies the number of days that logs will be retained.
      }
    }

    storage_account_static_website = {
      index_document     = "index.html" #Optional) The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive.
      error_404_document = "404.html"   #(Optional) The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file.
    }
    storage_account_share_properties = {
      cors_enabled = true #(optional) Should cross origin resource sharing be enabled.
      cors_rule = {
        allowed_headers    = ["*"]                                   #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = ["GET", "HEAD", "MERGE", "POST", "PUT"] #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = ["*"]                                   #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = ["*"]                                   #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = 60                                      #(Required) The number of seconds the client should cache a preflight response.
      }

      retention_policy = {
        retention_policy_days = 7 #(Optional) Specifies the number of days that the azurerm_storage_share should be retained, between 1 and 365 days. Defaults to 7.
      }

      smb = {
        smb_versions                        = ["SMB2.1"]      #(Optional) A set of SMB protocol versions. Possible values are SMB2.1, SMB3.0, and SMB3.1.1.
        smb_authentication_types            = ["NTLMv2"]      #(Optional) A set of SMB authentication methods. Possible values are NTLMv2, and Kerberos.
        smb_kerberos_ticket_encryption_type = ["RC4-HMAC"]    #(Optional) A set of Kerberos ticket encryption. Possible values are RC4-HMAC, and AES-256.
        smb_channel_encryption_type         = ["AES-128-CCM"] #(Optional) A set of SMB channel encryption. Possible values are AES-128-CCM, AES-128-GCM, and AES-256-GCM.
        smb_multichannel_enabled            = false           #(Optional) Indicates whether multichannel is enabled. Defaults to false. This is only supported on Premium storage accounts.
      }
    }

    storage_account_network_rules              = null
    storage_account_azure_files_authentication = null
    storage_account_routing = {
      publish_internet_endpoints  = false             #(Optional) Should internet routing storage endpoints be published? Defaults to false.
      publish_microsoft_endpoints = false             #(Optional) Should Microsoft routing storage endpoints be published? Defaults to false.
      choice                      = "InternetRouting" #(Optional) Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting. Defaults to MicrosoftRouting.
    }
    storage_account_immutability_policy = null
    storage_account_sas_policy = {
      expiration_period = "11:12:13:14" #(Required) The SAS expiration period in format of DD.HH:MM:SS.
      expiration_action = "Log"         #(Optional) The SAS expiration action. The only possible value is Log at this moment. Defaults to Log.
    }

    storage_account_tags = { #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus"
      Department = "CIS"
    }

  }
}

#User Assigned Identity VARIABLES
user_assigned_identity_variables = {
  "user_assigned_identity_1" = {
    user_assigned_identity_name                = "ploceusuai000001" #(Required) Specifies the name of this User Assigned Identity. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_location            = "eastus2"          # (Required) The Azure Region where the User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_resource_group_name = "ploceusrg000001"  #Required) Specifies the name of the Resource Group within which this User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    #(Optional) A mapping of tags which should be assigned to the User Assigned Identity.
    user_assigned_identity_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    } #(Optional) A mapping of tags which should be assigned to the User Assigned Identity.
  }
}

#APP SERVICE PLAN
app_service_plan_variables = {
  "app_service_plan_1" = {
    app_service_plan_name                          = "ploceusappplan000001" #(Required) The name which should be used for this Service Plan. Changing this forces a new AppService to be created.
    app_service_plan_location                      = "eastus2"              #(Required) The Azure Region where the Service Plan should exist. Changing this forces a new AppService to be created.
    app_service_plan_os_type                       = "Windows"              #(Required) The O/S type for the App Services to be hosted in this plan. Possible values include Windows, Linux, and WindowsContainer.
    app_service_plan_resource_group_name           = "ploceusrg000001"      #(Required) The name of the Resource Group where the AppService should exist. Changing this forces a new AppService to be created.
    app_service_plan_sku_name                      = "F1"                   #(Required) The SKU for the plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, WS3, and Y1.#Isolated SKUs (I1, I2, I3, I1v2, I2v2, and I3v2) can only be used with App Service Environments #Elastic and Consumption SKUs (Y1, EP1, EP2, and EP3) are for use with Function Apps.
    app_service_plan_maximum_elastic_worker_count  = null                   #(Optional) The maximum number of workers to use in an Elastic SKU Plan. Cannot be set unless using an Elastic SKU.
    app_service_plan_worker_count                  = null                   #(Optional) The number of Workers (instances) to be allocated.
    app_service_plan_per_site_scaling_enabled      = false                  #(Optional) Should Per Site Scaling be enabled. Defaults to false.
    app_service_plan_zone_balancing_enabled        = false                  #(Optional) Should the Service Plan balance across Availability Zones in the region. Defaults to false. If this setting is set to true and the worker_count value is specified, it should be set to a multiple of the number of availability zones in the region. Please see the Azure documentation for the number of Availability Zones in your region.
    app_service_environment_name                   = null                   #(Optional) Name of the app service environemnt Requires an Isolated SKU. Use one of I1, I2, I3 for azurerm_app_service_environment, or I1v2, I2v2, I3v2 for azurerm_app_service_environment_v3
    app_service_environment_resource_group_name    = null                   #(Optional) Resource Group Name of the app service environemnt
    app_service_environment_v3_name                = null                   #(Optional) Name of the app service environemnt Requires an Isolated SKU. Use one of I1, I2, I3 for azurerm_app_service_environment, or I1v2, I2v2, I3v2 for azurerm_app_service_environment_v3
    app_service_environment_v3_resource_group_name = null                   #(Optional) Resource Group Name of the app service environemnt
    # (Optional) A mapping of tags which should be assigned to the AppService.
    app_service_plan_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

windows_web_app_variables = {
  "windows_web_app_1" = {
    windows_web_app_name                                             = "ploceuswinwebapp000001" #(Required) The name which should be used for this Windows Web App. Changing this forces a new Windows Web App to be created.
    windows_web_app_location                                         = "eastus2"                #(Required) The Azure Region where the Windows Web App should exist. Changing this forces a new Windows Web App to be created.
    windows_web_app_resource_group_name                              = "ploceusrg000001"        #(Required) The name of the Resource Group where the Windows Web App should exist. Changing this forces a new Windows Web App to be created.
    windows_web_app_app_service_plan_name                            = "ploceusappplan000001"   #(Required) The App service plan name. This is required for fetching service_plan_id.
    windows_web_app_app_service_plan_resource_group_name             = "ploceusrg000001"        #(Required) The App service plan RG name. This is required for fetching service_plan_id.
    windows_web_app_client_affinity_enabled                          = false                    #(Optional) Should Client Affinity be enabled?
    windows_web_app_client_certificate_enabled                       = false                    # (Optional) Should Client Certificates be enabled?
    windows_web_app_client_certificate_mode                          = null                     #(Optional) The Client Certificate mode. Possible values are Required, Optional, and OptionalInteractiveUser. This property has no effect when client_cert_enabled is false
    windows_web_app_client_certificate_exclusion_paths               = null                     #(Optional) Paths to exclude when using client certificates, separated by ;
    windows_web_app_app_settings                                     = null                     #(Optional) A map of key-value pairs of App Settings.
    windows_web_app_enabled                                          = true                     #(Optional) Should the Windows Web App be enabled? Defaults to true.
    windows_web_app_https_only                                       = true                     #(Optional) Should the Windows Web App require HTTPS connections.
    windows_web_app_zip_deploy_file                                  = null                     #(Optional) The local path and filename of the Zip packaged application to deploy to this Windows Web App.
    windows_web_app_key_vault_reference_identity_id_required         = false                    #(Optional) To set virtual_network_subnet_id, make this value as true. If key_vault_reference_identity_id parameter is required or no.
    windows_web_app_is_regional_virtual_network_integration_required = false                    #The AzureRM Terraform provider provides regional virtual network integration via the standalone resource app_service_virtual_network_swift_connection and in-line within this resource using the virtual_network_subnet_id property. You cannot use both methods simultaneously. If the virtual network is set via the resource app_service_virtual_network_swift_connection then ignore_changes should be used in the web app configuration. Assigning the virtual_network_subnet_id property requires RBAC permissions on the subnet.
    windows_web_app_sticky_settings                                  = null                     #(Optional) A sticky_settings block as defined below.
    /*[{                                                                 
      sticky_settings_app_setting_names       = ["ploceusname000001", "ploceusname000002"]               #(Optional) A list of app_setting names that the Windows Web App will not swap between Slots when a swap operation is triggered.
      sticky_settings_connection_string_names = ["ploceusconnstrname000001", "ploceusconnstrname000002"] #(Optional) A list of connection_string names that the Windows Web App will not swap between Slots when a swap operation is triggered.
    }]*/

    windows_web_app_connection_string = null #(Optional) One or more connection_string blocks as defined below.
    /*{                                                 
      "windows_web_app_connection_string_1" = {                                           #(Optional) One or more connection_string blocks as defined below.
        connection_string_name                  = "ploceussqlazure000001"                 #(Required) The name of the Connection String.
        connection_string_type                  = "SQLAzure"                              #(Required) Type of database. Possible values include: APIHub, Custom, DocDb, EventHub, MySQL, NotificationHub, PostgreSQL, RedisCache, ServiceBus, SQLAzure, and SQLServer.
        connection_string_key_vault_secret_name = "ploceuskeyvaultconnectionstring000001" #(Required) The key vault secret name in which connection string value is present.
      }
    }*/

    windows_web_app_storage_account = null /* #(Optional) One or more storage_account blocks as defined below. Using this value requires WEBSITE_RUN_FROM_PACKAGE=1 to be set on the App in app_settings. Refer to the Azure docs for further details.
    {
      "windows_web_app_storage_account_1" = {                 
        storage_account_name       = "ploceusstg000001"       #(Required) The Name of the Storage Account.
        storage_account_todo_name  = "ploceusvalue000001"     #(Required) The name which should be used for this TODO.
        storage_account_share_name = "ploceuscontainer000001" #(Required) The Name of the File Share or Container Name for Blob storage.
        storage_account_type       = "AzureBlob"              #(Required) The Azure Storage Type. Possible values include AzureFiles and AzureBlob
        storage_account_mount_path = null                     #(Optional) The path at which to mount the storage share.
      }
    }*/

    windows_web_app_logs = null #(Optional) A logs block as defined below.
    /*[{                      
      logs_detailed_error_messages = true          #(Optional) Should detailed error messages be enabled.
      logs_failed_request_tracing  = false         #(Optional) Should tracing be enabled for failed requests.
      http_logs = [{                               #(Optional) A http_logs block as defined below.
        https_logs_azure_blob_storage = [{         #(Optional) An azure_blob_storage block as defined below.
          azure_blob_storage_retention_in_days = 7 #(Required) The time in days after which to remove blobs. A value of 0 means no retention.
        }]
        https_logs_file_system = [{          #(Optional) A file_system block as defined below.
          file_system_retention_in_days = 7  #(Required) The retention period in days. A values of 0 means no retention.
          file_system_retention_in_mb   = 25 #(Required) The maximum size in megabytes that log files can use.
        }]
      }]
      application_logs = [{                                #(Optional) A application_logs block as defined below.
        application_logs_file_system_level = "Verbose"     #(Required) Log level. Possible values include: Verbose, Information, Warning, and Error.
        application_logs_azure_blob_storage = [{           #(Optional) An azure_blob_storage block as defined below.
          azure_blob_storage_retention_in_days = 7         #(Required) The time in days after which to remove blobs. A value of 0 means no retention.
          azure_blob_storage_level             = "Verbose" #(Required) The level at which to log. Possible values include Error, Warning, Information, Verbose and Off. NOTE: this field is not available for http_logs
        }]
      }]
    }]*/

    windows_web_app_auth_settings = {                      #(Optional) An auth_settings block as defined below.
      auth_settings_enabled                        = false #(Required) Should the Authentication / Authorization feature is enabled for the Windows Web App be enabled?
      auth_settings_additional_login_parameters    = null  #(Optional) Specifies a map of login Parameters to send to the OpenID Connect authorization endpoint when a user logs in.
      auth_settings_allowed_external_redirect_urls = null  #(Optional) Specifies a list of External URLs that can be redirected to as part of logging in or logging out of the Windows Web App.
      auth_settings_unauthenticated_client_action  = null  #(Optional) The action to take when an unauthenticated client attempts to access the app. Possible values include: RedirectToLoginPage, AllowAnonymous.
      auth_settings_default_provider               = null  #(Optional) The default authentication provider to use when multiple providers are configured. Possible values include: AzureActiveDirectory, Facebook, Google, MicrosoftAccount, Twitter, Github. This setting is only needed if multiple providers are configured, and the unauthenticated_client_action is set to "RedirectToLoginPage".
      auth_settings_issuer                         = null  #(Optional) The OpenID Connect Issuer URI that represents the entity which issues access tokens for this Windows Web App. When using Azure Active Directory, this value is the URI of the directory tenant, e.g. https://sts.windows.net/{tenant-guid}/.
      auth_settings_runtime_version                = null  #(Optional) The RuntimeVersion of the Authentication / Authorization feature in use for the Windows Web App.
      auth_settings_token_refresh_extension_errors = null  #(Optional) The number of hours after session token expiration that a session token can be used to call the token refresh API. Defaults to 72 hours.
      auth_settings_token_store_enabled            = false #(Optional) Should the Windows Web App durably store platform-specific security tokens that are obtained during login flows? Defaults to false.
      windows_web_app_ad_secret_required           = false # make it false if auth_settings_active_directory=null
      auth_settings_active_directory               = null  #(Optional) An active_directory block as defined below.
      /*{                                                                                   
        active_directory_client_id                  = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"                                            #(Required) The ID of the Client to use to authenticate with Azure Active Directory.
        active_directory_client_secret              = "ploceusadsecret000001"                                              #(Optional) The Client Secret for the Client ID. Cannot be used with client_secret_setting_name.
        active_directory_allowed_audiences          = ["ploceusallowedaudiences0000001", "ploceusallowedaudiences0000002"] #(Optional) Specifies a list of Allowed audience values to consider when validating JWTs issued by Azure Active Directory.The client_id value is always considered an allowed audience.
        active_directory_client_secret_setting_name = null                                                                 #(Optional) The App Setting name that contains the client secret of the Client. Cannot be used with client_secret.
      }*/
      windows_web_app_facebook_secret_required = false # make it false if auth_settings_facebook=null
      auth_settings_facebook                   = null  # (Optional) A facebook block as defined below.
      /*{                       
        facebook_app_id                  = null        #(Required) The App ID of the Facebook app used for login.
        facebook_app_secret              = null        #(Optional) The App Secret of the Facebook app used for Facebook login. Cannot be specified with app_secret_setting_name.
        facebook_oauth_scopes            = null        #(Optional) Specifies a list of OAuth 2.0 scopes to be requested as part of Facebook login authentication.
        facebook_app_secret_setting_name = null        #(Optional) The app setting name that contains the app_secret value used for Facebook login. Cannot be specified with app_secret.
      }*/
      windows_web_app_github_secret_required = false # make it false if auth_settings_github=null
      auth_settings_github                   = null  #(Optional) A github block as defined below.
      /*{                                                                                   
        github_client_id                  = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"                                            #(Required) The ID of the GitHub app used for login.
        github_client_secret              = "ploceusgithubsecret000001"                                          #(Optional) The Client Secret of the GitHub app used for GitHub login. Cannot be specified with client_secret_setting_name.
        github_oauth_scopes               = ["ploceusallowedaudiences0000001", "ploceusallowedaudiences0000002"] #(Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of GitHub login authentication.
        github_client_secret_setting_name = null                                                                 #(Optional) The app setting name that contains the client_secret value used for GitHub login. Cannot be specified with client_secret.
      }*/
      windows_web_app_google_secret_required = false # make it false if auth_settings_google=null
      auth_settings_google                   = null  #(Optional) A google block as defined below.
      /*{                       
        google_client_id                  = null     #(Required) The OpenID Connect Client ID for the Google web application.
        google_client_secret              = null     #(Optional) The client secret associated with the Google web application. Cannot be specified with client_secret_setting_name.
        google_oauth_scopes               = null     #(Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of Google Sign-In authentication. If not specified, openid, profile, and email are used as default scopes.
        google_client_secret_setting_name = null     #(Optional) The app setting name that contains the client_secret value used for Google login. Cannot be specified with client_secret.
      }*/
      windows_web_app_microsoft_secret_required = false # make it false if auth_settings_microsoft=null
      auth_settings_microsoft                   = null  #(Optional) A microsoft block as defined below.
      /*{                       
        microsoft_client_id                  = null     #(Required) The OAuth 2.0 client ID that was created for the app used for authentication.
        microsoft_client_secret              = null     #(Optional) The OAuth 2.0 client secret that was created for the app used for authentication. Cannot be specified with client_secret_setting_name.
        microsoft_client_secret_setting_name = null     #(Optional) The app setting name containing the OAuth 2.0 client secret that was created for the app used for authentication. Cannot be specified with client_secret.
        microsoft_oauth_scopes               = null     #(Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of Microsoft Account authentication. If not specified, "wl.basic" is used as the default scope.
      }*/
      windows_web_app_twitter_secret_required = false # make it false if auth_settings_twitter=null
      auth_settings_twitter                   = null  #(Optional) A twitter block as defined below.
      /*{                       
        twitter_consumer_secret              = null   #(Optional) The OAuth 1.0a consumer secret of the Twitter application used for sign-in. Cannot be specified with consumer_secret_setting_name.
        twitter_consumer_key                 = null   #(Required) The OAuth 1.0a consumer key of the Twitter application used for sign-in.
        twitter_consumer_secret_setting_name = null   #(Optional) The app setting name that contains the OAuth 1.0a consumer secret of the Twitter application used for sign-in. Cannot be specified with consumer_secret.
      }*/
    }
    windows_web_app_backup = null #(Optional) A backup block as defined below.
    /*[{                                    
      backup_name    = "ploceusbackup000001"                       #(Required) The name which should be used for this Backup.
      backup_enabled = true                                        #(Optional) Should this backup job be enabled?
      backup_schedule = [{                                         #(Required) A schedule block as defined below.s
        schedule_frequency_interval      = 7                       #(Required) How often the backup should be executed (e.g. for weekly backup, this should be set to 7 and frequency_unit should be set to Day).Not all intervals are supported on all Windows Web App SKUs. Please refer to the official documentation for appropriate values.
        schedule_frequency_unit          = "Day"                   #(Required) The unit of time for how often the backup should take place. Possible values include: Day, Hour
        schedule_retention_period_days   = 180                     #(Optional) After how many days backups should be deleted.
        schedule_start_time              = "2023-2-4T07:20:50.52Z" #(Optional) When the schedule should start working in RFC-3339 format.
        schedule_keep_atleast_one_backup = false                   #(Optional) Should the service keep at least one backup, regardless of age of backup. Defaults to false.
      }]
    }]*/
    windows_web_app_identity = {                               #(Optional) An identity block as defined below.
      windows_web_app_identity_type = "UserAssigned"           #(Required) Specifies the type of Managed Service Identity that should be configured on this Windows Web App. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      windows_web_app_user_assigned_identities = [{            #(Optional) A list of User Assigned Managed Identity IDs to be assigned to this Windows Web App. This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
        user_identity_name                = "ploceusuai000001" #(Required) The user assigned identity name. This is required for fetching identity_ids.
        user_identity_resource_group_name = "ploceusrg000001"  #(Required) The user assigned identity RG name. This is required for fetching identity_ids.
      }]
    }
    windows_web_app_site_config = {                                           #(Required) A site_config block as defined below.
      site_config_always_on                                      = false      #(Optional) If this Windows Web App is Always On enabled. Defaults to true. always_on must be explicitly set to false when using Free, F1, D1, or Shared Service Plans.
      site_config_ftps_state                                     = "FtpsOnly" #(Optional) The State of FTP / FTPS service. Possible values include: AllAllowed, FtpsOnly, Disabled. Azure defaults this value to AllAllowed, however, in the interests of security Terraform will default this to Disabled to ensure the user makes a conscious choice to enable it.
      site_config_windows_web_app_is_api_management_api_required = false      #(Optional) Should API Management API ID be set under site_config?
      site_config_app_command_line                               = null       #(Optional) The App command line to launch.
      site_config_health_check_path                              = null       #(Optional) The path to the Health Check.
      site_config_health_check_eviction_time_in_min              = null       #(Optional) The amount of time in minutes that a node can be unhealthy before being removed from the load balancer. Possible values are between 2 and 10. Only valid in conjunction with health_check_path.
      site_config_http2_enabled                                  = false      #(Optional) Should the HTTP2 be enabled?
      site_config_auto_heal_enabled                              = false      #(Optional) Should Auto heal rules be enabled. Required with auto_heal_setting.
      site_config_local_mysql_enabled                            = false      #(Optional) Use Local MySQL. Defaults to false.
      site_config_websockets_enabled                             = false      #(Optional) Should Web Sockets be enabled. Defaults to false.
      site_config_vnet_route_all_enabled                         = false      #(Optional) Should all outbound traffic to have NAT Gateways, Network Security Groups and User Defined Routes applied? Defaults to false.
      site_config_scm_minimum_tls_version                        = null       #(Optional) The configures the minimum version of TLS required for SSL requests to the SCM site Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
      site_config_scm_use_main_ip_restriction                    = false      #(Optional) Should the Windows Web App ip_restriction configuration be used for the SCM also.
      site_config_use_32_bit_worker                              = true       #(Optional) Should the Windows Web App use a 32-bit worker.
      site_config_default_documents                              = null       #(Optional) Specifies a list of Default Documents for the Windows Web App.
      site_config_load_balancing_mode                            = null       #(Optional) The Site load balancing. Possible values include: WeightedRoundRobin, LeastRequests, LeastResponseTime, WeightedTotalTraffic, RequestHash, PerSiteRoundRobin. Defaults to LeastRequests if omitted.
      site_config_managed_pipeline_mode                          = null       #(Optional) Managed pipeline mode. Possible values include: Integrated, Classic.
      site_config_minimum_tls_version                            = null       #(Optional) The configures the minimum version of TLS required for SSL requests. Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
      site_config_remote_debugging_enabled                       = false      #(Optional) Should Remote Debugging be enabled. Defaults to false.
      site_config_remote_debugging_version                       = null       #(Optional) The Remote Debugging Version. Possible values include VS2017 and VS2019
      site_config_worker_count                                   = null       #(Optional) The number of Workers for this Windows App Service.
      site_config_container_registry_managed_identity_client_id  = null       #(Optional) The Client ID of the Managed Service Identity to use for connections to the Azure Container Registry.
      site_config_container_registry_use_managed_identity        = false      #(Optional) Should connections for Azure Container Registry use Managed Identity.
      site_config_cors                                           = null       #(Optional) A cors block as defined below.
      /*[{                                                               
        site_config_cors_allowed_origins     = ["ploceuscors000001", "ploceuscors000002"] #(Required) Specifies a list of origins that should be allowed to make cross-origin calls.
        site_config_cors_support_credentials = false                                      #(Optional) Whether CORS requests with credentials are allowed. Defaults to false
      }]*/
      site_config_ip_restriction = null #(Optional) One or more ip_restriction blocks as defined below.
      /*{ 
        "site_config_ip_restriction_1" = {
          ip_restriction_action                    = "Deny"                    #(Optional) The action to take. Possible values are Allow or Deny.
          ip_restriction_service_tag               = null                      #(Optional) The Service Tag used for this IP Restriction.
          ip_restriction_name                      = "ploceusiprestrict000001" #(Optional) The name which should be used for this ip_restriction.
          ip_restriction_priority                  = "2"                       #(Optional) The priority value of this ip_restriction.
          ip_restriction_ip_address                = "10.0.0.0/24"             #(Optional) The CIDR notation of the IP or IP Range to match. For example: 10.0.0.0/24 or 192.168.10.1/32
          ip_restriction_virtual_network_subnet_id = null                      #(Optional) The Virtual Network Subnet ID used for this IP Restriction. One and only one of ip_address, service_tag or virtual_network_subnet_id must be specified.
          ip_restriction_headers = [{                                          #(Optional) A headers block as defined below. Please see the official Azure Documentation - https://learn.microsoft.com/en-us/azure/app-service/app-service-ip-restrictions?tabs=arm#filter-by-http-header for details on using header filtering.
            headers_x_azure_fdid      = null                                   #(Optional) Specifies a list of Azure Front Door IDs.
            headers_x_fd_health_probe = null                                   #(Optional) Specifies if a Front Door Health Probe should be expected.
            headers_x_forworded_for   = null                                   #(Optional) Specifies a list of addresses for which matching should be applied. Omitting this value means allow any.
            headers_x_forworded_host  = null                                   #(Optional) Specifies a list of Hosts for which matching should be applied.
          }]
        }
      }*/
      site_config_scm_ip_restriction = null #(Optional) One or more scm_ip_restriction blocks as defined below.
      /*{ 
        "site_config_scm_ip_restriction_1" = {
          scm_ip_restriction_action                    = "Deny"                        #(Optional) The action to take. Possible values are Allow or Deny.
          scm_ip_restriction_service_tag               = null                          # (Optional) The Service Tag used for this IP Restriction.
          scm_ip_restriction_name                      = "ploceusscmiprestrict0000001" #(Optional) The name which should be used for this ip_restriction.
          scm_ip_restriction_priority                  = "4"                           #(Optional) The priority value of this ip_restriction.
          scm_ip_restriction_ip_address                = "10.0.0.0/24"                 #(Optional) The CIDR notation of the IP or IP Range to match. For example: 10.0.0.0/24 or 192.168.10.1/32
          scm_ip_restriction_virtual_network_subnet_id = null                          #(Optional) The Virtual Network Subnet ID used for this IP Restriction. One and only one of ip_address, service_tag or virtual_network_subnet_id must be specified.
          scm_ip_restriction_headers = [{                                              #(Optional) A headers block as defined below.
            headers_x_azure_fdid      = null                                           #(Optional) Specifies a list of Azure Front Door IDs.
            headers_x_fd_health_probe = null                                           #(Optional) Specifies if a Front Door Health Probe should be expected.
            headers_x_forworded_for   = null                                           #(Optional) Specifies a list of addresses for which matching should be applied. Omitting this value means allow any.
            headers_x_forworded_host  = null                                           #(Optional) Specifies a list of Hosts for which matching should be applied.
          }]
        }
      }*/
      site_config_application_stack = {                        #(Optional) A application_stack block as defined below
        application_stack_current_stack             = "dotnet" #(Optional) The Application Stack for the Windows Web App. Possible values include dotnet, dotnetcore, node, python, php, and java. Whilst this property is Optional omitting it can cause unexpected behaviour, in particular for display of settings in the Azure Portal.he value of dotnetcore is for use in combination with dotnet_version set to core3.1 only.
        application_stack_docker_container_name     = null     #(Optional) The name of the Docker Container. For example azure-app-service/samples/aspnethelloworld
        application_stack_docker_container_registry = null     #(Optional) The registry Host on which the specified Docker Container can be located. For example mcr.microsoft.com
        application_stack_docker_container_tag      = null     #(Optional) The Image Tag of the specified Docker Container to use. For example latest
        application_stack_dotnet_version            = "v7.0"   # (Optional) The version of .NET to use when current_stack is set to dotnet. Possible values include v2.0,v3.0,core3.1, v4.0, v5.0, v6.0 and v7.0.
        application_stack_java_container            = null     #(Optional) The Java container type to use when current_stack is set to java. Possible values include JAVA, JETTY, and TOMCAT. Required with java_version and java_container_version.
        application_stack_java_container_version    = null     #(Optional) The Version of the java_container to use. Required with java_version and java_container.
        application_stack_java_version              = null     #(Optional) The version of Java to use when current_stack is set to java. Possible values include 1.7, 1.8, 11 and 17. Required with java_container and java_container_version.For compatible combinations of java_version, java_container and java_container_version users can use az webapp list-runtimes from command line.
        application_stack_node_version              = null     #(Optional) The version of node to use when current_stack is set to node. Possible values include 12-LTS, 14-LTS, and 16-LTS.This property conflicts with java_version.
        application_stack_php_version               = null     #(Optional) The version of PHP to use when current_stack is set to php. Possible values include v7.4.
        application_stack_python_version            = null     #(Optional) The version of Python to use when current_stack is set to python. Possible values include 2.7 and 3.4.0.       
      }
      site_config_virtual_application = null #(Optional) One or more virtual_application blocks as defined below.
      /*{ 
        "site_config_virtual_application_1" = {
          virtual_application_physical_path = "ploceusphysicalpath000001" #(Required) The physical path for the Virtual Application.
          virtual_application_preload       = false                       #(Required) Should pre-loading be enabled. Defaults to false.
          virtual_application_virtual_path  = "ploceusvirtpath000001"     #(Required) The Virtual Path for the Virtual Application.
          virtual_application_virtual_directory = {
            "virtual_application_virtual_directory_1" = { #(Optional) One or more virtual_directory blocks as defined below.
              virtual_directory_physical_path = null      #(Optional) The physical path for the Virtual Application.
              virtual_directory_virtual_path  = null      #(Optional) The Virtual Path for the Virtual Application.
          } }
        }
      }*/
      site_config_auto_heal_setting = null #(Optional) A auto_heal_setting block as defined below. Required with auto_heal.
      /* [{                     
        auto_heal_setting_action = [{                        #(Required) An action block as defined below.
          action_action_type                    = "LogEvent" #(Required) Predefined action to be taken to an Auto Heal trigger. Possible values include: Recycle, LogEvent, and CustomAction.
          action_minimum_process_execution_time = "02:59:59" #(Optional) The minimum amount of time in hh:mm:ss the Windows Web App must have been running before the defined action will be run in the event of a trigger.
          action_custom_action = {
            custom_action_executable = "ploceusexe000001" #(Required) The executable to run for the custom_action.
            custom_action_parameters = null               #(Optional) The parameters to pass to the specified executable.
          }
        }]
        auto_heal_setting_trigger = [{       #(Required) A trigger block as defined below.
          trigger_private_memory_kb = 102400 #(Optional) The amount of Private Memory to be consumed for this rule to trigger. Possible values are between 102400 and 13631488.
          trigger_requests = [{              #(Optional) A requests block as defined below
            requests_count    = 10           #(Required) The number of requests in the specified interval to trigger this rule.
            requests_interval = "02:59:59"   #(Required) The interval in hh:mm:ss.
          }]
          trigger_slow_request = {
            "trigger_slow_request_1" = {           #(Optional) One or more slow_request blocks as defined below.
              slow_request_count      = 10         #(Required) The number of Slow Requests in the time interval to trigger this rule.
              slow_request_interval   = "02:59:59" #(Required) The time interval in the form hh:mm:ss.
              slow_request_time_taken = "01:59:59" #(Required) The threshold of time passed to qualify as a Slow Request in hh:mm:ss.
              slow_request_path       = null       #(Optional) The path for which this slow request rule applies.
            }
          }
          trigger_status_code = { #(Optional) One or more status_code blocks as defined below.
            "trigger_status_code_1" = {
              status_code_count             = 10         #(Required) The number of occurrences of the defined status_code in the specified interval on which to trigger this rule.
              status_code_interval          = "02:59:59" #(Required) The time interval in the form hh:mm:ss.
              status_code_status_code_range = "101"      #(Required) The status code for this rule, accepts single status codes and status code ranges. e.g. 500 or 400-499. Possible values are integers between 101 and 599
              status_code_path              = null       #(Optional) The path to which this rule status code applies.
              status_code_sub_status        = null       #(Optional) The Request Sub Status of the Status Code.
              status_code_win32_status      = null       #(Optional) The Win32 Status Code of the Request.
            }
          }
        }]
      }]
    }*/
    }
    windows_web_app_subnet_required                     = false                   #(Required) Whether subnet is required or not.
    windows_web_app_virtual_network_name                = null                    #(Optional) If windows_web_app_subnet_required = true, specify the Virtual Network name. This is required to fetch Subnet ID.
    windows_web_app_subnet_name                         = null                    #(Optional) If windows_web_app_subnet_required = true, specify the Subnet name. This is required to fetch Subnet ID.
    windows_web_app_subnet_resource_group_name          = null                    #(Optional) If windows_web_app_subnet_required = true, specify the Subnet RG name. This is required to fetch Subnet ID.
    windows_web_app_key_vault_name                      = "ploceuskeyvault000001" #(Optional) The Key vault name. Required for fetching key_vault_id.
    windows_web_app_key_vault_resource_group_name       = "ploceusrg000001"       #(Optional) The Key vault RG name. Required for fetching key_vault_id.
    windows_web_app_storage_account_required            = false                   #(Required) Whether storage account is required or not.
    windows_web_app_storage_account_name                = null                    #(Optional) If windows_web_app_storage_account_required = true, specify the Storage Account name. This is required to fetch Subnet ID.
    windows_web_app_storage_container_name              = null                    ##(Optional) The Storage Account Container name. This is required if logs settings needs to be set.
    windows_web_app_storage_account_resource_group_name = null                    #(Optional) If windows_web_app_storage_account_required = true, specify the Storage Account RG name. This is required to fetch Subnet ID.
    windows_web_app_storage_account_sas_start_time      = null                    #(Optional) If windows_web_app_storage_account_required = true, specify the Storage Account SAS Start Time. This is required to fetch Subnet ID.
    windows_web_app_storage_account_sas_end_time        = null                    #(Optional) If windows_web_app_storage_account_required = true, specify the Storage Account SAS End Time. This is required to fetch Subnet ID.
    windows_web_app_api_management_api_name             = null                    #(Optional) If site_config_is_api_management_api_id_required = true, specify the API Management API name.
    windows_web_app_api_management_name                 = null                    #(Optional) If site_config_is_api_management_api_id_required = true, specify the API Management name.
    windows_web_app_api_management_resource_group_name  = null                    #(Optional) If site_config_is_api_management_api_id_required = true, specify the API Management RG name.
    windows_web_app_api_management_revision             = null                    #(Optional) If site_config_is_api_management_api_id_required = true, specify the revision of API Management API.
    windows_web_app_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    } #(Optional) A mapping of tags which should be assigned to the Windows Web App.
  }
}



windows_web_app_sub_subscription_id = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"
windows_web_app_sub_tenant_id       = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"
storage_account_sub_subscription_id = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"
storage_account_sub_tenant_id       = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"
key_vault_sub_subscription_id       = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"
key_vault_sub_tenant_id             = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"