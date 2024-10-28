# mmssql_server Module Change Log

## mssql_server module v1.1.0 features and bug fixes:

1. Updated for_each object reference
2. Tested compatibility with azure_rm 3.9
3. Tested compatibility with Terraform version 1.1.7

Issues
------
1. Facing issue with version 3.9.0 (test case 2). Its showing below error while performing terraform plan

╷
│ Error: Missing required argument
│
│   with module.mssql_server.azurerm_mssql_server.mssql_server,
│   on ..\main.tf line 138, in resource "azurerm_mssql_server" "mssql_server":
│  138:   primary_user_assigned_identity_id = each.value.mssql_server_identity.mssql_server_identity_type != null ? each.value.mssql_server_identity.mssql_server_identity_type == "UserAssigned" ? data.azurerm_user_assigned_identity.primary_user_assigned_identity[each.key].id : null : null
│
│ "primary_user_assigned_identity_id": all of `identity.0.identity_ids,primary_user_assigned_identity_id` must be specified
╵
PS C:\Users\Divya.Nochur\New folder\ploceus\azure\mssql_server\v1.1.0\example> 


While checking, it seems like the issue with version v3.9.0 and the issue resolved from v3.14.0 onwards
 reference : https://github.com/hashicorp/terraform-provider-azurerm/issues/17531

 Tested with latest version 3.31.0, and working fine.


 ## Mssql_server module v1.2.0 features and bug fixes:

1. Updated for_each object reference
2. Tested compatibility with azure_rm 3.33.0
3. Tested compatibility with Terraform version 1.3.2

 ## Mssql_server module v1.3.0 features and bug fixes:

1. Tested compatibility with azure_rm 3.75.0
2. Tested compatibility with Terraform version 1.6.2
3. No new attributes added