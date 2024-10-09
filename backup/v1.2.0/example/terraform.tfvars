#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000001" # (Required) Name of the Resouce Group with which it should be created.
    resource_group_location = "westus2"         # (Required) The Azure Region where the Resource Group should exist.
    resource_group_tags = {                     # (Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#RECOVERY SERVICE VAULT 
recovery_services_vault_variables = {
  "recovery_services_vault_1" = {
    recovery_services_vault_name                         = "ploceusrsv000001" #(Required) Specifies the name of the Recovery Services Vault. Recovery Service Vault name must be 2 - 50 characters long, start with a letter, contain only letters, numbers and hyphens. Changing this forces a new resource to be created.
    recovery_services_vault_resource_group_name          = "ploceusrg000001"  #(Required) The name of the resource group in which to create the Recovery Services Vault. Changing this forces a new resource to be created.
    recovery_services_vault_location                     = "eastus"           #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    recovery_services_vault_sku                          = "Standard"         #(Required) Sets the vault's SKU. Possible values include: Standard, RS0
    recovery_services_vault_storage_mode_type            = "GeoRedundant"     #(Optional) The storage type of the Recovery Services Vault. Possible values are GeoRedundant, LocallyRedundant and ZoneRedundant. Defaults to GeoRedundant.
    recovery_services_vault_cross_region_restore_enabled = false              #(Optional) Is cross region restore enabled for this Vault? Only can be true, when storage_mode_type is GeoRedundant. Defaults to false.
    recovery_services_vault_soft_delete_enabled          = true               #(Optional) Is soft delete enable for this Vault? Defaults to true
    recovery_services_vault_identity = {                                      #(Optional) An identity block as defined below.
      recovery_services_vault_identity_type = "SystemAssigned"                #(Required) Specifies the type of Managed Service Identity that should be configured on this Recovery Services Vault. The only possible value is SystemAssigned
    }
    recovery_services_vault_encryption = null /* {                                   #(Optional) An encryption block as defined below. Required with identity.
      encryption_key_vault_name                    = "ploceuskeyvault000001" #(Required) The Key Vault name holding key used to encrypt this vault. Key managed by Vault Managed Hardware Security Module is also supported.
      encryption_key_vault_resource_group_name     = "ploceusrg000001"       #(Required) The Key Vault resource group name holding key used to encrypt this vault. Key managed by Vault Managed Hardware Security Module is also supported.
      encryption_key_vault_key_name                = "ploceuskvkey000001"    #(Required) The Key Vault key name used to encrypt this vault. Key managed by Vault Managed Hardware Security Module is also supported.
      encryption_infrastructure_encryption_enabled = false                    #(Required) Enabling/Disabling the Double Encryption state.
      encryption_use_system_assigned_identity      = true                    #(Optional) Indicate that system assigned identity should be used or not. At this time the only possible value is true. Defaults to true.
    } */
    recovery_services_vault_tags = { #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus"
      Department = "CIS"
    }
  }
}

#BACKUP POLICY
backup_policy_vm_variables = {
  backup_policy_1 = {
    backup_policy_vm_name                           = "ploceusbkp000001" # (Required) Specifies the name of the Backup Policy. Changing this forces a new resource to be created
    backup_policy_vm_timezone                       = "UTC"              # (Optional) Specifies the timezone. the possible values are defined here. Defaults to UTC
    backup_policy_vm_resource_group_name            = "ploceusrg000001"  # (Required) The name of the resource group in which to create the policy. Changing this forces a new resource to be created
    backup_policy_vm_recovery_vault_name            = "ploceusrsv000001" # (Required) Specifies the name of the Recovery Services Vault to use. Changing this forces a new resource to be created
    backup_policy_vm_policy_type                    = "V1"               # (Optional) Type of the Backup Policy. Possible values are V1 and V2 where V2 stands for the Enhanced Policy. Defaults to V1. Changing this forces a new resource to be created.
    backup_policy_vm_instant_restore_retention_days = "1"                # (Optional) Specifies the instant restore retention range in days. Possible values are between 1 and 5 when policy_type is V1, and 1 to 30 when policy_type is V2.
    backup_policy_vm_backup = {
      backup_frequency     = "Daily", # (Required) Sets the backup frequency. Must be either Daily or Weekly
      backup_time          = "23:00"  # (Required) The time of day to perform the backup in 24hour format
      backup_hour_interval = null     # (Optional) Interval in hour at which backup is triggered. Possible values are 4, 6, 8 and 12. This is used when frequency is Hourly.
      backup_hour_duration = null     # (Optional) Duration of the backup window in hours. Possible values are between 4 and 24 This is used when frequency is Hourly.
      backup_weekdays      = null     # (Optional) The days of the week to perform backups on. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday. This is used when frequency is Weekly.
    }
    backup_policy_vm_retention_daily = { # (Required) The number of daily backups to keep.
      retention_daily_count = 10         # (Required) The number of daily backups to keep. Must be between 7 and 9999
    }
    backup_policy_vm_retention_weekly = {                                       # (Required) The number of weekly backups to keep.
      retention_weekly_count    = 42                                            # Must be between 1 and 9999
      retention_weekly_weekdays = ["Sunday", "Wednesday", "Friday", "Saturday"] # (Required) The weekday backups to retain. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday
    }
    backup_policy_vm_retention_monthly = {                 # (Required) The number of monthly backups to keep.
      retention_monthly_count    = 7                       # (Required) The number of monthly backups to keep. Must be between 1 and 9999
      retention_monthly_weekdays = ["Sunday", "Wednesday"] # (Required) The weekday backups to retain . Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday
      retention_monthly_weeks    = ["First", "Last"]       # (Required) The weeks of the month to retain backups of. Must be one of First, Second, Third, Fourth, Last
    }
    backup_policy_vm_retention_yearly = {     # (Required) The number of yearly backups to keep.
      retention_yearly_count    = 77          # (Required) The number of yearly backups to keep. Must be between 1 and 9999
      retention_yearly_weekdays = ["Sunday"]  # (Required) The weekday backups to retain . Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday
      retention_yearly_weeks    = ["Last"]    # (Required) The weeks of the month to retain backups of. Must be one of First, Second, Third, Fourth, Last
      retention_yearly_months   = ["January"] # (Required) The months of the year to retain backups of. Must be one of January, February, March, April, May, June, July, Augest, September, October, November and December
    }
    backup_policy_vm_tags = { # (Optional) A mapping of tags to assign to the resource
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
