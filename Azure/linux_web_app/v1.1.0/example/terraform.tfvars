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
#RESOURCE GROUP 
key_vault_resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000002"
    location = "eastus"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#VNET 
vnets_variables = {
  "vnet_1" = {
    name                        = "ploceusvnet000001a"
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
subnet_variables = {
  "subnet_1" = {
    name                                           = "ploceussubnet000001"
    resource_group_name                            = "ploceusrg000001"
    address_prefixes                               = ["10.0.1.0/24"]
    virtual_network_name                           = "ploceusvnet000001a"
    enforce_private_link_service_network_policies  = true
    enforce_private_link_endpoint_network_policies = true
    is_delegetion_required                         = false #update to true if delegation required and update delegation name,service_name,Service_actions
    service_endpoints                              = ["Microsoft.AzureActiveDirectory"]
    delegation_name                                = "delegation000001"
    service_name                                   = "Microsoft.Sql/managedInstances"
    service_actions                                = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
  }
}
#USER ASSIGNED IDENTITY
user_assigned_identity_variables = {
  "uai1" = {
    user_assigned_identity_name                = "Ploceusuai000001a"
    user_assigned_identity_location            = "westus2"
    user_assigned_identity_resource_group_name = "ploceusrg000001"
    user_assigned_identity_tags = {
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
    os_type                          = "Linux"
    maximum_elastic_worker_count     = null
    worker_count                     = null
    app_service_environment_required = false
    app_service_environment_name     = null
    sku_name                         = "F1"
    per_site_scaling_enabled         = false
    zone_balancing_enabled           = false
    app_service_plan_tags = {
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
    key_vault_contact_email                 = "XXXXXXXXXXX@neudesic.com"
    key_vault_contact_name                  = "XXXXXXXXXXX"
    key_vault_contact_phone                 = "99999999999"

  }
}

# Key vault secret
key_vault_secret_variables = {
  "auth_settings_facebook_secret" = {
    key_vault_secret_name                = "ploceusfacebook000001"
    key_vault_secret_value               = "ploceusfacebook000001"
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
  "auth_settings_AD_secret" = {
    key_vault_secret_name                = "ploceusauthsettingad000001"
    key_vault_secret_value               = "ploceusauthsettingad000001"
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
  "auth_settings_github_secret" = {
    key_vault_secret_name                = "ploceusgithub000001"
    key_vault_secret_value               = "ploceusgithub000001"
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
  "auth_settings_google_secret" = {
    key_vault_secret_name                = "ploceusgoogle000001"
    key_vault_secret_value               = "ploceusgoogle000001"
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
  "auth_settings_microsoft_secret" = {
    key_vault_secret_name                = "ploceusmicrosoft000001"
    key_vault_secret_value               = "ploceusmicrosoft000001"
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
  "auth_settings_twitter_secret" = {
    key_vault_secret_name                = "ploceustwitter000001"
    key_vault_secret_value               = "ploceustwitter000001"
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
    name                              = "ploceussa000001"
    resource_group_name               = "ploceusrg000001"
    location                          = "eastus"
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


    network_rules = [{
      default_action      = "Allow" #default must be Deny.
      bypass              = null
      ip_rules            = null # ip rules or virtual_network_subnet_ids must be defines while using network rules
      private_link_access = null
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

#LINUX WEB APP
linux_web_app_variables = {
  "linux_web_app_1" = {
    linux_web_app_name                       = "ploceuslinuxwebapp000001"
    linux_web_app_resource_group_name        = "ploceusrg000001"
    linux_web_app_location                   = "eastus"
    linux_web_app_client_affinity_enabled    = false
    linux_web_app_client_certificate_enabled = false
    linux_web_app_client_certificate_mode    = null
    linux_web_app_enabled                    = false
    linux_web_app_app_settings               = null
    linux_web_app_https_only                 = false
    linux_web_app_app_settings_enabled       = false
    linux_web_app_zip_deploy_file            = null
    linux_web_app_sticky_settings            = null
    linux_web_app_storage_account            = null
    linux_web_app_logs                       = null
    linux_web_app_connection_string          = null
    linux_web_app_backup                     = null
    key_vault_reference_identity_id          = null
    linux_web_app_identity = {
      linux_web_app_identity_type = "SystemAssigned"
      # Other values could be "UserAssigned", "SystemAssigned" 
      # If given as "SystemAssigned" , then give below parameter as null
      linux_web_app_user_assigned_identities = null
      /* [{
        user_identity_name                = "Ploceusuai000001a"
        user_identity_resource_group_name = "ploceusrg000001"
      }] */
    }
    linux_web_app_auth_settings = {
      auth_settings_enabled                        = false
      auth_settings_additional_login_parameters    = null
      auth_settings_allowed_external_redirect_urls = null
      auth_settings_issuer                         = null
      unauthenticated_client_action                = null
      default_auth_provider                        = null
      multiple_auth_providers_configured           = false
      runtime_version                              = null
      token_refresh_extension_errors               = null
      token_store_enabled                          = false
      linux_web_app_ad_secret_required             = false
      auth_settings_active_directory               = null
      /* [{
        auth_settings_active_directory_client_id     = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        allowed_audiences                            = null
        auth_settings_active_directory_client_secret = "ploceusauthsettingad000001"
        linux_web_app_ad_client_secret_setting_name  = "activedirectory settings"
      }] */
      linux_web_app_facebook_secret_required = false
      auth_settings_facebook                 = null
      /* [{
        facebook_app_id                                = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        facebook_oauth_scopes                          = ["xx", "yy"]
        facebook_app_secret                            = "ploceusfacebook000001"
        linux_web_app_facebook_app_secret_setting_name = "facebooksetting"
      }] */
      linux_web_app_github_secret_required = false
      auth_settings_github                 = null
      /* [{
        github_client_id                                = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        github_oauth_scopes                             = ["xx", "yy"]
        github_client_secret                            = "ploceusgithub000001"
        linux_web_app_github_client_secret_setting_name = "githubsetting"
      }] */
      linux_web_app_google_secret_required = false
      auth_settings_google                 = null
      /* [{
        google_client_id                                = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        google_oauth_scopes                             = ["xx", "yy"]
        google_client_secret                            = "ploceusgoogle000001"
        linux_web_app_google_client_secret_setting_name = "googlesettings"
      }] */
      linux_web_app_microsoft_secret_required = false
      auth_settings_microsoft                 = null
      /* [{
        microsoft_client_id                                = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        microsoft_oauth_scopes                             = ["xx", "yy"]
        microsoft_client_secret                            = "ploceusmicrosoft000001"
        linux_web_app_microsoft_client_secret_setting_name = "microsoftsettings"
      }] */
      linux_web_app_twitter_secret_required = false
      auth_settings_twitter                 = null
      /* [{
        twitter_consumer_secret                            = "ploceustwitter000001"
        twitter_consumer_key                               = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        linux_web_app_twitter_consumer_secret_setting_name = "twittersetting"
      }] */
    }
    linux_web_app_site_config = [{
      site_config_always_on                                     = false
      site_config_api_management_config_id                      = null
      site_config_ftps_state                                    = null
      site_config_app_command_line                              = null
      site_config_health_check_path                             = null
      site_config_health_check_eviction_time_in_min             = null
      site_config_http2_enabled                                 = false
      auto_heal_enabled                                         = false
      local_mysql_enabled                                       = true
      websockets_enabled                                        = true
      vnet_route_all_enabled                                    = false
      scm_minimum_tls_version                                   = null
      scm_use_main_ip_restriction                               = null
      site_config_use_32_bit_worker                             = null
      site_config_default_documents                             = null
      site_config_load_balancing_mode                           = null
      site_config_managed_pipeline_mode                         = null
      site_config_minimum_tls_version                           = null
      site_config_remote_debugging                              = false
      site_config_remote_debugging_version                      = null
      site_config_worker_count                                  = null
      site_config_container_registry_managed_identity_client_id = null
      site_config_container_registry_use_managed_identity       = null
      site_config_cors                                          = null
      site_config_ip_restriction                                = null
      site_config_scm_ip_restriction                            = null
      site_config_application_stack                             = null
      site_config_auto_heal_setting = [{
        auto_heal_setting_action = null
        auto_heal_setting_trigger = [{
          trigger_slow_request = null
          trigger_status_code  = null
          trigger_requests     = null
        }]
      }]
    }]
    linux_web_app_subnet_required                = false
    linux_web_app_virtual_network_name           = null
    linux_web_app_subnet_name                    = null
    linux_web_app_subnet_resource_group_name     = null
    key_vault_name                               = "ploceusvault000001"
    key_vault_resource_group_name                = "ploceusrg000002"
    app_service_plan_name                        = "ploceusappplan000001"
    app_service_plan_resource_group_name         = "ploceusrg000001"
    linux_web_app_storage_account_required       = false
    storage_account_name                         = null
    storage_account_resource_group_name          = null
    linux_web_app_storage_account_sas_start_time = null
    linux_web_app_storage_account_sas_end_time   = null
    linux_web_app_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
linux_web_app_subscription_id   = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
linux_web_app_tenant_id         = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
storage_account_subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
storage_account_tenant_id       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
key_vault_subscription_id       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
key_vault_tenant_id             = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
