# Resource Group
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

key_vault_resource_group_variables = {
  "resource_group_2" = {
    name     = "ploceusrg000002"
    location = "westus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

storage_account_resource_group_variables = {
  "resource_group_3" = {
    name     = "ploceusrg000003"
    location = "westus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#Key Valut
key_vault_variables = {
  "key_vault_1" = {
    key_vault_name                                  = "ploceuskeyvault000001"
    key_vault_location                              = "westus2"
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
    key_vault_network_acls_enabled = false
    key_vault_network_acls_virtual_networks = [
      {
        virtual_network_name    = "ploceusvnet000001"
        subnet_name             = "ploceussubnet000001"
        subscription_id         = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        virtual_network_rg_name = "ploceusrg000001"
      }
    ]
    key_vault_network_acls_bypass         = "AzureServices"
    key_vault_network_acls_default_action = "Deny"
    key_vault_network_acls_ip_rules       = ["0.0.0.0/16"]
    key_vault_contact_information_enabled = false
    key_vault_contact_email               = "xxxxxxxx@ploceus.com"
    key_vault_contact_name                = "Ploceus"
    key_vault_contact_phone               = "99999999999"

  }
}

#Key Vault Secret
key_vault_secret_variables = {
  "key_vault_secret_1" = {
    key_vault_name                       = "ploceuskeyvault000001"
    key_vault_secret_value               = "ploceusmssqladminuser000001"
    key_vault_secret_content_type        = ""
    key_vault_secret_not_before_date     = ""
    key_vault_secret_expiration_date     = ""
    key_vault_secret_resource_group_name = "ploceusrg000002"
    key_vault_secret_name                = "Ploceuskvs0001"
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

#Storage Account
storage_account_variables = {
  "storage_account_1" = {
    name                              = "ploceussa000001"
    resource_group_name               = "ploceusrg000003"
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
    network_rules              = null
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

#MSSQL Server
mssql_server_variables = {
  "server1" = {
    mssql_server_name                = "ploceusmssql000001"
    mssql_server_resource_group_name = "ploceusrg000001"
    mssql_server_location            = "westus2"
    mssql_server_version             = "12.0"
    mssql_server_azuread_administrator = {
      azuread_administrator_login_email                 = "xxxxxxxxxx@ploceus.com"
      azuread_administrator_azuread_authentication_only = true
    }
    mssql_server_administrator_login                                = null
    mssql_server_access_container_agent_name                        = null
    mssql_server_primary_user_assigned_identity_name                = null # primary_user_identity has issues with current version. so disabled.
    mssql_server_primary_user_assigned_identity_resource_group_name = null
    mssql_server_identity = {
      mssql_server_identity_type            = "SystemAssigned"
      mssql_server_user_assigned_identities = null
    }
    mssql_server_connection_policy                    = "Default"
    mssql_server_minimum_tls_version                  = 1.2
    mssql_server_public_network_access_enabled        = true
    mssql_server_outbound_network_restriction_enabled = false
    mssql_server_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
    mssql_server_use_existing_admin_login_username                   = true
    mssql_server_generate_new_admin_password                         = true
    mssql_server_admin_credentials_key_vault_name                    = "ploceuskeyvault000001"
    mssql_server_admin_credentials_key_vault_resource_group_name     = "ploceusrg000002"
    mssql_server_existing_admin_login_username_key_vault_secret_name = "Ploceuskvs0001"
    mssql_server_generated_admin_password_key_vault_secret_name      = "Ploceuskvs0002"
    mssql_server_existing_admin_password_key_vault_secret_name       = null
  }
}

#MSSQL Database
mssql_database_variables = {
  "mssql_database_1" = {
    mssql_database_name                                    = "ploceusmssqldb000001"
    mssql_database_collation                               = null
    mssql_database_license_type                            = "LicenseIncluded"
    mssql_database_max_size_gb                             = null
    mssql_database_read_scale                              = false
    mssql_database_sku_name                                = null
    mssql_database_zone_redundant                          = false              #Optional only settable for Premium and Business Critical databases
    mssql_database_auto_pause_delay_in_minutes             = -1                 #Optional -1 means that automatic pause is disabled
    mssql_database_create_mode                             = "Default"          #Optional Possible values are Copy, Default, OnlineSecondary, PointInTimeRestore, Recovery, Restore, RestoreExternalBackup, RestoreExternalBackupSecondary, RestoreLongTermRetentionBackup and Secondary. 
    mssql_database_geo_backup_enabled                      = false              #Optional only applicable for DataWarehouse SKUs (DW*).
    mssql_database_ledger_enabled                          = false              #Optional A boolean that specifies if this is a ledger database
    mssql_database_min_capacity                            = null               #Optional This property is only settable for General Purpose Serverless databases
    mssql_database_restore_point_in_time                   = null               #Required This property is only settable for create_mode= PointInTimeRestore databases.
    mssql_database_read_replica_count                      = null               #Optional The number of readonly secondary replicas associated with the database to which readonly application intent connections may be routed. This property is only settable for Hyperscale edition databases.
    mssql_database_sample_name                             = "AdventureWorksLT" #Optional Specifies the name of the sample schema to apply when creating this database. Possible value is AdventureWorksLT
    mssql_database_storage_account_type                    = "Geo"              #Optional Possible values are Geo, GeoZone, Local and Zone. The default value is Geo.
    mssql_database_transparent_data_encryption_enabled     = "true"             #Optional If set to true, Transparent Data Encryption will be enabled on the database. Defaults to true. It cannot be disabled on servers with SKUs other than ones starting with DW.
    mssql_database_mssql_server_name                       = "ploceusmssql000001"
    mssql_database_mssql_server_resource_group_name        = "ploceusrg000001"
    mssql_database_creation_source_database_name           = null
    mssql_database_source_mssql_server_name                = null
    mssql_database_source_mssql_server_resource_group_name = null
    mssql_database_storage_account_name                    = "ploceussa000001"
    mssql_database_storage_account_resource_group_name     = "ploceusrg000003"
    mssql_database_elastic_pool_name                       = null
    mssql_database_elastic_pool_resource_group_name        = null
    mssql_database_threat_detection_policy_required        = true
    mssql_database_threat_detection_policy = {
      threat_detection_policy_state                = "New"
      threat_detection_policy_disabled_alerts      = ["Sql_Injection_Vulnerability", "Sql_Injection"]
      threat_detection_policy_email_account_admins = "Enabled"
      threat_detection_policy_email_addresses      = ["xxxxxxxx@ploceus.com"]
      threat_detection_policy_retention_days       = 5
    }
    mssql_database_long_term_retention_policy_required = true
    mssql_database_long_term_retention_policy = {
      long_term_retention_policy_weekly_retention  = "P1W"
      long_term_retention_policy_monthly_retention = "P4W"
      long_term_retention_policy_yearly_retention  = "P12M"
      long_term_retention_policy_week_of_year      = 1
    }
    mssql_database_short_term_retention_policy_required = true
    mssql_database_short_term_retention_policy = {
      short_term_retention_policy_retention_days           = 7
      short_term_retention_policy_backup_interval_in_hours = 12
    }
    mssql_database_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

key_vault_subscription_id       = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
key_vault_tenant_id             = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
storage_account_subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
storage_account_tenant_id       = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
mssql_server_subscription_id    = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
mssql_server_tenant_id          = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
azuread_tenant_id               = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"