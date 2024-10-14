#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000001"
    location = "westus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#VNET uncomment to create Vnet
vnets_variables = {
  "vnet_1" = {
    name                        = "ploceusvnet000001"
    location                    = "westus2"
    resource_group_name         = "ploceusrg000001"
    address_space               = ["10.0.0.0/16"]
    dns_servers                 = []
    flow_timeout_in_minutes     = null #possible values are between 4 and 30 minutes.
    bgp_community               = null
    edge_zone                   = null
    is_ddos_protection_required = false #Provide the value as true only if ddos_protection_plan is required
    ddos_protection_plan_name   = null  #Provide the name of the ddos protection plan if above value is true or else keep it as null. If new DDOS protection plan needs to be created uncomment from line 24 to 34
    vnet_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#SUBNET
subnet_variables = {
  "subnet_1" = {
    name                                           = "ploceussubnet000001"
    resource_group_name                            = "ploceusrg000001"
    address_prefixes                               = ["10.0.1.0/24"]
    virtual_network_name                           = "ploceusvnet000001"
    enforce_private_link_service_network_policies  = true
    enforce_private_link_endpoint_network_policies = true
    is_delegetion_required                         = false #update to true if delegation required and update delegation name,service_name,Service_actions
    service_endpoints                              = ["Microsoft.AzureActiveDirectory"]
    delegation_name                                = "delegation000001"
    service_name                                   = "Microsoft.Sql/managedInstances"
    service_actions                                = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
  }
}

#STORAGE ACCOUNT
storage_account_variables = {
  "storage_account_1" = {
    name                              = "ploceussa000001"
    resource_group_name               = "ploceusrg000001"
    location                          = "westus2"
    account_tier                      = "Standard"
    account_replication_type          = "LRS"
    account_kind                      = "StorageV2"
    access_tier                       = "Hot"
    enable_https_traffic_only         = true
    min_tls_version                   = "TLS1_2"
    allow_nested_items_to_be_public   = true
    large_file_share_enabled          = false
    is_hns_enabled                    = false #This can only be true when account_tier is Standard or Premium and account_kind is BlockBlobStorage
    nfsv3_enabled                     = false #This can only be true when account_tier is Standard and account_kind is StorageV2, or account_tier is Premium and account_kind is BlockBlobStorage. Additionally, the is_hns_enabled is true, and enable_https_traffic_only is false.
    cross_tenant_replication_enabled  = true
    shared_access_key_enabled         = true
    queue_encryption_key_type         = "service" #is only allowed when the account_kind is set to StorageV2.
    table_encryption_key_type         = "service" #is only allowed when the account_kind is set to StorageV2.
    edge_zone                         = null
    infrastructure_encryption_enabled = true #This can only be true when account_kind is StorageV2 or when account_tier is Premium and account_kind is BlockBlobStorage.
    custom_domain                     = null
    routing = [{
      publish_internet_endpoints  = false
      publish_microsoft_endpoints = false
      choice                      = "MicrosoftRouting"
    }]
    azure_files_authentication = null
    identity                   = null
    customer_managed_key       = null
    custom_domain              = null

    /*identity = [{
      type         = "UserAssigned"
      identity_ids = ["/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/XXXXXXXXXXXXXXXXXXXX/providers/Microsoft.ManagedIdentity/userAssignedIdentities/ploceus"]
    }]*/

    /*customer_managed_key = [{
      key_vault_key_id          = "https://ploceustesting.vault.azure.net/keys/ploceustestkey/XXXXXXXXXXXXXXXXXXXX"
      user_assigned_identity_id = "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/XXXXXXXXXXXXXXXXXXXX/providers/Microsoft.ManagedIdentity/userAssignedIdentities/ploceus"
    }]*/

    /*custom_domain = [{
      name          = "www.contoso.com"
      use_subdomain = true
    }]*/

    /*azure_files_authentication = [{
      directory_type = "AADDS"
      active_directory = {
        storage_sid         = "fhdf"
        domain_name         = "sckgf"
        domain_sid          = "djgcjj"
        domain_guid         = "gfwecye"
        forest_name         = "cjgjegwv"
        netbios_domain_name = "fscgdhcf"
      }
    }]*/

    network_rules = null

    share_properties = [{
      retention_policy = {
        days = 7
      }
      cors_rule = [{
        allowed_origins    = ["*"]
        allowed_methods    = ["GET", "DELETE"]
        allowed_headers    = ["*"]
        exposed_headers    = ["*"]
        max_age_in_seconds = 5
      }]
      smb = [{
        versions                        = ["SMB2.1"]
        authentication_types            = ["Kerberos"]
        kerberos_ticket_encryption_type = ["RC4-HMAC"]
        channel_encryption_type         = ["AES-128-CCM"]
      }]
    }]


    queue_properties = [{
      logging = {
        delete                = false
        read                  = false
        version               = "1.0"
        write                 = true
        retention_policy_days = "1"
      }
      hour_metrics = {
        enabled               = true
        include_apis          = true
        retention_policy_days = "7"
        version               = "1.0"
      }
      minute_metrics = {
        enabled               = true
        include_apis          = true
        retention_policy_days = "7"
        version               = "1.0"
      }
      cors_rule = [{
        allowed_origins    = ["*"]
        allowed_methods    = ["GET", "DELETE"]
        allowed_headers    = ["*"]
        exposed_headers    = ["*"]
        max_age_in_seconds = 5
      }]
    }]


    blob_properties = [{
      enable_versioning        = true
      default_service_version  = "2020-06-12" #The API Version which should be used by default for requests to the Data Plane API
      last_access_time_enabled = false
      change_feed_enabled      = false
      delete_retention_policy = {
        blob_retention_policy = "1"
      }
      container_delete_retention_policy = {
        container_delete_retention_policy = "1"
      }
      cors_rule = [{
        allowed_origins    = ["*"]
        allowed_methods    = ["GET", "DELETE"]
        allowed_headers    = ["*"]
        exposed_headers    = ["*"]
        max_age_in_seconds = 5
      }]
    }]

    static_website = {
      index_path      = "index.html"
      custom_404_path = "404.html"
    }

    storage_account_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#STORAGE CONTAINER
storage_container_variables = {
  "storage_container" = {
    name                  = "ploceussc000001"
    storage_account_name  = "ploceussa000001"
    container_access_type = "container"
    metadata              = null
  }
}

#Eventhub namespace
eventhub_namespace_variables = {
  "eventhub_namespace_1" = {
    eventhub_namespace_location                 = "westus2"
    eventhub_namespace_name                     = "ploceusehn000001"
    eventhub_namespace_resource_group_name      = "ploceusrg000001"
    eventhub_namespace_sku                      = "Standard"
    eventhub_namespace_capacity                 = "2"
    eventhub_namespace_auto_inflate_enabled     = true
    eventhub_namespace_maximum_throughput_units = 2
    eventhub_namespace_zone_redundant           = false
    eventhub_cluster_name                       = null
    eventhub_cluster_resource_group_name        = null
    eventhub_namespace_identity = [

      {
        eventhub_namespace_identity_type = "SystemAssigned"
      }
    ]                                              #Specifies the type of Managed Service Identity that should be configured on this Event Hub Namespace. The only possible value is SystemAssigned.
    eventhub_namespace_network_rulesets     = null #network rule block with values default_action,trusted_service_access_enabled,virtual_network_rule & ip_rule needs to be defined
    eventhub_namespace_virtual_network_rule = null #One or more virtual_network_rule blocks can be defined using subnet_ID & ignore_missing_virtual_network_service_endpoint with default value false 
    eventhub_namespace_ip_rule              = null # One or more ip_rule blocks can be defined with ip_mask & action
    eventhub_namespace_dedicated_cluster_id = null
    eventhub_namespace_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
    eventhub_namespace_subnet_name                 = "ploceussubnet000001"
    eventhub_namespace_subnet_resource_group_name  = "ploceusrg000001"
    eventhub_namespace_subnet_virtual_network_name = "ploceusvnet000001"
  }
}

#Eventhub
eventhub_variables = {
  "eventhub_1" = {
    eventhub_name                                             = "ploceuseventhub000001" #(Required) Specifies the name of the EventHub resource. Changing this forces a new resource to be created.
    eventhub_namespace_name                                   = "ploceusehn000001"      #(Required) Specifies the name of the EventHub Namespace. Changing this forces a new resource to be created.
    eventhub_resource_group_name                              = "ploceusrg000001"       #(Required) The name of the resource group in which the EventHub's parent Namespace exists. Changing this forces a new resource to be created.
    eventhub_partition_count                                  = 2                       #(Required) Partition_count cannot be changed unless Eventhub Namespace SKU is Premium.
    eventhub_message_retention                                = 1                       #(Required) When using a dedicated Event Hubs cluster, maximum value of message_retention is 90 days. When using a shared parent EventHub Namespace, maximum value is 7 days; or 1 day when using a Basic SKU for the shared parent EventHub Namespace.
    eventhub_status                                           = "Active"                #(Optional) Specifies the status of the Event Hub resource. Possible values are Active, Disabled and SendDisabled. Defaults to Active    
    eventhub_storage_blob_storage_account_name                = "ploceussa000001"       #(Optional) The Storage Account Name where messages should be archived. This is required for fetching storage_account_id.
    eventhub_storage_blob_storage_account_resource_group_name = "ploceusrg000001"       #(Optional) The name of the Storage Account RG. This is required for fetching storage_account_id.
    eventhub_capture_description = [{                                                   #(Optional) A capture_description block supports the following
      capture_description_enabled             = true                                    #(Required) Specifies if the Capture Description is Enabled.
      capture_description_encoding            = "Avro"                                  #(Required) Specifies the Encoding used for the Capture Description. Possible values are Avro and AvroDeflate.
      capture_description_interval_in_seconds = 300                                     #(Optional) Specifies the time interval in seconds at which the capture will happen. Values can be between 60 and 900 seconds. Defaults to 300 seconds.
      capture_description_size_limit_in_bytes = 314572800                               #(Optional) Value should be between 10485760 and 524288000 bytes. Defaults to 314572800 bytes.
      capture_description_skip_empty_archives = false                                   #(Optional) Specifies if empty files should not be emitted if no events occur during the Capture time window. Defaults to false.
      capture_description_destination = [{
        capture_description_destination_name                = "EventHubArchive.AzureBlockBlob"                                                     #(Required)At this time the only supported value is EventHubArchive.AzureBlockBlob.
        capture_description_destination_archive_name_format = "{Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}" #The Blob naming convention for archiving. e.g. {Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}. Here all the parameters (Namespace,EventHub .. etc) are mandatory irrespective of order
        capture_description_destination_blob_container_name = "ploceussc000001"                                                                    #(Required) The name of the Container within the Blob Storage Account where messages should be archived.
      }]
    }]
  }
}