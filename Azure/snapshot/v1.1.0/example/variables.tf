#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
  default = {}
}

#MANAGED DISK VARIABLES
variable "managed_disk_variables" {
  type = map(object({
    managed_disk_name                 = string
    managed_disk_location             = string
    managed_disk_resource_group_name  = string
    managed_disk_storage_account_type = string

    #Create Options
    managed_disk_create_option                               = string
    managed_disk_image_reference_name                        = string
    managed_disk_image_reference_resource_group_name         = string
    managed_disk_gallery_image_reference_name                = string
    managed_disk_gallery_image_reference_resource_group_name = string
    managed_disk_gallery_image_reference_gallery_name        = string
    managed_disk_source_resource_name                        = string
    managed_disk_source_resource_resource_group_name         = string
    managed_disk_storage_acccount_name                       = string
    managed_disk_storage_account_resource_group_name         = string
    managed_disk_storage_container_name                      = string
    managed_disk_os_type                                     = string
    managed_disk_hyper_v_generation                          = string

    #Disk Options
    managed_disk_disk_size_gb               = string
    managed_disk_disk_sector_size           = string
    managed_disk_tier                       = string
    managed_disk_max_shares                 = string
    managed_disk_zone                       = string
    managed_disk_trusted_launch_enabled     = bool
    managed_disk_on_demand_bursting_enabled = bool

    #Ultra SSD Options
    managed_disk_iops_read_write = string
    managed_disk_iops_read_only  = string
    managed_disk_mbps_read_write = string
    managed_disk_mbps_read_only  = string

    #Network Options
    managed_disk_public_network_access_enabled = bool
    managed_disk_network_access_policy         = string
    managed_disk_disk_access_id                = string

    #Disk Access
    managed_disk_access_name                = string
    managed_disk_access_resource_group_name = string

    #Encryption
    managed_disk_disk_encryption_set_name                      = string
    managed_disk_disk_encryption_resource_group_name           = string
    managed_disk_tags                                          = map(string)
    managed_disk_security_type                                 = string
    managed_disk_secure_vm_disk_encryption_set_name            = string
    managed_disk_secure_vm_disk_encryption_resource_group_name = string

    #Encryption Settings    
    managed_disk_encryption_settings_enabled                                  = bool
    managed_disk_encryption_settings_is_disk_encryption_key_present           = bool
    managed_disk_encryption_settings_is_key_encryption_key_present            = bool
    managed_disk_encryption_settings_disk_encryption_key_vault_name           = string
    managed_disk_encryption_settings_disk_encryption_key_vault_resource_group = string
    managed_disk_encryption_settings_disk_encryption_key_vault_secret_name    = string
    managed_disk_encryption_settings_key_encryption_key_vault_name            = string
    managed_disk_encryption_settings_key_encryption_key_vault_key_name        = string
    managed_disk_encryption_settings_key_encryption_key_vault_resource_group  = string
  }))
  description = "Map of Managed Disks"
  default     = {}
}

#SNAPSHOT VARIABLES
variable "snapshot_variables" {
  type = map(object({
    snapshot_name                                              = string      #(Required) Specifies the name of the Snapshot resource. Changing this forces a new resource to be created.
    snapshot_resource_group_name                               = string      #(Required) The name of the resource group in which to create the Snapshot. Changing this forces a new resource to be created.
    snapshot_location                                          = string      #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
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
    snapshot_tags                                              = map(string) #(Optional) A mapping of tags to assign to the resource.
  }))
}