#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000001"
    location = "westus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

resource_group_variables_key_vault = {
  "resource_group_2" = {
    name     = "ploceusrg000002"
    location = "westus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#KEY VAULT
key_vault_variables = {
  "key_vault_1" = {
    key_vault_name                                  = "ploceuskeyvault000001"
    key_vault_location                              = "westus2"
    key_vault_resource_group_name                   = "ploceusrg000002"
    key_vault_enabled_for_disk_encryption           = true
    key_vault_enabled_for_deployment                = true
    key_vault_enabled_for_template_deployment       = true
    key_vault_enable_rbac_authorization             = false
    key_vault_soft_delete_retention_days            = "7"
    key_vault_purge_protection_enabled              = false
    key_vault_sku_name                              = "standard"
    key_vault_access_container_agent_name           = null
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore", "Purge"]
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge", "Set"]
    key_vault_access_policy_storage_permissions     = []
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]
    key_vault_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_network_acls_enabled = false
    key_vault_network_acls_virtual_networks = [
      {
        virtual_network_name    = "ploceusvnet000001"
        subnet_name             = "ploceussubnet000001"
        subscription_id         = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        virtual_network_rg_name = "ploceusrg000001"
      }
    ]
    key_vault_network_acls_bypass         = "AzureServices"
    key_vault_network_acls_default_action = "Deny"
    key_vault_network_acls_ip_rules       = ["0.0.0.0/16"]
    key_vault_contact_information_enabled = false
    key_vault_contact_email               = "xxxxxxxxxx@ploceus.com"
    key_vault_contact_name                = "Ploceus"
    key_vault_contact_phone               = "99999999999"

  }
}

#Postgresql Server
postgresql_server_variables = {
  "postgresql_server_1" = {
    postgresql_server_name                = "ploceuspg000001"
    postgresql_server_location            = "eastus2"
    postgresql_server_resource_group_name = "ploceusrg000001"

    postgresql_server_administrator_login = "ploceuspgsqladmin"

    postgresql_server_sku_name   = "GP_Gen5_8" # The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8)
    postgresql_server_version    = "11"        #9.5, 9.6, 10, 10.0, and 11
    postgresql_server_storage_mb = 5120

    postgresql_server_backup_retention_days        = 7 #values are between 7 and 35 days
    postgresql_server_geo_redundant_backup_enabled = false
    postgresql_server_auto_grow_enabled            = true

    postgresql_server_public_network_access_enabled    = true
    postgresql_server_ssl_enforcement_enabled          = true
    postgresql_server_ssl_minimal_tls_version_enforced = "TLS1_2" #TLSEnforcementDisabled, TLS1_0, TLS1_1, and TLS1_2

    postgresql_server_create_mode                       = "Default" #Default, Replica, GeoRestore, and PointInTimeRestore
    postgresql_server_creation_source_server_id         = null
    postgresql_server_infrastructure_encryption_enabled = false
    postgresql_server_restore_point_in_time             = null #PointInTimeRestore
    postgresql_server_assign_identity                   = true


    postgresql_server_threat_detection_policy = {
      postgresql_server_enable_threat_detection_policy = false
      postgresql_server_storage_account_name           = null #"ploceussa000001"
      postgresql_server_storage_account_resource_group = null #"ploceuspg000001"
      postgresql_server_disabled_alerts                = []
      postgresql_server_email_addresses_for_alerts     = []   #["test@ploceus.com"]
      postgresql_server_log_retention_days             = null #7
    }

    postgresql_server_generate_new_admin_password          = true #false to use exisitng password
    postgresql_server_admin_password_key_vault_name        = "ploceuskeyvault000001"
    postgresql_server_key_vault_resource_group_name        = "ploceusrg000002"
    postgresql_server_admin_password_key_vault_secret_name = "ploceussecret000001"
    postgresql_server_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
key_vault_subscription_id         = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
key_vault_tenant_id               = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
postgresql_server_subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" #add your subscription_id 
postgresql_server_tenant_id       = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" #add your tenant_id
storage_account_subscription_id   = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
storage_account_tenant_id         = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
