#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
  default = {}
}

#VNET variable   #Uncomment the below lines if Vnet creation is required 
variable "vnets_variables" {
  description = "Map of vnet objects. name, vnet_address_space, and dns_server supported"
  type = map(object({
    name                        = string
    location                    = string
    resource_group_name         = string
    address_space               = list(string)
    dns_servers                 = list(string)
    flow_timeout_in_minutes     = number
    bgp_community               = string
    is_ddos_protection_required = bool
    ddos_protection_plan_name   = string
    vnet_tags                   = map(string)
    edge_zone                   = string
  }))
  default = {}
}

#Subnet Variables
variable "subnet_variables" {
  description = "Map of subnet"
  type = map(object({
    name                                           = string
    resource_group_name                            = string
    virtual_network_name                           = string
    address_prefixes                               = list(string)
    enforce_private_link_service_network_policies  = bool
    enforce_private_link_endpoint_network_policies = bool
    service_endpoints                              = list(string)
    is_delegetion_required                         = bool
    delegation_name                                = string
    service_name                                   = string
    service_actions                                = list(string)
  }))
  default = {}
}

#STORAGE ACCOUNT VARIABLES
variable "storage_account_variables" {
  description = "Map of storage account"
  type = map(object({
    name                              = string
    resource_group_name               = string
    location                          = string
    account_tier                      = string
    account_replication_type          = string
    account_kind                      = string
    access_tier                       = string
    enable_https_traffic_only         = bool
    min_tls_version                   = string
    allow_nested_items_to_be_public   = bool
    large_file_share_enabled          = bool
    nfsv3_enabled                     = bool
    is_hns_enabled                    = bool
    cross_tenant_replication_enabled  = bool
    shared_access_key_enabled         = bool
    edge_zone                         = string
    infrastructure_encryption_enabled = bool
    custom_domain = list(object({
      name          = string
      use_subdomain = bool
    }))
    identity = list(object({
      type         = string
      identity_ids = list(string)
    }))
    routing = list(object({
      publish_internet_endpoints  = bool
      publish_microsoft_endpoints = bool
      choice                      = string
    }))
    azure_files_authentication = list(object({
      directory_type = string
      active_directory = object({
        storage_sid         = string
        domain_name         = string
        domain_sid          = string
        domain_guid         = string
        forest_name         = string
        netbios_domain_name = string
      })
    }))
    customer_managed_key = list(object({
      key_vault_key_id          = string
      user_assigned_identity_id = string
    }))
    share_properties = list(object({
      retention_policy = object({
        days = number
      })
      cors_rule = list(object({
        allowed_origins    = list(string)
        allowed_methods    = list(string)
        allowed_headers    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      }))
      smb = list(object({
        versions                        = list(string)
        authentication_types            = list(string)
        kerberos_ticket_encryption_type = list(string)
        channel_encryption_type         = list(string)
      }))
    }))
    network_rules = list(object({
      default_action = string
      bypass         = list(string)
      ip_rules       = list(string)
      private_link_access = object({
        endpoint_resource_id = string
        endpoint_tenant_id   = string
      })
    }))
    queue_properties = list(object({
      logging = object({
        delete                = bool
        read                  = bool
        version               = string
        write                 = bool
        retention_policy_days = string
      })
      hour_metrics = object({
        enabled               = bool
        include_apis          = bool
        retention_policy_days = string
        version               = string
      })
      minute_metrics = object({
        enabled               = bool
        include_apis          = bool
        retention_policy_days = string
        version               = string
      })
      cors_rule = list(object({
        allowed_origins    = list(string)
        allowed_methods    = list(string)
        allowed_headers    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      }))
    }))
    storage_account_tags = map(string)
    blob_properties = list(object({
      enable_versioning        = bool
      last_access_time_enabled = bool
      default_service_version  = string
      change_feed_enabled      = bool
      delete_retention_policy = object({
        blob_retention_policy = string
      })
      container_delete_retention_policy = object({
        container_delete_retention_policy = string
      })
      cors_rule = list(object({
        allowed_origins    = list(string)
        allowed_methods    = list(string)
        allowed_headers    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      }))
    }))
    static_website = object({
      index_path      = string
      custom_404_path = string
    })
  }))
  default = {}
}

