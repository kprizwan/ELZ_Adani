## Attributes:
- recovery_services_vault_name                               = string    #(Required) Specifies the name of the Recovery Services Vault. Recovery Service Vault name must be 2 - 50 characters long, start with a letter, contain only letters, numbers and hyphens. Changing this forces a new resource to be created.
- recovery_services_vault_resource_group_name                = string    #(Required) The name of the resource group in which to create the Recovery Services Vault. Changing this forces a new resource to be created.
- recovery_services_vault_location                           = string    #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
- recovery_services_vault_sku                                = string    #(Required) Sets the vault's SKU. Possible values include: Standard, RS0
- recovery_services_vault_storage_mode_type                  = string    #(Optional) The storage type of the Recovery Services Vault. Possible values are GeoRedundant, LocallyRedundant and ZoneRedundant. Defaults to GeoRedundant.
- recovery_services_vault_cross_region_restore_enabled       = bool      #(Optional) Is cross region restore enabled for this Vault? Only can be true, when storage_mode_type is GeoRedundant. Defaults to false
- recovery_services_vault_soft_delete_enabled                = bool      #(Optional) Is soft delete enable for this Vault? Defaults to true
- recovery_services_vault_public_network_access_enabled      = bool      #(Optional) Is it enabled to access the vault from public networks. Defaults to true.
- recovery_services_vault_immutability                       = string    #(Optional) Immutability Settings of vault, possible values include: Locked, Unlocked and Disabled.
- recovery_services_vault_classic_vmware_replication_enabled = bool      #(Optional) Whether to enable the Classic experience for VMware replication. If set to false VMware machines will be protected using the new stateless ASR replication appliance. Changing this forces a new resource to be created.
- recovery_services_vault_identity = (object)                            #(Optional)
- recovery_services_vault_identity_type = string                       #(Required) Specifies the type of Managed Service Identity that should be configured on this Recovery Services Vault. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
- recovery_services_vault_user_assigned_identities = list(object)     #(Optional) A list of User Assigned Managed Identity IDs to be assigned to this App Configuration.
- recovery_services_vault_user_identity_name                = string # (Optional) Specifies a User Assigned Managed Identity Name to be assigned to this Recovery Services Vault.
- recovery_services_vault_user_identity_resource_group_name = string # (Optional) Specifies a User Assigned Managed Identity Resource group Name to be assigned to this Recovery Services Vault.
- recovery_services_vault_encryption = (object)            #(Optional) An encryption block as defined below. Required with identity.
- encryption_key_vault_name                     = string #(Required) The Key Vault name holding key used to encrypt this vault. Key managed by Vault Managed Hardware Security Module is also supported.
- encryption_key_vault_resource_group_name      = string #(Required) The Key Vault resource group name holding key used to encrypt this vault. Key managed by Vault Managed Hardware Security Module is also supported.
-  encryption_key_vault_key_name                 = string #(Required) The Key Vault key name used to encrypt this vault. Key managed by Vault Managed Hardware Security Module is also supported.
- encryption_infrastructure_encryption_enabled  = bool   #(Required) Enabling/Disabling the Double Encryption state.
- encryption_user_assigned_identity_id_required = bool   #(Required) Possible values are True or False.
- encryption_use_system_assigned_identity       = bool   #(Optional) Indicate that system assigned identity should be used or not. At this time the only possible value is true. Defaults to true.
- recovery_services_vault_monitoring = (object)
- monitoring_alerts_for_all_job_failures_enabled            = bool #(Optional) Enabling/Disabling built-in Azure Monitor alerts for security scenarios and job failure scenarios. Defaults to true.
- monitoring_alerts_for_critical_operation_failures_enabled = bool #(Optional) Enabling/Disabling alerts from the older (classic alerts) solution. Defaults to true. 
- recovery_services_vault_tags = map(string) #(Optional) A mapping of tags to assign to the resource. 

>## Notes:
>1. Once Encryption with your own key has been Enabled it's not possible to Disable it.
>2. Once infrastructure_encryption_enabled has been set it's not possible to change it.
>3. Enabling Encryption has bug in it since it is not able to access key for encryption from key vault.
>4. Once cross_region_restore_enabled is set to true, changing it back to false forces a new Recovery Service Vault to be created.
>5. use_system_assigned_identity only be able to set to false for new vaults. Any vaults containing existing items registered or attempted to be registered to it are not supported. Details can be found in the document.