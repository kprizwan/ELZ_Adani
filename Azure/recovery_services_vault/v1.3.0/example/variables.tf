#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  type = map(object({
    resource_group_name       = string      #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = string      #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags       = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups"
  default     = {}
}

#KEY VAULT VARIABLES
variable "key_vault_variables" {
  type = map(object({
    key_vault_name                                  = string                   #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_resource_group_name                   = string                   #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_location                              = string                   #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_enabled_for_disk_encryption           = bool                     #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = bool                     #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = bool                     # (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = bool                     #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = string                   #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = bool                     #(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
    key_vault_sku_name                              = string                   #(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium
    key_vault_access_container_agent_name           = string                   #(Optional) Self hosted conatiner agent name.
    key_vault_access_policy_application_id          = string                   #(Optional) The object ID of an Application in Azure Active Directory.
    key_vault_public_network_access_enabled         = bool                     #(Optional) key_vault_public_network_access_enabled
    key_vault_access_policy_key_permissions         = list(string)             #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey.
    key_vault_access_policy_secret_permissions      = list(string)             #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = list(string)             #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = list(string)             #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update
    key_vault_tags                                  = map(string)              #(Optional) A mapping of tags which should be assigned to the key vault.
    key_vault_network_acls_enabled                  = bool                     #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass                   = string                   #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action           = string                   # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
    key_vault_network_acls_ip_rules                 = list(string)             # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.
    key_vault_network_acls_virtual_networks = list(object({                    #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
      key_vault_network_acls_virtual_networks_virtual_network_name    = string #(Required) Vitural Network name to be associated.
      key_vault_network_acls_virtual_networks_subnet_name             = string #(Required) Subnet Name to be associated.
      key_vault_network_acls_virtual_networks_subscription_id         = string #(Required) Subscription Id where Vnet is created.
      key_vault_network_acls_virtual_networks_virtual_network_rg_name = string #(Required) Resource group where Vnet is created.
    }))
    key_vault_contact_information_enabled = bool   #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email               = string #(Required) E-mail address of the contact.
    key_vault_contact_name                = string #(Optional) Name of the contact.
    key_vault_contact_phone               = string #(Optional) Phone number of the contact.
  }))
  description = "Map of Variables for Key Vault details"
  default = {
  }
}

#KEY VAULT ACCESS POLICY VARIABLES
variable "key_vault_access_policy_variables" {
  type = map(object({
    key_vault_access_policy_key_permissions         = list(string) #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.
    key_vault_access_policy_secret_permissions      = list(string) #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = list(string) #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = list(string) #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_name                                  = string       #(Required) Specifies the name of the Key Vault resource.
    key_vault_resource_group_name                   = string       #(Required) Specifies the resource group name where the key vault resides in.
    key_vault_access_resource_name                  = string       #(Required) Specifies the resource name that needs the access policy to the key vault. Possible values are username, group name, service principal name and application name 
    key_vault_access_resource_type                  = string       #(Required) Specifies the type of resource that needs the access policy to the key vault. Possible values are User, SPN, Group, Application
  }))
  description = "Map of variables for key vault access policies"
  default     = {}
}

#KEY VAULT KEY VARIABLES
variable "key_vault_key_variables" {
  description = "Map of object of key vault key variables"
  type = map(object({
    key_vault_name                = string          #(Required) The name of the Key Vault where the Key should be created.
    key_vault_resource_group_name = string          #(Required) The resource group name of the Key Vault where the Key should be created.
    key_vault_key_name            = string          #(Required) Specifies the name of the Key Vault Key.
    key_vault_key_key_type        = string          #(Required) Specifies the Key Type to use for this Key Vault Key. Possible values are EC (Elliptic Curve), EC-HSM, RSA and RSA-HSM.
    key_vault_key_key_size        = number          #(Optional) Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048. Note: This field is required if key_type is RSA or RSA-HSM.
    key_vault_key_curve           = string          #(Optional) Specifies the curve to use when creating an EC key. Possible values are P-256, P-256K, P-384, and P-521. This field will be required in a future release if key_type is EC or EC-HSM. The API will default to P-256 if nothing is specified.
    key_vault_key_key_opts        = list(string)    #(Required) A list of JSON web key operations. Possible values include: decrypt, encrypt, sign, unwrapKey, verify and wrapKey. Please note these values are case sensitive.
    key_vault_key_not_before_date = string          #(Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_key_expiration_date = string          #(Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_key_rotation_policy = object({        #(Optional) A rotation_policy block as defined below.
      rotation_policy_expire_after         = string #(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration.
      rotation_policy_notify_before_expiry = string #(Optional) Notify at a given duration before expiry as an ISO 8601 duration. Default is P30D.
      rotation_policy_automatic = object({          #(Optional) An automatic block as defined below.
        automatic_time_after_creation = string      #(Optional) Rotate automatically at a duration after create as an ISO 8601 duration.
        automatic_time_before_expiry  = string      #(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration.
      })
    })
    key_vault_key_tags = map(string) #(Optional) A mapping of tags to assign to the resource.
  }))
  default = {}
}

