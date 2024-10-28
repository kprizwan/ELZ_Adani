### Attributes:

- mssql_database_name                                    = string #(Required) The name of the MS SQL Database. Changing this forces a new resource to be created.
- mssql_database_collation                               = string #(Optional) Specifies the collation of the database. Changing this forces a new resource to be created.
- mssql_database_license_type                            = string #(Optional) Specifies the license type applied to this database. Possible values are LicenseIncluded and BasePrice.
- mssql_database_max_size_gb                             = number #(Optional) The max size of the database in gigabytes.
- mssql_database_read_scale                              = bool   #(Optional) If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica. This property is only settable for Premium and Business Critical databases.
- mssql_database_sku_name                                = string #(Optional) Specifies the name of the SKU used by the database. For example, GP_S_Gen5_2,HS_Gen4_1,BC_Gen5_2, ElasticPool, Basic,S0, P2 ,DW100c, DS100. Changing this from the HyperScale service tier to another service tier will force a new resource to be created.
- mssql_database_zone_redundant                          = bool   #(Optional) Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones. This property is only settable for Premium and Business Critical databases.
- mssql_database_auto_pause_delay_in_minutes             = number #(Optional) Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled. This property is only settable for General Purpose Serverless databases.
- mssql_database_create_mode                             = string #(Optional) The create mode of the database. Possible values are Copy, Default, OnlineSecondary, PointInTimeRestore, Recovery, Restore, RestoreExternalBackup, RestoreExternalBackupSecondary, RestoreLongTermRetentionBackup and Secondary. Mutually exclusive with import.
- mssql_database_geo_backup_enabled                      = bool   #(Optional) A boolean that specifies if the Geo Backup Policy is enabled.
- mssql_database_ledger_enabled                          = bool   #(Optional) A boolean that specifies if this is a ledger database. Defaults to false. Changing this forces a new resource to be created.
- mssql_database_min_capacity                            = number #(Optional) Minimal capacity that database will always have allocated, if not paused. This property is only settable for General Purpose Serverless databases.
- mssql_database_restore_point_in_time                   = string #(Required) Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database. This property is only settable for create_mode= PointInTimeRestore databases.
- mssql_database_read_replica_count                      = number #(Optional) The number of readonly secondary replicas associated with the database to which readonly application intent connections may be routed. This property is only settable for Hyperscale edition databases.
- mssql_database_sample_name                             = string #(Optional) Specifies the name of the sample schema to apply when creating this database. Possible value is AdventureWorksLT.
- mssql_database_storage_account_type                    = string #(Optional) Specifies the storage account type used to store backups for this database. Possible values are Geo, Local and Zone. The default value is Geo.
- mssql_database_transparent_data_encryption_enabled     = bool   #(Required) If set to true, Transparent Data Encryption will be enabled on the database. Defaults to true.
- mssql_database_mssql_server_name                       = string #(Required) The name of mssql server on which to create the database.
- mssql_database_mssql_server_resource_group_name        = string #(Required) The name of the resource group in which the mssql_server resides in.
- mssql_database_creation_source_database_name           = string #(Optional) The name of the source database from which to create the new database. This should only be used for databases with create_mode values that use another database as reference.
- mssql_database_source_mssql_server_name                = string #(Optional) The name of source mssql server on which to create the database.
- mssql_database_source_mssql_server_resource_group_name = string #(Optional) The name of the resource group in which the source_mssql_server for creation_source_database resides in.
- mssql_database_storage_account_name                    = string #() The name of the storage account to be used for storage_account_access_key & storage_endpoint
- mssql_database_storage_account_resource_group_name     = string #() The name of the resource group in which the storage account resides in
- mssql_database_elastic_pool_name                       = string #(Optional) The name of the elastic pool containing this database
- mssql_database_elastic_pool_resource_group_name        = string #(Optional) The name of the resource group containing the elastic pool
- mssql_database_threat_detection_policy_required        = bool #(Required) Whether a threat_detection_policy is needed or not. Possible values are true and false.
- mssql_database_threat_detection_policy = object({ #(Optional) Threat detection policy configuration. The threat_detection_policy block supports fields documented below.
      threat_detection_policy_state                = string       #(Required) The State of the Policy. Possible values are Enabled, Disabled or New.
      threat_detection_policy_disabled_alerts      = list(string) #(Optional) Specifies a list of alerts which should be disabled. Possible values include Access_Anomaly, Sql_Injection and Sql_Injection_Vulnerability.
      threat_detection_policy_email_account_admins = string       #(Optional) Should the account administrators be emailed when this alert is triggered?
      threat_detection_policy_email_addresses      = list(string) #(Optional) A list of email addresses which alerts should be sent to.
      threat_detection_policy_retention_days       = number       #(Optional) Specifies the number of days to keep in the Threat Detection audit logs.
    })
- mssql_database_long_term_retention_policy_required = bool #(Required) Whether a long_term_retention_policy is needed or not. Possible values are true and false.
- mssql_database_long_term_retention_policy = object({ #(Optional) A long_term_retention_policy block as defined below.
      long_term_retention_policy_weekly_retention  = string #(Optional) The weekly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 520 weeks. e.g. P1Y, P1M, P1W or P7D.
      long_term_retention_policy_monthly_retention = string #(Optional) The monthly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 120 months. e.g. P1Y, P1M, P4W or P30D.
      long_term_retention_policy_yearly_retention  = string #(Optional) The yearly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 10 years. e.g. P1Y, P12M, P52W or P365D.
      long_term_retention_policy_week_of_year      = number #(Required) The week of year to take the yearly backup. Value has to be between 1 and 52.
    })
- mssql_database_short_term_retention_policy_required = bool #(Required) Whether a short_term_retention_policy is needed or not. Possible values are true and false.
- mssql_database_short_term_retention_policy = object({ #(Optional) A short_term_retention_policy block as defined below
      short_term_retention_policy_retention_days           = number #(Required) Point In Time Restore configuration. Value has to be between 7 and 35.
      short_term_retention_policy_backup_interval_in_hours = number #(Optional) The hours between each differential backup. This is only applicable to live databases but not dropped databases. Value has to be 12 or 24. Defaults to 12 hours.
    })
- mssql_database_tags = map(string) #(Optional) A mapping of tags which should be assigned to the mssql_database
  }))

>## Notes:

>1. auto_pause_delay_in_minutes is still required for "Serverless" SKUs
>2. When configuring a secondary database, please be aware of the constraints for the sku_name property, as noted below, for both the primary and secondary databases. The sku_name of the secondary database may be inadvertently changed to match that of the primary when an incompatible combination of SKUs is detected by the provider.
>3. geo_backup_enabled is only applicable for DataWarehouse SKUs (DW*). This setting is ignored for all other SKUs.
>4. maintenance_configuration_name is only applicable if elastic_pool_id is not set.
>5. This value should not be configured when the create_mode is Secondary or OnlineSecondary, as the sizing of the primary is then used as per Azure documentation.
>6. The default sku_name value may differ between Azure locations depending on local availability of Gen4/Gen5 capacity. When databases are replicated using the creation_source_database_id property, the source (primary) database cannot have a higher SKU service tier than any secondary databases. When changing the sku_name of a database having one or more secondary databases, this resource will first update any secondary databases as necessary. In such cases it's recommended to use the same sku_name in your configuration for all related databases, as not doing so may cause an unresolvable diff during subsequent plans.
>7. TDE cannot be disabled on servers with SKUs other than ones starting with DW.