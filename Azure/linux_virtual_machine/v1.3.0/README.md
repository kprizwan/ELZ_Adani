### Attributes ##
- linux_virtual_machine_admin_username = string #(Required) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created.
- linux_virtual_machine_location       = string #(Required) The Azure location where the Linux Virtual Machine should exist. Changing this forces a new resource to be created.
- linux_virtual_machine_license_type   = string #(Optional) Specifies the BYOL Type for this Virtual Machine. Possible values are RHEL_BYOS and SLES_BYOS.
- linux_virtual_machine_name           = string #(Required) The name of the Linux Virtual Machine. Changing this forces a new resource to be created.
- linux_virtual_machine_os_disk = object({})      #(Required) A os_disk block as defined below.
    - os_disk_caching              = string       #(Required) The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite.
    - os_disk_storage_account_type = string       #(Required) The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS. Changing this forces a new resource to be created.
    - os_disk_diff_disk_settings = object({})       #(Optional) A diff_disk_settings block as defined above. Changing this forces a new resource to be created.
        - diff_disk_settings_option    = string     # (Required) Specifies the Ephemeral Disk Settings for the OS Disk. At this time the only possible value is Local. Changing this forces a new resource to be created.
        - diff_disk_settings_placement = string     #(Optional) Specifies where to store the Ephemeral Disk. Possible values are CacheDisk and ResourceDisk. Defaults to CacheDisk. Changing this forces a new resource to be created.
    - os_disk_disk_size_gb              = number #(Optional) The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from.
    - os_disk_name                      = string #(Optional) The name which should be used for the Internal OS Disk. Changing this forces a new resource to be created.
    - os_disk_security_encryption_type  = string #(Optional) Encryption Type when the Virtual Machine is a Confidential VM. Possible values are VMGuestStateOnly and DiskWithVMGuestState. Changing this forces a new resource to be created.
    - os_disk_write_accelerator_enabled = bool   #(Optional) Should Write Accelerator be Enabled for this OS Disk? Defaults to false.
- linux_virtual_machine_resource_group_name = string       #(Required) The name of the Resource Group in which the Linux Virtual Machine should be exist. Changing this forces a new resource to be created.
- linux_virtual_machine_size                = string       #(Required) The SKU which should be used for this Virtual Machine, such as Standard_F2.
- linux_virtual_machine_additional_capabilities = object({}) #(Optional) A additional_capabilities block as defined below.
    - additional_capabilities_ultra_ssd_enabled = bool       #(Optional) Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine? Defaults to false.
- linux_virtual_machine_allow_extension_operations      = bool   #(Optional) Should Extension Operations be allowed on this Virtual Machine?
- linux_virtual_machine_computer_name                   = string #(Optional) Specifies the Hostname which should be used for this Virtual Machine. If unspecified this defaults to the value for the name field. If the value of the name field is not a valid computer_name, then you must specify computer_name. Changing this forces a new resource to be created.
- linux_virtual_machine_custom_data                     = string #(Optional) The Base64-Encoded Custom Data which should be used for this Virtual Machine. Changing this forces a new resource to be created.
- linux_virtual_machine_disable_password_authentication = bool   #(Optional) Should Password Authentication be disabled on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created.
- linux_virtual_machine_edge_zone                       = string #(Optional) Specifies the Edge Zone within the Azure Region where this Linux Virtual Machine should exist. Changing this forces a new Linux Virtual Machine to be created.
- linux_virtual_machine_encryption_at_host_enabled      = bool   #(Optional) Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?
- linux_virtual_machine_eviction_policy                 = string #(Optional) Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance. Possible values are Deallocate and Delete. Changing this forces a new resource to be created.
- linux_virtual_machine_extensions_time_budget          = string #(Optional) Specifies the duration allocated for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. Defaults to 90 minutes (PT1H30M).
- linux_virtual_machine_gallery_application = object({})           #(Optional) A gallery_application block as defined below.
    - gallery_application_order = number                           #(Optional) Specifies the order in which the packages have to be installed. Possible values are between 0 and 2,147,483,647.
    - gallery_application_tag   = string                           #(Optional) Specifies a passthrough value for more generic context. This field can be any valid string value.
