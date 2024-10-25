#Windows web app resource group 
windows_web_app_resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000001"
    location = "eastus"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#Key Vault resource group 
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

#APP SERVICE PLAN
app_service_plan_variables = {
  "app_service_plan_1" = {
    name                             = "ploceusappplan000001"
    resource_group_name              = "ploceusrg000001"
    location                         = "eastus"
    os_type                          = "Windows"
    maximum_elastic_worker_count     = null
    worker_count                     = null
    app_service_environment_required = false
    app_service_environment_name     = null
    sku_name                         = "S1"
    per_site_scaling_enabled         = false
    zone_balancing_enabled           = false
    app_service_plan_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#USER ASSIGNED IDENTITY
user_assigned_identity_variables = {
  "uai_1" = {
    user_assigned_identity_name                = "ploceusuai000001"
    user_assigned_identity_location            = "eastus"
    user_assigned_identity_resource_group_name = "ploceusrg000001"
    user_assigned_identity_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  },
  "uai_2" = {
    user_assigned_identity_name                = "ploceusuai000002"
    user_assigned_identity_location            = "eastus"
    user_assigned_identity_resource_group_name = "ploceusrg000001"
    user_assigned_identity_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#API Management Variables
api_management_variables = {
  api_1 = {
    api_management_name                                      = "ploceusapim000001"      #(Required) The name of the API Management Service. Changing this forces a new resource to be created.
    api_management_location                                  = "eastus"                 #(Required) The Azure location where the API Management Service exists. Changing this forces a new resource to be created.
    api_management_resource_group_name                       = "ploceusrg000001"        #(Required) The name of the Resource Group in which the API Management Service should be exist. Changing this forces a new resource to be created.
    api_management_publisher_name                            = "ploceus"                #(Required) The name of publisher/company.
    api_management_publisher_email                           = "xxxxxxxxxx@ploceus.com" #(Required) The email of publisher/company.
    api_management_sku_name                                  = "Developer_1"            #(Required) sku_name is a string consisting of two parts separated by an underscore(_). The first part is the name, valid values include: Consumption, Developer, Basic, Standard and Premium. The second part is the capacity (e.g. the number of deployed units of the sku), which must be a positive integer (e.g. Developer_1).
    api_management_additional_location                       = null
    api_management_certificate_key_vault_name                = null #(Optional) Only required if api_management_certificate block is passed. The key vault where Base64 encoded certificate and certificate password is stored
    api_management_certificate_key_vault_resource_group_name = null #(Optional) Only required if api_management_certificate block is passed. The key vault resource group, where Base64 encoded certificate and certificate password is stored
    api_management_certificate                               = null
    api_management_client_certificate_enabled                = null  #(Optional) Enforce a client certificate to be presented on each request to the gateway? This is only supported when SKU type is Consumption.
    api_management_gateway_disabled                          = false #(Optional) Disable the gateway in main region? This is only supported when additional_location is set.
    api_management_min_api_version                           = null  #(Optional) The version which the control plane API calls to API Management service are limited with version equal to or newer than.
    api_management_zones                                     = null  #(Optional) Specifies a list of Availability Zones in which this API Management service should be located. Changing this forces a new API Management service to be created.
    api_management_identity = {
      identity_type                     = "SystemAssigned"
      identity_user_assigned_identities = null /* [{                   #(Optional) A list of User Assigned Managed Identity IDs to be assigned to this API Management Service. This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
        user_identity_name                = "ploceusuai000001" #user assigned identity name Required if identity type ="systemassigned" or "systemassigned,userassigned"
        user_identity_resource_group_name = "ploceusrg000001"  #resource group name of the user identity
      }] */
    }
    api_management_hostname_configuration    = null #(Optional) A hostname_configuration block as defined below.
    api_management_notification_sender_email = null #(Optional) Email address from which the notification will be sent.
    api_management_policy                    = null
    api_management_protocols                 = null
    api_management_security                  = null
    api_management_sign_in                   = null
    api_management_sign_up                   = null
    api_management_tenant_access = { #(Optional) A tenant_access block as defined below.
      tenant_access_enabled = true   #(Required) Should the access to the management API be enabled?
    }
    api_management_public_ip_address_name                = null #(Optional) name of a standard SKU IPv4 Public IP.
    api_management_public_ip_address_resource_group_name = null #(Optional) resource group of a standard SKU IPv4 Public IP.
    api_management_public_network_access_enabled         = null #(Optional) Is public access to the service allowed?. Defaults to true
    api_management_virtual_network_type                  = null #(Optional) The type of virtual network you want to use, valid values include: None, External, Internal. virtual_network_type is Internal or External. And please ensure other necessary ports are open according to api management network configuration.
    api_management_virtual_network_configuration         = null /* {                                   #(Optional) A virtual_network_configuration block as defined below. Required when api_management_virtual_network_type is External or Internal.
      virtual_network_configuration_subnet_name                = "ploceussubnet000001" #(Required) The id of the subnet that will be used for the API Management.
      virtual_network_configuration_virtual_network_name       = "ploceusvnet000001"   #(Required) The id of the subnet that will be used for the API Management.
      virtual_network_configuration_subnet_resource_group_name = "ploceusrg000001"     #(Required) The id of the subnet that will be used for the API Management.
    } */
    api_management_tags = { #(Optional) A mapping of tags assigned to the resource.
      Created_By = "Ploceus"
      Department = "CIS"
    }
  }
}

#API MANAGEMENT API
api_management_api_variables = {
  "api_management_api_1" = {
    api_management_api_name                  = "ploceusapimapi000001"                                  #(Required) The name of the API Management API. Changing this forces a new resource to be created.
    api_management_api_resource_group_name   = "ploceusrg000001"                                       #(Required) The Name of the Resource Group where the API Management API exists. Changing this forces a new resource to be created.
    api_management_api_api_management_name   = "ploceusapim000001"                                     #(Required) The Name of the API Management Service where this API should be created. Changing this forces a new resource to be created.
    api_management_api_revision              = "1"                                                     #(Required) The Revision which used for this API.
    api_management_api_revision_description  = null                                                    #(Optional) The description of the API Revision of the API Management API.
    api_management_api_display_name          = "Ploceus API"                                           #(Optional) The display name of the API.
    api_management_api_description           = "API mangegment API resource to handle HTML tag"        #(Optional) A description of the API Management API, which may include HTML formatting tags.
    api_management_api_path                  = "ploceus"                                               #(Optional) The Path for this API Management API, which is a relative URL which uniquely identifies this API and all of its resource paths within the API Management Service.
    api_management_api_service_url           = null                                                    #(Optional) Absolute URL of the backend service implementing this API.
    api_management_api_protocols             = ["https"]                                               #(Optional) A list of protocols the operations in this API can be invoked. Possible values are http and https.
    api_management_api_soap_pass_through     = null                                                    #(Optional) Should this API expose a SOAP frontend, rather than a HTTP frontend? Defaults to false.
    api_management_api_subscription_required = false                                                   #(Optional) Should this API require a subscription key?
    api_management_api_version               = null                                                    #(Optional) The Version number of this API, if this API is versioned.
    api_management_api_version_set_id        = null                                                    #(Optional) The ID of the Version Set which this API is associated with.
    api_management_api_version_description   = null                                                    #(Optional) The description of the API Version of the API Management API.
    api_management_api_source_api_id         = null                                                    #(Optional) The API id of the source API, which could be in format azurerm_api_management_api.example.id or in format azurerm_api_management_api.example.id;rev=1
    api_management_api_import = {                                                                      #(Optional) A import block as documented below.
      api_management_api_import_content_format = "swagger-link-json"                                   #(Required) The format of the content from which the API Definition should be imported. Possible values are: openapi, openapi+json, openapi+json-link, openapi-link, swagger-json, swagger-link-json, wadl-link-json, wadl-xml, wsdl and wsdl-link.
      api_management_api_import_content_value  = "http://conferenceapi.azurewebsites.net/?format=json" #(Required) The Content from which the API Definition should be imported. When a content_format of *-link-* is specified this must be a URL, otherwise this must be defined inline.
      api_management_api_import_wsdl_selector = {                                                      #(Optional) A wsdl_selector block as defined below, which allows you to limit the import of a WSDL to only a subset of the document. This can only be specified when content_format is wsdl or wsdl-link.
        import_wsdl_selector_service_name  = "sql"                                                     #(Required) The name of service to import from WSDL.
        import_wsdl_selector_endpoint_name = "http://conferenceapi.azurewebsites.net/?format=json"     #(Required) The name of endpoint (port) to import from WSDL.
      }
    }
    api_management_api_oauth2_authorization  = null               #(Optional) An oauth2_authorization block as documented below.
    api_management_api_openid_authentication = null               #(Optional) An openid_authentication block as documented below.
    api_management_api_subscription_key_parameter_names = {       #(Optional) A subscription_key_parameter_names block
      subscription_key_parameter_names_header = "ploceusapi-id"   #(Required) The name of the HTTP Header which should be used for the Subscription Key.
      subscription_key_parameter_names_query  = "ploceusapiquery" #(Required) The name of the QueryString parameter which should be used for the Subscription Key.
    }
  }

}

#KEY VAULT
key_vault_variables = {
  "key_vault_1" = {
    key_vault_name                                  = "ploceuskeyvault000001"
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
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge", "Set"]
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
        subscription_id         = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"
        virtual_network_rg_name = "ploceusrg000001"
      }
    ]
    key_vault_network_acls_bypass         = "AzureServices"
    key_vault_network_acls_default_action = "Deny"
    key_vault_network_acls_ip_rules       = ["0.0.0.0/16"]
    key_vault_contact_information_enabled = false
    key_vault_contact_email               = null
    key_vault_contact_name                = null
    key_vault_contact_phone               = null

  }
}


#KEY VAULT SECRET
key_vault_secret_variables = {
  "key_1" = {
    key_vault_name                       = "ploceuskeyvault000001"
    key_vault_secret_value               = "authsettingad000001"
    key_vault_secret_content_type        = ""
    key_vault_secret_not_before_date     = ""
    key_vault_secret_expiration_date     = ""
    key_vault_secret_resource_group_name = "ploceusrg000002"
    key_vault_secret_name                = "ploceuskvsecretad000001"
    key_vault_secret_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_secret_min_upper   = 10
    key_vault_secret_min_lower   = 5
    key_vault_secret_min_numeric = 5
    key_vault_secret_min_special = 3
    key_vault_secret_length      = 32
  },
  "key_2" = {
    key_vault_name                       = "ploceuskeyvault000001"
    key_vault_secret_value               = "constringmysql0001"
    key_vault_secret_content_type        = ""
    key_vault_secret_not_before_date     = ""
    key_vault_secret_expiration_date     = ""
    key_vault_secret_resource_group_name = "ploceusrg000002"
    key_vault_secret_name                = "ploceuskvsecretmysql000001"
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

#KEY VAULT KEY
key_vault_key_variables = {
  "key_vault_key_1" = {
    name                = "ploceuskeyavaultkey000001"
    resource_group_name = "ploceusrg000002"
    key_vault_name      = "ploceuskeyvault000001"
    key_type            = "RSA"
    key_size            = 2048
    curve               = null
    key_opts            = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
    not_before_date     = null
    expiration_date     = null
    key_vault_key_tags = {
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
    infrastructure_encryption_enabled = false #This can only be true when account_kind is StorageV2 or when account_tier is Premium and account_kind is BlockBlobStorage.
    custom_domain                     = null
    routing                           = null
    azure_files_authentication        = null
    identity                          = null
    customer_managed_key              = null
    network_rules                     = null
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
    queue_properties = null
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
    static_website = null
    storage_account_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  },
  "storage_account_2" = {
    name                              = "ploceussa000002"
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
    infrastructure_encryption_enabled = false #This can only be true when account_kind is StorageV2 or when account_tier is Premium and account_kind is BlockBlobStorage.
    custom_domain                     = null
    routing                           = null
    azure_files_authentication        = null
    identity                          = null
    customer_managed_key              = null
    network_rules                     = null
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
    queue_properties = null
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
    static_website = null
    storage_account_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#STORAGE CONTAINER
storage_container_variables = {
  "storage_container_1" = {
    name                  = "ploceussc000001"
    storage_account_name  = "ploceussa000001"
    container_access_type = "container"
    metadata              = null
  }
}

#VNET 
vnets_variables = {
  "vnet_1" = {
    name                        = "ploceusvnet000001"
    location                    = "eastus"
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

#Subnets
subnet_variables = {
  "subnet_1" = {
    name                                           = "ploceussubnet000001"
    resource_group_name                            = "ploceusrg000001"
    address_prefixes                               = ["10.0.1.0/24"]
    virtual_network_name                           = "ploceusvnet000001"
    enforce_private_link_service_network_policies  = true
    enforce_private_link_endpoint_network_policies = true
    is_delegetion_required                         = true #update to true if delegation required and update delegation name,service_name,Service_actions
    service_endpoints                              = ["Microsoft.AzureActiveDirectory", "Microsoft.ContainerRegistry"]
    delegation_name                                = "delegation000001"
    service_name                                   = "Microsoft.Sql/managedInstances"
    service_actions                                = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
  },
  "subnet_2" = {
    name                                           = "ploceussubnet000002"
    resource_group_name                            = "ploceusrg000001"
    address_prefixes                               = ["10.0.2.0/24"]
    virtual_network_name                           = "ploceusvnet000001"
    enforce_private_link_service_network_policies  = true
    enforce_private_link_endpoint_network_policies = true
    is_delegetion_required                         = true #update to true if delegation required and update delegation name,service_name,Service_actions
    service_endpoints                              = ["Microsoft.AzureActiveDirectory", "Microsoft.ContainerRegistry"]
    delegation_name                                = "delegation000002"
    service_name                                   = "Microsoft.Sql/managedInstances"
    service_actions                                = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
  }
}

#CONTAINER REGISTRY
container_registry_variables = {
  "container_registry_1" = {
    container_registry_name                                     = "ploceusacr000001"
    container_registry_location                                 = "eastus"
    container_registry_resource_group_name                      = "ploceusrg000001"
    container_registry_sku                                      = "Premium"
    container_registry_admin_enabled                            = true
    container_registry_export_policy_enabled                    = true      #In order to set it to false, make sure the public_network_access_enabled is also set to false.
    container_registry_georeplication_enabled                   = false     #Only works for Premium sku
    container_registry_georeplication_location                  = "EastUS2" #Only works for Premium sku
    container_registry_georeplication_zone_redundancy_enabled   = true      #Only works for Premium sku
    container_registry_georeplication_regional_endpoint_enabled = true      #Only works for Premium sku
    container_registry_public_network_access_enabled            = true
    container_registry_quarantine_policy_enabled                = false
    container_registry_zone_redundancy_enabled                  = false #Only works for Premium sku 
    container_registry_regional_endpoint_enabled                = false
    container_registry_anonymous_pull_enabled                   = false #Only works with Standard and Premium SKU
    container_registry_retention_policy = {
      policy_enabled = false #Only works for Premium sku 
      policy_days    = 2     #Only works for Premium sku 
    }
    container_registry_trust_policy = {
      enabled = false #Only works for Premium sku 
    }
    container_registry_data_endpoint_enabled      = false           #Only works for Premium SKU
    container_registry_network_rule_bypass_option = "AzureServices" # Default is AzureServices, other possible value is None 
    is_container_registry_encryption_required     = false
    container_registry_encryption = {
      container_registry_encryption_enabled                      = false
      container_registry_encryption_keyvault_name                = "ploceuskeyvault000001"
      container_registry_encryption_keyvault_key_name            = "ploceuskeyavaultkey000001"
      container_registry_encryption_keyvault_resource_group_name = "ploceusrg000002"
      identity_name                                              = "ploceusuai000001"
      identity_resource_group_name                               = "ploceusrg000001"
    }
    is_container_registry_identity_required = true
    container_registry_identity = {
      identity_type = "SystemAssigned, UserAssigned"
      # Other values could be "UserAssigned", "SystemAssigned" 
      # If given as "SystemAssigned" , then give below parameter as null
      user_assigned_identities = [{
        identity_name                = "ploceusuai000001"
        identity_resource_group_name = "ploceusrg000001"
        }
      ]
    }
    container_registry_network_rule_set_enabled = false # Only works with Premium SKU
    container_registry_network_rule_set = {
      default_action          = "Allow"
      ip_rule_enabled         = true
      ip_rule_action          = "Allow"
      ip_rule_range           = "100.0.0.0/24"
      virtual_network_enabled = true
      virtual_network = [{
        action                     = "Allow"
        subnet_name                = "ploceussubnet000001"
        virtual_network_name       = "ploceusvnet000001"
        subnet_resource_group_name = "ploceusrg000001"
      }]
    }
    container_registry_network_rule_default_action                  = "Allow"
    container_registry_network_rule_set_ip_rule_enabled             = false
    container_registry_network_rule_set_ip_rule_action              = "Allow"
    container_registry_network_rule_set_ip_rule_range               = "10.0.0.1/16"
    container_registry_network_rule_set_virtual_network_enabled     = false
    container_registry_network_rule_set_virtual_network_rule_action = "Allow"
    container_registry_container_registry_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
    container_registry_georeplication_zone_tags = {
      Created_By = "Ploceus"
      Department = "CIS"
    }
  }
}

#WINDOWS WEB APP
windows_web_app_variables = {
  "windows_web_app_1" = {
    windows_web_app_service_plan_name                = "ploceusappplan000001" #(Required) The name of the Service Plan that this Windows App Service will be created in.
    windows_web_app_service_plan_resource_group_name = "ploceusrg000001"      #(Required) The resource group name of the Service Plan that this Windows App Service will be created in.

    windows_web_app_key_vault_user_assigned_identity_enabled             = true                    #(Optional) Should user assigned identity for key_vault be enabled to access key_vault secrets. This identity must also be present in windows_web_app_identity block.
    windows_web_app_key_vault_user_assigned_identity_name                = "ploceusuai000001"      #(Optional) The key_vault User Assigned Identity name used for accessing KeyVault secrets. The identity must be assigned to the application in the identity block.
    windows_web_app_key_vault_user_assigned_identity_resource_group_name = "ploceusrg000001"       #(Optional) The key_vault User Assigned Identity resource group name used for accessing KeyVault secrets. The identity must be assigned to the application in the identity block.
    windows_web_app_key_vault_name                                       = "ploceuskeyvault000001" #(Optional) The key vault name.
    windows_web_app_key_vault_resource_group_name                        = "ploceusrg000002"       #(Optional) The key vault resource group name.

    windows_web_app_storage_container_name = "ploceussc000001" #(Optional) The name of storage container required for blob container sas url.
    storage_account = [{
      storage_account_name                = "ploceussa000001" #(Optional) The backend storage account name which will be used by this Function App.
      storage_account_resource_group_name = "ploceusrg000001" #(Optional) The backend storage account resource group name which will be used by this Function App.
      },
      {
        storage_account_name                = "ploceussa000002" #(Optional) The backend storage account name which will be used by this Function App.
        storage_account_resource_group_name = "ploceusrg000001" #(Optional) The backend storage account resource group name which will be used by this Function App.
    }]

    windows_web_app_api_management_api_name            = "ploceusapimapi000001" #(Optional) The name of the API Management API.
    windows_web_app_api_management_name                = "ploceusapim000001"    #(Optional) The name of the API Management Service in which the API Management API exists.
    windows_web_app_api_management_resource_group_name = "ploceusrg000001"      #(Optional) The Name of the Resource Group in which the API Management Service exists.
    windows_web_app_api_management_api_revision        = "1"                    #(Optional) The Revision of the API Management API.

    windows_web_app_container_registry_name                = "ploceusacr000001" #(Optional) This is required if in site_config block site_config_container_registry_use_managed_identity is set to true.
    windows_web_app_container_registry_resource_group_name = "ploceusrg000001"  #(Optional) This is required if in site_config block site_config_container_registry_use_managed_identity is set to true.

    windows_web_app_ip_restriction_subnet_name                         = "ploceussubnet000001" #(Optional) This value is required if in windows_web_app_site config in ip_restriction_block , the value for "ip_restriction_virtual_network_subnet_id_enabled" is set to true.
    windows_web_app_ip_restriction_virtual_network_name                = "ploceusvnet000001"   #(Optional) This value is required if in windows_web_app_site config in ip_restriction_block , the value for "ip_restriction_virtual_network_subnet_id_enabled" is set to true.
    windows_web_app_ip_restriction_virtual_network_resource_group_name = "ploceusrg000001"     #(Optional) This value is required if in windows_web_app_site config in ip_restriction_block , the value for "ip_restriction_virtual_network_subnet_id_enabled" is set to true.

    windows_web_app_scm_ip_restriction_subnet_name                         = "ploceussubnet000002" #(Optional) This value is required if in windows_web_app_site config in scm_ip_restriction_block , the value for "scm_ip_restriction_virtual_network_subnet_id_enabled" is set to true.
    windows_web_app_scm_ip_restriction_virtual_network_name                = "ploceusvnet000001"   #(Optional) This value is required if in windows_web_app_site config in scm_ip_restriction_block , the value for "scm_ip_restriction_virtual_network_subnet_id_enabled" is set to true.
    windows_web_app_scm_ip_restriction_virtual_network_resource_group_name = "ploceusrg000001"     #(Optional) This value is required if in windows_web_app_site config in scm_ip_restriction_block , the value for "scm_ip_restriction_virtual_network_subnet_id_enabled" is set to true.

    windows_web_app_name                       = "ploceuswinwbap000001" #(Required) The name which should be used for this Windows Web App.
    windows_web_app_location                   = "eastus"               #(Required) The Azure Region where the Windows Web App should exist.
    windows_web_app_resource_group_name        = "ploceusrg000001"      #(Required) The name of the Resource Group where the Windows Web App should exist.
    windows_web_app_client_affinity_enabled    = false                  #(Optional) Should Client Affinity be enabled?
    windows_web_app_client_certificate_enabled = false                  #(Optional) Should Client Certificates be enabled?
    windows_web_app_client_certificate_mode    = "Required"             #(Optional) The Client Certificate mode. Possible values include Optional and Required. This property has no effect when client_cert_enabled is false.
    windows_web_app_enabled                    = true                   #(Optional) Should the Windows Web App be enabled? Defaults to true.
    windows_web_app_https_only                 = true                   #(Optional) Should the Windows Web App require HTTPS connections.
    windows_web_app_zip_deploy_file            = null                   #(Optional) The local path and filename of the Zip packaged application to deploy to this Windows Web App.

    windows_web_app_app_settings = null # (Optional) A map of key-value pairs of App Settings. The values to include can be found as per requirement here -> https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet 

    windows_web_app_auth_settings_enabled = false                              #(Optional) Should windows_web_app auth settings be enabled .
    windows_web_app_auth_settings = {                                          #(Optional) A auth_settings block as defined below.
      auth_settings_enabled                           = false                  #(Required) Should the Authentication / Authorization feature be enabled for the windows Web App?
      auth_settings_additional_login_parameters       = null                   #(Optional) Specifies a map of login Parameters to send to the OpenID Connect authorization endpoint when a user logs in.
      auth_settings_allowed_external_redirect_urls    = null                   #(Optional) Specifies a list of External URLs that can be redirected to as part of logging in or logging out of the windows Web App.
      auth_settings_configure_multiple_auth_providers = false                  #(Optional) Should Multiple Authentication providers be configured ?
      auth_settings_default_provider                  = "AzureActiveDirectory" #(Optional) The default authentication provider to use when multiple providers are configured. Possible values include: AzureActiveDirectory, Facebook, Google, MicrosoftAccount, Twitter, Github
      auth_settings_runtime_version                   = null                   #(Optional) The RuntimeVersion of the Authentication / Authorization feature in use for the windows Web App.
      auth_settings_token_refresh_extension_hours     = 72                     #(Optional) The number of hours after session token expiration that a session token can be used to call the token refresh API. Defaults to 72 hours.
      auth_settings_token_store_enabled               = false                  #Optional) Should the windows Web App durably store platform-specific security tokens that are obtained during login flows? Defaults to false.
      auth_settings_unauthenticated_client_action     = "AllowAnonymous"       #(Optional) The action to take when an unauthenticated client attempts to access the app. Possible values include: RedirectToLoginPage, AllowAnonymous.
      auth_settings_issuer                            = null                   #(Optional) The OpenID Connect Issuer URI that represents the entity which issues access tokens for this windows Web App.

      auth_settings_active_directory = {
        active_directory_enabled                             = true                      #(Required) should active directory authentication be enabled ?
        active_directory_client_id                           = "xxxxxxxxxxxxxxxxxxxx"    #(Required) The ID of the Client to use to authenticate with Azure Active Directory.
        active_directory_client_secret_key_vault_secret_name = "ploceuskvsecretad000001" #(Optional) The Key vault Secret key name for active directory authentication. 
        active_directory_client_secret_setting_name          = null                      #(Optional) The App Setting name that contains the client secret of the Client. Cannot be used with client_secret.
        active_directory_allowed_audiences                   = ["xxxx", "yyyyy"]         #(Optional) Specifies a list of Allowed audience values to consider when validating JWTs issued by Azure Active Directory.
      }
      auth_settings_facebook = {
        facebook_enabled                          = false #(Required) should facebook authentication be enabled ?
        facebook_app_id                           = null  #(Required) The App ID of the Facebook app used for login.
        facebook_app_secret_key_vault_secret_name = null  #(Optional) The Key vault Secret key name for facebook authentication.
        facebook_app_secret_setting_name          = null  #(Optional) The app setting name that contains the app_secret value used for Facebook login. Cannot be specified with app_secret.
        facebook_oauth_scopes                     = null  #(Optional) Specifies a list of OAuth 2.0 scopes to be requested as part of Facebook login authentication.
      }
      auth_settings_github = {
        github_enabled                             = false #(Required) should github authentication be enabled ?
        github_client_id                           = null  # (Required) The ID of the GitHub app used for login.
        github_client_secret_key_vault_secret_name = null  #(Optional) The Key vault Secret key name for facebook authentication.
        github_client_secret_setting_name          = null  #(Optional) The app setting name that contains the client_secret value used for GitHub login. Cannot be specified with client_secret.
        github_oauth_scopes                        = null  #(Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of GitHub login authentication.
      }
      auth_settings_google = {
        google_enabled                             = false #(Required) should google authentication be enabled ?
        google_client_id                           = null  # (Required) The ID of the google app used for login.
        google_client_secret_key_vault_secret_name = null  #(Optional) The Key vault Secret key name for facebook authentication.
        google_client_secret_setting_name          = null  #(Optional) The app setting name that contains the client_secret value used for google login. Cannot be specified with client_secret.
        google_oauth_scopes                        = null  #(Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of Google Sign-In authentication. If not specified, openid, profile, and email are used as default scopes.
      }
      auth_settings_microsoft = {
        microsoft_enabled                             = false #(Required) should google authentication be enabled ?
        microsoft_client_id                           = null  # (Required) The ID of the microsoft app used for login.
        microsoft_client_secret_key_vault_secret_name = null  #(Optional) The Key vault Secret key name for facebook authentication.
        microsoft_client_secret_setting_name          = null  #(Optional) The app setting name that contains the client_secret value used for microsoft login. Cannot be specified with client_secret.
        microsoft_oauth_scopes                        = null  #(Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of Microsoft Account authentication. If not specified, wl.basic is used as the default scope.
      }
      auth_settings_twitter = {
        twitter_enabled                               = false #(Required) should twitter authentication be enabled ?
        twitter_consumer_key_key_vault_secret_name    = null  #(Required) The OAuth 1.0a consumer key of the Twitter application used for sign-in.
        twitter_consumer_secret_key_vault_secret_name = null  #(Optional) The Key vault Secret key name for twitter authentication.
        twitter_consumer_secret_setting_name          = null  #(Optional) The app setting name that contains the OAuth 1.0a consumer secret of the Twitter application used for sign-in. Cannot be specified with consumer_secret.
      }
    }

    windows_web_app_backup_enabled = true  #(Optional) should backup be enabled for windows_web_app.
    windows_web_app_backup = {             #(Optional) A backup block as defined below.
      backup_enabled = true                #(Optional) Should this backup job be enabled?
      backup_name    = "winwebapbackup001" #(Required) The name which should be used for this Backup.
      backup_schedule = {
        backup_schedule_frequency_interval       = 7                      #(Required) How often the backup should be executed (e.g. for weekly backup, this should be set to 7 and frequency_unit should be set to Day).
        backup_schedule_frequency_unit           = "Day"                  #(Required) The unit of time for how often the backup should take place. Possible values include: Day and Hour.
        backup_schedule_keep_at_least_one_backup = false                  #(Optional) Should the service keep at least one backup, regardless of age of backup. Defaults to false.
        backup_schedule_retention_period_days    = 30                     #(Optional) After how many days backups should be deleted.
        backup_schedule_start_time               = "2023-01-01T02:07:14Z" #(Optional) When the schedule should start working in RFC-3339 format.
      }
    }

    windows_web_app_connection_string = { #(Optional) One or more connection_string blocks as defined below.
      "connection_string_01" = {
        connection_string_name                        = "mysqlconnectionstring"      #(Required) The name which should be used for this Connection.
        connection_string_type                        = "MySql"                      #(Required) Type of database. Possible values include: MySQL, SQLServer, SQLAzure, Custom, NotificationHub, ServiceBus, EventHub, APIHub, DocDb, RedisCache, and PostgreSQL.
        connection_string_value_key_vault_secret_name = "ploceuskvsecretmysql000001" #(Required) The Key vault secret name containing value for each connection string type.
      }

    }

    windows_web_app_identity = {                          #(Optional) A identity block as defined below.
      windows_web_app_identity_type = "UserAssigned"      #(Required) Possible values could be "UserAssigned", "SystemAssigned", "SystemAssigned, UserAssigned"
      windows_web_app_user_assigned_identity_ids = [{     #(Optional) This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
        identity_name                = "ploceusuai000001" #(Required) The user assigned identity name.
        identity_resource_group_name = "ploceusrg000001"  #(Required) The user assigned identity resource group name.
        },
        {                                                   #(Optional) This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
          identity_name                = "ploceusuai000002" #(Required) The user assigned identity name.
          identity_resource_group_name = "ploceusrg000001"  #(Required) The user assigned identity resource group name.
      }]
    }

    windows_web_app_logs = {              #(Optional) A logs block as defined below.
      logs_detailed_error_messages = true #(Optional) Should detailed error messages be enabled.
      logs_failed_request_tracing  = true #(Optional) Should tracing be enabled for failed requests.

      application_logs = {                               #(Optional) A application_logs block as defined below.
        application_logs_file_system_level = "Verbose"   #(Required) Log level. Possible values include: Verbose, Information, Warning, and Error.
        application_logs_azure_blob_storage = {          #(Optional) A azure_blob_storage block as defined below.
          azure_blob_storage_level             = "Error" #(Required) The level at which to log. Possible values include Error, Warning, Information, Verbose and Off. NOTE: this field is not available for http_logs.
          azure_blob_storage_retention_in_days = 0       #(Required) The time in days after which to remove blobs. A value of 0 means no retention.
        }
      }

      http_logs = null /* {                                #(Optional) A http_logs block as defined below.
        http_logs_azure_blob_storage = {           # (Optional) A azure_blob_storage block as defined below.
          azure_blob_storage_retention_in_days = 0 #(Required) The time in days after which to remove blobs. A value of 0 means no retention.
        }
        http_logs_file_system = {             #(Optional) A file_system block as defined below.
          file_system_retention_in_days = 0   #(Required) The retention period in days. A values of 0 means no retention.
          file_system_retention_in_mb   = 500 #(Required) The maximum size in megabytes that log files can use.
        }
      } */
    }

    windows_web_app_sticky_settings = {                 #(Optional) A sticky_settings block as defined below.
      sticky_app_setting_names       = ["xxxx", "yyyy"] #(Optional) A list of app_setting names that the windows_web_app will not swap between Slots when a swap operation is triggered.
      sticky_connection_string_names = ["xxxx", "yyyy"] #(Optional) A list of connection_string names that the windows_web_app will not swap between Slots when a swap operation is triggered.
    }

    windows_web_app_storage_account = { #(Optional) One or more storage_account blocks as defined below
      "storage_account_01" = {
        storage_account_name       = "ploceussa000001" #(Required) The name which should be used for this Storage Account.
        storage_account_name       = "ploceussa000001" #(Required) The name which should be used for this TODO.
        storage_account_share_name = "wwashare0001"    #(Required) The Name of the File Share or Container Name for Blob storage.
        storage_account_type       = "AzureFiles"      #(Required) The Azure Storage Type. Possible values include AzureFiles and AzureBlob.
        storage_account_mount_path = null              #(Optional) The path at which to mount the storage share.
      },
      "storage_account_02" = {
        storage_account_name       = "ploceussa000002" #(Required) The name which should be used for this Storage Account.
        storage_account_name       = "ploceussa000002" #(Required) The name which should be used for this TODO.
        storage_account_share_name = "wwashare0002"    #(Required) The Name of the File Share or Container Name for Blob storage.
        storage_account_type       = "AzureFiles"      #(Required) The Azure Storage Type. Possible values include AzureFiles and AzureBlob.
        storage_account_mount_path = null              #(Optional) The path at which to mount the storage share.
      }
    }

    windows_web_app_site_config = {                                                               #(Required) A site_config block as defined below.
      site_config_always_on                                                = true                 #(Optional) If this Windows Web App is Always On enabled. Defaults to true.
      site_config_api_management_enabled                                   = true                 ##(Optional) Should API Management be enabled for this Windows web App.
      site_config_app_command_line                                         = null                 #(Optional) The App command line to launch.
      site_config_auto_heal_enabled                                        = null                 #(Optional) Should Auto heal rules be enabled. Required with auto_heal_setting.
      site_config_container_registry_managed_idenitity_name                = "ploceusuai000002"   #(Optional) The User assigned Managed Service Identity name to use for connections to the Azure Container Registry.
      site_config_container_registry_managed_idenitity_resource_group_name = "ploceusrg000001"    #(Optional) The User assigned Managed Service Identity resource group name to use for connections to the Azure Container Registry.
      site_config_container_registry_use_managed_identity                  = true                 #(Optional) Should connections for Azure Container Registry use Managed Identity.
      site_config_default_documents                                        = null                 #(Optional) Specifies a list of Default Documents for the Windows Web App.
      site_config_ftps_state                                               = "Disabled"           #(Optional) The State of FTP / FTPS service. Possible values include: AllAllowed, FtpsOnly, Disabled.
      site_config_health_check_path                                        = null                 #(Optional) The path to the Health Check.
      site_config_health_check_eviction_time_in_min                        = 2                    #(Optional) The amount of time in minutes that a node can be unhealthy before being removed from the load balancer. Possible values are between 2 and 10. Only valid in conjunction with health_check_path.
      site_config_http2_enabled                                            = false                #(Optional) Should the HTTP2 be enabled?
      site_config_load_balancing_mode                                      = "WeightedRoundRobin" #(Optional) The Site load balancing. Possible values include: WeightedRoundRobin, LeastRequests, LeastResponseTime, WeightedTotalTraffic, RequestHash, PerSiteRoundRobin. Defaults to LeastRequests if omitted.
      site_config_local_mysql_enabled                                      = false                #(Optional) Use Local MySQL. Defaults to false.
      site_config_managed_pipeline_mode                                    = "Integrated"         #(Optional) Managed pipeline mode. Possible values include: Integrated, Classic.
      site_config_minimum_tls_version                                      = "1.2"                #(Optional) The configures the minimum version of TLS required for SSL requests. Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
      site_config_remote_debugging_enabled                                 = false                #(Optional) Should Remote Debugging be enabled. Defaults to false.
      site_config_remote_debugging_version                                 = "VS2019"             #(Optional) The Remote Debugging Version. Possible values include VS2017 and VS2019
      site_config_scm_minimum_tls_version                                  = "1.2"                #(Optional) The configures the minimum version of TLS required for SSL requests to the SCM site Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
      site_config_scm_use_main_ip_restriction                              = false                #(Optional) Should the Windows Web App ip_restriction configuration be used for the SCM also.
      site_config_use_32_bit_worker                                        = true                 #(Optional) Should the Windows Web App use a 32-bit worker.
      site_config_websockets_enabled                                       = false                #(Optional) Should Web Sockets be enabled. Defaults to false.
      site_config_worker_count                                             = null                 #(Optional) The number of Workers for this Windows App Service.

      site_config_application_stack = {                        #(Optional) A application_stack block as defined below.
        application_stack_current_stack             = "dotnet" #(Optional) The Application Stack for the Windows Web App. Possible values include dotnet, dotnetcore, node, python, php, and java.
        application_stack_docker_container_name     = null     #(Optional) The name of the Docker Container. For example azure-app-service/samples/aspnethelloworld
        application_stack_docker_container_registry = null     #(Optional) The registry Host on which the specified Docker Container can be located. For example mcr.microsoft.com
        application_stack_docker_container_tag      = null     #(Optional) The Image Tag of the specified Docker Container to use. For example latest
        application_stack_dotnet_version            = "v3.0"   #(Optional) The version of .NET to use when current_stack is set to dotnet. Possible values include v3.0, v4.0, v5.0, and v6.0.
        application_stack_java_container            = null     #(Optional) The Java container type to use when current_stack is set to java. Possible values include JAVA, JETTY, and TOMCAT. Required with java_version and java_container_version.
        application_stack_java_container_version    = null     #(Optional) The Version of the java_container to use. Required with java_version and java_container.
        application_stack_java_version              = null     #(Optional) The version of Java to use when current_stack is set to java. Possible values include 1.7, 1.8 and 11. Required with java_container and java_container_version.
        application_stack_node_version              = null     #(Optional) The version of node to use when current_stack is set to node. Possible values include 12-LTS, 14-LTS, and 16-LTS.
        application_stack_php_version               = null     #(Optional) The version of PHP to use when current_stack is set to php. Possible values include v7.4.
        application_stack_python_version            = null     #(Optional) The version of Python to use when current_stack is set to python. Possible values include 2.7 and 3.4.0.
      }

      site_config_auto_heal_setting = null ## NOTE:- when site_config_auto_heal_enabled = true , then this block is REQUIRED , but when "site_config_auto_heal_enabled" is null then this block has to be null. This is a package deal.
      # site_config_auto_heal_setting = {               # (Optional) A auto_heal_setting block as defined below. Required with auto_heal.
      #   auto_heal_setting_action = {                  #(Required) An action block as defined below.
      #     action_type                    = "LogEvent" # (Required) Predefined action to be taken to an Auto Heal trigger. Possible values include: Recycle, LogEvent, and CustomAction.
      #     minimum_process_execution_time = "10:11:12" #(Optional) The minimum amount of time in hh:mm:ss the Windows Web App must have been running before the defined action will be run in the event of a trigger.
      #     custom_action                  = null /* {                #(Optional) A custom_action block as defined below.
      #       custom_action_executable = null     #(Required) The executable to run for the custom_action.
      #       custom_action_parameters = null     #(Optional) The parameters to pass to the specified executable.
      #     } */
      #   }

      #   auto_heal_setting_trigger = {        #(Required) A trigger block as defined below.
      #     trigger_private_memory_kb = 102400 #(Optional) The amount of Private Memory to be consumed for this rule to trigger. Possible values are between 102400 and 13631488.

      #     trigger_requests = {             # (Optional) A requests block as defined below.
      #       requests_count    = 5          #(Required) The number of requests in the specified interval to trigger this rule.
      #       requests_interval = "10:11:12" #(Required) The interval in hh:mm:ss.
      #     }

      #     trigger_slow_request = { #(Optional) One or more slow_request blocks as defined below.
      #       "slow_request_01" = {
      #         slow_request_count      = 5          #(Required) The number of Slow Requests in the time interval to trigger this rule.
      #         slow_request_interval   = "10:11:12" #(Required) The time interval in the form hh:mm:ss.
      #         slow_request_time_taken = "10:12:14" #(Required) The threshold of time passed to qualify as a Slow Request in hh:mm:ss.
      #         slow_request_path       = null       #(Optional) The path for which this slow request rule applies.
      #       }
      #     }

      #     trigger_status_code = { #(Optional) One or more status_code blocks as defined above.
      #       "status_code_01" = {
      #         status_code_count        = 5          #(Required) The number of occurrences of the defined status_code in the specified interval on which to trigger this rule.
      #         status_code_interval     = "10:11:12" #(Required) The time interval in the form hh:mm:ss.
      #         status_code_range        = "598"      #(Required) The status code for this rule, accepts single status codes and status code ranges. e.g. 500 or 400-499. Possible values are integers between 101 and 599
      #         status_code_path         = null       #(Optional) The path to which this rule status code applies.
      #         status_code_sub_status   = null       #(Optional) The Request Sub Status of the Status Code.
      #         status_code_win32_status = null       #(Optional) The Win32 Status Code of the Request.
      #       }
      #     }
      #   }
      # }

      site_config_cors_enabled = false #(Optional) Should windows_web_app cross origin resource sharing be enabled.
      cors = {
        cors_allowed_origins     = ["xxx", "yyy"] #(Required) Specifies a list of origins that should be allowed to make cross-origin calls.
        cors_support_credentials = false          #(Optional) Are credentials allowed in CORS requests? Defaults to false.
      }

      ip_restriction_enabled = false #(Optional) should windows web app ip restriction be enabled.
      ip_restriction = {             ## NOTE:- One and only one of ip_address, service_tag or virtual_network_subnet_id must be specified.
        "ip_restriction_01" = {
          ip_restriction_action                            = "Allow"               #(Optional) The action to take. Possible values are Allow or Deny.
          ip_restriction_ip_address                        = "10.0.4.0/24"         #(Optional) The CIDR notation of the IP or IP Range to match. For example: 10.0.0.0/24 or 192.168.10.1/32
          ip_restriction_name                              = "ploceusiprest000001" #(Optional) The name which should be used for this ip_restriction.
          ip_restriction_priority                          = "100"                 #(Optional) The priority value of this ip_restriction.
          ip_restriction_service_tag                       = null                  #(Optional) The Service Tag used for this IP Restriction.
          ip_restriction_virtual_network_subnet_id_enabled = false

          ip_restriction_headers = {
            ip_restriction_headers_x_azure_fdid      = null #(Optional) Specifies a list of Azure Front Door IDs.
            ip_restriction_headers_x_fd_health_probe = null #(Optional) Specifies if a Front Door Health Probe should be expected.
            ip_restriction_headers_x_forwarded_for   = null #(Optional) Specifies a list of addresses for which matching should be applied. Omitting this value means allow any.
            ip_restriction_headers_x_forwarded_host  = null #(Optional) Specifies a list of Hosts for which matching should be applied.
          }
        }
      }

      scm_ip_restriction_enabled = false #(Optional) should windows web app scm ip restriction be enabled.
      scm_ip_restriction = {
        "scm_ip_restriction_01" = {
          scm_ip_restriction_action                            = "Allow"                  #(Optional) The action to take. Possible values are Allow or Deny.
          scm_ip_restriction_ip_address                        = "10.0.4.0/24"            #(Optional) The CIDR notation of the IP or IP Range to match. For example: 10.0.0.0/24 or 192.168.10.1/32
          scm_ip_restriction_name                              = "ploceusscmiprest000001" #(Optional) The name which should be used for this ip_restriction.
          scm_ip_restriction_priority                          = "110"                    #(Optional) The priority value of this ip_restriction.
          scm_ip_restriction_service_tag                       = null                     #(Optional) The Service Tag used for this IP Restriction.
          scm_ip_restriction_virtual_network_subnet_id_enabled = false

          scm_ip_restriction_headers = {
            scm_ip_restriction_headers_x_azure_fdid      = null #(Optional) Specifies a list of Azure Front Door IDs.
            scm_ip_restriction_headers_x_fd_health_probe = null #(Optional) Specifies if a Front Door Health Probe should be expected.
            scm_ip_restriction_headers_x_forwarded_for   = null #(Optional) Specifies a list of addresses for which matching should be applied. Omitting this value means allow any.
            scm_ip_restriction_headers_x_forwarded_host  = null #(Optional) Specifies a list of Hosts for which matching should be applied.
          }
        }
      }

      site_config_virtual_application = null /* { #Optional) One or more virtual_application blocks as defined below.
        "virtual_application_01" = {
          virtual_application_physical_path = "xyz" #(Required) The physical path for the Virtual Application.
          virtual_application_preload       = false #(Required) Should pre-loading be enabled. Defaults to false.
          virtual_application_virtual_path  = "abc" #(Required) The Virtual Path for the Virtual Application.

          virtual_application_virtual_directory = { #(Optional) One or more virtual_directory blocks as defined below.
            "virtual_directory_01" = {
              virtual_directory_physical_path = null #(Optional) The physical path for the Virtual Application.
              virtual_directory_virtual_path  = null #(Optional) The Virtual Path for the Virtual Application.
            }
          }
        }
      } */
    }

    windows_web_app_tags = { #(Optional) A mapping of tags which should be assigned to the Windows Web App.
      Created_By = "Ploceus"
      Department = "CIS"
    }
  }
}

windows_web_app_subscription_id        = "xxxxxxxxx-xxxxxxxxxx-xxxxxxxxx-xxxxxxxx"
windows_web_app_tenant_id              = "xxxxxxxxx-xxxxxxxxxx-xxxxxxxxx-xxxxxxx"
api_management_subscription_id         = "xxxxxxxxx-xxxxxxxxxx-xxxxxxxxx-xxxxxxxx"
api_management_tenant_id               = "xxxxxxxxx-xxxxxxxxxx-xxxxxxxxx-xxxxxxx"
key_vault_subscription_id              = "xxxxxxxxx-xxxxxxxxxx-xxxxxxxxx-xxxxxxxx"
key_vault_tenant_id                    = "xxxxxxxxx-xxxxxxxxxx-xxxxxxxxx-xxxxxxx"
virtual_network_subscription_id        = "xxxxxxxxx-xxxxxxxxxx-xxxxxxxxx-xxxxxxxx"
virtual_network_tenant_id              = "xxxxxxxxx-xxxxxxxxxx-xxxxxxxxx-xxxxxxx"
storage_account_subscription_id        = "xxxxxxxxx-xxxxxxxxxx-xxxxxxxxx-xxxxxxxx"
storage_account_tenant_id              = "xxxxxxxxx-xxxxxxxxxx-xxxxxxxxx-xxxxxxx"
user_assigned_identity_subscription_id = "xxxxxxxxx-xxxxxxxxxx-xxxxxxxxx-xxxxxxxx"
user_assigned_identity_tenant_id       = "xxxxxxxxx-xxxxxxxxxx-xxxxxxxxx-xxxxxxx"