#Variables for Recovery Service Vault
variable "recovery_services_vault_variables" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    sku                 = string # (Required) Sets the vault's SKU. Possible values include: Standard, RS0
    soft_delete_enabled = bool
    identity = list(object({
      type = string
    }))
    storage_mode_type            = string # (Optional) The storage type of the Recovery Services Vault. Possible values are GeoRedundant, LocallyRedundant and ZoneRedundant. Defaults to GeoRedundant.
    cross_region_restore_enabled = bool   # (Optional) Is cross region restore enabled for this Vault? Only can be true, when storage_mode_type is GeoRedundant. Defaults to false
    encryption = map(object({
      key_id                            = string
      infrastructure_encryption_enabled = string
      use_system_assigned_identity      = bool
    }))
    tags = map(string)
  }))
}

