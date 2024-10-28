
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

#RESOURCE GROUP KEY VAULT
resource_group_variables_key_vault = {
  "resource_group_2" = {
    resource_group_name       = "ploceusrg000002" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = "eastus2"         #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = "ploceus"         #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {                       #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#USER ASSIGNED IDENTITY
user_assigned_identity_variables = {
  "user_assigned_identity_1" = {
    user_assigned_identity_name                = "ploceusuai000001" #(Required) Specifies the name of this User Assigned Identity. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_location            = "eastus"           # (Required) The Azure Region where the User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_resource_group_name = "ploceusrg000001"  #Required) Specifies the name of the Resource Group within which this User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_tags = {                                 #(Optional) A mapping of tags which should be assigned to the Resource Group.
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
    key_vault_purge_protection_enabled              = true                                                                                                                                                                                                                            #(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
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

#KEY VAULT SECRET
key_vault_secret_variables = {
  "key_vault_secret_1" = {
    key_vault_name                       = "ploceuskeyvault000001"       #(Required) Specifies the name of the Key Vault.
    key_vault_secret_value               = "ploceusmssqladminuser000001" #(Required) Specifies the value of the Key Vault Secret
    key_vault_secret_content_type        = ""                            #(Optional) Specifies the content type for the Key Vault Secret
    key_vault_secret_not_before_date     = null                          #(Optional) Specifies that the key is not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_expiration_date     = null                          #(Optional) Specifies the expiration UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_resource_group_name = "ploceusrg000002"             #(Required) Specifies the name of the resource group, where the key_vault resides in
    key_vault_secret_name                = "ploceuskvs000001"            #(Required) Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created
    key_vault_secret_tags = {                                            #(Optional) A mapping of tags which should be assigned to the key vault secret. 
      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_secret_min_upper   = 10 #(Optional)(Number) Minimum number of uppercase alphabet characters in the result. Default value is 0
    key_vault_secret_min_lower   = 5  #(Optional)(Number) Minimum number of lowercase alphabet characters in the result. Default value is 0
    key_vault_secret_min_numeric = 5  #(Optional)(Number) Minimum number of numeric characters in the result. Default value is 0
    key_vault_secret_min_special = 3  #(Optional)(Number) Minimum number of special characters in the result. Default value is 0
    key_vault_secret_length      = 32 #(Optional)(Number) The length of the string desired. The minimum value for length is 1 and, length must also be >= (min_upper + min_lower + min_numeric + min_special)
  },
  "key_vault_secret_2" = {
    key_vault_name                       = "ploceuskeyvault000001" #(Required) Specifies the name of the Key Vault.
    key_vault_secret_value               = ""                      #(Required) Specifies the value of the Key Vault Secret
    key_vault_secret_content_type        = ""                      #(Optional) Specifies the content type for the Key Vault Secret
    key_vault_secret_not_before_date     = null                    #(Optional) Specifies that the key is not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_expiration_date     = null                    #(Optional) Specifies the expiration UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_resource_group_name = "ploceusrg000002"       #(Required) Specifies the name of the resource group, where the key_vault resides in
    key_vault_secret_name                = "ploceuskvs000002"      #(Required) Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created
    key_vault_secret_tags = {                                      #(Optional) A mapping of tags which should be assigned to the key vault secret. 
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

#KEY VAULT ACCESS POLICY
key_vault_access_policy_variables = {
  "key_vault_access_policy_1" = {
    key_vault_access_policy_key_permissions         = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"] #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge", "Set"]                                                                                                                                                       #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]                                 #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_name                                  = "ploceuskeyvault000001"                                                                                                                                                                                                         #(Required) Specifies the name of the Key Vault resource.
    key_vault_resource_group_name                   = "ploceusrg000002"                                                                                                                                                                                                               #(Required) Specifies the resource group name where the key vault resides in.
    key_vault_access_resource_name                  = "xxxxxxxxxxxx@ploceus.com"                                                                                                                                                                                                      #(Required) Specifies the resource name that needs an access policy to the key vault. Possible values are username, group name, service principal name and application name
    key_vault_access_resource_type                  = "User"                                                                                                                                                                                                                          #(Required) Specifies the type of resource that needs the access policy to the key vault. Possible values are User, SPN, Group, Application
  },
  "key_vault_access_policy_2" = {
    key_vault_access_policy_key_permissions         = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"] #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge", "Set"]                                                                                                                                                       #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]                                 #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_name                                  = "ploceuskeyvault000001"                                                                                                                                                                                                         #(Required) Specifies the name of the Key Vault resource.
    key_vault_resource_group_name                   = "ploceusrg000002"                                                                                                                                                                                                               #(Required) Specifies the resource group name where the key vault resides in.
    key_vault_access_resource_name                  = "ploceusuai000001"                                                                                                                                                                                                              #(Required) Specifies the resource name that needs an access policy to the key vault. Possible values are username, group name, service principal name and application name
    key_vault_access_resource_type                  = "SPN"                                                                                                                                                                                                                           #(Required) Specifies the type of resource that needs the access policy to the key vault. Possible values are User, SPN, Group, Application
  }
}

#KEY VAULT KEY 
key_vault_key_variables = {
  "key_vault_key_01" = {
    key_vault_name                = "ploceuskeyvault000001"                                          #(Required) The name of the Key Vault where the Key should be created.
    key_vault_resource_group_name = "ploceusrg000002"                                                #(Required) The resource group name of the Key Vault where the Key should be created.
    key_vault_key_name            = "ploceuskvkey000001"                                             #(Required) Specifies the name of the Key Vault Key.
    key_vault_key_key_type        = "RSA"                                                            #(Required) Specifies the Key Type to use for this Key Vault Key. Possible values are EC (Elliptic Curve), EC-HSM, RSA and RSA-HSM.
    key_vault_key_key_size        = 2048                                                             #(Optional) Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048. Note: This field is required if key_type is RSA or RSA-HSM.
    key_vault_key_curve           = null                                                             #(Optional) Specifies the curve to use when creating an EC key. Possible values are P-256, P-256K, P-384, and P-521. This field will be required in a future release if key_type is EC or EC-HSM. The API will default to P-256 if nothing is specified.
    key_vault_key_key_opts        = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"] #(Required) A list of JSON web key operations. Possible values include: decrypt, encrypt, sign, unwrapKey, verify and wrapKey. Please note these values are case sensitive.
    key_vault_key_not_before_date = null                                                             #(Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_key_expiration_date = "2024-05-05T18:15:30Z"                                           #(Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z').
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

#MSSQL SERVER
mssql_server_variables = {
  "server1" = {
    mssql_server_name                = "ploceusmssql000001" # (Required) The name of the Microsoft SQL Server. This needs to be globally unique within Azure.
    mssql_server_resource_group_name = "ploceusrg000001"    # (Required) The name of the resource group in which to create the Microsoft SQL Server. 
    mssql_server_location            = "eastus2"            # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    mssql_server_version             = "12.0"               # (Required) The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)
    mssql_server_azuread_administrator = {
      azuread_administrator_login_email                 = "xxxxxxxxxxxxxxx@ploceus.com" # (Required) login username of the Azure AD Administrator
      azuread_administrator_azuread_authentication_only = true                          # (Optional) Specifies whether only AD Users and administrators can be used to login, or also local database users
    }
    mssql_server_administrator_login                                = null               # (Optional) The administrator login name for the new server. Required if azuread_administrator_azuread_authentication_only = false
    mssql_server_access_container_agent_name                        = null               # (Required) for fetching object_id
    mssql_server_primary_user_assigned_identity_name                = "ploceusuai000001" # primary_user_identity has issues with current version. so disabled.
    mssql_server_primary_user_assigned_identity_resource_group_name = "ploceusrg000001"  # (Required) if we specify primary user assigned identity
    mssql_server_identity = {                                                            # (Optional) An identity block as defined below.             
      mssql_server_identity_type = "UserAssigned"                                        # (Required) Specifies the type of Managed Service Identity. Possible values - SystemAssigned, UserAssigned. # If given as "SystemAssigned" , then give below parameter as null
      mssql_server_user_assigned_identities = [{                                         # (Optional) Specifies a list of User Assigned Managed Identity IDs
        identity_name                = "ploceusuai000001"                                #(Optional) Name of the user assigned identity
        identity_resource_group_name = "ploceusrg000001"                                 #(Optional) Resource group Name of the user assigned identity
      }]
    }
    mssql_server_connection_policy                    = "Default" # (Optional) Possible values - Default, Proxy, and Redirect. Defaults to Default
    mssql_server_minimum_tls_version                  = 1.2       # (Optional) Valid values are: 1.0, 1.1 , 1.2 and Disabled. Defaults to 1.2
    mssql_server_public_network_access_enabled        = true      # (Optional) Public network access is allowed or not. Defaults to true
    mssql_server_outbound_network_restriction_enabled = false     # (Optional) Whether outbound network traffic is restricted for this server. Defaults to false
    mssql_server_tags = {                                         # (Optional) tags
      Created_By = "Ploceus",
      Department = "CIS"
    }
    mssql_server_use_existing_admin_login_username                     = false                              # true if it uses existing admin login username
    mssql_server_generate_new_admin_password                           = true                               # Specify if new password need to be generated for login
    mssql_server_admin_credentials_key_vault_name                      = "ploceuskeyvault000001"            # Key vault name in which admin credentials are stored
    mssql_server_admin_credentials_key_vault_resource_group_name       = "ploceusrg000002"                  # Key vault resource group name
    mssql_server_transparent_data_encryption_key_vault_key_id_required = true                               # is transparent_data_encryption_key_vault_key_id required true/false
    mssql_server_key_vault_key_name                                    = "ploceuskvkey000001"               # key vault key name for transparent_data_encryption_key_vault_key_id
    mssql_server_key_vault_key_version                                 = "e002e582715248fcbd22b0c0ec116acc" # version of key vault key
    mssql_server_existing_admin_login_username_key_vault_secret_name   = "ploceuskvs000001"                 # Secret key name in which admin login username is stored
    mssql_server_generated_admin_password_key_vault_secret_name        = "ploceuskvs000003"                 # Specify if mssql_server_generate_new_admin_password = true. Secret key name to which generated password to be stored
    mssql_server_existing_admin_password_key_vault_secret_name         = "ploceuskvs000002"                 # secret key name in which password is stored
  }
}

key_vault_subscription_id    = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
key_vault_tenant_id          = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
mssql_server_subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
mssql_server_tenant_id       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
azuread_tenant_id            = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"