#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  type = map(object({
    resource_group_name     = string      #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_tags     = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups"
  default = {
  }
}

#MANAGED DISK VARIABLES
variable "managed_disk_variables" {
  type = map(object({
    managed_disk_name                 = string #(Required) Specifies the name of the Managed Disk.
    managed_disk_location             = string #(Required) Specifies the supported Azure location where the resource exists.
    managed_disk_resource_group_name  = string # (Required) The name of the Resource Group where the Managed Disk should exist.
    managed_disk_storage_account_type = string #(Required) The type of storage to use for the managed disk. Possible values are Standard_LRS, StandardSSD_ZRS, Premium_LRS, PremiumV2_LRS, Premium_ZRS, StandardSSD_LRS or UltraSSD_LRS

    #Create Options
    managed_disk_create_option                               = string #(Required) The method to use when creating the managed disk. Allowed values are Empty,FromImage,Copy, Import and Restore
    managed_disk_image_reference_name                        = string #(Optional) ID of an existing platform/marketplace disk image to copy when create_option is FromImage. This field cannot be specified if gallery_image_reference_name is specified.
    managed_disk_image_reference_resource_group_name         = string #(Optional) Resource group name where disk image reference is present. Specify when image_reference_name is specified.
    managed_disk_gallery_image_reference_name                = string #(Optional) ID of a Gallery Image Version to copy when create_option is FromImage. This field cannot be specified if image_reference_name is specified.
    managed_disk_gallery_image_reference_resource_group_name = string #(Optional) Resource group name where disk image reference is present. Specify when gallery_image_reference_name is specified.
    managed_disk_gallery_image_reference_gallery_name        = string #(Optional) Gallery Name where the specified gallery_image_reference_name is present. Specify when gallery_image_reference_name is specified.
    managed_disk_source_resource_name                        = string #(Optional) The ID of an existing Managed Disk or Snapshot to copy when create_option is Copy or the recovery point to restore when create_option is Restore
    managed_disk_source_resource_resource_group_name         = string #(Optional) The resource group name where the existing Managed Disk or Snapshot to copy is present. Specify when managed_disk_source_resource_name is specified.
    managed_disk_storage_acccount_name                       = string #(Optional) The ID of the Storage Account where the source_uri is located. Required when create_option is set to Import. 
    managed_disk_storage_account_resource_group_name         = string #(Optional) The Resource group name of the Storage Account where the source_uri is located. specify if the managed_disk_create_option = Import is used
    managed_disk_storage_container_name                      = string #(Optional) The container name of the Storage Account where the source_uri is located. specify if the managed_disk_create_option = Import is used
    managed_disk_os_type                                     = string #(Optional) Specify a value when the source of an Import or Copy operation targets a source that contains an operating system. Valid values are Linux or Windows.
    managed_disk_hyper_v_generation                          = string #(Optional) The HyperV Generation of the Disk when the source of an Import or Copy operation targets a source that contains an operating system. Possible values are V1 and V2

    #Disk Options
    managed_disk_disk_size_gb               = string #(Optional, Required for a new managed disk) Specifies the size of the managed disk to create in gigabytes. If create_option is Copy or FromImage, then the value must be equal to or greater than the source's size. The size can only be increased.
    managed_disk_disk_sector_size           = string #(Optional) Logical Sector Size. Possible values are: 512 and 4096. Defaults to 4096
    managed_disk_tier                       = string # The disk performance tier to use. This feature is currently supported only for premium SSDs.
    managed_disk_max_shares                 = string #(Optional) The maximum number of VMs that can attach to the disk at the same time. Value greater than one indicates a disk that can be mounted on multiple VMs at the same time.
    managed_disk_zone                       = string #(Optional) Specifies the Availability Zone in which this Managed Disk should be located.
    managed_disk_trusted_launch_enabled     = bool   #(Optional) Specifies if Trusted Launch is enabled for the Managed Disk. Defaults to false.Can only be enabled when create_option is FromImage or Import.
    managed_disk_on_demand_bursting_enabled = bool   #(Optional) Specifies if On-Demand Bursting is enabled for the Managed Disk. Defaults to false.
    managed_disk_edge_zone                  = string #(Optional) Specifies the Edge Zone within the Azure Region where this Managed Disk should exist. Changing this forces a new Managed Disk to be created.

    #Ultra SSD Options
    managed_disk_iops_read_write = string #(Optional) The number of IOPS allowed for this disk; only settable for UltraSSD disks and PremiumV2 disks. One operation can transfer between 4k and 256k bytes.
    managed_disk_iops_read_only  = string #(Optional) The number of IOPS allowed across all VMs mounting the shared disk as read-only; only settable for UltraSSD disks and PremiumV2 disks with shared disk enabled. One operation can transfer between 4k and 256k bytes.
    managed_disk_mbps_read_write = string #(Optional) The bandwidth allowed for this disk; only settable for UltraSSD disks and PremiumV2 disks. MBps means millions of bytes per second.
    managed_disk_mbps_read_only  = string #(Optional) The bandwidth allowed across all VMs mounting the shared disk as read-only; only settable for UltraSSD disks and PremiumV2 disks with shared disk enabled. MBps means millions of bytes per second.

    #Network Options
    managed_disk_public_network_access_enabled = bool   #(Optional) Whether it is allowed to access the disk via public network. Defaults to true.
    managed_disk_network_access_policy         = string #Policy for accessing the disk via network. Allowed values are AllowAll, AllowPrivate, and DenyAll.
    managed_disk_disk_access_id                = string #The ID of the disk access resource for using private endpoints on disks

    #Disk Access
    managed_disk_access_name                = string #(Optional) The name used for this Disk Access.
    managed_disk_access_resource_group_name = string #(Optional) The Resource group name where the Disk access is created

    #Encryption
    managed_disk_disk_encryption_set_name                      = string      #(Optional) The ID of a Disk Encryption Set which should be used to encrypt this Managed Disk. Conflicts with secure_vm_disk_encryption_set_id
    managed_disk_disk_encryption_resource_group_name           = string      #(Optional) The resource group name of the disk encryption.
    managed_disk_tags                                          = map(string) #(Optional) A mapping of tags to assign to the resource.
    managed_disk_security_type                                 = string      #(Optional) Security Type of the Managed Disk when it is used for a Confidential VM. Possible values are ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey, ConfidentialVM_DiskEncryptedWithPlatformKey and ConfidentialVM_DiskEncryptedWithCustomerKey
    managed_disk_secure_vm_disk_encryption_set_name            = string      #(Optional) The ID of the Secure VM Disk Encryption Set which should be used to Encrypt this OS Disk when the Virtual Machine is a Confidential VM. Conflicts with disk_encryption_set_id
    managed_disk_secure_vm_disk_encryption_resource_group_name = string      #(Optional) The resource group name of the Secure VM disk encryption.

    #Encryption Settings    
    managed_disk_encryption_settings_enabled                                  = bool   #(Optional) Enable this setting to configure Azure Disk Encryption. true to enable false to remove the block 
    managed_disk_encryption_settings_is_disk_encryption_key_present           = bool   #(Optional) To specify disk encryption key pass true otherwise false
    managed_disk_encryption_settings_is_key_encryption_key_present            = bool   #(Optional) To specify key encryption key pass true otherwise false
    managed_disk_encryption_settings_disk_encryption_key_vault_name           = string #(Optional) Specify key vault name where disk encryption secret_url is present
    managed_disk_encryption_settings_disk_encryption_key_vault_resource_group = string #(Optional) Specify resource group name where key vault for disk encryption secret_url is present
    managed_disk_encryption_settings_disk_encryption_key_vault_secret_name    = string #(Optional) Specify key vault secret name for disk encryption secret_url
    managed_disk_encryption_settings_key_encryption_key_vault_name            = string #(Optional) Specify key vault name where key encryption key_url is present
    managed_disk_encryption_settings_key_encryption_key_vault_key_name        = string #(Optional) Specify key vault secret name for key encryption key_url
    managed_disk_encryption_settings_key_encryption_key_vault_resource_group  = string #(Optional) Specify resource group name where key vault for key encryption key_url is present
  }))
  description = "Map of Managed Disks"
  default     = {}
}

