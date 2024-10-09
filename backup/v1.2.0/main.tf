resource "azurerm_backup_policy_vm" "backup_policy_vm" {
  for_each                       = var.backup_policy_vm_variables
  name                           = each.value.backup_policy_vm_name                                                            #Required
  resource_group_name            = each.value.backup_policy_vm_resource_group_name                                             #Required
  recovery_vault_name            = each.value.backup_policy_vm_recovery_vault_name                                             #Required
  timezone                       = each.value.backup_policy_vm_timezone == null ? "UTC" : each.value.backup_policy_vm_timezone #Optional
  policy_type                    = each.value.backup_policy_vm_policy_type
  instant_restore_retention_days = each.value.backup_policy_vm_instant_restore_retention_days
  backup { #Required
    frequency     = each.value.backup_policy_vm_backup.backup_frequency
    time          = each.value.backup_policy_vm_backup.backup_time
    hour_interval = each.value.backup_policy_vm_backup.backup_hour_interval
    hour_duration = each.value.backup_policy_vm_backup.backup_hour_duration
    weekdays      = each.value.backup_policy_vm_backup.backup_weekdays
  }

  dynamic "retention_daily" { #Required, if backup frequency set to daily
    for_each = each.value.backup_policy_vm_retention_daily == null ? [] : [true]
    #for_each = coalesce(lookup(each.value, "retention_daily"), "") == true ? [true] : []
    content {
      count = each.value.backup_policy_vm_retention_daily.retention_daily_count
    }
  }

  dynamic "retention_weekly" { #Required, if backup frequency set to weekly
    for_each = each.value.backup_policy_vm_retention_weekly == null ? [] : [true]
    content {
      count    = each.value.backup_policy_vm_retention_weekly.retention_weekly_count
      weekdays = each.value.backup_policy_vm_retention_weekly.retention_weekly_weekdays
    }
  }

  dynamic "retention_monthly" { #Optional
    for_each = each.value.backup_policy_vm_retention_monthly == null ? [] : [true]
    content {
      count    = each.value.backup_policy_vm_retention_monthly.retention_monthly_count
      weekdays = each.value.backup_policy_vm_retention_monthly.retention_monthly_weekdays
      weeks    = each.value.backup_policy_vm_retention_monthly.retention_monthly_weeks
    }
  }

  dynamic "retention_yearly" { #Optional
    for_each = each.value.backup_policy_vm_retention_yearly == null ? [] : [true]
    content {
      count    = each.value.backup_policy_vm_retention_yearly.retention_yearly_count
      weekdays = each.value.backup_policy_vm_retention_yearly.retention_yearly_weekdays
      weeks    = each.value.backup_policy_vm_retention_yearly.retention_yearly_weeks
      months   = each.value.backup_policy_vm_retention_yearly.retention_yearly_months
    }
  }
}
