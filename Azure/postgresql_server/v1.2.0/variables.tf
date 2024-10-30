#Postgresql Server VARIABLES
variable "postgresql_server_variables" {
  type = map(object({
    postgresql_server_name                                 = string   #(Required) Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created.
    postgresql_server_location                             = string   #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    postgresql_server_resource_group_name                  = string   #(Required) The name of the resource group in which to create the PostgreSQL Server. Changing this forces a new resource to be created.
    postgresql_server_administrator_login                  = string   #(Optional) The Administrator login for the PostgreSQL Server. Required when create_mode is Default. Changing this forces a new resource to be created.
    postgresql_server_sku_name                             = string   #(Required) Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8).
    postgresql_server_version                              = string   #(Required) Specifies the version of PostgreSQL to use. Valid values are 9.5, 9.6, 10, 10.0, 10.2 and 11. Changing this forces a new resource to be created.
    postgresql_server_storage_mb                           = number   #(Optional) Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 16777216 MB(16TB) for General Purpose/Memory Optimized SKUs. For more information see the product documentation.
    postgresql_server_backup_retention_days                = number   #(Optional) Backup retention days for the server, supported values are between 7 and 35 days.
    postgresql_server_geo_redundant_backup_enabled         = bool     #(Optional) Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster. This is not support for the Basic tier. Changing this forces a new resource to be created.
    postgresql_server_auto_grow_enabled                    = bool     #(Optional) Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. The default value if not explicitly specified is true.
    postgresql_server_public_network_access_enabled        = bool     #(Optional) Whether or not public network access is allowed for this server. Defaults to true.
    postgresql_server_ssl_enforcement_enabled              = bool     #(Required) Specifies if SSL should be enforced on connections. Possible values are true and false.
    postgresql_server_ssl_minimal_tls_version_enforced     = string   #(Optional) The minimum TLS version to support on the sever. Possible values are TLSEnforcementDisabled, TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2.
    postgresql_server_create_mode                          = string   #(Optional) The creation mode. Can be used to restore or replicate existing servers. Possible values are Default, Replica, GeoRestore, and PointInTimeRestore. Defaults to Default.
    postgresql_server_creation_source_server_name          = string   #(Optional) To fetch source server ID. For creation modes other than Default, the source server ID to use.
    postgresql_server_infrastructure_encryption_enabled    = bool     #(Optional) Whether or not infrastructure is encrypted for this server. Defaults to false. Changing this forces a new resource to be created.
    postgresql_server_restore_point_in_time                = string   #(Optional) When create_mode is PointInTimeRestore the point in time to restore from creation_source_server_id. It should be provided in RFC3339 format, e.g. 2013-11-08T22:00:40Z.
    postgresql_server_assign_identity                      = bool     #(Optional) Whether SystemAssigned identity required or not
    postgresql_server_generate_new_admin_password          = bool     #(Optional) To decide generate new password. The Password associated with the administrator_login for the PostgreSQL Server. Required when create_mode is Default.
    postgresql_server_admin_password_key_vault_name        = string   #(Optional) To fetch The Password associated with the administrator_login for the PostgreSQL Server. Required when create_mode is Default.
    postgresql_server_key_vault_resource_group_name        = string   #(Optional) To fetch The Password associated with the administrator_login for the PostgreSQL Server. Required when create_mode is Default.
    postgresql_server_admin_password_key_vault_secret_name = string   #(Optional) To fetch existing password. The Password associated with the administrator_login for the PostgreSQL Server. Required when create_mode is Default.
    postgresql_server_threat_detection_policy = object({              #(Optional)
      postgresql_server_enable_threat_detection_policy = bool         #(Required) Is the policy enabled?
      postgresql_server_disabled_alerts                = list(string) #(Optional) Specifies a list of alerts which should be disabled. Possible values include Access_Anomaly, Sql_Injection and Sql_Injection_Vulnerability.
      postgresql_server_email_addresses_for_alerts     = list(string) #(Optional) A list of email addresses which alerts should be sent to.
      postgresql_server_log_retention_days             = number       #(Optional) Specifies the number of days to keep in the Threat Detection audit logs.
      postgresql_server_storage_account_name           = string       #(Optional) To fetch storage account. Specifies the identifier key of the Threat Detection audit storage account.
      postgresql_server_storage_account_resource_group = string       ##(Optional) To fetch storage account. Specifies the identifier key of the Threat Detection audit storage account.
    })
    postgresql_server_tags = map(string) #(Optional) A mapping of tags to assign to the resource.
  }))
  description = "variable for PostgrSql server details"
  default     = {}
}
