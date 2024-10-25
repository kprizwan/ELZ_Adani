# Azure Logic App Standard Module Change Log

## Azure Logic App Standard v1.1.0 features and bug fixes:

1. Updated for_each object reference
2. Tested compatibility with azure_rm provider version 3.9.0
3. Tested compatibility with Terraform version 1.2.8

### Azure Logic App Standard v1.1.0 Notes:

1. You must set azurerm_app_service_plan kind to Linux and reserved to true when used with linux_fx_version.
2. There are a number of application settings that will be managed for you by this resource type and shouldn't be configured separately as part of the app_settings you specify. AzureWebJobsStorage is filled based on storage_account_name and storage_account_access_key. WEBSITE_CONTENTSHARE is detailed below. FUNCTIONS_EXTENSION_VERSION is filled based on version. APP_KIND is set to workflowApp and AzureFunctionsJobHost__extensionBundle__id and AzureFunctionsJobHost__extensionBundle__version.
3. When integrating a CI/CD pipeline and expecting to run from a deployed package in Azure you must seed your app settings as part of terraform code for Logic App to be successfully deployed. Important Default key pairs: ("WEBSITE_RUN_FROM_PACKAGE" = "", "FUNCTIONS_WORKER_RUNTIME" = "node" (or Python, etc), "WEBSITE_NODE_DEFAULT_VERSION" = "10.14.1", "APPINSIGHTS_INSTRUMENTATIONKEY" = "").
4. When using an App Service Plan in the Free or Shared Tiers use_32_bit_worker_process must be set to true.
5. User has to explicitly set ip_restriction to empty slice ([]) to remove it.
6. When using an App Service Plan in the Free or Shared Tiers use_32_bit_worker_process must be set to true.
7. When type is set to SystemAssigned, The assigned principal_id and tenant_id can be retrieved after the Logic App has been created.


## stream_analytics_job module v1.2.0 features:
1. Tested compatibility with azure_rm 3.33.0
2. Tested compatibility with Terraform version 1.3.6
3. Added the new attributes available in the v3.33.0
4. Added Notes in the README file.

## logic app standard module v1.3.0 features:
1. Tested compatibility with azure_rm 3.75.0
2. Tested compatibility with Terraform version 1.6.2
3. No new attributes added.