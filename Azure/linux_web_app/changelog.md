# Azure Web App for Linux Module Change Log

## Linux Web app module v1.1.0 features and bug fixes:

1. Updated for_each object reference
2. Tested compatibility with azure_rm provider version 3.9.0
3. Tested compatibility with Terraform version 1.3.2
4. remote_debugging is comment because of argument not expected here error
5. api_management_config_id is comment because of argument not expected here error

## Linux Web app module v1.2.0 features and bug fixes:

1. Upgraded the azurerm version to 3.33.0 and terraform v1.3.6
2. Tested by running terraform plan and apply. Module works as expected.
3. new attributes are added in version 3.33.0 site_config_remote_debugging_enabled, site_config_api_definition_url and site_config_api_management_api_id.
4. committed blocks in the tfvars are belongs to linux web app module if need uncomment and pass the value.

## Linux Web app module v1.3.0 features and bug fixes:

1. Upgraded the azurerm version to 3.75.0 and terraform v1.6.2
2. Tested by running terraform plan and apply. Module works as expected.
3. new block linux_web_app_auth_settings_v2 added in version 3.75.0.