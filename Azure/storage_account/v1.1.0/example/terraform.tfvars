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
      identity_ids = ["/subscriptions/e3d2d88d-b54a-4fb7-b918-3cb24aad9ba9/resourceGroups/XXXXXXXXXXXXXXXXXXXX/providers/Microsoft.ManagedIdentity/userAssignedIdentities/ploceus"]
    }]*/

    /*customer_managed_key = [{
      key_vault_key_id          = "https://ploceustesting.vault.azure.net/keys/ploceustestkey/8b4967f586394edba60644e5506b8467"
      user_assigned_identity_id = "/subscriptions/e3d2d88d-b54a-4fb7-b918-3cb24aad9ba9/resourceGroups/XXXXXXXXXXXXXXXXXXXX/providers/Microsoft.ManagedIdentity/userAssignedIdentities/ploceus"
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

    network_rules = [{
      default_action = "Deny" #default must be Deny.
      bypass         = ["Logging", "Metrics", "AzureServices"]
      ip_rules       = ["40.87.5.111"] # ip rules or virtual_network_subnet_ids must be defines while using network rules
      private_link_access = {
        endpoint_resource_id = "/subscriptions/e3d2d88d-b54a-4fb7-b918-3cb24aad9ba9/resourceGroups/XXXXXXXXXXXXXXXXXXXX/providers/Microsoft.Sql/servers/XXXXXXXXXXXXXXXXXXXX"
        endpoint_tenant_id   = "687f51c3-0c5d-4905-84f8-97c683a5b9d1"
      }
    }]

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
