# Log Analytics Workspace Module Change Log
## log_analytics_workspace module v1.0.0 features and bug fixes:
1. Updated for_each object reference
2. Tested compatibility with azure_rm 2.98
3. Tested compatibility with Terraform version 1.1.7

## log_analytics_workspace module v1.x.x features and bug fixes:
1. Add changes implemented in new module version here

## log_analytics_workspace module v1.2.0 features and bug fixes:
1. Upgraded the azurerm version to 3.33.0 and terraform v1.3.x
2. Tested by running terraform plan and apply. Module works as expected.
3. cmk_for_query_forced attribute in azurerm v3.33.0 which are not present in v3.9.0

## log_analytics_workspace module v1.3.0 features and bug fixes:
1. Upgraded the azurerm version to 3.75.0 and terraform v1.3.x
2. Tested by running terraform plan and apply. Module works as expected.
3. cmk_for_query_forced attribute in azurerm v3.33.0 which are not present in v3.9.0
4. log_analytics_workspace_allow_resource_only_permissions, log_analytics_workspace_local_authentication_disabled, log_analytics_workspace_data_collection_rule_id attributes in azurerm v3.75.0 which are not present in v3.33.0