#STORAGE ACCOUNT VARIABLES
variable "storage_container_variables" {
  description = "Map of storage container"
  type = map(object({
    name                  = string
    storage_account_name  = string
    container_access_type = string
    metadata              = map(string)
  }))
  default = {}
}

#EVENTHUB NAMESPACE VARIABLES
variable "eventhub_namespace_variables" {
  description = "Map of eventhub namespace"
  type = map(object({
    eventhub_namespace_name                        = string
    eventhub_namespace_location                    = string
    eventhub_namespace_resource_group_name         = string
    eventhub_namespace_tags                        = map(string)
    eventhub_namespace_sku                         = string
    eventhub_namespace_capacity                    = number
    eventhub_namespace_auto_inflate_enabled        = string
    eventhub_namespace_dedicated_cluster_id        = string
    eventhub_namespace_identity                    = string
    eventhub_namespace_maximum_throughput_units    = number
    eventhub_namespace_zone_redundant              = string
    eventhub_cluster_name                          = string
    eventhub_cluster_resource_group_name           = string
    eventhub_namespace_subnet_name                 = string
    eventhub_namespace_subnet_resource_group_name  = string
    eventhub_namespace_subnet_virtual_network_name = string

    eventhub_namespace_identity = list(object({
      eventhub_namespace_identity_type = string
    }))
    eventhub_namespace_network_rulesets = list(object({
      eventhub_namespace_default_action = string
      trusted_service_access_enabled    = bool

    }))
    eventhub_namespace_virtual_network_rule = list(object({
      eventhub_namespace_subnet_id                    = string
      ignore_missing_virtual_network_service_endpoint = string
    }))
    eventhub_namespace_ip_rule = list(object({
      ip_rule_ip_mask = string
      ip_rule_action  = string
    }))

  }))
  default = {}
}

#Eventhub Variable
variable "eventhub_variables" {
  description = "Map of Eventhub Variables"
  type = map(object({
    eventhub_name                                             = string #(Required) Specifies the name of the EventHub resource. Changing this forces a new resource to be created.
    eventhub_namespace_name                                   = string #(Required) Specifies the name of the EventHub Namespace. Changing this forces a new resource to be created.
    eventhub_resource_group_name                              = string #(Required) The name of the resource group in which the EventHub's parent Namespace exists. Changing this forces a new resource to be created.
    eventhub_partition_count                                  = number #(Required) Partition_count cannot be changed unless Eventhub Namespace SKU is Premium.
    eventhub_message_retention                                = number #(Required) When using a dedicated Event Hubs cluster, maximum value of message_retention is 90 days. When using a shared parent EventHub Namespace, maximum value is 7 days; or 1 day when using a Basic SKU for the shared parent EventHub Namespace.
    eventhub_status                                           = string #(Optional) Specifies the status of the Event Hub resource. Possible values are Active, Disabled and SendDisabled. Defaults to Active
    eventhub_storage_blob_storage_account_name                = string #(Optional) The Storage Account Name where messages should be archived. This is required for fetching storage_account_id.
    eventhub_storage_blob_storage_account_resource_group_name = string #(Optional) The name of the Storage Account RG. This is required for fetching storage_account_id.
    eventhub_capture_description = list(object({                       #(Optional)A capture_description block supports the following
      capture_description_enabled             = bool                   #(Required)Specifies if the Capture Description is Enabled.
      capture_description_encoding            = string                 #(Required)Specifies the Encoding used for the Capture Description. Possible values are Avro and AvroDeflate.
      capture_description_interval_in_seconds = number                 #(Optional)Specifies the time interval in seconds at which the capture will happen. Values can be between 60 and 900 seconds. Defaults to 300 seconds.
      capture_description_size_limit_in_bytes = number                 #(Optional)Value should be between 10485760 and 524288000 bytes. Defaults to 314572800 bytes.
      capture_description_skip_empty_archives = bool                   #(Optional)Specifies if empty files should not be emitted if no events occur during the Capture time window. Defaults to false.
      capture_description_destination = list(object({
        capture_description_destination_name                = string #(Required)At this time the only supported value is EventHubArchive.AzureBlockBlob.
        capture_description_destination_archive_name_format = string #The Blob naming convention for archiving. e.g. {Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}. Here all the parameters (Namespace,EventHub .. etc) are mandatory irrespective of order
        capture_description_destination_blob_container_name = string #(Required) The name of the Container within the Blob Storage Account where messages should be archived.
      }))
    }))
  }))
  default = {}
}