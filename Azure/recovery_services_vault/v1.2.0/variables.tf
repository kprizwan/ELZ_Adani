variable "recovery_services_vault_variables" {
  type = map(object({
    recovery_services_vault_name                         = string #(Required) Specifies the name of the Recovery Services Vault. Recovery Service Vault name must be 2 - 50 characters long, start with a letter, contain only letters, numbers and hyphens. Changing this forces a new resource to be created.
    recovery_services_vault_resource_group_name          = string #(Required) The name of the resource group in which to create the Recovery Services Vault. Changing this forces a new resource to be created.
    recovery_services_vault_location                     = string #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    recovery_services_vault_sku                          = string #(Required) Sets the vault's SKU. Possible values include: Standard, RS0
    recovery_services_vault_storage_mode_type            = string #(Optional) The storage type of the Recovery Services Vault. Possible values are GeoRedundant, LocallyRedundant and ZoneRedundant. Defaults to GeoRedundant.
    recovery_services_vault_cross_region_restore_enabled = bool   #(Optional) Is cross region restore enabled for this Vault? Only can be true, when storage_mode_type is GeoRedundant. Defaults to false
    recovery_services_vault_soft_delete_enabled          = bool   #(Optional) Is soft delete enable for this Vault? Defaults to true
    recovery_services_vault_identity = object({                   #(Optional) An identity block as defined below.
      recovery_services_vault_identity_type = string              #(Required) Specifies the type of Managed Service Identity that should be configured on this Recovery Services Vault. The only possible value is SystemAssigned
    })
    recovery_services_vault_encryption = object({           #(Optional) An encryption block as defined below. Required with identity.
      encryption_key_vault_name                    = string #(Required) The Key Vault name holding key used to encrypt this vault. Key managed by Vault Managed Hardware Security Module is also supported.
      encryption_key_vault_resource_group_name     = string #(Required) The Key Vault resource group name holding key used to encrypt this vault. Key managed by Vault Managed Hardware Security Module is also supported.
      encryption_key_vault_key_name                = string #(Required) The Key Vault key name used to encrypt this vault. Key managed by Vault Managed Hardware Security Module is also supported.
      encryption_infrastructure_encryption_enabled = bool   #(Required) Enabling/Disabling the Double Encryption state.
      encryption_use_system_assigned_identity      = bool   #(Optional) Indicate that system assigned identity should be used or not. At this time the only possible value is true. Defaults to true.
    })
    recovery_services_vault_tags = map(string) #(Optional) A mapping of tags to assign to the resource.
  }))
  description = "Map of Variables for Recovery Service Vault details"
  default     = {}
}