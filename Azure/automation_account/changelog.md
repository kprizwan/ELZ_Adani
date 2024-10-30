# Azure Automation account Module Change Log

## Automation account module v1.0.0 features and bug fixes:

1. Updated for_each object reference
2. Tested compatibility with azure_rm provider version 3.9
3. Tested compatibility with Terraform version 1.2.8


## Automation account module v1.1.0 features and bug fixes:

1. Updated for_each object reference
2. Tested compatibility with azure_rm provider version 3.9
3. Tested compatibility with Terraform version 1.2.8

## Automation account module v1.2.0 features and bug fixes:
1. Upgraded the azurerm version to 3.33.0 and terraform v1.3.0
2. Tested by running terraform plan and apply. Module works as expected.
3. New attributes added in azurerm v3.33.0 compared to azurerm v3.9.0
    - local_authentication_enabled
    - automation_account_encryption object.

## Automation account module v1.3.0 features and bug fixes:
1. Upgraded the azurerm version to 3.75.0 and terraform v1.6.2
2. Tested by running terraform plan and apply. Module works as expected.
3. No New Attributes.