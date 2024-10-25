#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
  default = {}
}

#Variables for Recovery Service Vault
variable "recovery_service_vault_variable" {
  type = map(object({
    name                = string
    resource_group_name = string
    sku                 = string
    soft_delete_enabled = bool
    identity = map(object({
      type = string
    }))
    storage_mode_type = string
    encryption = map(object({
      key_id                            = string
      infrastructure_encryption_enabled = string
      use_system_assigned_identity      = bool
    }))
    tags = map(string)
  }))
}

