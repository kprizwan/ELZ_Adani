## Attributes:
- storage_account_key_vault_name                                     = string #(Required) The name of the Key Vault.
- storage_account_key_vault_resource_group_name                      = string #(Required) The resource group name of the Key Vault.
- storage_account_key_vault_key_name                                 = string #(Required) The name of the Key Vault key required for customer managed key.
- storage_account_user_assigned_identity_name_for_cmk                = string #(Required) The name of a user assigned identity for customer managed key.
- storage_account_user_assigned_identity_resource_group_name_for_cmk = string #(Required) The resource group name of a user assigned identity for customer managed key.
- storage_account_identity_type_for_cmk                              = string #(Required) The identity type of a user assigned identity for customer managed key. Possible values could be "UserAssigned", "SystemAssigned", "SystemAssigned, UserAssigned".
- storage_account_name                                               = string #(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed.This must be unique across the entire Azure service, not just within the resource group.
- storage_account_resource_group_name                                = string #(Required) The name of the resource group in which to create the storage account.
- storage_account_location                                           = string #(Required) Specifies the supported Azure location where the resource exists. 
- storage_account_account_kind                                       = string #(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2.
- storage_account_account_tier                                       = string #(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
- storage_account_account_replication_type                           = string #(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa.
- storage_account_cross_tenant_replication_enabled                   = bool   #(Optional) Should cross Tenant replication be enabled? Defaults to true.
- storage_account_access_tier                                        = string #(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot.
- storage_account_edge_zone                                          = string #(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist.
- storage_account_enable_https_traffic_only                          = bool   #(Optional) Boolean flag which forces HTTPS if enabled. Defaults to true.
- storage_account_min_tls_version                                    = string #(Optional) The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts.
- storage_account_allow_nested_items_to_be_public                    = bool   #Allow or disallow nested items within this Account to opt into being public. Defaults to true.
- storage_account_shared_access_key_enabled                          = bool   #Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true.
- storage_account_public_network_access_enabled                      = bool   #(Optional) Whether the public network access is enabled? Defaults to true.
- storage_account_default_to_oauth_authentication                    = bool   #(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false
- storage_account_is_hns_enabled                                     = bool   #(Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2.
- storage_account_nfsv3_enabled                                      = bool   #(Optional) Is NFSv3 protocol enabled? Defaults to false.
- storage_account_large_file_share_enabled                           = bool   #(Optional) Is Large File Share Enabled?
- storage_account_queue_encryption_key_type                          = string #(Optional) The encryption type of the queue service. Possible values are Service and Account.Default value is Service.
- storage_account_table_encryption_key_type                          = string #(Optional) The encryption type of the table service. Possible values are Service and Account. Default value is Service.
- storage_account_infrastructure_encryption_enabled                  = bool   #(Optional) Is infrastructure encryption enabled? Defaults to false.
- storage_account_custom_domain = object
    - custom_domain_name          = string #(Required) The Custom Domain Name to use for the Storage Account, which will be validated by Azure.
    - custom_domain_use_subdomain = bool   #(Optional) Should the Custom Domain Name be validated by using indirect CNAME validation?
