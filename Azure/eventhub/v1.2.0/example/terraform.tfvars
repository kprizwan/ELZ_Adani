#resource group 
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000001" #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = "westus2"         #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

# Virtual Network 
virtual_network_variables = {
  "virtual_network_1" = {
    virtual_network_name                    = "ploceusvnet000001"         #(Required) The name of the virtual network.
    virtual_network_location                = "westus2"                   #(Required) The location/region where the virtual network is created.
    virtual_network_resource_group_name     = "ploceusrg000001"           #(Required) The name of the resource group in which to create the virtual network.
    virtual_network_address_space           = ["10.0.0.0/16"]             #(Required) The address space that is used the virtual network.
    virtual_network_dns_servers             = null                        #(Optional) List of IP addresses of DNS servers.Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it.
    virtual_network_flow_timeout_in_minutes = null                        #(Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = null                        #(Optional) The BGP community attribute in format <as-number>:<community-value>.The as-number segment is the Microsoft ASN, which is always 12076 for now.
    virtual_network_edge_zone               = null                        #(Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_ddos_protection_plan = {                              #(Optional block) provide true for virtual_network_ddos_protection_enable incase ddos_protection needs to be enabled.
      virtual_network_ddos_protection_enable    = false                   #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = "ploceusddosplan000001" #(Required) Needed for ddos protection plan id.Provide the name of the ddos protection plan if above enable is true
    }
    virtual_network_subnet = [] #(Optional) Can be specified multiple times to define multiple subnets
    virtual_network_tags = {    #(Optional) A mapping of tags which should be assigned to the virtual network.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

# Subnets
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

#storage account
storage_account_variables = {
  "storage_account_01" = {
    storage_account_key_vault_name                                     = null                  #(Required) The name of the Key Vault.
    storage_account_key_vault_resource_group_name                      = null                  #(Required) The resource group name of the Key Vault.
    storage_account_key_vault_key_name                                 = null                  #(Required) The name of the Key Vault key required for customer managed key.
    storage_account_user_assigned_identity_name_for_cmk                = null                  #(Required) The name of a user assigned identity for customer managed key.
    storage_account_user_assigned_identity_resource_group_name_for_cmk = null                  #(Required) The resource group name of a user assigned identity for customer managed key.
    storage_account_identity_type_for_cmk                              = null                  #(Required) The identity type of a user assigned identity for customer managed key.Possible values could be "UserAssigned", "SystemAssigned", "SystemAssigned, UserAssigned"
    storage_account_name                                               = "ploceusstracc000001" #(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed.This must be unique across the entire Azure service, not just within the resource group.
    storage_account_resource_group_name                                = "ploceusrg000001"     #(Required) The name of the resource group in which to create the storage account.
    storage_account_location                                           = "westus2"             #(Required) Specifies the supported Azure location where the resource exists. 
    storage_account_account_kind                                       = null                  #(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2.
    storage_account_account_tier                                       = "Standard"            #(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    storage_account_account_replication_type                           = "LRS"                 #(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa.
    storage_account_cross_tenant_replication_enabled                   = true                  #(Optional) Should cross Tenant replication be enabled? Defaults to true.
    storage_account_access_tier                                        = "Hot"                 #(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot.
    storage_account_edge_zone                                          = null                  #(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist.
    storage_account_enable_https_traffic_only                          = true                  #(Optional) Boolean flag which forces HTTPS if enabled. Defaults to true.
    storage_account_min_tls_version                                    = "TLS1_2"              #(Optional) The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts.
    storage_account_allow_nested_items_to_be_public                    = true                  #Allow or disallow nested items within this Account to opt into being public. Defaults to true.
    storage_account_shared_access_key_enabled                          = true                  #Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true.
    storage_account_public_network_access_enabled                      = true                  #(Optional) Whether the public network access is enabled? Defaults to true.
    storage_account_default_to_oauth_authentication                    = false                 #(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false
    storage_account_is_hns_enabled                                     = false                 #(Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2.
    storage_account_nfsv3_enabled                                      = false                 #(Optional) Is NFSv3 protocol enabled? Defaults to false.
    storage_account_large_file_share_enabled                           = false                 #(Optional) Is Large File Share Enabled?
    storage_account_queue_encryption_key_type                          = "Service"             #(Optional) The encryption type of the queue service. Possible values are Service and Account.Default value is Service.
    storage_account_table_encryption_key_type                          = "Service"             #(Optional) The encryption type of the table service. Possible values are Service and Account. Default value is Service.
    storage_account_infrastructure_encryption_enabled                  = false                 #(Optional) Is infrastructure encryption enabled? Defaults to false.
    storage_account_custom_domain                                      = null
    storage_account_identity                                           = null
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
      delete_retention_policy = {
        delete_retention_policy_days = "7" #(Optional) Specifies the number of days that the blob should be retained, between 1 and 365 days. Defaults to 7.
      }
      container_delete_retention_policy = {
        container_delete_retention_policy_days = "1" #(Optional) Specifies the number of days that the container should be retained, between 1 and 365 days. Defaults to 7.
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
    storage_account_share_properties           = null
    storage_account_network_rules              = null
    storage_account_azure_files_authentication = null
    storage_account_routing = {
      publish_internet_endpoints  = false             #(Optional) Should internet routing storage endpoints be published? Defaults to false.
      publish_microsoft_endpoints = false             #(Optional) Should Microsoft routing storage endpoints be published? Defaults to false.
      choice                      = "InternetRouting" #(Optional) Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting. Defaults to MicrosoftRouting.
    }
    storage_account_immutability_policy = {
      allow_protected_append_writes = false      #(Required) When enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted.
      state                         = "Disabled" #(Required) Defines the mode of the policy. Disabled state disables the policy, Unlocked state allows increase and decrease of immutability retention time and also allows toggling allowProtectedAppendWrites property, Locked state only allows the increase of the immutability retention time. A policy can only be created in a Disabled or Unlocked state and can be toggled between the two states. Only a policy in an Unlocked state can transition to a Locked state which cannot be reverted.
      period_since_creation_in_days = 7          #(Required) The immutability period for the blobs in the container since the policy creation, in days.
    }
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

#storage container
storage_container_variables = {
  "storage_container" = {
    storage_container_name                  = "ploceusstrcon000001" #Required The name of the Container which should be created within the Storage Account.
    storage_container_storage_account_name  = "ploceusstracc000001" #Required The name of the Storage Account where the Container should be created.
    storage_container_container_access_type = "container"           #Optional The Access Level configured for this Container. Possible values are blob, container or private. Defaults to private.
    storage_container_metadata              = null                  #Optional A mapping of MetaData for this Container. All metadata keys should be lowercase.
  }
}

#eventhub cluster
eventhub_cluster_variables = {
  eventhub_cluster_1 = {
    eventhub_cluster_name                = "Ploceuseventhubcluster000001" # (Required) Specifies the name of the EventHub Cluster resource.
    eventhub_cluster_resource_group_name = "ploceusrg000001"              # (Required) The name of the resource group in which the EventHub Cluster exists.
    eventhub_cluster_location            = "westus2"                      # (Required) Specifies the supported Azure location where the resource exists.
    eventhub_cluster_sku_name            = "Dedicated_1"                  # (Required) The SKU name of the EventHub Cluster. The only supported value at this time is Dedicated_1.
    eventhub_cluster_tags = {                                             # (Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#Eventhub namespace
eventhub_namespace_variables = {
  "eventhub_namespace_1" = {
    eventhub_namespace_location                 = "westus2"          # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    eventhub_namespace_name                     = "ploceusasg000001" # (Required) Specifies the name of the EventHub Namespace resource. Changing this forces a new resource to be created.
    eventhub_namespace_resource_group_name      = "ploceusrg000001"  # (Required) The name of the resource group in which to create the namespace. Changing this forces a new resource to be created.
    eventhub_namespace_sku                      = "Standard"         # (Required) Defines which tier to use. Valid options are Basic, Standard, and Premium. Please note that setting this field to Premium will force the creation of a new resource.
    eventhub_namespace_capacity                 = "1"                # (Optional) Specifies the Capacity / Throughput Units for a Standard SKU namespace. Default capacity has a maximum of 2, but can be increased in blocks of 2 on a committed purchase basis.
    eventhub_namespace_auto_inflate_enabled     = true               # (Optional) Is Auto Inflate enabled for the EventHub Namespace?
    eventhub_namespace_maximum_throughput_units = 2                  # (Optional) Specifies the maximum number of throughput units when Auto Inflate is Enabled. Valid values range from 1 - 20.
    eventhub_namespace_zone_redundant           = false              #(Optional) Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). Changing this forces a new resource to be created. Defaults to false.
    eventhub_namespace_dedicated_cluster_id     = null               # (Optional) Specifies the ID of the EventHub Dedicated Cluster where this Namespace should created. Changing this forces a new resource to be created.
    eventhub_cluster_name                       = "ploceuscn000001"  #(Optional) Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). Changing this forces a new resource to be created. Defaults to false.#(Required) Specifies the name of the EventHub Cluster resource.
    eventhub_cluster_resource_group_name        = "ploceusrg000001"  # (Required) The name of the resource group in which the EventHub Cluster exists. 
    eventhub_namespace_identity = [
      {
        eventhub_namespace_identity_type = "SystemAssigned" #(Required) Specifies the type of Managed Service Identity that should be configured on this Event Hub Namespace. Possible values are SystemAssigned or UserAssigned.
      }
    ]                                              #Specifies the type of Managed Service Identity that should be configured on this Event Hub Namespace. The only possible value is SystemAssigned.
    eventhub_namespace_network_rulesets     = null #network rule block with values default_action,trusted_service_access_enabled,virtual_network_rule & ip_rule needs to be defined
    eventhub_namespace_virtual_network_rule = null #One or more virtual_network_rule blocks can be defined using subnet_ID & ignore_missing_virtual_network_service_endpoint with default value false 
    eventhub_namespace_ip_rule              = null # One or more ip_rule blocks can be defined with ip_mask & action
    eventhub_namespace_tags = {                    # (Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
    eventhub_namespace_subnet_name                 = "ploceussubnet000001"          # (Required) The name of the subnet. Changing this forces a new resource to be created.
    eventhub_namespace_subnet_resource_group_name  = "ploceusrg000001"              #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    eventhub_namespace_subnet_virtual_network_name = "ploceusvnet000001"            #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    eventhub_cluster_name                          = "ploceuseventhubcluster000001" #(Optional) Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). Changing this forces a new resource to be created. Defaults to false.#(Required) Specifies the name of the EventHub Cluster resource.
    eventhub_cluster_resource_group_name           = "ploceusrg000001"              # (Required) The name of the resource group in which the EventHub Cluster exists. 
  }
}

#Eventhub
eventhub_variables = {
  "eventhub_01" = {
    eventhub_capture_description = {                                                                                                               #(Optional) A capture_description block as defined below.
      capture_description_destination = {                                                                                                          #(Required) A destination block as defined below.
        capture_description_destination_archive_name_format = "{Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}" #(Required)The Blob naming convention for archiving. e.g. {Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}. Here all the parameters (Namespace,EventHub .. etc) are mandatory irrespective of order
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
    eventhub_namespace_name                                   = "ploceusasg000001"      #(Required) Specifies the name of the EventHub Namespace. Changing this forces a new resource to be created.
    eventhub_partition_count                                  = 1                       #(Required) Specifies the current number of shards on the Event Hub.
    eventhub_resource_group_name                              = "ploceusrg000001"       #(Required) The name of the resource group in which the EventHub's parent Namespace exists. Changing this forces a new resource to be created.
    eventhub_status                                           = "Active"                #(Optional) Specifies the status of the Event Hub resource. Possible values are Active, Disabled and SendDisabled. Defaults to Active.
    eventhub_storage_blob_storage_account_name                = "ploceusstracc000001"   #(Required) The ID of the Blob Storage Account where messages should be archived if capture description is enabled.
    eventhub_storage_blob_storage_account_resource_group_name = "ploceusrg000001"       #(Required) Specifies the name of the resource group the Storage Account is located in. if capture description is enabled.
    eventhub_storage_blob_storage_container_name              = "ploceusstrcon000001"   #(Required) The name of the Container within the Blob Storage Account where messages should be archived. if capture description is enabled.
  }
}