#USER ASSIGNED IDENTITY VARIABLES
variable "user_assigned_identity_variables" {
  type = map(object({
    user_assigned_identity_name                = string      #(Required) Specifies the name of this User Assigned Identity. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_location            = string      # (Required) The Azure Region where the User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_resource_group_name = string      #Required) Specifies the name of the Resource Group within which this User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_tags                = map(string) #(Optional) A mapping of tags which should be assigned to the User Assigned Identity.
  }))
  description = "Map of User Assigned Identities"
  default     = {}
}

#RECOVERY SERVICE VAULT VARIABLES
variable "recovery_services_vault_variables" {
  type = map(object({
    recovery_services_vault_name                               = string    #(Required) Specifies the name of the Recovery Services Vault. Recovery Service Vault name must be 2 - 50 characters long, start with a letter, contain only letters, numbers and hyphens. Changing this forces a new resource to be created.
    recovery_services_vault_resource_group_name                = string    #(Required) The name of the resource group in which to create the Recovery Services Vault. Changing this forces a new resource to be created.
    recovery_services_vault_location                           = string    #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    recovery_services_vault_sku                                = string    #(Required) Sets the vault's SKU. Possible values include: Standard, RS0
    recovery_services_vault_storage_mode_type                  = string    #(Optional) The storage type of the Recovery Services Vault. Possible values are GeoRedundant, LocallyRedundant and ZoneRedundant. Defaults to GeoRedundant.
    recovery_services_vault_cross_region_restore_enabled       = bool      #(Optional) Is cross region restore enabled for this Vault? Only can be true, when storage_mode_type is GeoRedundant. Defaults to false
    recovery_services_vault_soft_delete_enabled                = bool      #(Optional) Is soft delete enable for this Vault? Defaults to true
    recovery_services_vault_public_network_access_enabled      = bool      #(Optional) Is it enabled to access the vault from public networks. Defaults to true.
    recovery_services_vault_immutability                       = string    #(Optional) Immutability Settings of vault, possible values include: Locked, Unlocked and Disabled.
    recovery_services_vault_classic_vmware_replication_enabled = bool      #(Optional) Whether to enable the Classic experience for VMware replication. If set to false VMware machines will be protected using the new stateless ASR replication appliance. Changing this forces a new resource to be created.
    recovery_services_vault_identity = object({                            #(Optional)
      recovery_services_vault_identity_type = string                       #(Required) Specifies the type of Managed Service Identity that should be configured on this Recovery Services Vault. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      recovery_services_vault_user_assigned_identities = list(object({     #(Optional) A list of User Assigned Managed Identity IDs to be assigned to this App Configuration.
        recovery_services_vault_user_identity_name                = string # (Optional) Specifies a User Assigned Managed Identity Name to be assigned to this Recovery Services Vault.
        recovery_services_vault_user_identity_resource_group_name = string # (Optional) Specifies a User Assigned Managed Identity Resource group Name to be assigned to this Recovery Services Vault.
      }))
    })
    recovery_services_vault_encryption = object({            #(Optional) An encryption block as defined below. Required with identity.
      encryption_key_vault_name                     = string #(Required) The Key Vault name holding key used to encrypt this vault. Key managed by Vault Managed Hardware Security Module is also supported.
      encryption_key_vault_resource_group_name      = string #(Required) The Key Vault resource group name holding key used to encrypt this vault. Key managed by Vault Managed Hardware Security Module is also supported.
      encryption_key_vault_key_name                 = string #(Required) The Key Vault key name used to encrypt this vault. Key managed by Vault Managed Hardware Security Module is also supported.
      encryption_infrastructure_encryption_enabled  = bool   #(Required) Enabling/Disabling the Double Encryption state.
      encryption_user_assigned_identity_id_required = bool   #(Required) Possible values are True or False.
      encryption_use_system_assigned_identity       = bool   #(Optional) Indicate that system assigned identity should be used or not. At this time the only possible value is true. Defaults to true.
    })
    recovery_services_vault_monitoring = object({
      monitoring_alerts_for_all_job_failures_enabled            = bool #(Optional) Enabling/Disabling built-in Azure Monitor alerts for security scenarios and job failure scenarios. Defaults to true.
      monitoring_alerts_for_critical_operation_failures_enabled = bool #(Optional) Enabling/Disabling alerts from the older (classic alerts) solution. Defaults to true. 
    })
    recovery_services_vault_tags = map(string) #(Optional) A mapping of tags to assign to the resource.
  }))
  description = "Map of Variables for Recovery Service Vault details"
  default     = {}
}