## Attributes :     
    
- mssql_server_name   = string # (Required) The name of the Microsoft SQL Server. This needs to be globally unique within Azure.
- mssql_server_location  = string # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
- mssql_server_resource_group_name = string # (Required) The name of the resource group in which to create the Microsoft SQL Server.
- mssql_server_version             = string # (Required) The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)
- azuread_administrator_login_email  = string # (Required)  login username of the Azure AD Administrator
- azuread_administrator_azuread_authentication_only = bool # (Optional) Specifies whether only AD Users and administrators can be used to login, or also local  users
- mssql_server_administrator_login = string # (Optional) The administrator login name for the new server. Required if azuread_administrator_azuread_authentication_only = false
- mssql_server_access_container_agent_name = string # (Required) for fetching object_id
- mssql_server_primary_user_assigned_identity_name = string # (Optional) Specifies the primary      user managed identity id. Required if type = UserAssigned. This has issues with current version. so disabled.
- mssql_server_primary_user_assigned_identity_resource_group_name = string # Required if we specify primary user assigned identity
- mssql_server_identity_type = string # (Required) Specifies the type of Managed Service Identity. Possible values SystemAssigned, UserAssigned. # If given as       "SystemAssigned" , then give below parameter as null
- mssql_server_connection_policy  = string # (Optional) Possible values - Default, Proxy, and Redirect. Defaults to Default
- mssql_server_minimum_tls_version = number # (Optional) Valid values are: 1.0, 1.1 , 1.2 and Disabled. Defaults to 1.2
- mssql_server_public_network_access_enabled = bool   # (Optional) Public network access is allowed or not. Defaults to true
-mssql_server_outbound_network_restriction_enabled = bool   # (Optional) Whether outbound network traffic is restricted for this server. Defaults to false
- mssql_server_tags = map(string) # (Optional) tags
- mssql_server_use_existing_admin_login_username                   = bool   # true if it uses existing admin login username
- mssql_server_generate_new_admin_password                         = bool   # Specify if new password need to be generated for login
- mssql_server_admin_credentials_key_vault_name                    = string # Key vault name in which admin credentials are stored
- mssql_server_admin_credentials_key_vault_resource_group_name     = string # Key vault resource group name
- mssql_server_existing_admin_login_username_key_vault_secret_name = string # Secret key name in which admin login username is stored
- mssql_server_generated_admin_password_key_vault_secret_name    = string # Specify if - -     mssql_server_generate_new_admin_password = true. Secret key name to which generated password to be stored
- mssql_server_existing_admin_password_key_vault_secret_name       = string # secret key name in which password is stored

## NOTE:
>1. The minimum_tls_version is set to Disabled means all TLS versions are allowed. After you enforce a version of minimum_tls_version, it's not possible to revert to Disabled.
>2. This is required when type is set to UserAssigned
>3. When type is set to SystemAssigned, the assigned principal_id and tenant_id can be retrieved after the Microsoft SQL Server has been created. More details are available below.
>4. You can access the Principal ID via azurerm_mssql_server.example.identity.0.principal_id and the Tenant ID via azurerm_mssql_server.example.identity.0.tenant_id
>5. All arguments including the administrator login and password will be stored in the raw state as plain-text