- linux_virtual_machine_identity = object({ #(Optional)
    - identity_type = string                  # Other values could be "UserAssigned", "SystemAssigned".If given as "SystemAssigned" , then give below parameter as null      
    - linux_virtual_machine_user_assigned_identities = list(object({})
        - user_assigned_identities_name                = string #Name of the user assigned identity
        - user_assigned_identities_resource_group_name = string #Resource group name of the user assigned identity
- linux_virtual_machine_patch_assessment_mode = string #(Optional) Specifies the mode of VM Guest Patching for the Virtual Machine. Possible values are AutomaticByPlatform or ImageDefault. Defaults to ImageDefault.
- linux_virtual_machine_patch_mode            = string # (Optional) Specifies the mode of in-guest patching to this Linux Virtual Machine. Possible values are AutomaticByPlatform and ImageDefault. Defaults to ImageDefault. For more information on patch modes please see the product documentation.
- linux_virtual_machine_max_bid_price         = string #(Optional) The maximum price you're willing to pay for this Virtual Machine, in US Dollars; which must be greater than the current spot price. If this bid price falls below the current spot price the Virtual Machine will be evicted using the eviction_policy. Defaults to -1, which means that the Virtual Machine should not be evicted for price reasons.
- linux_virtual_machine_plan = list(object({})           #(Optional) A plan block as defined below. Changing this forces a new resource to be created.
    - plan_name      = string                            #(Required) Specifies the Name of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
    - plan_product   = string                            #(Required) Specifies the Product of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
    - plan_publisher = string                            #(Required) Specifies the Publisher of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
- linux_virtual_machine_platform_fault_domain = string    #(Optional) Specifies the Platform Fault Domain in which this Linux Virtual Machine should be created. Defaults to -1, which means this will be automatically assigned to a fault domain that best maintains balance across the available fault domains. Changing this forces a new Linux Virtual Machine to be created.
- linux_virtual_machine_priority              = string    #(Optional) Specifies the priority of this Virtual Machine. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created.
- linux_virtual_machine_provision_vm_agent    = bool      #(Optional) Should the Azure VM Agent be provisioned on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created.
- linux_virtual_machine_secure_boot_enabled   = bool      #(Optional) Specifies whether secure boot should be enabled on the virtual machine. Changing this forces a new resource to be created.
- linux_virtual_machine_source_image_reference = object({ #Optional) A source_image_reference block as defined below. Changing this forces a new resource to be created.
    - source_image_reference_publisher = string             #(Optional) Specifies the publisher of the image used to create the virtual machines.
    - source_image_reference_offer     = string             #(Optional) Specifies the offer of the image used to create the virtual machines.
    - source_image_reference_sku       = string             #(Optional) Specifies the SKU of the image used to create the virtual machines.
    - source_image_reference_version   = string             #(Optional) Specifies the version of the image used to create the virtual machines.
- linux_virtual_machine_termination_notification = list(object({ #(Optional) A termination_notification block as defined below.
    - termination_notification_enabled = bool                      #(Required) Should the termination notification be enabled on this Virtual Machine? Defaults to false.
    - termination_notification_timeout = string                    #(Optional) Length of time (in minutes, between 5 and 15) a notification to be sent to the VM on the instance metadata server till the VM gets deleted. The time duration should be specified in ISO 8601 format.
- linux_virtual_machine_user_data    = string #(Optional) The Base64-Encoded User Data which should be used for this Virtual Machine.
- linux_virtual_machine_vtpm_enabled = bool   #(Optional) Specifies whether vTPM should be enabled on the virtual machine. Changing this forces a new resource to be created.
- linux_virtual_machine_zone         = string #(Optional) Specifies the Availability Zones in which this Linux Virtual Machine should be located. Changing this forces a new Linux Virtual Machine to be created.
- linux_virtual_machine_tags         = map(string)
- linux_virtual_machine_use_existing_vm_username        = bool   #(Required)should be set true if existing user name is used
- linux_virtual_machine_generate_new_admin_password     = bool   #(Required)admin_password should be generated if disable_password_authentication is false
- linux_virtual_machine_generate_new_ssh_key            = bool   #(Required)Should be true/false if linux_virtual_machine_disable_password_authentication is true
- linux_virtual_machine_admin_login_key_vault_name      = string #"existingkeyvaultscenario"
- linux_virtual_machine_tls_private_key_algorithm       = string #Provide Algorithm used for TLS private key
- linux_virtual_machine_tls_private_key_rsa_bits        = number #Provide number if bits for TLS private key
- linux_virtual_machine_admin_ssh_key_vault_secret_name = string #Key vault secret name to store the ssh key
- linux_virtual_machine_is_disk_encryption_set_required = bool #(Required)Boolean value if disk encryption set is required or not
- linux_virtual_machine_is_vmss_id_required             = bool #(Required)Boolean value if VMSS id is required
- linux_virtual_machine_network_interface = map(object({       #(Required) Map of object for network interface
    - network_interface_name                = string             #Name of the network interface
    - network_interface_resource_group_name = string             #Resource group name of network interface
- linux_virtual_machine_is_secret_required                            = bool   #(Required)Boolean value if secret is required or not
- linux_virtual_machine_is_storage_blob_required                      = bool   #(Required)Boolean value if blob storage is required
- linux_virtual_machine_storage_blob_name                             = string #Provide blob storage name value if linux_virtual_machine_is_storage_blob_required is set to true.
- linux_virtual_machine_storage_account_name                          = string #Provide storage account name value if linux_virtual_machine_is_storage_blob_required or linux_virtual_machine_is_boot_diagnostics_required is set to true
- linux_virtual_machine_storage_container_name                        = string #Provide storage container name value if linux_virtual_machine_is_storage_blob_required is set to true.
- linux_virtual_machine_is_gallery_application_id_required            = bool   #(Required)Boolean value if gallery application id is required
- linux_virtual_machine_gallery_application_version_name              = string #Provide version name if linux_virtual_machine_is_gallery_application_id_required is set to true
- linux_virtual_machine_shared_image_gallery_name                     = string #Name of the shared image gallery. #Provide value if linux_virtual_machine_is_gallery_application_id_required is set to true
- linux_virtual_machine_gallery_application_name                      = string #Name of gallery application. #Provide value if linux_virtual_machine_is_gallery_application_id_required is set to true
- linux_virtual_machine_is_capacity_reservation_group_id_required     = bool   #(Required)Boolean value if capacity reservation group id is required
- linux_virtual_machine_capacity_reservation_group_name               = string #Provide capacity reservation group name if linux_virtual_machine_is_capacity_reservation_group_id_required is set to true
- linux_virtual_machine_is_key_vault_certificate_url_required         = bool   #(Required)Boolean value if key vault certificate url is required
- linux_virtual_machine_key_vault_certificate_name                    = string #Provide key vault certificate name if linux_virtual_machine_is_key_vault_certificate_url_required is set to true
- linux_virtual_machine_disk_encryption_set_name                      = string #Name of the disk encryption set. Provide value if linux_virtual_machine_is_disk_encryption_set_required is set to true
- linux_virtual_machine_is_boot_diagnostics_required                  = bool   #(Required)Boolean value if boot diagnostics required
- linux_virtual_machine_bypass_platform_safety_checks_on_user_schedule_enabled = bool #(Optional) Specifies whether to skip platform scheduled patching when a user schedule is associated with the VM. Defaults to false.Can only be set to true when patch_mode is set to AutomaticByPlatform.
- linux_virtual_machine_is_availability_set_id_required               = bool   #(Required)Boolean value if availability set id required
- linux_virtual_machine_is_capacity_reservation_group_id_required     = bool   #(Required)Boolean value if capacity reservation group id is required
- linux_virtual_machine_is_proximity_placement_group_id_required      = bool   #(Required)Boolean value if proximity placement group id required
- linux_virtual_machine_reboot_setting = string # (Optional) Specifies the reboot setting for platform scheduled patching. Possible values are Always, IfRequired and Never. can only be set when patch_mode is set to AutomaticByPlatform.
- linux_virtual_machine_is_dedicated_host_group_id_required           = bool   #(Required)Boolean value if dedicated host group id required
- linux_virtual_machine_is_dedicated_host_id_required                 = bool   #(Required)Boolean value if dedicated host id required
- linux_virtual_machine_boot_diagnostics_storage_account_name         = string # Name of the storage account
- linux_virtual_machine_deploy_vm_using_source_image_reference        = bool   #(Required)Boolean value if VM should be deployed using source image reference
- linux_virtual_machine_availability_set_name                         = string # Provide availability set name if linux_virtual_machine_is_availability_set_id_required is set true
- linux_virtual_machine_availability_set_resource_group_name          = string # Provide availability set resource group name if linux_virtual_machine_is_availability_set_id_required is set true
- linux_virtual_machine_dedicated_host_group_name                     = string # Provide host group name if linux_virtual_machine_is_dedicated_host_group_id_required is set true
- linux_virtual_machine_dedicated_host_group_resource_group_name      = string # Provide host group resource group name if linux_virtual_machine_is_dedicated_host_group_id_required is set true
- linux_virtual_machine_dedicated_host_name                           = string # Provide host name if linux_virtual_machine_is_dedicated_host_id_required is set true
- linux_virtual_machine_dedicated_host_resource_group_name            = string # Provide host resource group name if linux_virtual_machine_is_dedicated_host_id_required is set true
- linux_virtual_machine_proximity_placement_group_name                = string # Provide proximity palcement group name if linux_virtual_machine_is_proximity_placement_group_id_required is set true
- linux_virtual_machine_proximity_placement_group_resource_group_name = string # Provide proximity palcement group resource group name if linux_virtual_machine_is_proximity_placement_group_id_required is set true
- linux_virtual_machine_generated_admin_password_secret_name          = string #Key vault secret name to store random password
- linux_virtual_machine_existing_admin_password_secret_name           = string #Key vault secret name where the existing password exists
- linux_virtual_machine_virtual_machine_scale_set_name                = string #Provide Vm scale set name if linux_virtual_machine_is_vmss_id_required is true
- linux_virtual_machine_virtual_machine_scale_set_resource_group_name = string #Provide VM scale set resource group name if linux_virtual_machine_is_vmss_id_required is true
- linux_virtual_machine_source_image_type                             = string #if you are using existing vm image make image type as "VMImage" if you are using share image give as "SharedImage"
- linux_virtual_machine_shared_image_name                             = string #Provide image name if linux_virtual_machine_source_image_type is "SharedImage"
- linux_virtual_machine_shared_image_resource_group_name              = string #Provide image resource group name if linux_virtual_machine_source_image_type is "SharedImage"
- linux_virtual_machine_existing_image_name                           = string # image name should be given if image type is "VMImage"
- linux_virtual_machine_existing_image_resource_group_name            = string #Provide existing image resource group name if image type is "VMImage"
- linux_virtual_machine_admin_key_vault_resource_group_name           = string #Provide key vault resource group name to store credentials
- linux_virtual_machine_storage_account_resource_group_name           = string #Provide value if linux_virtual_machine_is_boot_diagnostics_required is set to true
- linux_virtual_machine_disk_encryption_set_resource_group_name       = string #Resource group name of the disk encryption set. Provide value if linux_virtual_machine_is_disk_encryption_set_required is set to true
- linux_virtual_machine_existing_admin_username_secret_name           = string #Key vault secret name to store admin username

>### Notes ###
>1. Terraform will automatically remove the OS Disk by default - this behaviour can be configured using the features setting within the Provider block.
>2. This resource does not support Unmanaged Disks. If you need to use Unmanaged Disks you can continue to use the azurerm_virtual_machine resource instead.
>3. This resource does not support attaching existing OS Disks. You can instead capture an image of the OS Disk or continue to use the azurerm_virtual_machine resource instead.
>4. In this release there's a known issue where the public_ip_address and public_ip_addresses fields may not be fully populated for Dynamic Public IP's.
>5. When an admin_password is specified disable_password_authentication must be set to false. ~> NOTE: One of either admin_password or admin_ssh_key must be specified.
>6. One of either admin_password or admin_ssh_key must be specified.
>7. capacity_reservation_group_id cannot be used with availability_set_id or proximity_placement_group_id
>8. In general we'd recommend using SSH Keys for authentication rather than Passwords - but there's tradeoff's to each - please see this thread for more information.
>9. When an admin_password is specified disable_password_authentication must be set to false.
>10. eviction_policy can only be configured when priority is set to Spot.
>11. If the patch_assessment_mode is set to AutomaticByPlatform then the provision_vm_agent field must be set to true.
>12. If patch_mode is set to AutomaticByPlatform then provision_vm_agent must also be set to true.
>13. max_bid_price can only be configured when priority is set to Spot.
>14. If provision_vm_agent is set to false then allow_extension_operations must also be set to false.
>15. One of either source_image_id or source_image_reference must be set.
>16. One of either source_image_id or source_image_reference must be set.
>17. Orchestrated Virtual Machine Scale Sets can be provisioned using the azurerm_orchestrated_virtual_machine_scale_set resource.
>18. The Azure VM Agent only allows creating SSH Keys at the path /home/{username}/.ssh/authorized_keys - as such this public key will be written to the authorized keys file.
>19. Passing a null value will utilize a Managed Storage Account to store Boot Diagnostics
>20. url in certificate block can be sourced from the secret_id field within the azurerm_key_vault_certificate Resource.
>21. identity_ids is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
>22. diff_disk_settings can only be set when caching is set to ReadOnly.
>23. The Disk Encryption Set must have the Reader Role Assignment scoped on the Key Vault - in addition to an Access Policy to the Key Vault
>24. If specified disk_size_gb must be equal to or larger than the size of the Image the Virtual Machine is based on. When creating a larger disk than exists in the image you'll need to repartition the disk to use the remaining space.
>25. secure_vm_disk_encryption_set_id can only be specified when security_encryption_type is set to DiskWithVMGuestState.
>26. vtpm_enabled must be set to true when security_encryption_type is specified.
>27. encryption_at_host_enabled cannot be set to true when security_encryption_type is set to DiskWithVMGuestState.
>28. This requires that the storage_account_type is set to Premium_LRS and that caching is set to None.
>29. For more information about the termination notification, please refer to this doc.- https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-terminate-notification

Possible scenarios

| Scenario Number | 1.a | 1.b | 1.c | 1.d | 2.a | 2.b | 2.c | 2.d |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| disable_password_authentication | true | true	| true | true | false | false | false | false |
| use_ssh_keys | true | true | false | false | false | true | true | false |
| generate_new_ssh_key | false | true | false | true | false | false | true | true |						  
| Successful/Failed	| Successful | Successful | Failed | Failed | Failed | Successful | Successful | Error |
| Scenario Possibility | Correct | Correct | Incorrect | Incorrect | Correct | Correct | Correct | Incorrect |
| | No Password | No Password | No Password | No Password | Password ON | Password ON | Password ON | Password ON |
| | Existing SSH key | New SSH Keys | No SSH keys | No SSH Keys | No SSH Keys | Existing SSH key | New SSH Keys | No SSH keys |
| Top chances | HIGH | HIGH | ZERO | ZERO | HIGH | HIGH | HIGH | Can be attained by 2.a |