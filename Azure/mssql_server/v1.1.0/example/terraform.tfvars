#ResourceGroup
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

#RESOURCE GROUP KEY VAULT
resource_group_variables_key_vault = {
  "resource_group_2" = {
    name     = "ploceusrg000002"
    location = "eastus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#Key Vault
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
        virtual_network_rg_name = "ploceusrg000002"
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

#Key vault secret
key_vault_secret_variables = {
  "key_vault_secret_1" = {
    key_vault_name                       = "ploceuskeyvault000001"
    key_vault_secret_value               = "ploceusmssqladminuser000001"
    key_vault_secret_content_type        = ""
    key_vault_secret_not_before_date     = ""
    key_vault_secret_expiration_date     = ""
    key_vault_secret_resource_group_name = "ploceusrg000002"
    key_vault_secret_name                = "ploceuskvs000001"
    key_vault_secret_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_secret_min_upper   = 10
    key_vault_secret_min_lower   = 5
    key_vault_secret_min_numeric = 5
    key_vault_secret_min_special = 3
    key_vault_secret_length      = 32
  }
}

#MSSQL Server
mssql_server_variables = {
  "server1" = {
    mssql_server_name                = "ploceusmssql000001"
    mssql_server_resource_group_name = "ploceusrg000001"
    mssql_server_location            = "westus2"
    mssql_server_version             = "12.0"

    mssql_server_azuread_administrator = {
      azuread_administrator_login_email                 = "xxxxxxxxxx@ploceus.com"
      azuread_administrator_azuread_authentication_only = true
    }
    mssql_server_administrator_login         = null
    mssql_server_access_container_agent_name = null

    mssql_server_primary_user_assigned_identity_name                = null # primary_user_identity has issues with current version. so disabled.
    mssql_server_primary_user_assigned_identity_resource_group_name = null
    mssql_server_identity = {
      mssql_server_identity_type            = "SystemAssigned"
      mssql_server_user_assigned_identities = null
    }


    mssql_server_connection_policy                    = "Default"
    mssql_server_minimum_tls_version                  = 1.2
    mssql_server_public_network_access_enabled        = true
    mssql_server_outbound_network_restriction_enabled = false

    mssql_server_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }

    mssql_server_use_existing_admin_login_username                   = false
    mssql_server_generate_new_admin_password                         = true
    mssql_server_admin_credentials_key_vault_name                    = "ploceuskeyvault000001"
    mssql_server_admin_credentials_key_vault_resource_group_name     = "ploceusrg000002"
    mssql_server_existing_admin_login_username_key_vault_secret_name = "ploceuskvs000001"
    mssql_server_generated_admin_password_key_vault_secret_name      = "ploceuskvs000002"
    mssql_server_existing_admin_password_key_vault_secret_name       = null
  }
}



key_vault_subscription_id    = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
key_vault_tenant_id          = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
mssql_server_subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
mssql_server_tenant_id       = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
azuread_tenant_id            = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"