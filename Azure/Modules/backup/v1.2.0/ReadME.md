### Attributes: ###

- backup_policy_vm_name                           = string # (Required) Specifies the name of the Backup Policy. Changing this forces a new resource to be created
- backup_policy_vm_timezone                       = string # (Optional) Specifies the timezone. the possible values are defined here. Defaults to UTC
- backup_policy_vm_resource_group_name            = string # (Required) The name of the resource group in which to create the policy. Changing this forces a new resource to be created
- backup_policy_vm_recovery_vault_name            = string # (Required) Specifies the name of the Recovery Services Vault to use. Changing this forces a new resource to be created
- backup_policy_vm_policy_type                    = string # (Optional) Type of the Backup Policy. Possible values are V1 and V2 where V2 stands for the Enhanced Policy. Defaults to V1. Changing this forces a new resource to be created.
- backup_policy_vm_instant_restore_retention_days = string # (Optional) Specifies the instant restore retention range in days. Possible values are between 1 and 5 when policy_type is V1, and 1 to 30 when policy_type is V2.
- backup_policy_vm_backup = object()
  - backup_frequency     = string       # (Required) Sets the backup frequency. Must be either Daily or Weekly
  - backup_time          = string       # (Required) The time of day to perform the backup in 24hour format
  - backup_hour_interval = string       # (Required) Possible values are 4, 6, 8 and 12. This is used when frequency is Hourly.
  - backup_hour_duration = string       # (Optional) Possible values are between 4 and 24 This is used when frequency is Hourly.
  - backup_weekdays      = list(string) # (Optional) The days of the week to perform backups on. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday. This is used when frequency is Weekly.
- backup_policy_vm_retention_daily = object() # (Required) The number of daily backups to keep.
  - retention_daily_count = number            # (Required) The number of daily backups to keep. Must be between 7 and 9999
- backup_policy_vm_retention_weekly = object() # (Required) The number of weekly backups to keep.
    - retention_weekly_count    = number         # Must be between 1 and 9999
    - retention_weekly_weekdays = list(string)   # (Required) The weekday backups to retain. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday
- backup_policy_vm_retention_monthly = object({ # (Required) The number of monthly backups to keep.
    - retention_monthly_count    = number         # (Required) The number of monthly backups to keep. Must be between 1 and 9999
    - retention_monthly_weekdays = list(string)   # (Required) The weekday backups to retain . Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday
    - retention_monthly_weeks    = list(string)   # (Required) The weeks of the month to retain backups of. Must be one of First, Second, Third, Fourth, Last
- backup_policy_vm_retention_yearly = object() # (Required) The number of yearly backups to keep.
    - retention_yearly_count    = number         # (Required) The number of yearly backups to keep. Must be between 1 and 9999
    - retention_yearly_weekdays = list(string)   # (Required) The weekday backups to retain . Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday
    - retention_yearly_weeks    = list(string)   # (Required) The weeks of the month to retain backups of. Must be one of First, Second, Third, Fourth, Last
    - retention_yearly_months   = list(string)   # (Required) The months of the year to retain backups of. Must be one of January, February, March, April, May, June, July, Augest, September, October, November and December
- backup_policy_vm_tags = map(string) # (Optional) A mapping of tags to assign to the resource

>### Notes: ###
>1. hour_duration must be multiplier of hour_interval
>2. Azure previously allows this field to be set to a minimum of 1 (day) - but for new resources/to update this value on existing Backup Policies - this value must now be at least 7 (days).