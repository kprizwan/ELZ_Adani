#ResourceGroup
variable "resource_group_variables" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
}

#RESOURCE GROUP VARIABLES KEY VAULT
variable "resource_group_variables_key_vault" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
  default = {}
}

#Key Vault
variable "key_vault_variables" {
  type = map(object({
    key_vault_name                                  = string
    key_vault_resource_group_name                   = string
    key_vault_location                              = string
    key_vault_enabled_for_disk_encryption           = bool
    key_vault_enabled_for_deployment                = bool
    key_vault_enabled_for_template_deployment       = bool
    key_vault_enable_rbac_authorization             = bool
    key_vault_soft_delete_retention_days            = string
    key_vault_purge_protection_enabled              = bool
    key_vault_sku_name                              = string
    key_vault_access_container_agent_name           = string
    key_vault_access_policy_key_permissions         = list(string)
    key_vault_access_policy_secret_permissions      = list(string)
    key_vault_access_policy_storage_permissions     = list(string)
    key_vault_access_policy_certificate_permissions = list(string)
    key_vault_tags                                  = map(string)
    key_vault_network_acls_enabled                  = bool
    key_vault_network_acls_bypass                   = string
    key_vault_network_acls_default_action           = string
    key_vault_network_acls_ip_rules                 = list(string)
    key_vault_network_acls_virtual_networks = list(object({
      virtual_network_name    = string
      subnet_name             = string
      subscription_id         = string
      virtual_network_rg_name = string
    }))
    key_vault_contact_information_enabled = bool
    key_vault_contact_email               = string
    key_vault_contact_name                = string
    key_vault_contact_phone               = string
  }))
}

#Key Vault Secret
variable "key_vault_secret_variables" {
  type = map(object({
    key_vault_name                       = string
    key_vault_secret_value               = string
    key_vault_secret_content_type        = string
    key_vault_secret_not_before_date     = string
    key_vault_secret_expiration_date     = string
    key_vault_secret_resource_group_name = string
    key_vault_secret_name                = string
    key_vault_secret_tags                = map(string)
    key_vault_secret_min_upper           = number
    key_vault_secret_min_lower           = number
    key_vault_secret_min_numeric         = number
    key_vault_secret_min_special         = number
    key_vault_secret_length              = number
  }))
}

#MSSQL Server
variable "mssql_server_variables" {
  type = map(object({
    mssql_server_name                = string # (Required)
    mssql_server_location            = string # (Required)
    mssql_server_resource_group_name = string # (Required)
    mssql_server_version             = string # (Required)

    # (Optional)
    mssql_server_azuread_administrator = object({
      azuread_administrator_login_email                 = string # (Required)  login username of the Azure AD Administrator
      azuread_administrator_azuread_authentication_only = bool   # (Optional)  Specifies whether only AD Users and administrators can be used to login, or also local database users
    })

    mssql_server_administrator_login         = string # (Optional) The administrator login name for the new server. Required if azuread_administrator_azuread_authentication_only = false
    mssql_server_access_container_agent_name = string # (Required) for fetching object_id

    mssql_server_primary_user_assigned_identity_name                = string # (Optional) Specifies the primary user managed identity id. Required if type = UserAssigned. This has issues with current version. so disabled.
    mssql_server_primary_user_assigned_identity_resource_group_name = string # Required if we specify primary user assigned identity

    # (Optional)
    mssql_server_identity = object({
      mssql_server_identity_type = string                   # (Required) Specifies the type of Managed Service Identity. Possible values - SystemAssigned, UserAssigned. # If given as "SystemAssigned" , then give below parameter as null
      mssql_server_user_assigned_identities = list(object({ # (Optional) Specifies a list of User Assigned Managed Identity IDs
        identity_name                = string
        identity_resource_group_name = string
      }))
    })

    mssql_server_connection_policy                    = string # (Optional) Possible values - Default, Proxy, and Redirect. Defaults to Default
    mssql_server_minimum_tls_version                  = number # (Optional) Valid values are: 1.0, 1.1 , 1.2 and Disabled. Defaults to 1.2
    mssql_server_public_network_access_enabled        = bool   # (Optional) Public network access is allowed or not. Defaults to true
    mssql_server_outbound_network_restriction_enabled = bool   # (Optional) Whether outbound network traffic is restricted for this server. Defaults to false

    mssql_server_tags = map(string) # (Optional) tags

    # (Optional) Required if it uses admin_login.
    mssql_server_use_existing_admin_login_username                   = bool   # true if it uses existing admin login username
    mssql_server_generate_new_admin_password                         = bool   # Specify if new password need to be generated for login
    mssql_server_admin_credentials_key_vault_name                    = string # Key vault name in which admin credentials are stored
    mssql_server_admin_credentials_key_vault_resource_group_name     = string # Key vault resource group name
    mssql_server_existing_admin_login_username_key_vault_secret_name = string # Secret key name in which admin login username is stored
    mssql_server_generated_admin_password_key_vault_secret_name      = string # Specify if mssql_server_generate_new_admin_password = true. Secret key name to which generated password to be stored
    mssql_server_existing_admin_password_key_vault_secret_name       = string # secret key name in which password is stored

  }))
  description = "variable for sql server details"
  default     = {}
}


