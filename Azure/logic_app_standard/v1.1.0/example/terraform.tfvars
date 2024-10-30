#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000001"
    location = "eastus"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#RESOURCE GROUP KEY VAULT
resource_group_variables_key_vault = {
  "resource_group_2" = {
    name     = "ploceusrg000002"
    location = "eastus"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#RESOURCE GROUP STORAGE ACCOUNT
resource_group_variables_storage_account = {
  "resource_group_2" = {
    name     = "ploceusrg000002"
    location = "eastus"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

# Key Vault
key_vault_variables = {
  "key_vault_1" = {
    key_vault_name                                  = "ploceusvault000001"
    key_vault_location                              = "eastus"
    key_vault_resource_group_name                   = "ploceusrg000002"
    key_vault_enabled_for_disk_encryption           = true
    key_vault_enabled_for_deployment                = true
    key_vault_enabled_for_template_deployment       = true
    key_vault_enable_rbac_authorization             = false
    key_vault_soft_delete_retention_days            = "7"
    key_vault_purge_protection_enabled              = false
    key_vault_sku_name                              = "standard"
    key_vault_access_container_agent_name           = null
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore", "Purge"]
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]
    key_vault_access_policy_storage_permissions     = []
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]
    key_vault_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_network_acls_enabled          = false
    key_vault_network_acls_enabled          = false
    key_vault_network_acls_bypass           = "AzureServices"
    key_vault_network_acls_default_action   = "Allow"
    key_vault_network_acls_ip_rules         = null
    key_vault_network_acls_virtual_networks = null
    key_vault_contact_information_enabled   = false
    key_vault_contact_email                 = "XXXXXXXXXXX@ploceus.com"
    key_vault_contact_name                  = "XXXXXXXXXXX"
    key_vault_contact_phone                 = "99999999999"
  }
}

# Key vault secret
key_vault_secret_variables = {
  "connection_string_value" = {
    key_vault_secret_name                = "ploceusconnstring000001"
    key_vault_secret_value               = "ploceusconnstring000001"
    key_vault_secret_content_type        = ""
    key_vault_secret_not_before_date     = ""
    key_vault_secret_expiration_date     = ""
    key_vault_secret_resource_group_name = "ploceusrg000002"
    key_vault_name                       = "ploceusvault000001"
    key_vault_secret_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_secret_min_upper   = 10
    key_vault_secret_min_lower   = 5
    key_vault_secret_min_numeric = 5
    key_vault_secret_min_special = 3
    key_vault_secret_length      = 32
  }
}

#STORAGE ACCOUNT
storage_account_variables = {
  "storage_account_1" = {
    name                              = "ploceussa000050"
    resource_group_name               = "ploceusrg000002"
    location                          = "eastus"
    account_tier                      = "Standard"
    account_replication_type          = "LRS"
    account_kind                      = null
    access_tier                       = null
    enable_https_traffic_only         = null
    min_tls_version                   = null
    allow_nested_items_to_be_public   = true
    large_file_share_enabled          = false
    is_hns_enabled                    = false #This can only be true when account_tier is Standard or Premium and account_kind is BlockBlobStorage
    nfsv3_enabled                     = false #This can only be true when account_tier is Standard and account_kind is StorageV2, or account_tier is Premium and account_kind is BlockBlobStorage. Additionally, the is_hns_enabled is true, and enable_https_traffic_only is false.
    cross_tenant_replication_enabled  = null
    shared_access_key_enabled         = null
    queue_encryption_key_type         = null #is only allowed when the account_kind is set to StorageV2.
    table_encryption_key_type         = null #is only allowed when the account_kind is set to StorageV2.
    edge_zone                         = null
    infrastructure_encryption_enabled = false #This can only be true when account_kind is StorageV2 or when account_tier is Premium and account_kind is BlockBlobStorage.
    custom_domain                     = null
    routing                           = null
    azure_files_authentication        = null
    identity                          = null
    customer_managed_key              = null
    custom_domain                     = null
    network_rules                     = null
    share_properties                  = null
    queue_properties                  = null
    blob_properties                   = null
    static_website                    = null
    storage_account_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#APP SERVICE PLAN
app_service_plan_variables = {
  "app_service_plan_1" = {
    name                             = "ploceusappplan000001"
    resource_group_name              = "ploceusrg000001"
    location                         = "eastus"
    os_type                          = "Windows" #Change this to "Linux" when used with linux_fx_version otherwise use "Windows"
    maximum_elastic_worker_count     = null
    worker_count                     = null
    app_service_environment_required = false
    app_service_environment_name     = null
    sku_name                         = "WS1"
    per_site_scaling_enabled         = false
    zone_balancing_enabled           = false
    app_service_plan_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#Logic App Standard
logic_app_standard_variables = {
  "logic_app_standard_variables_1" = {
    logic_app_standard_resource_group_name                  = "ploceusrg000001"
    logic_app_standard_storage_account_name                 = "ploceussa000050"
    logic_app_standard_app_service_plan_name                = "ploceusappplan000001"
    logic_app_standard_name                                 = "ploceuslogappstd000001"
    logic_app_standard_resource_group_location              = "eastus"
    logic_app_standard_storage_account_resource_group_name  = "ploceusrg000002"
    logic_app_standard_app_service_plan_resource_group_name = "ploceusrg000001"
    logic_app_standard_app_settings                         = null
    logic_app_standard_use_extension_bundle                 = true
    logic_app_standard_bundle_version                       = "[1.*,2.0.0)"
    is_connection_string_required                           = false
    logic_app_standard_connection_string = {
      name = "ploceuslaconnstring000001"
      type = "SQLServer" #Possible values are APIHub, Custom, DocDb, EventHub, MySQL, NotificationHub, PostgreSQL, RedisCache, ServiceBus, SQLAzure and SQLServer.
    }

    logic_app_standard_client_affinity_enabled = null
    logic_app_standard_client_certificate_mode = null #Possible values are Required and Optional
    logic_app_standard_enabled                 = null
    logic_app_standard_https_only              = null

    logic_app_standard_identity = {
      type = "SystemAssigned" #The only possible value is SystemAssigned
    }

    is_subnet_required = false
    logic_app_standard_site_config = [{
      always_on       = null
      app_scale_limit = null
      cors = [{
        allowed_origins     = ["*"]
        support_credentials = null
      }]
      dotnet_framework_version         = null
      elastic_instance_minimum         = "1"
      ftps_state                       = null
      health_check_path                = null
      http2_enabled                    = null
      ip_restriction                   = null /*[{
        ip_address                = null
        service_tag               = null
        name                      = null
        priority                  = null
        action                    = null
        headers = {
          x_azure_fdid      = null
          x_fd_health_probe = null
          x_forwarded_for   = null
          x_forwarded_host  = null
        }
      }]*/
      linux_fx_version                 = null
      min_tls_version                  = null
      pre_warmed_instance_count        = null
      runtime_scale_monitoring_enabled = null
      use_32_bit_worker_process        = null
      vnet_route_all_enabled           = null
      websockets_enabled               = null
    }]

    logic_app_standard_storage_account_share_name = null
    logic_app_standard_version                    = null
    logic_app_standard_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_name                      = "ploceusvault000001"
    key_vault_resource_group_name       = "ploceusrg000002"
    secret_connection_string_value_name = "ploceusconnstring000001"
    subnet_name                         = "ploceussubnet000001"
    vnet_name                           = "ploceusvnet000001"
    subnet_resource_group_name          = "ploceusrg000001"
  }
}

logic_app_standard_subscription_id = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"
logic_app_standard_tenant_id       = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"
storage_account_subscription_id    = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"
storage_account_tenant_id          = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"
key_vault_subscription_id          = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"
key_vault_tenant_id                = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"