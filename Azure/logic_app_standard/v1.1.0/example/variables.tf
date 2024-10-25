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

#RESOURCE GROUP VARIABLES KEY VAULT
variable "resource_group_variables_key_vault" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
  default = {}
}

#RESOURCE GROUP VARIABLES STORAGE ACCOUNT
variable "resource_group_variables_storage_account" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
  default = {}
}

#KEY VAULT
variable "key_vault_variables" {
  type = map(object({
    key_vault_name                                  = string
    key_vault_resource_group_name                   = string
    key_vault_location                              = string
    key_vault_enabled_for_disk_encryption           = bool
    key_vault_enabled_for_deployment                = bool
    key_vault_enabled_for_template_deployment       = bool
    key_vault_enable_rbac_authorization             = bool
    key_vault_soft_delete_retention_days            = string
    key_vault_purge_protection_enabled              = bool
    key_vault_sku_name                              = string
    key_vault_access_container_agent_name           = string
    key_vault_access_policy_key_permissions         = list(string)
    key_vault_access_policy_secret_permissions      = list(string)
    key_vault_access_policy_storage_permissions     = list(string)
    key_vault_access_policy_certificate_permissions = list(string)
    key_vault_tags                                  = map(string)
    key_vault_network_acls_enabled                  = bool
    key_vault_network_acls_bypass                   = string
    key_vault_network_acls_default_action           = string
    key_vault_network_acls_ip_rules                 = list(string)
    key_vault_network_acls_virtual_networks = list(object({
      virtual_network_name    = string
      subnet_name             = string
      subscription_id         = string
      virtual_network_rg_name = string
    }))
    key_vault_contact_information_enabled = bool
    key_vault_contact_email               = string
    key_vault_contact_name                = string
    key_vault_contact_phone               = string
  }))
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

#STORAGE ACCOUNT VARIABLES
variable "storage_account_variables" {
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
}

#APP SERVICE PLAN VARIABLE
variable "app_service_plan_variables" {
  type = map(object({
    name                             = string
    resource_group_name              = string
    location                         = string
    os_type                          = string
    maximum_elastic_worker_count     = number
    worker_count                     = number
    app_service_environment_required = bool
    app_service_environment_name     = string
    sku_name                         = string /*The SKU for the app service plan.Possible values include B1,B2,B3,D1,F1,FREE,I1,I2,I3,I1v2,I2v2,I3v2,P1v2,P2v2,P3v2,
    P1v3,P2v3,P3v3,S1,S2,S3,SHARED,EP1,EP2,EP3,WS1,WS2,WS3.
    Note: Isolated SKUs (I1,I2,I3,I1v2,I2v2,and I3v2) can only be used with App Service Environments.
    Note: Elastic and Consumption SKUs(Y1,EP1,EP2,and EP3) are for use with Function Apps.
    Note: F1,B1,B2,B3 can only be used for Dev/Test less demanding workloads.
    Note: P1v2,P2v2,P3v2,P1v3,P2v3,P3v3,S1,S2,S3 can only be used for most production workloads.*/
    per_site_scaling_enabled         = bool
    zone_balancing_enabled           = bool
    app_service_plan_tags            = map(string)
  }))
}

#Logic App Standard Variables
variable "logic_app_standard_variables" {
  type = map(object({
    logic_app_standard_resource_group_name                  = string #Required
    logic_app_standard_storage_account_name                 = string #Required
    logic_app_standard_storage_account_resource_group_name  = string #Required
    logic_app_standard_app_service_plan_resource_group_name = string #Required
    logic_app_standard_resource_group_location              = string #Required
    logic_app_standard_app_service_plan_name                = string #Required
    logic_app_standard_name                                 = string #Required
    logic_app_standard_app_settings                         = map(string)
    logic_app_standard_use_extension_bundle                 = bool   #Defaults to true
    logic_app_standard_bundle_version                       = string #If use_extension_bundle=true then controls the allowed range for bundle versions. Default [1.*, 2.0.0)

    is_connection_string_required = bool #Variable to ask user whether connection string is required
    logic_app_standard_connection_string = object({
      name = string
      type = string #Possible values are APIHub, Custom, DocDb, EventHub, MySQL, NotificationHub, PostgreSQL, RedisCache, ServiceBus, SQLAzure and SQLServer.
    })

    logic_app_standard_client_affinity_enabled = bool
    logic_app_standard_client_certificate_mode = string #Possible values are Required and Optional.
    logic_app_standard_enabled                 = bool
    logic_app_standard_https_only              = bool #Defaults to false.

    logic_app_standard_identity = object({
      type = string #The only possible value is SystemAssigned.
    })

    is_subnet_required = bool #Variable to ask user whether subnet is required
    logic_app_standard_site_config = list(object({
      always_on       = bool   #Defaults to false
      app_scale_limit = string #Only applicable to apps on the Consumption and Premium plan.
      cors = list(object({
        allowed_origins     = list(string) # '*' can be used to allow all calls.
        support_credentials = bool
      }))
      dotnet_framework_version = string #The version of the .NET framework's CLR used in this Logic App Possible values are v4.0 (including .NET Core 2.1 and 3.1), v5.0 and v6.0. Defaults to v4.0.
      elastic_instance_minimum = string
      ftps_state               = string #Possible values include: AllAllowed, FtpsOnly and Disabled. Defaults to AllAllowed.
      health_check_path        = string
      http2_enabled            = bool #Defaults to false.
      ip_restriction = list(object({
        ip_address  = string
        service_tag = string #One of either ip_address, service_tag or virtual_network_subnet_id must be specified
        name        = string
        priority    = string #The priority for this IP Restriction. Restrictions are enforced in priority order. By default, the priority is set to 65000 if not specified.
        action      = string #Does this restriction Allow or Deny access for this IP range. Defaults to Allow.
        headers = object({
          x_azure_fdid      = list(string)
          x_fd_health_probe = list(string)
          x_forwarded_for   = list(string)
          x_forwarded_host  = list(string)
        })
      }))
      linux_fx_version                 = string #Linux App Framework and version for the AppService, e.g. DOCKER|(golang:latest). Setting this value will also set the kind of application deployed to functionapp,linux,container,workflowapp
      min_tls_version                  = string #Possible values are 1.0, 1.1, and 1.2. Defaults to 1.2
      pre_warmed_instance_count        = string
      runtime_scale_monitoring_enabled = bool #Defaults to false.
      use_32_bit_worker_process        = bool #Defaults to true.
      vnet_route_all_enabled           = bool
      websockets_enabled               = bool
    }))

    logic_app_standard_storage_account_share_name = string
    logic_app_standard_version                    = string #The runtime version associated with the Logic App Defaults to ~1.
    logic_app_standard_tags                       = map(string)
    key_vault_name                                = string
    key_vault_resource_group_name                 = string
    secret_connection_string_value_name           = string
    subnet_name                                   = string
    vnet_name                                     = string
    subnet_resource_group_name                    = string
  }))
}