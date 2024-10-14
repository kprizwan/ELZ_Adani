#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name       = "ploceusrg000001" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = "eastus"          #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = "ploceus"         #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {                       #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#VIRTUAL NETWORK
virtual_network_variables = {
  "virtual_network_1" = {
    virtual_network_name                    = "ploceusvnet000001" #(Required) The name of the virtual network.
    virtual_network_location                = "eastus"            #(Required) The location/region where the virtual network is created.
    virtual_network_resource_group_name     = "ploceusrg000001"   #(Required) The name of the resource group in which to create the virtual network.
    virtual_network_address_space           = ["10.0.0.0/16"]     #(Required) The address space that is used the virtual network.
    virtual_network_dns_servers             = null                #(Optional) List of IP addresses of DNS servers.Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it.
    virtual_network_flow_timeout_in_minutes = null                #(Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = null                #(Optional) The BGP community attribute in format <as-number>:<community-value>.The as-number segment is the Microsoft ASN, which is always 12076 for now.
    virtual_network_edge_zone               = null                #(Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_ddos_protection_plan = {                      #(Optional block) provide true for virtual_network_ddos_protection_enable incase ddos_protection needs to be enabled.
      virtual_network_ddos_protection_enable    = false           #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = null            #(Required) Needed for ddos protection plan id.Provide the name of the ddos protection plan if above enable is true
    }
    virtual_network_encryption = [ #(Optional) A encryption block
      {
        virtual_network_encryption_enforcement = "AllowUnencrypted" #(Required) Specifies if the encrypted Virtual Network allows VM that does not support encryption. Possible values are DropUnencrypted and AllowUnencrypted.
      }
    ]
    virtual_network_subnet = null #(Optional) Can be specified multiple times to define multiple subnets
    virtual_network_tags = {      #(Optional) A mapping of tags which should be assigned to the virtual network.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#SUBNET
subnet_variables = {
  "subnet_1" = {
    subnet_name                                           = "ploceussubnet000001"              # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                            = "ploceusrg000001"                  #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                               = ["10.0.3.0/24"]                    #(Required) The address prefixes to use for the subnet.
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

# STORAGE ACCOUNT
storage_account_variables = {
  "storage_account_1" = {
    storage_account_key_vault_name                                     = null                 #(Required) The name of the Key Vault.
    storage_account_key_vault_resource_group_name                      = null                 #(Required) The resource group name of the Key Vault.
    storage_account_key_vault_key_name                                 = null                 #(Required) The name of the Key Vault key required for customer managed key.
    storage_account_user_assigned_identity_name_for_cmk                = null                 #(Required) The name of a user assigned identity for customer managed key.
    storage_account_user_assigned_identity_resource_group_name_for_cmk = null                 #(Required) The resource group name of a user assigned identity for customer managed key.
    storage_account_identity_type_for_cmk                              = null                 #(Required) The identity type of a user assigned identity for customer managed key.Only Possible value could be "UserAssigned" in order to use customer managed key. Other Possible values are "SystemAssigned", "SystemAssigned, UserAssigned"
    storage_account_name                                               = "ploceusstrac000001" #(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed.This must be unique across the entire Azure service, not just within the resource group.
    storage_account_resource_group_name                                = "ploceusrg000001"    #(Required) The name of the resource group in which to create the storage account.
    storage_account_location                                           = "eastus"             #(Required) Specifies the supported Azure location where the resource exists. 
    storage_account_account_kind                                       = "StorageV2"          #(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2.
    storage_account_account_tier                                       = "Standard"           #(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    storage_account_account_replication_type                           = "LRS"                #(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa.
    storage_account_cross_tenant_replication_enabled                   = true                 #(Optional) Should cross Tenant replication be enabled? Defaults to true.
    storage_account_access_tier                                        = "Hot"                #(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot.
    storage_account_edge_zone                                          = null                 #(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist.
    storage_account_enable_https_traffic_only                          = true                 #(Optional) Boolean flag which forces HTTPS if enabled. Defaults to true.
    storage_account_min_tls_version                                    = "TLS1_2"             #(Optional) The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts.
    storage_account_allow_nested_items_to_be_public                    = true                 #Allow or disallow nested items within this Account to opt into being public. Defaults to true.
    storage_account_shared_access_key_enabled                          = true                 #Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true.
    storage_account_public_network_access_enabled                      = true                 #(Optional) Whether the public network access is enabled? Defaults to true.
    storage_account_default_to_oauth_authentication                    = false                #(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false
    storage_account_is_hns_enabled                                     = false                #(Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2.
    storage_account_nfsv3_enabled                                      = false                #(Optional) Is NFSv3 protocol enabled? Defaults to false.
    storage_account_large_file_share_enabled                           = false                #(Optional) Is Large File Share Enabled?
    storage_account_queue_encryption_key_type                          = "Service"            #(Optional) The encryption type of the queue service. Possible values are Service and Account.Default value is Service.
    storage_account_table_encryption_key_type                          = "Service"            #(Optional) The encryption type of the table service. Possible values are Service and Account. Default value is Service.
    storage_account_infrastructure_encryption_enabled                  = false                #(Optional) Is infrastructure encryption enabled? Defaults to false.
    storage_account_allowed_copy_scope                                 = null                 #(Optional) Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values are AAD and PrivateLink.
    storage_account_sftp_enabled                                       = false                #(Optional) Boolean, enable SFTP for the storage account, to enable this, is_hns_enabled should be true as well
    storage_account_custom_domain                                      = null
    storage_account_identity                                           = null #(Optional) A block to pass storage account identity.
    storage_account_blob_properties = {
      versioning_enabled            = true         #(Optional) Is versioning enabled? Default to false.
      change_feed_enabled           = true         #(Optional) Is the blob service properties for change feed events enabled? Default to false.
      change_feed_retention_in_days = 7            #(Optional) The duration of change feed events retention in days. The possible values are between 1 and 146000 days (400 years). Setting this to null (or omit this in the configuration file) indicates an infinite retention of the change feed.
      default_service_version       = "2020-06-12" #(Optional) The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version. Defaults to 2020-06-12.
      last_access_time_enabled      = true         #(Optional) Is the last access time based tracking enabled? Default to false.
      cors_enabled                  = true         #(optional) Should cross origin resource sharing be enabled.
      cors_rule = {
        allowed_headers    = ["*"]                                                                 #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = ["DELETE", "GET", "HEAD", "MERGE", "POST", "OPTIONS", "PUT", "PATCH"] #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = ["*"]                                                                 #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = ["*", ]                                                               #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = 60                                                                    #(Required) The number of seconds the client should cache a preflight response.
      }
      restore_policy = {
        restore_policy_days = "4" #(Required) Specifies the number of days that the blob can be restored, between 1 and 365 days. This must be less than the days specified for delete_retention_policy.
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
    storage_account_network_rules = null #(Optional) A block to pass network rules.

    storage_account_azure_files_authentication = null #(Optional) Use this block when need to authenticate with Azure active directory domain services or Active Directory.
    storage_account_routing = {
      publish_internet_endpoints  = false             #(Optional) Should internet routing storage endpoints be published? Defaults to false.
      publish_microsoft_endpoints = false             #(Optional) Should Microsoft routing storage endpoints be published? Defaults to false.
      choice                      = "InternetRouting" #(Optional) Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting. Defaults to MicrosoftRouting.
    }
    storage_account_immutability_policy = null #(Optional) A block to ass immutability policy
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

#STORAGE CONTAINER
storage_container_variables = {
  "storage_container" = {
    storage_container_name                  = "ploceusstrcon000001" #Required The name of the Container which should be created within the Storage Account.
    storage_container_storage_account_name  = "ploceusstrac000001"  #Required The name of the Storage Account where the Container should be created.
    storage_container_container_access_type = "container"           #Optional The Access Level configured for this Container. Possible values are blob, container or private. Defaults to private.
    storage_container_metadata              = null                  #Optional A mapping of MetaData for this Container. All metadata keys should be lowercase.
  }
}

#ROLE ASSIGNMENT
role_assignment_variables = {
  "role_assignment" = {
    role_assignment_role_definition_name                   = "Storage Blob Data Owner"                                                                                     # (Optional) A unique UUID/GUID for this Role Assignment - one will be generated if not specified. Changing this forces a new resource to be created.
    role_assignment_description                            = "Allows for full access to Azure Storage blob containers and data, including assigning POSIX access control." # (Optional) The description of the role
    role_assignment_target_resource_name                   = null                                                                                                          # (Required) The name of the resource to which we are assigning role
    role_assignment_target_resource_type                   = "ResourceGroup"                                                                                               # (Required) Possible values are ResourceGroup, Subscription, ManagementGroup or AzureResource
    role_assignment_management_group_name                  = null                                                                                                          # (Optional) The name of the management group. Please make as null if scope is not set as ManagementGroup
    role_assignment_resource_group_name                    = "ploceusrg000001"                                                                                             # (Optional) The name of the resource group. Please make as null if scope is not set as ResourceGroup
    role_assignment_principal_type                         = "User"                                                                                                        # (Optional) Type of the principal id. It maybe User, Group or ServicePrincipal
    is_group_principal_id_exists                           = false                                                                                                         # (Optional) Provide true when principal_type is "Group"
    role_assignment_group_principal_display_name           = null                                                                                                          # (Optional) give user_principal_name if is_group_principal_id_exists =true, and principal_type="Group".
    is_service_principal_id_exists                         = true                                                                                                          # (Optional) Provide true when principal_type is "ServicePrincipal"
    role_assignment_service_principal_display_name         = "ploceussp000001"                                                                                             # (Optional) give service_principal_display_name if is_service_principal_id_exists =true, and principal_type="ServicePrincipal".
    is_user_principal_id_exists                            = true                                                                                                          # (Optional) Provide true when principle_type is "User" 
    role_assignment_user_principal_name                    = "xxxxxxxxxx@ploceus.com"                                                                                      # (Optional) give user_principal_name if is_user_principal_id_exists =true, and principal_type="User".
    role_assignment_condition                              = null                                                                                                          # (Optional) The condition that limits the resources that the role can be assigned to. Changing this forces a new resource to be created.
    role_assignment_security_enabled                       = true                                                                                                          # (Optional) Required for fetching group principal
    role_assignment_condition_version                      = null                                                                                                          # (Optional) The version of the condition. Possible values are 1.0 or 2.0. Changing this forces a new resource to be created.  
    role_assignment_delegated_managed_identity_resource_id = null                                                                                                          # (Optional) The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created 
    role_assignment_skip_service_principal_aad_check       = false                                                                                                         # (Optional) If the principal_id is a newly provisioned Service Principal set this value to true to skip the Azure Active Directory check which may fail due to replication lag. This argument is only valid if the principal_id is a Service Principal identity. Defaults to false.
  }
}

#EVENTHUB NAMESPACE
eventhub_namespace_variables = {
  "eventhub_namespace_1" = {
    eventhub_namespace_location                             = "eastus"           # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    eventhub_namespace_name                                 = "ploceusens000001" # (Required) Specifies the name of the EventHub Namespace resource. Changing this forces a new resource to be created.
    eventhub_namespace_resource_group_name                  = "ploceusrg000001"  # (Required) The name of the resource group in which to create the namespace. Changing this forces a new resource to be created.
    eventhub_namespace_sku                                  = "Standard"         # (Required) Defines which tier to use. Valid options are Basic, Standard, and Premium. Please note that setting this field to Premium will force the creation of a new resource.
    eventhub_namespace_capacity                             = "2"                # (Optional) Specifies the Capacity / Throughput Units for a Standard SKU namespace. Default capacity has a maximum of 2, but can be increased in blocks of 2 on a committed purchase basis.
    eventhub_namespace_auto_inflate_enabled                 = true               # (Optional) Is Auto Inflate enabled for the EventHub Namespace?
    eventhub_namespace_maximum_throughput_units             = 2                  # (Optional) Specifies the maximum number of throughput units when Auto Inflate is Enabled. Valid values range from 1 - 20.
    eventhub_namespace_zone_redundant                       = false              # (Optional) Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). Changing this forces a new resource to be created. Defaults to false.
    eventhub_namespace_dedicated_eventhub_cluster_name      = null               # (Optional) Specifies the name of the EventHub Cluster resource. Required, when the namespace needs a dedicated eventhub_cluster
    eventhub_namespace_eventhub_cluster_resource_group_name = null               # (Optional) The name of the resource group in which the EventHub Cluster exists. Required, when the namespace needs a dedicated eventhub_cluster 
    eventhub_namespace_local_authentication_enabled         = false              # (Optional) Is SAS authentication enabled for the EventHub Namespace?
    eventhub_namespace_public_network_access_enabled        = false              # (Optional) Is public network access enabled for the EventHub Namespace? Defaults to true.
    eventhub_namespace_minimum_tls_version                  = null               # (Optional) Specifies the maximum number of throughput units when Auto Inflate is Enabled. Valid values range from 1 - 20.
    eventhub_namespace_identity = {
      eventhub_namespace_identity_type = "SystemAssigned" # (Required) Specifies the type of Managed Service Identity that should be configured on this Eventhub Namespace. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).# Other values could be "UserAssigned", "SystemAssigned" 
      # If given as "SystemAssigned" , then give below parameter as null
      eventhub_namespace_user_assigned_identities = null # (Optional) Eventhub namespace user assigned identities
    }
    eventhub_namespace_network_rulesets = { # (Optional) A network_rulesets block as defined below.
      "eventhub_namespace_network_rulesets_1" = {
        network_rulesets_default_action                 = "Deny"                                       # (Required) The default action to take when a rule is not matched. Possible values are Allow and Deny.
        network_rulesets_trusted_service_access_enabled = false                                        # (Optional) Whether Trusted Microsoft Services are allowed to bypass firewall.
        network_rulesets_public_network_access_enabled  = false                                        # (Optional) Is public network access enabled for the EventHub Namespace? Defaults to true.
        network_rulesets_virtual_network_rule = {                                                      # (Optional) One or more virtual_network_rule blocks can be defined using subnet_ID & ignore_missing_virtual_network_service_endpoint with default value false
          virtual_network_rule_subnet_name                                     = "ploceussubnet000001" # (Required) The name of the subnet. Changing this forces a new resource to be created.
          virtual_network_rule_subnet_resource_group_name                      = "ploceusrg000001"     # (Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
          virtual_network_rule_subnet_virtual_network_name                     = "ploceusvnet000001"   # (Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
          virtual_network_rule_ignore_missing_virtual_network_service_endpoint = true                  # (Optional) Are missing virtual network service endpoints ignored? Defaults to false.
        }
        network_rulesets_ip_rule = null # (Optional) One or more ip_rule blocks can be defined with ip_mask & action
      }
    }
    eventhub_namespace_tags = { # (Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#EVENTHUB
eventhub_variables = {
  "eventhub_1" = {
    eventhub_capture_description = {                                                                                                               #(Optional) A capture_description block supports the following
      capture_description_destination = {                                                                                                          #(Required) A destination block as defined below.
        capture_description_destination_archive_name_format = "{Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}" #(Required) The Blob naming convention for archiving. e.g. {Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}. Here all the parameters (Namespace,EventHub .. etc) are mandatory irrespective of order
        capture_description_destination_blob_container_name = "ploceusstrcon000001"                                                                #(Required) The name of the Container within the Blob Storage Account where messages should be archived.
        capture_description_destination_name                = "EventHubArchive.AzureBlockBlob"                                                     #(Required) The Name of the Destination where the capture should take place. At this time the only supported value is EventHubArchive.AzureBlockBlob.
      }
      capture_description_enabled             = true     #(Required) Specifies if the Capture Description is Enabled.
      capture_description_encoding            = "Avro"   #(Required) Specifies the Encoding used for the Capture Description. Possible values are Avro and AvroDeflate.
      capture_description_interval_in_seconds = 60       #(Optional) Specifies the time interval in seconds at which the capture will happen. Values can be between 60 and 900 seconds. Defaults to 300 seconds.
      capture_description_size_limit_in_bytes = 10485760 #(Optional) Specifies the amount of data built up in your EventHub before a Capture Operation occurs. Value should be between 10485760 and 524288000 bytes. Defaults to 314572800 bytes.
      capture_description_skip_empty_archives = false    #(Optional) Specifies if empty files should not be emitted if no events occur during the Capture time window. Defaults to false.
    }
    eventhub_message_retention                                = 1                       #(Required) Specifies the number of days to retain the events for this Event Hub.
    eventhub_name                                             = "ploceuseventhub000001" #(Required) Specifies the name of the EventHub resource. Changing this forces a new resource to be created.
    eventhub_namespace_name                                   = "ploceusens000001"      #(Required) Specifies the name of the EventHub Namespace. Changing this forces a new resource to be created.
    eventhub_partition_count                                  = 1                       #(Required) Specifies the current number of shards on the Event Hub. Changing this will force-recreate the resource.
    eventhub_resource_group_name                              = "ploceusrg000001"       #(Required) The name of the resource group in which the EventHub's parent Namespace exists. Changing this forces a new resource to be created.
    eventhub_status                                           = "Active"                #(Optional) Specifies the status of the Event Hub resource. Possible values are Active, Disabled and SendDisabled. Defaults to Active.
    eventhub_storage_blob_storage_account_name                = "ploceusstrac000001"    #(Optional) To fetch The ID of the Blob Storage Account where messages should be archived.
    eventhub_storage_blob_storage_account_resource_group_name = "ploceusrg000001"       #(Required) Specifies the name of the resource group the Storage Account is located in. if capture description is enabled.
    eventhub_storage_blob_storage_container_name              = "ploceusstrcon000001"   #(Required) The name of the Container within the Blob Storage Account where messages should be archived. if capture description is enabled.
  }
}