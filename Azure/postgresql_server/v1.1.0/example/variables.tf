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

variable "resource_group_variables_key_vault" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
  default = {}
}

#KEY VAULT VARIABLES
variable "key_vault_variables" {
  type = map(object({
    key_vault_name                                  = string
    key_vault_resource_group_name                   = string
    key_vault_location                              = string
    key_vault_enabled_for_disk_encryption           = bool
    key_vault_enabled_for_deployment                = bool
    key_vault_enabled_for_template_deployment       = bool
    key_vault_enable_rbac_authorization             = bool
    key_vault_soft_delete_retention_days            = string
    key_vault_purge_protection_enabled              = bool
    key_vault_sku_name                              = string
    key_vault_access_container_agent_name           = string
    key_vault_access_policy_key_permissions         = list(string)
    key_vault_access_policy_secret_permissions      = list(string)
    key_vault_access_policy_storage_permissions     = list(string)
    key_vault_access_policy_certificate_permissions = list(string)
    key_vault_tags                                  = map(string)
    key_vault_network_acls_enabled                  = bool
    key_vault_network_acls_bypass                   = string
    key_vault_network_acls_default_action           = string
    key_vault_network_acls_ip_rules                 = list(string)
    key_vault_network_acls_virtual_networks = list(object({
      virtual_network_name    = string
      subnet_name             = string
      subscription_id         = string
      virtual_network_rg_name = string
    }))
    key_vault_contact_information_enabled = bool
    key_vault_contact_email               = string
    key_vault_contact_name                = string
    key_vault_contact_phone               = string
  }))
}

#Postgresql Server VARIABLES
variable "postgresql_server_variables" {
  type = map(object({
    postgresql_server_name                                 = string
    postgresql_server_location                             = string
    postgresql_server_resource_group_name                  = string
    postgresql_server_administrator_login                  = string
    postgresql_server_sku_name                             = string
    postgresql_server_version                              = string
    postgresql_server_storage_mb                           = number
    postgresql_server_backup_retention_days                = number
    postgresql_server_geo_redundant_backup_enabled         = bool
    postgresql_server_auto_grow_enabled                    = bool
    postgresql_server_public_network_access_enabled        = bool
    postgresql_server_ssl_enforcement_enabled              = bool
    postgresql_server_ssl_minimal_tls_version_enforced     = string
    postgresql_server_create_mode                          = string
    postgresql_server_creation_source_server_id            = string
    postgresql_server_infrastructure_encryption_enabled    = bool
    postgresql_server_restore_point_in_time                = string
    postgresql_server_assign_identity                      = bool
    postgresql_server_generate_new_admin_password          = bool
    postgresql_server_admin_password_key_vault_name        = string
    postgresql_server_key_vault_resource_group_name        = string
    postgresql_server_admin_password_key_vault_secret_name = string
    postgresql_server_threat_detection_policy = object({
      postgresql_server_enable_threat_detection_policy = bool
      postgresql_server_disabled_alerts                = list(string)
      postgresql_server_email_addresses_for_alerts     = list(string)
      postgresql_server_log_retention_days             = number
      postgresql_server_storage_account_name           = string
      postgresql_server_storage_account_resource_group = string
    })
    postgresql_server_tags = map(string)
  }))
  description = "variable for PostgrSql server details"
  default     = {}
}
