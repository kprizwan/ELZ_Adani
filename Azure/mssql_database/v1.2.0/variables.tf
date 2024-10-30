# MSSQL Database
variable "mssql_database_variables" {
  description = "variable for mssql database details"
  type = map(object({
    mssql_database_name                                    = string #(Required) The name of the MS SQL Database. Changing this forces a new resource to be created.
    mssql_database_collation                               = string #(Optional) Specifies the collation of the database. Changing this forces a new resource to be created.
    mssql_database_license_type                            = string #(Optional) Specifies the license type applied to this database. Possible values are LicenseIncluded and BasePrice.
    mssql_database_max_size_gb                             = number #(Optional) The max size of the database in gigabytes.
    mssql_database_read_scale                              = bool   #(Optional) If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica. This property is only settable for Premium and Business Critical databases.
    mssql_database_sku_name                                = string #(Optional) Specifies the name of the SKU used by the database. For example, GP_S_Gen5_2,HS_Gen4_1,BC_Gen5_2, ElasticPool, Basic,S0, P2 ,DW100c, DS100. Changing this from the HyperScale service tier to another service tier will force a new resource to be created.
    mssql_database_zone_redundant                          = bool   #(Optional) Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones. This property is only settable for Premium and Business Critical databases.
    mssql_database_auto_pause_delay_in_minutes             = number #(Optional) Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled. This property is only settable for General Purpose Serverless databases.
    mssql_database_create_mode                             = string #(Optional) The create mode of the database. Possible values are Copy, Default, OnlineSecondary, PointInTimeRestore, Recovery, Restore, RestoreExternalBackup, RestoreExternalBackupSecondary, RestoreLongTermRetentionBackup and Secondary. Mutually exclusive with import.
    mssql_database_geo_backup_enabled                      = bool   #(Optional) A boolean that specifies if the Geo Backup Policy is enabled.
    mssql_database_maintenance_configuration_name          = string #(Optional) The name of the Public Maintenance Configuration window to apply to the database. Valid values include SQL_Default, SQL_EastUS_DB_1, SQL_EastUS2_DB_1, SQL_SoutheastAsia_DB_1, SQL_AustraliaEast_DB_1, SQL_NorthEurope_DB_1, SQL_SouthCentralUS_DB_1, SQL_WestUS2_DB_1, SQL_UKSouth_DB_1, SQL_WestEurope_DB_1, SQL_EastUS_DB_2, SQL_EastUS2_DB_2, SQL_WestUS2_DB_2, SQL_SoutheastAsia_DB_2, SQL_AustraliaEast_DB_2, SQL_NorthEurope_DB_2, SQL_SouthCentralUS_DB_2, SQL_UKSouth_DB_2, SQL_WestEurope_DB_2, SQL_AustraliaSoutheast_DB_1, SQL_BrazilSouth_DB_1, SQL_CanadaCentral_DB_1, SQL_CanadaEast_DB_1, SQL_CentralUS_DB_1, SQL_EastAsia_DB_1, SQL_FranceCentral_DB_1, SQL_GermanyWestCentral_DB_1, SQL_CentralIndia_DB_1, SQL_SouthIndia_DB_1, SQL_JapanEast_DB_1, SQL_JapanWest_DB_1, SQL_NorthCentralUS_DB_1, SQL_UKWest_DB_1, SQL_WestUS_DB_1, SQL_AustraliaSoutheast_DB_2, SQL_BrazilSouth_DB_2, SQL_CanadaCentral_DB_2, SQL_CanadaEast_DB_2, SQL_CentralUS_DB_2, SQL_EastAsia_DB_2, SQL_FranceCentral_DB_2, SQL_GermanyWestCentral_DB_2, SQL_CentralIndia_DB_2, SQL_SouthIndia_DB_2, SQL_JapanEast_DB_2, SQL_JapanWest_DB_2, SQL_NorthCentralUS_DB_2, SQL_UKWest_DB_2, SQL_WestUS_DB_2, SQL_WestCentralUS_DB_1, SQL_FranceSouth_DB_1, SQL_WestCentralUS_DB_2, SQL_FranceSouth_DB_2, SQL_SwitzerlandNorth_DB_1, SQL_SwitzerlandNorth_DB_2, SQL_BrazilSoutheast_DB_1, SQL_UAENorth_DB_1, SQL_BrazilSoutheast_DB_2, SQL_UAENorth_DB_2. Defaults to SQL_Default.
    mssql_database_ledger_enabled                          = bool   #(Optional) A boolean that specifies if this is a ledger database. Defaults to false. Changing this forces a new resource to be created.
    mssql_database_min_capacity                            = number #(Optional) Minimal capacity that database will always have allocated, if not paused. This property is only settable for General Purpose Serverless databases.
    mssql_database_restore_point_in_time                   = string #(Required) Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database. This property is only settable for create_mode= PointInTimeRestore databases.
    mssql_database_read_replica_count                      = number #(Optional) The number of readonly secondary replicas associated with the database to which readonly application intent connections may be routed. This property is only settable for Hyperscale edition databases.
    mssql_database_sample_name                             = string #(Optional) Specifies the name of the sample schema to apply when creating this database. Possible value is AdventureWorksLT.
    mssql_database_storage_account_type                    = string #(Optional) Specifies the storage account type used to store backups for this database. Possible values are Geo, Local and Zone. The default value is Geo.
    mssql_database_transparent_data_encryption_enabled     = bool   #(Required) If set to true, Transparent Data Encryption will be enabled on the database. Defaults to true.
    mssql_database_mssql_server_name                       = string #(Required) The name of mssql server on which to create the database.
    mssql_database_mssql_server_resource_group_name        = string #(Required) The name of the resource group in which the mssql_server resides in.
    mssql_database_creation_source_database_name           = string #(Optional) The name of the source database from which to create the new database. This should only be used for databases with create_mode values that use another database as reference.
    mssql_database_source_mssql_server_name                = string #(Optional) The name of source mssql server on which to create the database.
    mssql_database_source_mssql_server_resource_group_name = string #(Optional) The name of the resource group in which the source_mssql_server for creation_source_database resides in.
    mssql_database_storage_account_name                    = string #(Optional) The name of the storage account to be used for storage_account_access_key & storage_endpoint
    mssql_database_storage_account_resource_group_name     = string #(Optional) The name of the resource group in which the storage account resides in
    mssql_database_elastic_pool_name                       = string #(Optional) The name of the elastic pool containing this database
    mssql_database_elastic_pool_resource_group_name        = string #(Optional) The name of the resource group containing the elastic pool
    mssql_database_threat_detection_policy_required        = bool   #(Required) Whether a threat_detection_policy is needed or not. Possible values are true and false.
    mssql_database_threat_detection_policy = object({               #(Optional) Threat detection policy configuration. The threat_detection_policy block supports fields documented below.
      threat_detection_policy_state                = string         #(Required) The State of the Policy. Possible values are Enabled, Disabled or New.
      threat_detection_policy_disabled_alerts      = list(string)   #(Optional) Specifies a list of alerts which should be disabled. Possible values include Access_Anomaly, Sql_Injection and Sql_Injection_Vulnerability.
      threat_detection_policy_email_account_admins = string         #(Optional) Should the account administrators be emailed when this alert is triggered?
      threat_detection_policy_email_addresses      = list(string)   #(Optional) A list of email addresses which alerts should be sent to.
      threat_detection_policy_retention_days       = number         #(Optional) Specifies the number of days to keep in the Threat Detection audit logs.
    })
    mssql_database_long_term_retention_policy_required = bool #(Required) Whether a long_term_retention_policy is needed or not. Possible values are true and false.
    mssql_database_long_term_retention_policy = object({      #(Optional) A long_term_retention_policy block as defined below.
      long_term_retention_policy_weekly_retention  = string   #(Optional) The weekly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 520 weeks. e.g. P1Y, P1M, P1W or P7D.
      long_term_retention_policy_monthly_retention = string   #(Optional) The monthly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 120 months. e.g. P1Y, P1M, P4W or P30D.
      long_term_retention_policy_yearly_retention  = string   #(Optional) The yearly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 10 years. e.g. P1Y, P12M, P52W or P365D.
      long_term_retention_policy_week_of_year      = number   #(Required) The week of year to take the yearly backup. Value has to be between 1 and 52.
    })
    mssql_database_short_term_retention_policy_required = bool      #(Required) Whether a short_term_retention_policy is needed or not. Possible values are true and false.
    mssql_database_short_term_retention_policy = object({           #(Optional) A short_term_retention_policy block as defined below
      short_term_retention_policy_retention_days           = number #(Required) Point In Time Restore configuration. Value has to be between 7 and 35.
      short_term_retention_policy_backup_interval_in_hours = number #(Optional) The hours between each differential backup. This is only applicable to live databases but not dropped databases. Value has to be 12 or 24. Defaults to 12 hours.
    })
    mssql_database_tags = map(string) #(Optional) A mapping of tags which should be assigned to the mssql_database
  }))
  default = {}
}