- storage_account_identity = object
    - storage_account_identity_type = string # Possible values could be "UserAssigned", "SystemAssigned", "SystemAssigned, UserAssigned"
    - storage_account_user_assigned_identity_ids = list(object
      - identity_name                = string
      - identity_resource_group_name = string
- storage_account_blob_properties = object
    - versioning_enabled            = bool   #(Optional) Is versioning enabled? Default to false.
    - change_feed_enabled           = bool   #(Optional) Is the blob service properties for change feed events enabled? Default to false.
    - change_feed_retention_in_days = number #(Optional) The duration of change feed events retention in days. The possible values are between 1 and 146000 days (400 years). Setting this to null (or omit this in the configuration file) indicates an infinite retention of the change feed.
    - default_service_version       = string #(Optional) The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version. Defaults to 2020-06-12.
    - last_access_time_enabled      = bool   #(Optional) Is the last access time based tracking enabled? Default to false.

    - cors_enabled = bool #(optional) Should cross origin resource sharing be enabled
      - cors_rule = object
        - allowed_headers    = list(string) #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        - allowed_methods    = list(string) #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        - allowed_origins    = list(string) #(Required) A list of origin domains that will be allowed by CORS.
        - exposed_headers    = list(string) #(Required) A list of response headers that are exposed to CORS clients.
        - max_age_in_seconds = number       #(Required) The number of seconds the client should cache a preflight response.
      - delete_retention_policy = object
        - delete_retention_policy_days = string #(Optional) Specifies the number of days that the blob should be retained, between 1 and 365 days. Defaults to 7.
      - container_delete_retention_policy = object
        - container_delete_retention_policy_days = string #(Optional) Specifies the number of days that the container should be retained, between 1 and 365 days. Defaults to 7.
    - storage_account_queue_properties = object
      - cors_enabled = bool #(optional) Should cross origin resource sharing be enabled.
      - cors_rule = object
        - allowed_headers    = list(string) #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        - allowed_methods    = list(string) #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        - allowed_origins    = list(string) #(Required) A list of origin domains that will be allowed by CORS.
        - exposed_headers    = list(string) #(Required) A list of response headers that are exposed to CORS clients.
        - max_age_in_seconds = number       #(Required) The number of seconds the client should cache a preflight response.
      - logging_enabled = bool #Should storage account queue properties logging be enabled.
        - logging = object
            - delete                = bool   #(Required) Indicates whether all delete requests should be logged. 
            - read                  = bool   #(Required) Indicates whether all read requests should be logged. 
            - version               = string #(Required) The version of storage analytics to configure.
            - write                 = bool   #(Required) Indicates whether all write requests should be logged.
            - retention_policy_days = number #(Optional) Specifies the number of days that logs will be retained.
      - minute_metrics = object
            - enabled               = bool   #(Required) Indicates whether minute metrics are enabled for the Queue service. 
            - version               = string #(Required) The version of storage analytics to configure. 
            - include_apis          = bool   #(Optional) Indicates whether metrics should generate summary statistics for called API operations.
            - retention_policy_days = number #(Optional) Specifies the number of days that logs will be retained.
      - hour_metrics = object
            - enabled               = bool   #(Required) Indicates whether minute metrics are enabled for the Queue service. 
            - version               = string #(Required) The version of storage analytics to configure. 
            - include_apis          = bool   #(Optional) Indicates whether metrics should generate summary statistics for called API operations.
            - retention_policy_days = number #(Optional) Specifies the number of days that logs will be retained.
    - storage_account_static_website = object
        - index_document     = string #Optional) The webpage that Azure Storage serves for requests to the root of a website or any - subfolder. For example, index.html. The value is case-sensitive.
      error_404_document = string #(Optional) The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file.
    - storage_account_share_properties = object
        - cors_enabled = bool #(optional) Should cross origin resource sharing be enabled.
        - cors_rule = object
            - allowed_headers    = list(string) #(Required) A list of headers that are allowed to be a part of the cross-origin request.
            - allowed_methods    = list(string) #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
            - allowed_origins    = list(string) #(Required) A list of origin domains that will be allowed by CORS.
            - exposed_headers    = list(string) #(Required) A list of response headers that are exposed to CORS clients.
            - max_age_in_seconds = number       #(Required) The number of seconds the client should cache a preflight response.
        - retention_policy = object
            - retention_policy_days = number #(Optional) Specifies the number of days that the azurerm_storage_share should be retained, between 1 and 365 days. Defaults to 7.
        - smb = object
            - smb_versions                        = set(string) #(Optional) A set of SMB protocol versions. Possible values are SMB2.1, SMB3.0, and SMB3.1.1.
            - smb_authentication_types            = set(string) #(Optional) A set of SMB authentication methods. Possible values are NTLMv2, and Kerberos.
            - smb_kerberos_ticket_encryption_type = set(string) #(Optional) A set of Kerberos ticket encryption. Possible values are RC4-HMAC, and AES-256.
            - smb_channel_encryption_type         = set(string) #(Optional) A set of SMB channel encryption. Possible values are AES-128-CCM, AES-128-GCM, and AES-256-GCM.
            - smb_multichannel_enabled            = bool        #(Optional) Indicates whether multichannel is enabled. Defaults to false. This is only supported on Premium storage accounts.
    - storage_account_network_rules = object
        - default_action = string       #(Required) Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow.
        - bypass         = list(string) #(Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None.
        - ip_rules       = list(string) #(Optional) List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed.
       - storage_account_network_rules_vnet_subnets = list(object
            - storage_account_network_rules_virtual_network_name = string #(Required) Vitural Network name to be associated.
            - storage_account_network_rules_subnet_name          = string #(Required) Subnet Name to be associated.
            - storage_account_network_rules_vnet_subscription_id = string #(Required) Subscription Id where Vnet is created.
            - storage_account_network_rules_vnet_rg_name         = string #(Required) Resource group where Vnet is created.
            - private_link_access = map(object
                - endpoint_resource_id = string
                - endpoint_tenant_id   = string
   - storage_account_azure_files_authentication = object
        - directory_type = string #(Required) Specifies the directory service used. Possible values are AADDS and AD.
      active_directory = object
        - storage_sid         = string #(Required) Specifies the security identifier (SID) for Azure Storage.
        - domain_name         = string #(Required) Specifies the primary domain that the AD DNS server is authoritative for.
        - domain_sid          = string #(Required) Specifies the security identifier (SID).
        - domain_guid         = string #(Required) Specifies the domain GUID.
        - forest_name         = string #(Required) Specifies the Active Directory forest.
        - netbios_domain_name = string #(Required) Specifies the NetBIOS domain name.
    - storage_account_routing = object
        - publish_internet_endpoints  = bool   #(Optional) Should internet routing storage endpoints be published? Defaults to false.
        - publish_microsoft_endpoints = bool   #(Optional) Should Microsoft routing storage endpoints be published? Defaults to false.
        - choice                      = string #(Optional) Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting. Defaults to MicrosoftRouting.
    - storage_account_immutability_policy = object
         -  allow_protected_append_writes = bool   #(Required) When enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted.
         - state                         = string #(Required) Defines the mode of the policy. Disabled state disables the policy, Unlocked state allows increase and decrease of immutability retention time and also allows toggling allowProtectedAppendWrites property, Locked state only allows the increase of the immutability retention time. A policy can only be created in a Disabled or Unlocked state and can be toggled between the two states. Only a policy in an Unlocked state can transition to a Locked state which cannot be reverted.
        - period_since_creation_in_days = number #(Required) The immutability period for the blobs in the container since the policy creation, in days.
    - storage_account_sas_policy = object
        - expiration_period = string #(Required) The SAS expiration period in format of DD.HH:MM:SS.
        - expiration_action = string #(Optional) The SAS expiration action. The only possible value is Log at this moment. Defaults to Log.
   - storage_account_tags = map(string) #(Optional) A mapping of tags to assign to the resource.

>## Notes:
>1. account_kind = Changing the account_kind value from Storage to StorageV2 will not trigger a force new on the storage account, it will only upgrade the existing storage account from Storage to StorageV2 keeping the existing storage account in place.
>2. account_tier = Blobs with a tier of Premium are of account kind StorageV2.
>3. min_tls_version = At this time min_tls_version is only supported in the Public Cloud, China Cloud, and US Government Cloud.
>4. allow_nested_items_to_be_public = At this time allow_nested_items_to_be_public is only supported in the Public Cloud, China Cloud, and US Government Cloud.
>5. shared_access_key_enabled = Terraform uses Shared Key Authorisation to provision Storage Containers, Blobs and other items - when Shared Key Access is disabled, you will need to enable the storage_use_azuread flag in the Provider block to use Azure AD for authentication, however not all Azure Storage services support Active Directory authentication.
>6. is_hns_enabled = This can only be true when account_tier is Standard or when account_tier is Premium and account_kind is BlockBlobStorage.
>7. nfsv3_enabled = This can only be true when account_tier is Standard and account_kind is StorageV2, or account_tier is Premium and account_kind is BlockBlobStorage. Additionally, the is_hns_enabled is true, and enable_https_traffic_only is false.
>8. queue_encryption_key_type & table_encryption_key_type = For the queue_encryption_key_type and table_encryption_key_type, the Account key type is only allowed when the account_kind is set to StorageV2.
>9. queue_properties = queue_properties cannot be set when the account_kind is set to BlobStorage.
>10. static_website = static_website can only be set when the account_kind is set to StorageV2 or BlockBlobStorage.
>11. infrastructure_encryption_enabled = This can only be true when account_kind is StorageV2 or when account_tier is Premium and account_kind is BlockBlobStorage.
>12. customer_managed_key = customer_managed_key can only be set when the account_kind is set to StorageV2 or account_tier set to Premium, and the identity type is UserAssigned.
>13. identity_ids = This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
>14. The assigned principal_id and tenant_id can be retrieved after the identity type has been set to SystemAssigned and Storage Account has been created.
>15. immutability_policy = This argument specifies the default account-level immutability policy which is inherited and applied to objects that do not possess an explicit immutability policy at the object level. The object-level immutability policy has higher precedence than the container-level immutability policy, which has a higher precedence than the account-level immutability policy.
>16. network_rules = If specifying network_rules, one of either ip_rules or virtual_network_subnet_ids must be specified and default_action must be set to Deny.
>17. Network Rules can be defined either directly on the azurerm_storage_account resource, or using the azurerm_storage_account_network_rules resource - but the two cannot be used together. If both are used against the same Storage Account, spurious changes will occur. When managing Network Rules using this resource, to change from a default_action of Deny to Allow requires defining, rather than removing, the block.
>18. The prefix of ip_rules must be between 0 and 30 and only supports public IP addresses.
>19. key_vault must be configured for both Purge Protection and Soft Delete.
>20. Add Microsoft.Storage to subnet's ServiceEndpoints.
>21. share_properties` aren't supported for account kind "BlobStorage" in sku tier "Standard.
>22. Routing Preferences is not supported for the account kind = "Storage".
>23. When account_kind is set to "FileStorage" , large_file_share_enabled must be set to "true", account_tier must be set to "Premium" and replication_type must be set to "LRS" , Other replication_types such as ZRS, GRS, GZRS, RAGZRS are not supported for "FileStorage" account kind.
