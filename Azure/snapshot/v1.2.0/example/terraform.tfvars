#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000001" #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = "westus2"         #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#MANAGED DISK
managed_disk_variables = {
  "managed_disk_1" = {
    managed_disk_name                 = "ploceusdisk000001" #(Required) Specifies the name of the Managed Disk.
    managed_disk_location             = "westus2"           #(Required) Specifies the supported Azure location where the resource exists.
    managed_disk_resource_group_name  = "ploceusrg000001"   # (Required) The name of the Resource Group where the Managed Disk should exist.
    managed_disk_storage_account_type = "Premium_LRS"       #(Required) The type of storage to use for the managed disk. Possible values are Standard_LRS, StandardSSD_ZRS, Premium_LRS, PremiumV2_LRS, Premium_ZRS, StandardSSD_LRS or UltraSSD_LRS

    #Create Options
    managed_disk_create_option                               = "Empty"                #(Required) The method to use when creating the managed disk. Allowed values are Empty,FromImage,Copy, Import and Restore
    managed_disk_image_reference_name                        = "ploceusimage000001"   #(Optional) ID of an existing platform/marketplace disk image to copy when create_option is FromImage. This field cannot be specified if gallery_image_reference_name is specified.
    managed_disk_image_reference_resource_group_name         = "ploceusrg000001"      #(Optional) Resource group name where disk image reference is present. Specify when image_reference_name is specified.
    managed_disk_gallery_image_reference_name                = "ploceusimage000001"   #(Optional) ID of a Gallery Image Version to copy when create_option is FromImage. This field cannot be specified if image_reference_name is specified.
    managed_disk_gallery_image_reference_resource_group_name = "ploceusrg000001"      #(Optional) Resource group name where disk image reference is present. Specify when gallery_image_reference_name is specified.
    managed_disk_gallery_image_reference_gallery_name        = "ploceusgallery000001" #(Optional) Gallery Name where the specified gallery_image_reference_name is present. Specify when gallery_image_reference_name is specified.
    managed_disk_source_resource_name                        = "ploceussnap000001"    #(Optional) The ID of an existing Managed Disk or Snapshot to copy when create_option is Copy or the recovery point to restore when create_option is Restore
    managed_disk_source_resource_resource_group_name         = "ploceusrg000001"      #(Optional) The resource group name where the existing Managed Disk or Snapshot to copy is present. Specify when managed_disk_source_resource_name is specified.
    managed_disk_storage_acccount_name                       = "ploceussg000001"      #(Optional) The ID of the Storage Account where the source_uri is located. Required when create_option is set to Import. 
    managed_disk_storage_account_resource_group_name         = "ploceusrg000001"      #(Optional) The Resource group name of the Storage Account where the source_uri is located. specify if the managed_disk_create_option = Import is used
    managed_disk_storage_container_name                      = "blob"                 #(Optional) The container name of the Storage Account where the source_uri is located. specify if the managed_disk_create_option = Import is used
    managed_disk_os_type                                     = "linux"                #(Optional) Specify a value when the source of an Import or Copy operation targets a source that contains an operating system. Valid values are Linux or Windows.
    managed_disk_hyper_v_generation                          = "V1"                   #(Optional) The HyperV Generation of the Disk when the source of an Import or Copy operation targets a source that contains an operating system. Possible values are V1 and V2

    #Disk Options
    managed_disk_disk_size_gb               = "100"  #(Optional, Required for a new managed disk) Specifies the size of the managed disk to create in gigabytes. If create_option is Copy or FromImage, then the value must be equal to or greater than the source's size. The size can only be increased.
    managed_disk_disk_sector_size           = "4096" #(Optional) Logical Sector Size. Possible values are: 512 and 4096. Defaults to 4096
    managed_disk_tier                       = "P10"  # The disk performance tier to use. This feature is currently supported only for premium SSDs.
    managed_disk_max_shares                 = "4"    #(Optional) The maximum number of VMs that can attach to the disk at the same time. Value greater than one indicates a disk that can be mounted on multiple VMs at the same time.
    managed_disk_zone                       = "1"    #(Optional) Specifies the Availability Zone in which this Managed Disk should be located.
    managed_disk_trusted_launch_enabled     = false  #(Optional) Specifies if Trusted Launch is enabled for the Managed Disk. Defaults to false.Can only be enabled when create_option is FromImage or Import.
    managed_disk_on_demand_bursting_enabled = false  #(Optional) Specifies if On-Demand Bursting is enabled for the Managed Disk. Defaults to false.
    managed_disk_edge_zone                  = null   #(Optional) Specifies the Edge Zone within the Azure Region where this Managed Disk should exist. Changing this forces a new Managed Disk to be created.

    #Ultra SSD Options
    managed_disk_iops_read_write = "4" #(Optional) The number of IOPS allowed for this disk; only settable for UltraSSD disks and PremiumV2 disks. One operation can transfer between 4k and 256k bytes.
    managed_disk_iops_read_only  = "4" #(Optional) The number of IOPS allowed across all VMs mounting the shared disk as read-only; only settable for UltraSSD disks and PremiumV2 disks with shared disk enabled. One operation can transfer between 4k and 256k bytes.
    managed_disk_mbps_read_write = "4" #(Optional) The bandwidth allowed for this disk; only settable for UltraSSD disks and PremiumV2 disks. MBps means millions of bytes per second.
    managed_disk_mbps_read_only  = "4" #(Optional) The bandwidth allowed across all VMs mounting the shared disk as read-only; only settable for UltraSSD disks and PremiumV2 disks with shared disk enabled. MBps means millions of bytes per second.

    #Network Options
    managed_disk_public_network_access_enabled = true                            #(Optional) Whether it is allowed to access the disk via public network. Defaults to true.
    managed_disk_network_access_policy         = "AllowAll"                      #Policy for accessing the disk via network. Allowed values are AllowAll, AllowPrivate, and DenyAll.
    managed_disk_disk_access_id                = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX" #The ID of the disk access resource for using private endpoints on disks

    #Disk Access
    managed_disk_access_name                = null              #(Optional) The name used for this Disk Access.
    managed_disk_access_resource_group_name = "ploceusrg000001" #(Optional) The Resource group name where the Disk access is created

    #Encryption
    managed_disk_disk_encryption_set_name                      = null #(Optional) The ID of a Disk Encryption Set which should be used to encrypt this Managed Disk. Conflicts with secure_vm_disk_encryption_set_id
    managed_disk_disk_encryption_resource_group_name           = null #(Optional) The resource group name of the disk encryption.
    managed_disk_security_type                                 = null #(Optional) Security Type of the Managed Disk when it is used for a Confidential VM. Possible values are ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey, ConfidentialVM_DiskEncryptedWithPlatformKey and ConfidentialVM_DiskEncryptedWithCustomerKey
    managed_disk_secure_vm_disk_encryption_set_name            = null #(Optional) The ID of the Secure VM Disk Encryption Set which should be used to Encrypt this OS Disk when the Virtual Machine is a Confidential VM. Conflicts with disk_encryption_set_id
    managed_disk_secure_vm_disk_encryption_resource_group_name = null #(Optional) The resource group name of the Secure VM disk encryption.

    #Encryption Settings    
    managed_disk_encryption_settings_enabled                                  = false #(Optional) Enable this setting to configure Azure Disk Encryption. true to enable false to remove the block 
    managed_disk_encryption_settings_is_disk_encryption_key_present           = false #(Optional) To specify disk encryption key pass true otherwise false
    managed_disk_encryption_settings_is_key_encryption_key_present            = false #(Optional) To specify key encryption key pass true otherwise false
    managed_disk_encryption_settings_disk_encryption_key_vault_name           = null  #(Optional) Specify key vault name where disk encryption secret_url is present
    managed_disk_encryption_settings_disk_encryption_key_vault_resource_group = null  #(Optional) Specify resource group name where key vault for disk encryption secret_url is present
    managed_disk_encryption_settings_disk_encryption_key_vault_secret_name    = null  #(Optional) Specify key vault secret name for disk encryption secret_url
    managed_disk_encryption_settings_key_encryption_key_vault_name            = null  #(Optional) Specify key vault name where key encryption key_url is present
    managed_disk_encryption_settings_key_encryption_key_vault_key_name        = null  #(Optional) Specify key vault secret name for key encryption key_url
    managed_disk_encryption_settings_key_encryption_key_vault_resource_group  = null  #(Optional) Specify resource group name where key vault for key encryption key_url is present
    managed_disk_tags = {                                                             #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

# SNAPSHOT
snapshot_variables = {
  "snapshot_01" = {
    snapshot_name                                              = "ploceusss000001"   #(Required) Specifies the name of the Snapshot resource. Changing this forces a new resource to be created.
    snapshot_resource_group_name                               = "ploceusrg000001"   #(Required) The name of the resource group in which to create the Snapshot. Changing this forces a new resource to be created.
    snapshot_location                                          = "westus2"           #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    snapshot_create_option                                     = "Copy"              #(Required) Indicates how the snapshot is to be created. Possible values are Copy or Import. Changing this forces a new resource to be created.
    snapshot_disk_size_gb                                      = null                #(Optional) The size of the Snapshotted Disk in GB.
    snapshot_source_manged_disk                                = true                #(Optional) Spicy when create_option is import whether managed disk or unmanged disk.
    snapshot_source_uri_unmanaged_blobs_different_subscription = false               #(Optional) Used with source_uri to allow authorization during import of unmanaged blobs from a different subscription. Changing this forces a new resource to be created.
    managed_disk_source_resource_name                          = null                #(Optional) Specifies a reference to an existing snapshot, when create_option is Copy. Changing this forces a new resource to be created. 
    managed_disk_source_resource_resource_group_name           = null                #(Optional) Specifies a reference to an existing snapshot, when create_option is Copy. Changing this forces a new resource to be created.
    snapshot_managed_disk_name                                 = "ploceusdisk000001" #(Optional) Specify when create_option is import and snapshot_source_manged_disk is true.
    snapshot_managed_disk_resource_group_name                  = "ploceusrg000001"   #(Optional) Specify when create_option is import and snapshot_source_manged_disk is true.
    snapshot_storage_account_name                              = null                #(optional) Specify when create_option is import and snapshot_source_manged_disk is false.
    snapshot_storage_resource_group_name                       = null                #(optional) Specify when create_option is import and snapshot_source_manged_disk is false.
    snapshot_storage_blob_name                                 = null                #(optional) Specify when create_option is import and snapshot_source_manged_disk is false.
    snapshot_storage_container_name                            = null                #(optional) Specify when create_option is import and snapshot_source_manged_disk is false.
    snapshot_encryption_settings_enabled                       = false               # True if encryption_settings needs to be enabled.
    snapshot_encryption_settings_key_vault_name                = null                # Required if snapshot_encryption_settings_enabled is set to True.
    snapshot_encryption_settings_key_vault_resource_group_name = null                # Required if snapshot_encryption_settings_enabled is set to True.
    snapshot_encryption_settings_key_vault_secret_name         = null                # Required if encryption secret is stored in key vault secret when snapshot_encryption_settings_enabled is set to True 
    snapshot_encryption_settings_key_vault_key_name            = null                # Required if encryption secret is stored in key vault key when snapshot_encryption_settings_enabled is set to True
    snapshot_tags = {                                                                #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

key_vault_subscription_id       = "xxxxxxxxx-xxxxxxxx-xxxxxxxxxx-xxxxxxxxxx"
key_vault_tenant_id             = "xxxxxxxxx-xxxxxxxx-xxxxxxxxxx-xxxxxxxxxx"
snapshot_subscription_id        = "xxxxxxxxx-xxxxxxxx-xxxxxxxxxx-xxxxxxxxxx"
snapshot_tenant_id              = "xxxxxxxxx-xxxxxxxx-xxxxxxxxxx-xxxxxxxxxx"
storage_account_subscription_id = "xxxxxxxxx-xxxxxxxx-xxxxxxxxxx-xxxxxxxxxx"
storage_account_tenant_id       = "xxxxxxxxx-xxxxxxxx-xxxxxxxxxx-xxxxxxxxxx"