#SNAPSHOT VARIABLES
variable "snapshot_variables" {
  description = "Map of object of snapshot variables"
  type = map(object({
    snapshot_name                                              = string      #(Required) Specifies the name of the Snapshot resource. Changing this forces a new resource to be created.
    snapshot_location                                          = string      #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    snapshot_resource_group_name                               = string      #(Required) The name of the resource group in which to create the Snapshot. Changing this forces a new resource to be created.
    snapshot_create_option                                     = string      #(Required) Indicates how the snapshot is to be created. Possible values are Copy or Import. Changing this forces a new resource to be created.
    snapshot_disk_size_gb                                      = string      #(Optional) The size of the Snapshotted Disk in GB.
    snapshot_source_manged_disk                                = bool        #(Optional) Spicy when create_option is import whether managed disk or unmanged disk.
    snapshot_source_uri_unmanaged_blobs_different_subscription = bool        #(Optional) Used with source_uri to allow authorization during import of unmanaged blobs from a different subscription. Changing this forces a new resource to be created.
    managed_disk_source_resource_name                          = string      #(Optional) Specifies a reference to an existing snapshot, when create_option is Copy. Changing this forces a new resource to be created. 
    managed_disk_source_resource_resource_group_name           = string      #(Optional) Specifies a reference to an existing snapshot, when create_option is Copy. Changing this forces a new resource to be created.
    snapshot_managed_disk_name                                 = string      #(Optional) Specify when create_option is import and snapshot_source_manged_disk is true.
    snapshot_managed_disk_resource_group_name                  = string      #(Optional) Specify when create_option is import and snapshot_source_manged_disk is true.
    snapshot_storage_account_name                              = string      #(optional) Specify when create_option is import and snapshot_source_manged_disk is false.
    snapshot_storage_resource_group_name                       = string      #(optional) Specify when create_option is import and snapshot_source_manged_disk is false.
    snapshot_storage_blob_name                                 = string      #(optional) Specify when create_option is import and snapshot_source_manged_disk is false.
    snapshot_storage_container_name                            = string      #(optional) Specify when create_option is import and snapshot_source_manged_disk is false.
    snapshot_encryption_settings_enabled                       = bool        # True if encryption_settings needs to be enabled.
    snapshot_encryption_settings_key_vault_name                = string      # Required if snapshot_encryption_settings_enabled is set to True.
    snapshot_encryption_settings_key_vault_resource_group_name = string      # Required if snapshot_encryption_settings_enabled is set to True.
    snapshot_encryption_settings_key_vault_secret_name         = string      # Required if encryption secret is stored in key vault secret when snapshot_encryption_settings_enabled is set to True 
    snapshot_encryption_settings_key_vault_key_name            = string      # Required if encryption secret is stored in key vault key when snapshot_encryption_settings_enabled is set to True
    snapshot_tags                                              = map(string) #(Optional) A mapping of tags to assign to the resource.
  }))
  default = {}
}