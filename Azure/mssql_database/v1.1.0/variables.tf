# MSSQL Database
variable "mssql_database_variables" {
  type = map(object({
    mssql_database_name                                    = string #Required
    mssql_database_collation                               = string #Optional Specifies the collation of the database
    mssql_database_license_type                            = string #Optional Possible values are LicenseIncluded and BasePrice.
    mssql_database_max_size_gb                             = number #Optional The max size of the database in gigabytes.
    mssql_database_read_scale                              = bool   #Optional This property is only settable for Premium and Business Critical databases.
    mssql_database_sku_name                                = string #Optional Specifies the name of the SKU used by the database. For example, GP_S_Gen5_2,HS_Gen4_1,BC_Gen5_2, ElasticPool, Basic,S0, P2 ,DW100c, DS100.
    mssql_database_zone_redundant                          = bool   #Optional This property is only settable for Premium and Business Critical databases.
    mssql_database_auto_pause_delay_in_minutes             = number #Optional A value of -1 means that automatic pause is disabled.
    mssql_database_create_mode                             = string #Optional The create mode of the database. Possible values are Copy, Default, OnlineSecondary, PointInTimeRestore, Recovery, Restore, RestoreExternalBackup, RestoreExternalBackupSecondary, RestoreLongTermRetentionBackup and Secondary.
    mssql_database_geo_backup_enabled                      = bool   #Optional only applicable for DataWarehouse SKUs (DW*)
    mssql_database_ledger_enabled                          = bool   #Optional A boolean that specifies if this is a ledger database.
    mssql_database_min_capacity                            = number #Optional This property is only settable for General Purpose Serverless databases.
    mssql_database_restore_point_in_time                   = string #Required This property is only settable for create_mode= PointInTimeRestore databases.
    mssql_database_read_replica_count                      = number #Optional This property is only settable for Hyperscale edition databases.
    mssql_database_sample_name                             = string #Optional Possible value is AdventureWorksLT.
    mssql_database_storage_account_type                    = string #Optional Possible values are Geo, GeoZone, Local and Zone. The default value is Geo.
    mssql_database_transparent_data_encryption_enabled     = bool   #Required Defaults to true.
    mssql_database_mssql_server_name                       = string
    mssql_database_mssql_server_resource_group_name        = string
    mssql_database_creation_source_database_name           = string
    mssql_database_source_mssql_server_name                = string
    mssql_database_source_mssql_server_resource_group_name = string
    mssql_database_storage_account_name                    = string
    mssql_database_storage_account_resource_group_name     = string
    mssql_database_elastic_pool_name                       = string
    mssql_database_elastic_pool_resource_group_name        = string
    mssql_database_threat_detection_policy_required        = bool
    mssql_database_threat_detection_policy = object({
      threat_detection_policy_state                = string       #Required Possible values are Enabled, Disabled or New.
      threat_detection_policy_disabled_alerts      = list(string) #Optional Possible values include Access_Anomaly, Sql_Injection and Sql_Injection_Vulnerability.
      threat_detection_policy_email_account_admins = string       #Optional Should the account administrators be emailed when this alert is triggered?
      threat_detection_policy_email_addresses      = list(string) #Optional
      threat_detection_policy_retention_days       = number       #Optional
    })
    mssql_database_long_term_retention_policy_required = bool
    mssql_database_long_term_retention_policy = object({
      long_term_retention_policy_weekly_retention  = string #Optional Valid value is between 1 to 520 weeks. e.g. P1Y, P1M, P1W or P7D.
      long_term_retention_policy_monthly_retention = string #Optional Valid value is between 1 to 120 months. e.g. P1Y, P1M, P4W or P30D.
      long_term_retention_policy_yearly_retention  = string #Optional Valid value is between 1 to 10 years. e.g. P1Y, P12M, P52W or P365D.
      long_term_retention_policy_week_of_year      = number #Optional Value has to be between 1 and 52.
    })
    mssql_database_short_term_retention_policy_required = bool
    mssql_database_short_term_retention_policy = object({
      short_term_retention_policy_retention_days           = number #Required Point In Time Restore configuration. Value has to be between 7 and 35.
      short_term_retention_policy_backup_interval_in_hours = number #Optional Value has to be 12 or 24. Defaults to 12 hours.
    })
    mssql_database_tags = map(string)
  }))
  description = "variable for mssql database details"
  default     = {}
}