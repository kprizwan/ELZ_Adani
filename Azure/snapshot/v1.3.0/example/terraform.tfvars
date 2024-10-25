#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name       = "ploceusrg000001" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = "eastus2"         #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = "ploceus"         #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {                       #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#RESOURCE GROUP 
key_vault_resource_group_variables = {
  "resource_group_1" = {
    resource_group_name       = "ploceusrg000002" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = "eastus2"         #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = "ploceus"         #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {                       #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#RESOURCE GROUP 
storage_account_resource_group_variables = {
  "resource_group_1" = {
    resource_group_name       = "ploceusrg000003" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = "eastus2"         #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = "ploceus"         #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {                       #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#KEY VAULT
key_vault_variables = {
  "key_vault_1" = {
    key_vault_name                                  = "ploceuskeyvault000001"                                                                                                                                                                                                         #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_location                              = "eastus2"                                                                                                                                                                                                                       #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_resource_group_name                   = "ploceusrg000002"                                                                                                                                                                                                               #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_enabled_for_disk_encryption           = true                                                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = true                                                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = true                                                                                                                                                                                                                            # (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = false                                                                                                                                                                                                                           #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = "7"                                                                                                                                                                                                                             #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = false                                                                                                                                                                                                                           #(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
    key_vault_sku_name                              = "standard"                                                                                                                                                                                                                      #(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium
    key_vault_access_container_agent_name           = null                                                                                                                                                                                                                            #(Optional) Self hosted conatiner agent name.
    key_vault_access_policy_application_id          = null                                                                                                                                                                                                                            #(Optional) The object ID of an Application in Azure Active Directory.                                                                                                                                                                        
    key_vault_public_network_access_enabled         = true                                                                                                                                                                                                                            #(Optional) key_vault_public_network_access_enabled
    key_vault_access_policy_key_permissions         = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"] #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                                                              #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]                                 # (Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_tags = {                                                                                                                                                                                                                                                                #(Optional) A mapping of tags which should be assigned to the key vault.
      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_network_acls_enabled          = false           #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass           = "AzureServices" #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action   = "Deny"          # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
    key_vault_network_acls_ip_rules         = []              # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.
    key_vault_network_acls_virtual_networks = null            #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
    key_vault_contact_information_enabled   = false           #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email                 = null            #(Required) E-mail address of the contact.
    key_vault_contact_name                  = null            #(Optional) Name of the contact.
    key_vault_contact_phone                 = null            #(Optional) Phone number of the contact.

  }
}

#KEY VAULT ACCESS POLICY
key_vault_access_policy_variables = {
  "key_vault_access_policy_1" = {
    key_vault_access_policy_key_permissions         = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"] #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge", "Set"]                                                                                                                                                       #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]                                 #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_name                                  = "ploceuskeyvault000001"                                                                                                                                                                                                         #(Required) Specifies the name of the Key Vault resource.
    key_vault_resource_group_name                   = "ploceusrg000002"                                                                                                                                                                                                               #(Required) Specifies the resource group name where the key vault resides in.
    key_vault_access_resource_name                  = "xxxxxxxxxxxxx@ploceus.com"                                                                                                                                                                                                     #(Required) Specifies the resource name that needs an access policy to the key vault. Possible values are username, group name, service principal name and application name
    key_vault_access_resource_type                  = "User"                                                                                                                                                                                                                          #(Required) Specifies the type of resource that needs the access policy to the key vault. Possible values are User, SPN, Group, Application
  }
}

# KEY VAULT KEY 
key_vault_key_variables = {
  "key_vault_key_01" = {
    key_vault_name                = "ploceuskeyvault000001"                                          #(Required) The name of the Key Vault where the Key should be created.
    key_vault_resource_group_name = "ploceusrg000002"                                                #(Required) The resource group name of the Key Vault where the Key should be created.
    key_vault_key_name            = "ploceuskvkey000001"                                             #(Required) Specifies the name of the Key Vault Key.
    key_vault_key_key_type        = "RSA"                                                            #(Required) Specifies the Key Type to use for this Key Vault Key. Possible values are EC (Elliptic Curve), EC-HSM, RSA and RSA-HSM.
    key_vault_key_key_size        = 2048                                                             #(Optional) Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048. Note: This field is required if key_type is RSA or RSA-HSM.
    key_vault_key_curve           = null                                                             #(Optional) Specifies the curve to use when creating an EC key. Possible values are P-256, P-256K, P-384, and P-521. This field will be required in a future release if key_type is EC or EC-HSM. The API will default to P-256 if nothing is specified.
    key_vault_key_key_opts        = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"] #(Required) A list of JSON web key operations. Possible values include: decrypt, encrypt, sign, unwrapKey, verify and wrapKey. Please note these values are case sensitive.
    key_vault_key_not_before_date = "2023-01-05T18:15:30Z"                                           #(Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_key_expiration_date = "2023-05-05T18:15:30Z"                                           #(Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_key_rotation_policy = {                                                                #(Optional) A rotation_policy block as defined below.
      rotation_policy_expire_after         = "P90D"                                                  #(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration.
      rotation_policy_notify_before_expiry = "P29D"                                                  #(Optional) Notify at a given duration before expiry as an ISO 8601 duration. Default is P30D.
      rotation_policy_automatic = {                                                                  #(Optional) An automatic block as defined below.
        automatic_time_after_creation = "P50D"                                                       #(Optional) Rotate automatically at a duration after create as an ISO 8601 duration.
        automatic_time_before_expiry  = "P30D"                                                       #(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration.
      }
    }
    key_vault_key_tags = { #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus"
      Department = "CIS"
    }
  }
}

#KEY VAULT SECRET
key_vault_secret_variables = {
  "key_vault_secret_1" = {
    key_vault_name                       = "ploceuskeyvault000001"       #(Required) Specifies the name of the Key Vault.
    key_vault_secret_value               = ""                            #(Required) Specifies the value of the Key Vault Secret
    key_vault_secret_content_type        = ""                            #(Optional) Specifies the content type for the Key Vault Secret
    key_vault_secret_not_before_date     = null                          #(Optional) Specifies that the key is not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_expiration_date     = null                          #(Optional) Specifies the expiration UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_resource_group_name = "ploceusrg000002"             #(Required) Specifies the name of the resource group, where the key_vault resides in
    key_vault_secret_name                = "ploceuskeyvaultsecret000001" #(Required) Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created
    key_vault_secret_tags = {                                            #(Optional) A mapping of tags which should be assigned to the key vault secret. 

      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_secret_min_upper   = 10 #(Optional)(Number) Minimum number of uppercase alphabet characters in the result. Default value is 0
    key_vault_secret_min_lower   = 5  #(Optional)(Number) Minimum number of lowercase alphabet characters in the result. Default value is 0
    key_vault_secret_min_numeric = 5  #(Optional)(Number) Minimum number of numeric characters in the result. Default value is 0
    key_vault_secret_min_special = 3  #(Optional)(Number) Minimum number of special characters in the result. Default value is 0
    key_vault_secret_length      = 32 #(Optional)(Number) The length of the string desired. The minimum value for length is 1 and, length must also be >= (min_upper + min_lower + min_numeric + min_special)
  }
}

#STORAGE ACCOUNT
storage_account_variables = {
  "storage_account_01" = {
    storage_account_key_vault_name                                     = null              #(Required) The name of the Key Vault.
    storage_account_key_vault_resource_group_name                      = null              #(Required) The resource group name of the Key Vault.
    storage_account_key_vault_key_name                                 = null              #(Required) The name of the Key Vault key required for customer managed key.
    storage_account_user_assigned_identity_name_for_cmk                = null              #(Required) The name of a user assigned identity for customer managed key.
    storage_account_user_assigned_identity_resource_group_name_for_cmk = null              #(Required) The resource group name of a user assigned identity for customer managed key.
    storage_account_identity_type_for_cmk                              = "SystemAssigned"  #(Required) The identity type of a user assigned identity for customer managed key.Only Possible value could be "UserAssigned" in order to use customer managed key. Other Possible values are "SystemAssigned", "SystemAssigned, UserAssigned"
    storage_account_name                                               = "ploceussa000001" #(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed.This must be unique across the entire Azure service, not just within the resource group.
    storage_account_resource_group_name                                = "ploceusrg000003" #(Required) The name of the resource group in which to create the storage account.
    storage_account_location                                           = "eastus2"         #(Required) Specifies the supported Azure location where the resource exists. 
    storage_account_account_kind                                       = "StorageV2"       #(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2.
    storage_account_account_tier                                       = "Standard"        #(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    storage_account_account_replication_type                           = "LRS"             #(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa.
    storage_account_cross_tenant_replication_enabled                   = true              #(Optional) Should cross Tenant replication be enabled? Defaults to true.
    storage_account_access_tier                                        = "Hot"             #(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot.
    storage_account_edge_zone                                          = null              #(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist.
    storage_account_enable_https_traffic_only                          = true              #(Optional) Boolean flag which forces HTTPS if enabled. Defaults to true.
    storage_account_min_tls_version                                    = "TLS1_2"          #(Optional) The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts.
    storage_account_allow_nested_items_to_be_public                    = true              #Allow or disallow nested items within this Account to opt into being public. Defaults to true.
    storage_account_shared_access_key_enabled                          = true              #Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true.
    storage_account_public_network_access_enabled                      = true              #(Optional) Whether the public network access is enabled? Defaults to true.
    storage_account_default_to_oauth_authentication                    = false             #(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false
    storage_account_is_hns_enabled                                     = false             #(Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2.
    storage_account_nfsv3_enabled                                      = false             #(Optional) Is NFSv3 protocol enabled? Defaults to false.
    storage_account_large_file_share_enabled                           = false             #(Optional) Is Large File Share Enabled?
    storage_account_queue_encryption_key_type                          = "Service"         #(Optional) The encryption type of the queue service. Possible values are Service and Account.Default value is Service.
    storage_account_table_encryption_key_type                          = "Service"         #(Optional) The encryption type of the table service. Possible values are Service and Account. Default value is Service.
    storage_account_infrastructure_encryption_enabled                  = false             #(Optional) Is infrastructure encryption enabled? Defaults to false.
    storage_account_allowed_copy_scope                                 = null              #(Optional) Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values are AAD and PrivateLink.
    storage_account_sftp_enabled                                       = false             #(Optional) Boolean, enable SFTP for the storage account, to enable this, is_hns_enabled should be true as well
    storage_account_custom_domain                                      = null
    # storage_account_custom_domain = {
    #     custom_domain_name = "www.ploceus.com" #(Required) The Custom Domain Name to use for the Storage Account, which will be validated by Azure.
    #     custom_domain_use_subdomain = false #(Optional) Should the Custom Domain Name be validated by using indirect CNAME validation?
    # }
    storage_account_identity = null
    # storage_account_identity = {
    #   storage_account_identity_type = "UserAssigned" # Possible values could be "UserAssigned", "SystemAssigned", "SystemAssigned, UserAssigned"
    #   # storage_account_user_assigned_identity_ids = null
    #   storage_account_user_assigned_identity_ids = [{ # This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
    #     identity_name                = "ploceusuai000002"
    #     identity_resource_group_name = "loceusrg000005"
    #   }]
    # }
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
      restore_policy = {
        restore_policy_days = "4" #(Required) Specifies the number of days that the blob can be restored, between 1 and 365 days. This must be less than the days specified for delete_retention_policy.
      }
      delete_retention_policy = {
        delete_retention_policy_days = "7" #(Optional) Specifies the number of days that the blob should be retained, between 1 and 365 days. Defaults to 7.
      }
      container_delete_retention_policy = {
        container_delete_retention_policy_days = "7" #(Optional) Specifies the n  umber of days that the container should be retained, between 1 and 365 days. Defaults to 7.
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
    storage_account_share_properties = {
      cors_enabled = true #(optional) Should cross origin resource sharing be enabled.
      cors_rule = {
        allowed_headers    = ["*"]                                   #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = ["GET", "HEAD", "MERGE", "POST", "PUT"] #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = ["*"]                                   #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = ["*"]                                   #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = 60                                      #(Required) The number of seconds the client should cache a preflight response.
      }
      retention_policy = {
        retention_policy_days = 7 #(Optional) Specifies the number of days that the azurerm_storage_share should be retained, between 1 and 365 days. Defaults to 7.
      }
      smb = {
        smb_versions                        = ["SMB2.1"]      #(Optional) A set of SMB protocol versions. Possible values are SMB2.1, SMB3.0, and SMB3.1.1.
        smb_authentication_types            = ["NTLMv2"]      #(Optional) A set of SMB authentication methods. Possible values are NTLMv2, and Kerberos.
        smb_kerberos_ticket_encryption_type = ["RC4-HMAC"]    #(Optional) A set of Kerberos ticket encryption. Possible values are RC4-HMAC, and AES-256.
        smb_channel_encryption_type         = ["AES-128-CCM"] #(Optional) A set of SMB channel encryption. Possible values are AES-128-CCM, AES-128-GCM, and AES-256-GCM.
        smb_multichannel_enabled            = false           #(Optional) Indicates whether multichannel is enabled. Defaults to false. This is only supported on Premium storage accounts.
      }
    }
    storage_account_network_rules              = null /* {
      default_action = "Deny"                 #(Required) Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow.
      bypass         = ["Logging", "Metrics"] #(Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None.
      ip_rules       = ["8.29.228.191"]        #(Optional) List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed.

      storage_account_network_rules_vnet_subnets = [{
        storage_account_network_rules_virtual_network_name = "ploceusvnet000001"                   #(Required) Vitural Network name to be associated.
        storage_account_network_rules_subnet_name          = "ploceussubnet000001"                 #(Required) Subnet Name to be associated.
        storage_account_network_rules_vnet_subscription_id = "xxxxxxx-xxxxxxx-xxxxxxxxx-xxxxxxxxx" #(Required) Subscription Id where Vnet is created.
        storage_account_network_rules_vnet_rg_name         = "ploceusrg000001"                     #(Required) Resource group where Vnet is created.
        }]

      private_link_access = null /*{
        "private_link_access_01" = {
          endpoint_resource_id = "/subscriptions/XXXXXXXXXXXXXXXXXXXXXXX/resourceGroups/XXXXXXXXXXXXXXXXXXXX/providers/Microsoft.Sql/servers/XXXXXXXXXXXXXXXXXXXX"
          endpoint_tenant_id   = "xxxxxxxxx-xxxxxxxxx-xxxxxxxxxx-xxxxxxxxx"
        }
      }
    } */
    storage_account_azure_files_authentication = null
    # storage_account_azure_files_authentication = {  # Use this block when need to authenticate with Azure active directory domain services or Active Directory.
    #   directory_type = "AADDS" #(Required) Specifies the directory service used. Possible values are AADDS and AD.
    #   active_directory = {
    #     storage_sid         = "xxxxxxxxxx" #(Required) Specifies the security identifier (SID) for Azure Storage.
    #     domain_name         = "www.ploceus1.com" #(Required) Specifies the primary domain that the AD DNS server is authoritative for.
    #     domain_sid          = "xxxxxxxxxx" #(Required) Specifies the security identifier (SID).
    #     domain_guid         = "xxxxxxxxxx" #(Required) Specifies the domain GUID.
    #     forest_name         = "xxxxxxxxxx" #(Required) Specifies the Active Directory forest.
    #     netbios_domain_name = "www.ploceus2.com" #(Required) Specifies the NetBIOS domain name.
    #   }
    # }
    storage_account_routing = {
      publish_internet_endpoints  = false             #(Optional) Should internet routing storage endpoints be published? Defaults to false.
      publish_microsoft_endpoints = false             #(Optional) Should Microsoft routing storage endpoints be published? Defaults to false.
      choice                      = "InternetRouting" #(Optional) Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting. Defaults to MicrosoftRouting.
    }
    storage_account_immutability_policy = null /* {
      allow_protected_append_writes = false      #(Required) When enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted.
      state                         = "Disabled" #(Required) Defines the mode of the policy. Disabled state disables the policy, Unlocked state allows increase and decrease of immutability retention time and also allows toggling allowProtectedAppendWrites property, Locked state only allows the increase of the immutability retention time. A policy can only be created in a Disabled or Unlocked state and can be toggled between the two states. Only a policy in an Unlocked state can transition to a Locked state which cannot be reverted.
      period_since_creation_in_days = 7          #(Required) The immutability period for the blobs in the container since the policy creation, in days.
    } */
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

#STORAGE CONTAINER
storage_container_variables = {
  "storage_container" = {
    storage_container_name                  = "ploceusstrcon000001" #Required The name of the Container which should be created within the Storage Account.
    storage_container_storage_account_name  = "ploceussa000001"     #Required The name of the Storage Account where the Container should be created.
    storage_container_container_access_type = "container"           #Optional The Access Level configured for this Container. Possible values are blob, container or private. Defaults to private.
    storage_container_metadata              = null                  #Optional A mapping of MetaData for this Container. All metadata keys should be lowercase.
  }
}

#STORAGE BLOB
storage_blob_variables = {
  storage_blob_1 = {
    storage_blob_name                   = "ploceusblob000001"   #(Required) The name of the storage blob. Must be unique within the storage container the blob is located.
    storage_blob_storage_account_name   = "ploceussa000001"     #(Required) Specifies the storage account in which to create the storage container. Changing this forces a new resource to be created.
    storage_blob_storage_container_name = "ploceusstrcon000001" #(Required) The name of the storage container in which this blob should be created.
    storage_blob_type                   = "Block"               #(Required) The type of the storage blob to be created. Possible values are Append, Block or Page. Changing this forces a new resource to be created.
    storage_blob_size                   = null                  #(Optional) Used only for page blobs to specify the size in bytes of the blob to be created. Must be a multiple of 512. Defaults to 0.
    storage_blob_content_type           = null                  #(Optional) The content type of the storage blob. Cannot be defined if source_uri is defined. Defaults to application/octet-stream.
    storage_blob_source                 = "./main.tf"           #(Optional) An absolute path to a file on the local system. This field cannot be specified for Append blobs and cannot be specified if source_content or source_uri is specified.
    storage_blob_source_uri             = null                  #(Optional) The URI of an existing blob, or a file in the Azure File service, to use as the source contents for the blob to be created. Changing this forces a new resource to be created. This field cannot be specified for Append blobs and cannot be specified if source or source_content is specified.
    storage_blob_access_tier            = "Cool"                #(Optional) The access tier of the storage blob. Possible values are Archive, Cool and Hot.
    storage_blob_cache_control          = null                  #(Optional) Controls the cache control header content of the response when blob is requested .
    storage_blob_content_md5            = null                  #(Optional) The MD5 sum of the blob contents. Cannot be defined if source_uri is defined, or if blob type is Append or Page. Changing this forces a new resource to be created.
    storage_blob_source_content         = null                  #(Optional) The content for this blob which should be defined inline. This field can only be specified for Block blobs and cannot be specified if source or source_uri is specified.
    storage_blob_parallelism            = 8                     #(Optional) The number of workers per CPU core to run for concurrent uploads. Defaults to 8.
    storage_blob_metadata = {                                   #(Optional) A map of custom blob metadata.
      name = "Inputfile"
    }
  }
}

#MANAGED DISK
managed_disk_variables = {
  "managed_disk_1" = {
    managed_disk_name                 = "ploceusdisk000001" #(Required) Specifies the name of the Managed Disk.
    managed_disk_location             = "eastus2"           #(Required) Specifies the supported Azure location where the resource exists.
    managed_disk_resource_group_name  = "ploceusrg000001"   #(Required) The name of the Resource Group where the Managed Disk should exist.
    managed_disk_storage_account_type = "Standard_LRS"      #(Required) The type of storage to use for the managed disk. Possible values are Standard_LRS, StandardSSD_ZRS, Premium_LRS, PremiumV2_LRS, Premium_ZRS, StandardSSD_LRS or UltraSSD_LRS

    #CREATE OPTIONS
    managed_disk_create_option = "Empty" #Allowed values are Empty,FromImage,Copy, Import and Restore

    #MANAGED IMAGE
    managed_disk_image_reference_name                = "ploceusimage000001" #specify if the managed_disk_create_option = FromImage and managed image is used
    managed_disk_image_reference_resource_group_name = "ploceusrg000001"    #specify if the managed_disk_create_option = FromImage and managed image is used

    #GALLERY IMAGE
    managed_disk_gallery_image_reference_name                = "ploceusimage000001"   #specify if the managed_disk_create_option = FromImage and gallery image is used
    managed_disk_gallery_image_reference_gallery_name        = "ploceusgallery000001" #specify if the managed_disk_create_option = FromImage and gallery image is used
    managed_disk_gallery_image_reference_resource_group_name = "ploceusrg000001"      #specify if the managed_disk_create_option = FromImage and gallery image is used

    #SNAPSHOT
    managed_disk_source_resource_name                = "ploceussnap000001" #specify if the managed_disk_create_option = Copy is used
    managed_disk_source_resource_resource_group_name = "ploceusrg000001"   #specify if the managed_disk_create_option = Copy is used

    #STORAGE BLOB
    managed_disk_storage_acccount_name               = "ploceussa000001" #specify if the managed_disk_create_option = Import is used
    managed_disk_storage_account_resource_group_name = "ploceusrg000003" #specify if the managed_disk_create_option = Import is used
    managed_disk_storage_container_name              = "ploceusstrcon000001"
    managed_disk_os_type                             = "linux" #specify only if managed_disk_create_option = Copy or Import is used
    managed_disk_hyper_v_generation                  = "V1"    #specify only if managed_disk_create_option = Copy or Import is used
    managed_disk_logical_sector_size                 = null    #(Optional) Logical Sector Size. Possible values are: 512 and 4096. Defaults to 4096. Changing this forces a new resource to be created.
    managed_disk_optimized_frequent_attach_enabled   = false   #(Optional) Specifies whether this Managed Disk should be optimized for frequent disk attachments (where a disk is attached/detached more than 5 times in a day). Defaults to false.
    managed_disk_performance_plus_enabled            = false   #(Optional) Specifies whether Performance Plus is enabled for this Managed Disk. Defaults to false. Changing this forces a new resource to be created.

    #DISK OPTIONS
    managed_disk_disk_size_gb               = "100" #specify if create_option is Copy or FromImage
    managed_disk_disk_sector_size           = "4096"
    managed_disk_tier                       = "P10" #specify if managed_disk_storage_type is Premium_LRS
    managed_disk_max_shares                 = "4"   #allowed Values 1 to 5
    managed_disk_zone                       = "1" /*Availability Zones are only supported in select regions at this time.refer https://learn.microsoft.com/en-us/azure/availability-zones/az-overview*/
    managed_disk_trusted_launch_enabled     = false #(Optional) Specifies if Trusted Launch is enabled for the Managed Disk. Defaults to false.Can only be enabled when create_option is FromImage or Import.
    managed_disk_on_demand_bursting_enabled = false #(Optional) Specifies if On-Demand Bursting is enabled for the Managed Disk. Defaults to false.
    managed_disk_edge_zone                  = null  #(Optional) Specifies the Edge Zone within the Azure Region where this Managed Disk should exist. Changing this forces a new Managed Disk to be created.

    #ULTRA SSD OPTIONS
    managed_disk_disk_iops_read_write = "4" #Specify when UltraSSD disks and PremiumV2 disks
    managed_disk_disk_iops_read_only  = "4" #Specify when UltraSSD disks and PremiumV2 disks
    managed_disk_disk_mbps_read_write = "4" #Specify when UltraSSD disks and PremiumV2 disks
    managed_disk_disk_mbps_read_only  = "4" #Specify when UltraSSD disks and PremiumV2 disks

    #NETWORK OPTIONS
    managed_disk_public_network_access_enabled = true
    managed_disk_network_access_policy         = "AllowAll"                      # Allowed values AllowAll,AllowPrivate and DenyAll
    managed_disk_disk_access_id                = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX" #Specify when network_access_policy is AllowPrivate

    #DISK ACCESS
    managed_disk_access_name                = null              #(Optional) The name used for this Disk Access.
    managed_disk_access_resource_group_name = "ploceusrg000001" #(Optional) The Resource group name where the Disk access is created

    #ENCRYPTION
    managed_disk_disk_encryption_set_name                      = null #specify when disk encryption is added
    managed_disk_disk_encryption_resource_group_name           = null #specify when disk encryption is added
    managed_disk_security_type                                 = null #(Optional) Security Type of the Managed Disk when it is used for a Confidential VM. Possible values are ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey, ConfidentialVM_DiskEncryptedWithPlatformKey and ConfidentialVM_DiskEncryptedWithCustomerKey
    managed_disk_secure_vm_disk_encryption_set_name            = null #(Optional) The ID of the Secure VM Disk Encryption Set which should be used to Encrypt this OS Disk when the Virtual Machine is a Confidential VM. Conflicts with disk_encryption_set_id
    managed_disk_secure_vm_disk_encryption_resource_group_name = null #(Optional) The resource group name of the Secure VM disk encryption.

    #ENCRYPTION SETTINGS   
    managed_disk_encryption_settings_enabled                                  = false                         #(Optional) Enable this setting to configure Azure Disk Encryption. true to enable false to remove the block 
    managed_disk_encryption_settings_is_disk_encryption_key_present           = true                          #(Optional) To specify disk encryption key pass true otherwise false
    managed_disk_encryption_settings_is_key_encryption_key_present            = true                          #(Optional) To specify key encryption key pass true otherwise false
    managed_disk_encryption_settings_disk_encryption_key_vault_name           = "ploceuskeyvault000001"       #(Optional) Specify key vault name where disk encryption secret_url is present
    managed_disk_encryption_settings_disk_encryption_key_vault_resource_group = "ploceusrg000002"             #(Optional) Specify resource group name where key vault for disk encryption secret_url is present
    managed_disk_encryption_settings_disk_encryption_key_vault_secret_name    = "ploceuskeyvaultsecret000001" #(Optional) Specify key vault secret name for disk encryption secret_url
    managed_disk_encryption_settings_key_encryption_key_vault_name            = "ploceuskeyvault000001"       #(Optional) Specify key vault name where key encryption key_url is present
    managed_disk_encryption_settings_key_encryption_key_vault_key_name        = "ploceuskvkey000001"          #(Optional) Specify key vault secret name for key encryption key_url
    managed_disk_encryption_settings_key_encryption_key_vault_resource_group  = "ploceusrg000002"             #(Optional) Specify resource group name where key vault for key encryption key_url is present
    managed_disk_tags = {                                                                                     #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#SNAPSHOT
snapshot_variables = {
  "snapshot_01" = {
    snapshot_name                                              = "ploceusss000001"   #(Required) Specifies the name of the Snapshot resource. Changing this forces a new resource to be created.
    snapshot_resource_group_name                               = "ploceusrg000001"   #(Required) The name of the resource group in which to create the Snapshot. Changing this forces a new resource to be created.
    snapshot_location                                          = "eastus2"           #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    snapshot_create_option                                     = "Copy"              #(Required) Indicates how the snapshot is to be created. Possible values are Copy or Import. Changing this forces a new resource to be created.
    snapshot_disk_size_gb                                      = null                #(Optional) The size of the Snapshotted Disk in GB.
    snapshot_incremental_enabled                               = null                #(Optional) Specifies if the Snapshot is incremental.
    snapshot_source_manged_disk                                = true                #(Optional) Spicy when create_option is import whether managed disk or unmanged disk.
    snapshot_source_uri_unmanaged_blobs_different_subscription = false               #(Optional) Used with source_uri to allow authorization during import of unmanaged blobs from a different subscription. Changing this forces a new resource to be created.
    managed_disk_source_resource_name                          = null                #(Optional) Specifies a reference to an existing snapshot, when create_option is Copy. Changing this forces a new resource to be created. 
    managed_disk_source_resource_resource_group_name           = null                #(Optional) Specifies a reference to an existing snapshot, when create_option is Copy. Changing this forces a new resource to be created.
    snapshot_managed_disk_name                                 = "ploceusdisk000001" #(Optional) Specify when create_option is import and snapshot_source_manged_disk is true.
    snapshot_managed_disk_resource_group_name                  = "ploceusrg000001"   #(Optional) Specify when create_option is import and snapshot_source_manged_disk is true.
    snapshot_storage_account_name                              = null                #(optional) Specify when create_option is import and snapshot_source_manged_disk is false.
    snapshot_storage_resource_group_name                       = null                #(optional) Specify when create_option is import and snapshot_source_manged_disk is false.
    snapshot_storage_blob_name                                 = null                #(optional) Specify when create_option is import and snapshot_source_manged_disk is false.
    snapshot_storage_container_name                            = null                #(optional) Specify when create_option is import and snapshot_source_manged_disk is false.
    snapshot_encryption_settings_enabled                       = false               # True if encryption_settings needs to be enabled.
    snapshot_encryption_settings_key_vault_name                = null                # Required if snapshot_encryption_settings_enabled is set to True.
    snapshot_encryption_settings_key_vault_resource_group_name = null                # Required if snapshot_encryption_settings_enabled is set to True.
    snapshot_encryption_settings_key_vault_secret_name         = null                # Required if encryption secret is stored in key vault secret when snapshot_encryption_settings_enabled is set to True 
    snapshot_encryption_settings_key_vault_key_name            = null                # Required if encryption secret is stored in key vault key when snapshot_encryption_settings_enabled is set to True
    snapshot_tags = {                                                                #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

key_vault_subscription_id       = "xxxxxxxxx-xxxxxxxx-xxxxxxxxxx-xxxxxxxxxx"
key_vault_tenant_id             = "xxxxxxxxx-xxxxxxxx-xxxxxxxxxx-xxxxxxxxxx"
snapshot_subscription_id        = "xxxxxxxxx-xxxxxxxx-xxxxxxxxxx-xxxxxxxxxx"
snapshot_tenant_id              = "xxxxxxxxx-xxxxxxxx-xxxxxxxxxx-xxxxxxxxxx"
storage_account_subscription_id = "xxxxxxxxx-xxxxxxxx-xxxxxxxxxx-xxxxxxxxxx"
storage_account_tenant_id       = "xxxxxxxxx-xxxxxxxx-xxxxxxxxxx-xxxxxxxxxx"
