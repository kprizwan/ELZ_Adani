# MSSQL Database Change Log

## mssql_database module v1.1.0 features and bug fixes:

1. Updated for_each object reference
2. Tested compatibility with azure_rm 3.9
3. Tested compatibility with Terraform version 1.1.7

extended_auditing_policy is not supported inside database module v3.9.0.

## mssql_database module v1.2.0 features and bug fixes:

1. Tested compatibility with azure_rm 3.33.0
2. Tested compatibility with Terraform version 1.2.9

## mssql_database module v1.3.0 features and bug fixes:
1. Upgraded the azurerm version to 3.75.0 and terraform v1.6.2
2. Tested by running terraform plan and apply. Module works as expected.
3. New Attributes - mssql_database_import(storage_uri, storage_key, storage_key_type, administrator_login, administrator_login_password, authentication_type, storage_account_id).