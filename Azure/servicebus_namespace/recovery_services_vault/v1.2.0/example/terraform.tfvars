#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000001" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location = "eastus"          #(Required) The Azure Region where the Resource Group should exist.
    resource_group_tags = {                     #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#KEY VAULT
key_vault_variables = {
  "key_vault_1" = {
    key_vault_name                                  = "ploceuskeyvault000001"                                                                                                                                                                         #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_location                              = "eastus"                                                                                                                                                                                        #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_resource_group_name                   = "ploceusrg000001"                                                                                                                                                                               #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_enabled_for_disk_encryption           = false                                                                                                                                                                                           #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = true                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = true                                                                                                                                                                                            # (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = false                                                                                                                                                                                           #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = "7"                                                                                                                                                                                             #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = true                                                                                                                                                                                            #(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
    key_vault_sku_name                              = "standard"                                                                                                                                                                                      #(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium
    key_vault_access_container_agent_name           = null                                                                                                                                                                                            #(Optional) Self hosted conatiner agent name.
    key_vault_access_policy_application_id          = null                                                                                                                                                                                            #(Optional) The object ID of an Application in Azure Active Directory.                                                                                                                                                                        
    key_vault_public_network_access_enabled         = true                                                                                                                                                                                            #(Optional) key_vault_public_network_access_enabled
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                    #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                              #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"] # (Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_network_acls_enabled                  = false                                                                                                                                                                                           #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass                   = "AzureServices"                                                                                                                                                                                 #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action           = "Deny"                                                                                                                                                                                          # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
    key_vault_network_acls_ip_rules                 = null                                                                                                                                                                                            # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.
    key_vault_network_acls_virtual_networks         = null                                                                                                                                                                                            #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
    key_vault_contact_information_enabled           = false                                                                                                                                                                                           #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email                         = null                                                                                                                                                                                            #(Required) E-mail address of the contact.
    key_vault_contact_name                          = null                                                                                                                                                                                            #(Optional) Name of the contact.
    key_vault_contact_phone                         = null                                                                                                                                                                                            #(Optional) Phone number of the contact.
    key_vault_tags = {                                                                                                                                                                                                                                #(Optional) A mapping of tags which should be assigned to the key vault.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#KEY VAULT ACCESS POLICY
key_vault_access_policy_variables = {
  "key_vault_access_policy_1" = {
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                    #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge", "Set"]                                                                                                                       #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"] #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_name                                  = "ploceuskeyvault000001"                                                                                                                                                                         #(Required) Specifies the name of the Key Vault resource.
    key_vault_resource_group_name                   = "ploceusrg000001"                                                                                                                                                                               #(Required) Specifies the resource group name where the key vault resides in.
    key_vault_access_resource_name                  = "xxxxxxxxxxx@ploceus.com"                                                                                                                                                                       #(Required) Specifies the resource name that needs the access policy to the key vault. Possible values are username, group name, service principal name and application name
    key_vault_access_resource_type                  = "User"                                                                                                                                                                                          #(Required) Specifies the type of resource that needs the access policy to the key vault. Possible values are User, SPN, Group, Application
  }
}

# KEY VAULT KEY 
key_vault_key_variables = {
  "key_vault_key_01" = {
    key_vault_name                = "ploceuskeyvault000001"                                          #(Required) The name of the Key Vault where the Key should be created.
    key_vault_resource_group_name = "ploceusrg000001"                                                #(Required) The resource group name of the Key Vault where the Key should be created.
    key_vault_key_name            = "ploceuskvkey000001"                                             #(Required) Specifies the name of the Key Vault Key.
    key_vault_key_key_type        = "RSA"                                                            #(Required) Specifies the Key Type to use for this Key Vault Key. Possible values are EC (Elliptic Curve), EC-HSM, RSA and RSA-HSM.
    key_vault_key_key_size        = 2048                                                             #(Optional) Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048. Note: This field is required if key_type is RSA or RSA-HSM.
    key_vault_key_curve           = null                                                             #(Optional) Specifies the curve to use when creating an EC key. Possible values are P-256, P-256K, P-384, and P-521. This field will be required in a future release if key_type is EC or EC-HSM. The API will default to P-256 if nothing is specified.
    key_vault_key_key_opts        = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"] #(Required) A list of JSON web key operations. Possible values include: decrypt, encrypt, sign, unwrapKey, verify and wrapKey. Please note these values are case sensitive.
    key_vault_key_not_before_date = "2023-01-05T18:15:30Z"                                           #(Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_key_expiration_date = "2023-05-05T18:15:30Z"                                           #(Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_key_tags = {                                                                           #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus"
      Department = "CIS"
    }
  }
}

#RECOVERY SERVICE VAULT 
recovery_services_vault_variables = {
  "recovery_services_vault_1" = {
    recovery_services_vault_name                         = "ploceusrsv000001" #(Required) Specifies the name of the Recovery Services Vault. Recovery Service Vault name must be 2 - 50 characters long, start with a letter, contain only letters, numbers and hyphens. Changing this forces a new resource to be created.
    recovery_services_vault_resource_group_name          = "ploceusrg000001"  #(Required) The name of the resource group in which to create the Recovery Services Vault. Changing this forces a new resource to be created.
    recovery_services_vault_location                     = "eastus"           #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    recovery_services_vault_sku                          = "Standard"         #(Required) Sets the vault's SKU. Possible values include: Standard, RS0
    recovery_services_vault_storage_mode_type            = "GeoRedundant"     #(Optional) The storage type of the Recovery Services Vault. Possible values are GeoRedundant, LocallyRedundant and ZoneRedundant. Defaults to GeoRedundant.
    recovery_services_vault_cross_region_restore_enabled = false              #(Optional) Is cross region restore enabled for this Vault? Only can be true, when storage_mode_type is GeoRedundant. Defaults to false.
    recovery_services_vault_soft_delete_enabled          = true               #(Optional) Is soft delete enable for this Vault? Defaults to true
    recovery_services_vault_identity = {                                      #(Optional) An identity block as defined below.
      recovery_services_vault_identity_type = "SystemAssigned"                #(Required) Specifies the type of Managed Service Identity that should be configured on this Recovery Services Vault. The only possible value is SystemAssigned
    }
    recovery_services_vault_encryption = null /* {                                   #(Optional) An encryption block as defined below. Required with identity.
      encryption_key_vault_name                    = "ploceuskeyvault000001" #(Required) The Key Vault name holding key used to encrypt this vault. Key managed by Vault Managed Hardware Security Module is also supported.
      encryption_key_vault_resource_group_name     = "ploceusrg000001"       #(Required) The Key Vault resource group name holding key used to encrypt this vault. Key managed by Vault Managed Hardware Security Module is also supported.
      encryption_key_vault_key_name                = "ploceuskvkey000001"    #(Required) The Key Vault key name used to encrypt this vault. Key managed by Vault Managed Hardware Security Module is also supported.
      encryption_infrastructure_encryption_enabled = false                    #(Required) Enabling/Disabling the Double Encryption state.
      encryption_use_system_assigned_identity      = true                    #(Optional) Indicate that system assigned identity should be used or not. At this time the only possible value is true. Defaults to true.
    } */
    recovery_services_vault_tags = { #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus"
      Department = "CIS"
    }
  }
}
