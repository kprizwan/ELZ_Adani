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
