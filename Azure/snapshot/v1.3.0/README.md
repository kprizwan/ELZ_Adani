## Attributes:
- snapshot_name                                              = string      #(Required) Specifies the name of the Snapshot resource. Changing this forces a new resource to be created.
- snapshot_resource_group_name                               = string      #(Required) The name of the resource group in which to create the Snapshot. Changing this forces a new resource to be created.
- snapshot_location                                          = string      #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
- snapshot_create_option                                     = string      #(Required) Indicates how the snapshot is to be created. Possible values are Copy or Import. Changing this forces a new resource to be created.
- snapshot_disk_size_gb                                      = string      #(Optional) The size of the Snapshotted Disk in GB.
- snapshot_incremental_enabled                               = bool        #(Optional) Specifies if the Snapshot is incremental.
- snapshot_source_manged_disk                                = bool        #(Optional) Spicy when create_option is import whether managed disk or unmanged disk.
- snapshot_source_uri_unmanaged_blobs_different_subscription = bool        #(Optional) Used with source_uri to allow authorization during import of unmanaged blobs from a different subscription. Changing this forces a new resource to be created.
- managed_disk_source_resource_name                          = string      #(Optional) Specifies a reference to an existing snapshot, when create_option is Copy. Changing this forces a new resource to be created. 
- managed_disk_source_resource_resource_group_name           = string      #(Optional) Specifies a reference to an existing snapshot, when create_option is Copy. Changing this forces a new resource to be created.
- snapshot_managed_disk_name                                 = string      #(Optional) Specify when create_option is import and snapshot_source_manged_disk is true.
- snapshot_managed_disk_resource_group_name                  = string      #(Optional) Specify when create_option is import and snapshot_source_manged_disk is true.
- snapshot_storage_account_name                              = string      #(optional) Specify when create_option is import and snapshot_source_manged_disk is false.
- snapshot_storage_resource_group_name                       = string      #(optional) Specify when create_option is import and snapshot_source_manged_disk is false.
- snapshot_storage_blob_name                                 = string      #(optional) Specify when create_option is import and snapshot_source_manged_disk is false.
- snapshot_storage_container_name                            = string      #(optional) Specify when create_option is import and snapshot_source_manged_disk is false.
- snapshot_encryption_settings_enabled                       = bool        # True if encryption_settings needs to be enabled.
- snapshot_encryption_settings_key_vault_name                = string      # Required if snapshot_encryption_settings_enabled is set to True.
- snapshot_encryption_settings_key_vault_resource_group_name = string      # Required if snapshot_encryption_settings_enabled is set to True.
- snapshot_encryption_settings_key_vault_secret_name         = string      # Required if encryption secret is stored in key vault secret when snapshot_encryption_settings_enabled is set to True 
- snapshot_encryption_settings_key_vault_key_name            = string      # Required if encryption secret is stored in key vault key when snapshot_encryption_settings_enabled is set to True 
- snapshot_tags                                              = map(string) #(Optional) A mapping of tags to assign to the resource.

>## Notes:
>1. One of source_uri, source_resource_id or storage_account_id must be specified.
>2. Removing encryption_settings forces a new resource to be created.