#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000001"
    location = "westus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#MANAGED DISK
managed_disk_variables = {
  "managed_disk_1" = {
    managed_disk_name                 = "ploceusdisk000001"
    managed_disk_location             = "westus2"
    managed_disk_resource_group_name  = "ploceusrg000001"
    managed_disk_storage_account_type = "Premium_LRS"

    #Create Options
    managed_disk_create_option = "Empty" #Allowed values are Empty,FromImage,Copy, Import and Restore

    #Managed image
    managed_disk_image_reference_name                = "ploceusimage000001" #specify if the managed_disk_create_option = FromImage and managed image is used
    managed_disk_image_reference_resource_group_name = "ploceusrg000001"    #specify if the managed_disk_create_option = FromImage and managed image is used

    #Gallery Image
    managed_disk_gallery_image_reference_name                = "ploceusimage000001"   #specify if the managed_disk_create_option = FromImage and gallery image is used
    managed_disk_gallery_image_reference_gallery_name        = "ploceusgallery000001" #specify if the managed_disk_create_option = FromImage and gallery image is used
    managed_disk_gallery_image_reference_resource_group_name = "ploceusrg000001"      #specify if the managed_disk_create_option = FromImage and gallery image is used

    #Snapshot
    managed_disk_source_resource_name                = "ploceussnap000001" #specify if the managed_disk_create_option = Copy is used
    managed_disk_source_resource_resource_group_name = "ploceusrg000001"   #specify if the managed_disk_create_option = Copy is used

    #Storage blob
    managed_disk_storage_acccount_name               = "ploceussg000001" #specify if the managed_disk_create_option = Import is used
    managed_disk_storage_account_resource_group_name = "ploceusrg000001" #specify if the managed_disk_create_option = Import is used
    managed_disk_storage_container_name              = "blob"


    managed_disk_os_type            = "linux" #specify only if managed_disk_create_option = Copy or Import is used
    managed_disk_hyper_v_generation = "V1"    #specify only if managed_disk_create_option = Copy or Import is used

    #Disk Options
    managed_disk_disk_size_gb               = "100" #specify if create_option is Copy or FromImage
    managed_disk_disk_sector_size           = "4096"
    managed_disk_tier                       = "P10" #specify if managed_disk_storage_type is Premium_LRS
    managed_disk_max_shares                 = "4"   #allowed Values 1 to 5
    managed_disk_zone                       = "1" /*Availability Zones are only supported in select regions at this time.refer https://learn.microsoft.com/en-us/azure/availability-zones/az-overview*/
    managed_disk_trusted_launch_enabled     = false
    managed_disk_on_demand_bursting_enabled = false

    #Ultra SSD Options
    managed_disk_iops_read_write = "4" #Specify when UltraSSD disks and PremiumV2 disks
    managed_disk_iops_read_only  = "4" #Specify when UltraSSD disks and PremiumV2 disks
    managed_disk_mbps_read_write = "4" #Specify when UltraSSD disks and PremiumV2 disks
    managed_disk_mbps_read_only  = "4" #Specify when UltraSSD disks and PremiumV2 disks

    #Network Options
    managed_disk_public_network_access_enabled = true
    managed_disk_network_access_policy         = "AllowAll"                      # Allowed values AllowAll,AllowPrivate and DenyAll
    managed_disk_disk_access_id                = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX" #Specify when network_access_policy is AllowPrivate

    #Disk Access
    managed_disk_access_name                = null
    managed_disk_access_resource_group_name = "ploceusrg000001"

    #Encryption
    managed_disk_disk_encryption_set_name                      = null #specify when disk encryption is added
    managed_disk_disk_encryption_resource_group_name           = null #specify when disk encryption is added
    managed_disk_security_type                                 = null #(Optional) Security Type of the Managed Disk when it is used for a Confidential VM. Possible values are ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey, ConfidentialVM_DiskEncryptedWithPlatformKey and ConfidentialVM_DiskEncryptedWithCustomerKey
    managed_disk_secure_vm_disk_encryption_set_name            = null #(Optional) The ID of the Secure VM Disk Encryption Set which should be used to Encrypt this OS Disk when the Virtual Machine is a Confidential VM. Conflicts with disk_encryption_set_id
    managed_disk_secure_vm_disk_encryption_resource_group_name = null #(Optional) The resource group name of the Secure VM disk encryption.

    #Encryption Settings   
    managed_disk_encryption_settings_enabled                                  = false
    managed_disk_encryption_settings_is_disk_encryption_key_present           = false
    managed_disk_encryption_settings_is_key_encryption_key_present            = false
    managed_disk_encryption_settings_disk_encryption_key_vault_name           = "ploceuskeyvault000001"
    managed_disk_encryption_settings_disk_encryption_key_vault_resource_group = "ploceusrg000001"
    managed_disk_encryption_settings_disk_encryption_key_vault_secret_name    = "ploceuskeyvaultsecret000001"
    managed_disk_encryption_settings_key_encryption_key_vault_name            = "ploceuskeyvault000001"
    managed_disk_encryption_settings_key_encryption_key_vault_key_name        = "ploceuskeyavaultkey000001"
    managed_disk_encryption_settings_key_encryption_key_vault_resource_group  = "ploceusrg000001"
    managed_disk_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#SNAPSHOT
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
    snapshot_tags = {                                                                #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}