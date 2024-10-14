#resource group variables
variable "resource_group_variables" {
  type = map(object({
    resource_group_name     = string      #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_tags     = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups"
  default     = {}
}

#Virtual Network Variable
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
  description = "Map of variables for subnet"
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
  default = {}
}

# STORAGE ACCOUNT VARIABLES
variable "storage_account_variables" {
  description = "Map of object of storage account variables"
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
  default = {}
}

#storage container variables
variable "storage_container_variables" {
  description = "Map of storage container variables"
  type = map(object({
    storage_container_name                  = string      #Required The name of the Container which should be created within the Storage Account.
    storage_container_storage_account_name  = string      #Required The name of the Storage Account where the Container should be created.
    storage_container_container_access_type = string      #Optional The Access Level configured for this Container. Possible values are blob, container or private. Defaults to private.
    storage_container_metadata              = map(string) #Optional A mapping of MetaData for this Container. All metadata keys should be lowercase.
  }))
  default = {}
}

#eventhub cluster
variable "eventhub_cluster_variables" {
  type = map(object({
    eventhub_cluster_name                = string      # (Required) Specifies the name of the EventHub Cluster resource. 
    eventhub_cluster_resource_group_name = string      # (Required) The name of the resource group in which the EventHub Cluster exists.
    eventhub_cluster_location            = string      # (Required) Specifies the supported Azure location where the resource exists.
    eventhub_cluster_sku_name            = string      # (Required) The SKU name of the EventHub Cluster. The only supported value at this time is Dedicated_1.
    eventhub_cluster_tags                = map(string) # (Optional) A mapping of tags to assign to the resource.
  }))
  description = "Map of evenethub cluster variables"
  default     = {}
}

#EventHub Namespace Variables
variable "eventhub_namespace_variables" {
  type = map(object({
    eventhub_namespace_name                        = string # (Required) Specifies the name of the EventHub Namespace resource. Changing this forces a new resource to be created.
    eventhub_namespace_location                    = string # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    eventhub_namespace_resource_group_name         = string # (Required) The name of the resource group in which to create the namespace. Changing this forces a new resource to be created.
    eventhub_namespace_sku                         = string # (Required) Defines which tier to use. Valid options are Basic, Standard, and Premium. Please note that setting this field to Premium will force the creation of a new resource.
    eventhub_namespace_dedicated_cluster_id        = string # (Optional) Specifies the ID of the EventHub Dedicated Cluster where this Namespace should created. Changing this forces a new resource to be created.
    eventhub_namespace_capacity                    = number # (Optional) Specifies the Capacity / Throughput Units for a Standard SKU namespace. Default capacity has a maximum of 2, but can be increased in blocks of 2 on a committed purchase basis.
    eventhub_namespace_auto_inflate_enabled        = bool   # (Optional) Is Auto Inflate enabled for the EventHub Namespace?
    eventhub_namespace_maximum_throughput_units    = number # (Optional) Specifies the maximum number of throughput units when Auto Inflate is Enabled. Valid values range from 1 - 20.
    eventhub_namespace_zone_redundant              = string #(Optional) Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). Changing this forces a new resource to be created. Defaults to false.
    eventhub_cluster_name                          = string #(Optional) Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). Changing this forces a new resource to be created. Defaults to false.#(Required) Specifies the name of the EventHub Cluster resource.
    eventhub_cluster_resource_group_name           = string # (Required) The name of the resource group in which the EventHub Cluster exists.
    eventhub_namespace_subnet_name                 = string # (Required) The name of the subnet. Changing this forces a new resource to be created.
    eventhub_namespace_subnet_resource_group_name  = string #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    eventhub_namespace_subnet_virtual_network_name = string #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.

    eventhub_namespace_identity = list(object({
      eventhub_namespace_identity_type = string #(Required) Specifies the type of Managed Service Identity that should be configured on this Event Hub Namespace. Possible values are SystemAssigned or UserAssigned.
    }))
    eventhub_namespace_network_rulesets = list(object({
      network_rulesets_default_action                 = string #(Required) The default action to take when a rule is not matched. Possible values are Allow and Deny.
      network_rulesets_trusted_service_access_enabled = bool   # (Optional) Whether Trusted Microsoft Services are allowed to bypass firewall.
    }))
    eventhub_namespace_virtual_network_rule = list(object({
      eventhub_namespace_virtual_network_rule_subnet_id = string #(Required) The id of the subnet to match on.
      ignore_missing_virtual_network_service_endpoint   = string #(Optional) Are missing virtual network service endpoints ignored? Defaults to false.
    }))
    eventhub_namespace_ip_rule = list(object({
      eventhub_namespace_ip_rule_ip_mask = string #(Required) The IP mask to match on.
      eventhub_namespace_ip_rule_action  = string #(Optional) The action to take when the rule is matched. Possible values are Allow.
    }))
    eventhub_namespace_tags = map(string) # (Optional) A mapping of tags to assign to the resource.
  }))
  description = "Map of EventHub Namespace Variables"
  default     = {}
}

# eventhub variables
variable "eventhub_variables" {
  description = "Map of variables for eventhub"
  type = map(object({
    eventhub_name                                             = string #(Required) Specifies the name of the EventHub resource. Changing this forces a new resource to be created.
    eventhub_namespace_name                                   = string #(Required) Specifies the name of the EventHub Namespace. Changing this forces a new resource to be created.
    eventhub_resource_group_name                              = string #(Required) The name of the resource group in which the EventHub's parent Namespace exists. Changing this forces a new resource to be created.
    eventhub_partition_count                                  = number #(Required) Partition_count cannot be changed unless Eventhub Namespace SKU is Premium.
    eventhub_message_retention                                = number #(Required) When using a dedicated Event Hubs cluster, maximum value of message_retention is 90 days. When using a shared parent EventHub Namespace, maximum value is 7 days; or 1 day when using a Basic SKU for the shared parent EventHub Namespace.
    eventhub_status                                           = string #(Optional) Specifies the status of the Event Hub resource. Possible values are Active, Disabled and SendDisabled. Defaults to Active
    eventhub_storage_blob_storage_account_name                = string #(Optional) The ID of the Blob Storage Account where messages should be archived if capture description is enabled.
    eventhub_storage_blob_storage_container_name              = string #(Optional) The name of the Container within the Blob Storage Account where messages should be archived.if capture description is enabled.
    eventhub_storage_blob_storage_account_resource_group_name = string #(Required) Specifies the name of the resource group the Storage Account is located in. if capture description is enabled.
    eventhub_capture_description = object({                            #(Optional)A capture_description block supports the following
      capture_description_enabled             = bool                   #(Required)Specifies if the Capture Description is Enabled.
      capture_description_encoding            = string                 #(Required)Specifies the Encoding used for the Capture Description. Possible values are Avro and AvroDeflate.
      capture_description_interval_in_seconds = number                 #(Optional)Specifies the time interval in seconds at which the capture will happen. Values can be between 60 and 900 seconds. Defaults to 300 seconds.
      capture_description_size_limit_in_bytes = number                 #(Optional)Value should be between 10485760 and 524288000 bytes. Defaults to 314572800 bytes.
      capture_description_skip_empty_archives = bool                   #(Optional)Specifies if empty files should not be emitted if no events occur during the Capture time window. Defaults to false.
      capture_description_destination = object({
        capture_description_destination_name                = string #(Required)At this time the only supported value is EventHubArchive.AzureBlockBlob.
        capture_description_destination_archive_name_format = string #(Required)The Blob naming convention for archiving. e.g. {Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}. Here all the parameters (Namespace,EventHub .. etc) are mandatory irrespective of order
        capture_description_destination_blob_container_name = string #(Required) The name of the Container within the Blob Storage Account where messages should be archived.
      })
    })
  }))
  default = {}
}