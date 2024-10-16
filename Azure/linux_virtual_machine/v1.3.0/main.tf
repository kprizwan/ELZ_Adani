locals {
  is_disk_encryption_set_exists             = { for k, v in var.linux_virtual_machine_variables : k => v if lookup(v, "linux_virtual_machine_is_disk_encryption_set_required", false) == true }
  is_storage_blob_exists                    = { for k, v in var.linux_virtual_machine_variables : k => v if lookup(v, "linux_virtual_machine_is_storage_blob_required", false) == true }
  is_vmss_id_required                       = { for k, v in var.linux_virtual_machine_variables : k => v if lookup(v, "linux_virtual_machine_is_vmss_id_required", false) == true }
  is_proximity_placement_group_id_required  = { for k, v in var.linux_virtual_machine_variables : k => v if lookup(v, "linux_virtual_machine_is_proximity_placement_group_id_required", false) == true }
  is_availability_set_id_required           = { for k, v in var.linux_virtual_machine_variables : k => v if lookup(v, "linux_virtual_machine_is_availability_set_id_required", false) == true }
  is_capacity_reservation_group_id_required = { for k, v in var.linux_virtual_machine_variables : k => v if lookup(v, "linux_virtual_machine_is_capacity_reservation_group_id_required", false) == true }
  is_key_vault_certificate_url_required     = { for k, v in var.linux_virtual_machine_variables : k => v if lookup(v, "linux_virtual_machine_is_key_vault_certificate_url_required", false) == true }
  is_gallery_application_id_required        = { for k, v in var.linux_virtual_machine_variables : k => v if lookup(v, "linux_virtual_machine_is_gallery_application_id_required", false) == true }
  is_dedicated_host_id_required             = { for k, v in var.linux_virtual_machine_variables : k => v if lookup(v, "linux_virtual_machine_is_dedicated_host_id_required", false) == true }
  is_dedicated_host_group_id_required       = { for k, v in var.linux_virtual_machine_variables : k => v if lookup(v, "linux_virtual_machine_is_dedicated_host_group_id_required", false) == true }
  is_boot_diagnostics_exists                = { for k, v in var.linux_virtual_machine_variables : k => v if lookup(v, "linux_virtual_machine_is_boot_diagnostics_required", false) == true }
  generate_ssh_keys                         = { for k, v in var.linux_virtual_machine_variables : k => v if(lookup(v, "linux_virtual_machine_generate_new_ssh_key", false) == true) }
  use_existing_ssh_keys                     = { for k, v in var.linux_virtual_machine_variables : k => v if(lookup(v, "linux_virtual_machine_generate_new_ssh_key", true) == false) }
  generate_new_vm_password                  = { for k, v in var.linux_virtual_machine_variables : k => v if(lookup(v, "linux_virtual_machine_generate_new_admin_password", false) == true) }
  use_existing_vm_password                  = { for k, v in var.linux_virtual_machine_variables : k => v if(lookup(v, "linux_virtual_machine_generate_new_admin_password", true) == false) && lookup(v, "linux_virtual_machine_disable_password_authentication", true) == false }
  use_existing_vm_username                  = { for k, v in var.linux_virtual_machine_variables : k => v if(lookup(v, "linux_virtual_machine_use_existing_vm_username", false) == true) }
  is_vm_using_source_image_reference        = { for k, v in var.linux_virtual_machine_variables : k => v if(lookup(v, "linux_virtual_machine_deploy_vm_using_source_image_reference", true) == false) }
  is_vm_using_platform_image                = { for k, v in var.linux_virtual_machine_variables : k => v if(lookup(v, "linux_virtual_machine_source_image_type", null) == "PlatformImage" && lookup(v, "linux_virtual_machine_deploy_vm_using_source_image_reference", true) == false) }
  is_vm_using_shared_image                  = { for k, v in var.linux_virtual_machine_variables : k => v if(lookup(v, "linux_virtual_machine_source_image_type", null) == "SharedImage" && lookup(v, "linux_virtual_machine_deploy_vm_using_source_image_reference", true) == false) }
  is_vm_using_existing_image                = { for k, v in var.linux_virtual_machine_variables : k => v if(lookup(v, "linux_virtual_machine_source_image_type", null) == "VMImage" && lookup(v, "linux_virtual_machine_deploy_vm_using_source_image_reference", true) == false) }
  nic_ids_final                             = { for k, v in data.azurerm_network_interface.network_interface : element(split(",", k), 0) => v.id... }
  identities                                = { for k, v in var.linux_virtual_machine_variables : k => lookup(v, "linux_virtual_machine_identity", null) != null ? v.linux_virtual_machine_identity.identity_type != "SystemAssigned" ? v.linux_virtual_machine_identity.linux_virtual_machine_user_assigned_identities : null : null }
  nic_object_list = flatten([
    for k, v in var.linux_virtual_machine_variables : [
      for i, j in lookup(v, "linux_virtual_machine_network_interface", {}) :
      merge({
        terraform_main_key = k, terraform_nested_key = i
      }, j)
  ]])
  identities_list = flatten([
    for k, v in local.identities : [for i in v : [
      {
        main_key                                     = k
        user_assigned_identities_name                = i.user_assigned_identities_name
        user_assigned_identities_resource_group_name = i.user_assigned_identities_resource_group_name
    }]] if v != null
  ])
}

data "azurerm_resource_group" "resource_group_id" {
  provider = azurerm.linux_vm_sub
  for_each = var.linux_virtual_machine_variables
  name     = each.value.linux_virtual_machine_resource_group_name
}
#DATA BLOCK FOR CAPACITY RESERVATION GROUP
data "azurerm_resources" "capacity_reservation_group_id" {
  provider = azurerm.linux_vm_sub
  for_each = local.is_capacity_reservation_group_id_required
  name     = each.value.linux_virtual_machine_capacity_reservation_group_name
}
#DATA BLOCK FOR STORAGE BLOB
data "azurerm_storage_blob" "storage_blob_uri" {
  provider               = azurerm.linux_vm_sub
  for_each               = local.is_storage_blob_exists
  name                   = each.value.linux_virtual_machine_storage_blob_name
  storage_account_name   = each.value.linux_virtual_machine_storage_account_name
  storage_container_name = each.value.linux_virtual_machine_storage_container_name
}
#DATA BLOCK FOR DISK ENCRYPTION SET
data "azurerm_disk_encryption_set" "disk_encryption_set" {
  provider            = azurerm.linux_vm_sub
  for_each            = local.is_disk_encryption_set_exists
  name                = each.value.linux_virtual_machine_disk_encryption_set_name
  resource_group_name = each.value.linux_virtual_machine_disk_encryption_set_resource_group_name
}
#DTA BLOCK FOR STORAGE ACCOUNT
data "azurerm_storage_account" "boot_diagnostics_storage_account" {
  provider            = azurerm.linux_vm_sub
  for_each            = local.is_boot_diagnostics_exists
  name                = each.value.linux_virtual_machine_boot_diagnostics_storage_account_name
  resource_group_name = each.value.linux_virtual_machine_storage_account_resource_group_name
}
#DATA BLOCK FOR USER ASSIGNED IDENTITY
data "azurerm_user_assigned_identity" "linux_user_identity" {
  provider            = azurerm.linux_vm_sub
  for_each            = { for v in local.identities_list : "${v.main_key},${v.user_assigned_identities_name}" => v }
  name                = each.value.user_assigned_identities_name
  resource_group_name = each.value.user_assigned_identities_resource_group_name
}

#DATA BLOCK FOR KEY VAULT LOGIN DETAILS
data "azurerm_key_vault" "login_keys_key_vault_id" {
  provider            = azurerm.key_vault_sub
  for_each            = var.linux_virtual_machine_variables
  name                = each.value.linux_virtual_machine_admin_login_key_vault_name
  resource_group_name = each.value.linux_virtual_machine_admin_key_vault_resource_group_name
}

#CREATES NEW PRIVATE KEY IF linux_virtual_machine_generate_new_ssh_key IS true
resource "tls_private_key" "generate_ssh_keys_tls_private_key" {
  for_each  = local.generate_ssh_keys
  algorithm = each.value.linux_virtual_machine_tls_private_key_algorithm
  rsa_bits  = each.value.linux_virtual_machine_tls_private_key_rsa_bits
}

#GENERATE RANDOM PASSWORD
resource "random_password" "password" {
  for_each         = local.generate_new_vm_password
  length           = 16
  special          = true
  lower            = true
  upper            = true
  numeric          = true
  min_lower        = 6
  min_upper        = 7
  min_numeric      = 1
  min_special      = 1
  override_special = "@"
}

#ADD THE NEWLY CREATED PRIVATE KEY AS A SECRET TO A KEY VAULT FOR ADMIN LOGIN PURPOSE
resource "azurerm_key_vault_secret" "generate_ssh_key_vault_secret" {
  provider        = azurerm.key_vault_sub
  for_each        = local.generate_ssh_keys
  expiration_date = each.value.linux_virtual_machine_admin_ssh_key_vault_secret_expiration_date
  content_type    = each.value.linux_virtual_machine_admin_ssh_key_vault_secret_content_type
  name            = each.value.linux_virtual_machine_admin_ssh_key_vault_secret_name
  value           = tls_private_key.generate_ssh_keys_tls_private_key[each.key].private_key_pem
  key_vault_id    = data.azurerm_key_vault.login_keys_key_vault_id[each.key].id
}
#KEY VAULT SECRET FOR GENERATING NEW ADMIN PASSWORD
resource "azurerm_key_vault_secret" "generated_admin_pass_key_vault_secret" {
  provider        = azurerm.key_vault_sub
  for_each        = local.generate_new_vm_password
  expiration_date = each.value.linux_virtual_machine_generated_admin_password_secret_expiration_date
  content_type    = each.value.linux_virtual_machine_generated_admin_password_secret_content_type
  name            = each.value.linux_virtual_machine_generated_admin_password_secret_name
  value           = random_password.password[each.key].result
  key_vault_id    = data.azurerm_key_vault.login_keys_key_vault_id[each.key].id
}
#KEY VAULT SECRET FOR ADMIN SSH KEYS
data "azurerm_key_vault_secret" "existing_ssh_keys_key_vault_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = local.use_existing_ssh_keys
  name         = each.value.linux_virtual_machine_admin_ssh_key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.login_keys_key_vault_id[each.key].id
}
#KEY VAULT SECRET FOR FETCHING THE EXISTING ADMIN PASSWORD
data "azurerm_key_vault_secret" "existing_vm_password_key_vault_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = local.use_existing_vm_password
  name         = each.value.linux_virtual_machine_existing_admin_password_secret_name
  key_vault_id = data.azurerm_key_vault.login_keys_key_vault_id[each.key].id
}
#KEY VAULT SECRET FOR FETCHING THE EXISTING ADMIN USERNAME
data "azurerm_key_vault_secret" "existing_vm_username_key_vault_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = local.use_existing_vm_username
  name         = each.value.linux_virtual_machine_existing_admin_username_secret_name
  key_vault_id = data.azurerm_key_vault.login_keys_key_vault_id[each.key].id
}
#DATA BLOCK FOR KEY VAULT CERTIFICATE
data "azurerm_key_vault_certificate" "secret_id" {
  provider     = azurerm.key_vault_sub
  for_each     = local.is_key_vault_certificate_url_required
  name         = each.value.linux_virtual_machine_key_vault_certificate_name
  key_vault_id = data.azurerm_key_vault.login_keys_key_vault_id[each.key].id
}

#DATA BLOCK FOR VIRTUAL MACHINE SCALE SET ID
data "azurerm_virtual_machine_scale_set" "virtual_machine_scale_set_id" {
  provider            = azurerm.linux_vm_sub
  for_each            = local.is_vmss_id_required
  name                = each.value.linux_virtual_machine_virtual_machine_scale_set_name
  resource_group_name = each.value.linux_virtual_machine_virtual_machine_scale_set_resource_group_name
}
#DATA BLOCK FOR AVAILABILITY SET
data "azurerm_availability_set" "availability_set_id" {
  provider            = azurerm.linux_vm_sub
  for_each            = local.is_availability_set_id_required
  name                = each.value.linux_virtual_machine_availability_set_name
  resource_group_name = each.value.linux_virtual_machine_availability_set_resource_group_name
}
#DATA BLOCK FOR DEDICATED HOST GROUP
data "azurerm_dedicated_host_group" "dedicated_host_group_id" {
  provider            = azurerm.linux_vm_sub
  for_each            = local.is_dedicated_host_group_id_required
  name                = each.value.linux_virtual_machine_dedicated_host_group_name
  resource_group_name = each.value.linux_virtual_machine_dedicated_host_group_resource_group_name
}
#DATA BLOCK FOR DEDICATED HOST
data "azurerm_dedicated_host" "dedicated_host_id" {
  provider                  = azurerm.linux_vm_sub
  for_each                  = local.is_dedicated_host_id_required
  name                      = each.value.linux_virtual_machine_dedicated_host_name
  dedicated_host_group_name = each.value.linux_virtual_machine_dedicated_host_group_name
  resource_group_name       = each.value.linux_virtual_machine_dedicated_host_resource_group_name
}
#DATA BLOCK FOR PROXIMITY PLACEMENT GROUP
data "azurerm_proximity_placement_group" "proximity_placement_group_id" {
  provider            = azurerm.linux_vm_sub
  for_each            = local.is_proximity_placement_group_id_required
  name                = each.value.linux_virtual_machine_proximity_placement_group_name
  resource_group_name = each.value.linux_virtual_machine_proximity_placement_group_resource_group_name
}
#DATA BLOCK FOR PLATFORM IMAGE
data "azurerm_platform_image" "platform_image" {
  provider  = azurerm.linux_vm_sub
  for_each  = local.is_vm_using_platform_image
  location  = each.value.location
  publisher = each.value.source_image_reference_publisher
  offer     = each.value.source_image_reference_offer
  sku       = each.value.source_image_reference_sku
}
#DATA BLOCK FOR SHARED IMAGE
data "azurerm_shared_image" "shared_image" {
  provider            = azurerm.gallery_sub
  for_each            = local.is_vm_using_shared_image
  name                = each.value.linux_virtual_machine_shared_image_name
  gallery_name        = each.value.linux_virtual_machine_shared_image_gallery_name
  resource_group_name = each.value.linux_virtual_machine_shared_image_resource_group_name
}
#DATA BLOCK FOR EXISTING IMAGE
data "azurerm_image" "existing_vm_image" {
  provider            = azurerm.linux_vm_sub
  for_each            = local.is_vm_using_existing_image
  name                = each.value.linux_virtual_machine_existing_image_name
  resource_group_name = each.value.linux_virtual_machine_existing_image_resource_group_name
}
#DATA BLOCK FOR NETWORK INTERFACE
data "azurerm_network_interface" "network_interface" {
  provider            = azurerm.linux_vm_sub
  for_each            = { for i in local.nic_object_list : "${i.terraform_main_key},${i.terraform_nested_key}" => i }
  name                = each.value.network_interface_name
  resource_group_name = each.value.network_interface_resource_group_name
}
#RESOURCE Linux VIRTUAL MACHINE
resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
  provider                                               = azurerm.linux_vm_sub
  for_each                                               = var.linux_virtual_machine_variables
  admin_username                                         = each.value.linux_virtual_machine_admin_username == null ? data.azurerm_key_vault_secret.existing_vm_username_key_vault_secret[each.key].value : each.value.linux_virtual_machine_admin_username
  location                                               = each.value.linux_virtual_machine_location
  license_type                                           = each.value.linux_virtual_machine_license_type
  name                                                   = each.value.linux_virtual_machine_name
  network_interface_ids                                  = local.nic_ids_final[each.key]
  resource_group_name                                    = each.value.linux_virtual_machine_resource_group_name
  size                                                   = each.value.linux_virtual_machine_size
  admin_password                                         = each.value.linux_virtual_machine_disable_password_authentication == true ? null : each.value.linux_virtual_machine_generate_new_admin_password == false ? data.azurerm_key_vault_secret.existing_vm_password_key_vault_secret[each.key].value : azurerm_key_vault_secret.generated_admin_pass_key_vault_secret[each.key].value
  allow_extension_operations                             = each.value.linux_virtual_machine_allow_extension_operations
  availability_set_id                                    = each.value.linux_virtual_machine_is_availability_set_id_required == false ? null : data.azurerm_availability_set.availability_set_id[each.key].id
  bypass_platform_safety_checks_on_user_schedule_enabled = each.value.linux_virtual_machine_bypass_platform_safety_checks_on_user_schedule_enabled
  capacity_reservation_group_id                          = each.value.linux_virtual_machine_is_capacity_reservation_group_id_required == false ? null : data.azurerm_resources.capacity_reservation_group_id[each.key].resources[0].id
  computer_name                                          = each.value.linux_virtual_machine_computer_name
  /* custom_data                     = fileexists("../script.sh") ? filebase64("../script.sh") : null */ #Commented for further iteration check
  dedicated_host_id               = (each.value.linux_virtual_machine_is_dedicated_host_id_required == true && each.value.linux_virtual_machine_is_dedicated_host_group_id_required == false) ? data.azurerm_dedicated_host.dedicated_host_id[each.key].id : null
  dedicated_host_group_id         = (each.value.linux_virtual_machine_is_dedicated_host_group_id_required == true && each.value.linux_virtual_machine_is_dedicated_host_id_required == false) ? data.azurerm_dedicated_host_group.dedicated_host_group_id[each.key].id : null
  disable_password_authentication = each.value.linux_virtual_machine_disable_password_authentication == null ? true : each.value.linux_virtual_machine_disable_password_authentication
  edge_zone                       = each.value.linux_virtual_machine_edge_zone
  encryption_at_host_enabled      = each.value.linux_virtual_machine_encryption_at_host_enabled
  eviction_policy                 = each.value.linux_virtual_machine_eviction_policy
  extensions_time_budget          = each.value.linux_virtual_machine_extensions_time_budget # Specifies the duration allocated for all extensions to start.
  patch_assessment_mode           = each.value.linux_virtual_machine_patch_assessment_mode == null ? "ImageDefault" : each.value.linux_virtual_machine_patch_assessment_mode
  patch_mode                      = each.value.linux_virtual_machine_patch_mode == null ? "ImageDefault" : each.value.linux_virtual_machine_patch_mode
  max_bid_price                   = each.value.linux_virtual_machine_max_bid_price
  platform_fault_domain           = each.value.linux_virtual_machine_platform_fault_domain
  priority                        = each.value.linux_virtual_machine_priority
  provision_vm_agent              = each.value.linux_virtual_machine_patch_mode == null ? true : (each.value.linux_virtual_machine_patch_mode == "AutomaticByPlatform" || each.value.linux_virtual_machine_patch_assessment_mode == "AutomaticByPlatform" ? true : each.value.linux_virtual_machine_provision_vm_agent)
  proximity_placement_group_id    = each.value.linux_virtual_machine_is_proximity_placement_group_id_required == false ? null : data.azurerm_proximity_placement_group.proximity_placement_group_id[each.key].id
  reboot_setting                  = each.value.linux_virtual_machine_reboot_setting
  secure_boot_enabled             = each.value.linux_virtual_machine_secure_boot_enabled
  source_image_id                 = each.value.linux_virtual_machine_deploy_vm_using_source_image_reference == true ? null : (each.value.linux_virtual_machine_source_image_type == "PlatformImage" ? data.azurerm_platform_image.platform_image[each.key].id : (each.value.linux_virtual_machine_source_image_type == "SharedImage" ? data.azurerm_shared_image.shared_image[each.key].id : (each.value.linux_virtual_machine_source_image_type == "VMImage" ? data.azurerm_image.existing_vm_image[each.key].id : null)))
  user_data                       = each.value.linux_virtual_machine_user_data
  vtpm_enabled                    = each.value.linux_virtual_machine_vtpm_enabled
  zone                            = each.value.linux_virtual_machine_zone
  virtual_machine_scale_set_id    = each.value.linux_virtual_machine_is_vmss_id_required == true ? data.azurerm_virtual_machine_scale_set.virtual_machine_scale_set_id[each.key].id : null

  dynamic "additional_capabilities" { #Required, if Ultra SSD is required
    for_each = each.value.linux_virtual_machine_additional_capabilities == null ? [] : [each.value.linux_virtual_machine_additional_capabilities]
    content {
      ultra_ssd_enabled = additional_capabilities.value.additional_capabilities_ultra_ssd_enabled
    }
  }

  dynamic "admin_ssh_key" {
    for_each = each.value.linux_virtual_machine_disable_password_authentication == true ? [1] : []
    content {
      public_key = each.value.linux_virtual_machine_generate_new_ssh_key == false ? data.azurerm_key_vault_secret.existing_ssh_keys_key_vault_secret[each.key].value : tls_private_key.generate_ssh_keys_tls_private_key[each.key].public_key_openssh
      username   = each.value.linux_virtual_machine_admin_username == null ? data.azurerm_key_vault_secret.existing_vm_username_key_vault_secret[each.key].value : each.value.linux_virtual_machine_admin_username
    }
  }

  dynamic "boot_diagnostics" { #Required, if boot diagnostics is required
    for_each = each.value.linux_virtual_machine_is_boot_diagnostics_required == false ? [] : [1]
    content {
      storage_account_uri = data.azurerm_storage_account.boot_diagnostics_storage_account[each.key].primary_blob_endpoint
    }
  }

  os_disk {
    name                      = each.value.linux_virtual_machine_os_disk.os_disk_name
    caching                   = each.value.linux_virtual_machine_os_disk.os_disk_caching == null ? "None" : each.value.linux_virtual_machine_os_disk.os_disk_caching
    storage_account_type      = each.value.linux_virtual_machine_os_disk.os_disk_storage_account_type == null ? "Standard_LRS" : each.value.linux_virtual_machine_os_disk.os_disk_storage_account_type
    disk_encryption_set_id    = each.value.linux_virtual_machine_is_disk_encryption_set_required == false ? null : data.azurerm_disk_encryption_set.disk_encryption_set[each.key].id
    disk_size_gb              = each.value.linux_virtual_machine_os_disk.os_disk_disk_size_gb
    security_encryption_type  = each.value.linux_virtual_machine_os_disk.os_disk_security_encryption_type
    write_accelerator_enabled = each.value.linux_virtual_machine_os_disk.os_disk_write_accelerator_enabled == null ? false : ((each.value.linux_virtual_machine_os_disk.os_disk_storage_account_type == "Premium_LRS" && each.value.linux_virtual_machine_os_disk.os_disk_caching == "None") ? each.value.linux_virtual_machine_os_disk.os_disk_write_accelerator_enabled : false)

    #Required, if diff disk settings is required
    dynamic "diff_disk_settings" {
      for_each = each.value.linux_virtual_machine_os_disk.os_disk_caching == "ReadOnly" ? toset(each.value.linux_virtual_machine_os_disk.os_disk_caching) : []
      content {
        option    = each.value.linux_virtual_machine_os_disk.os_disk_diff_disk_settings.diff_disk_settings_option
        placement = each.value.linux_virtual_machine_os_disk.os_disk_diff_disk_settings.diff_disk_settings_placement
      }
    }
  }

  dynamic "gallery_application" {
    for_each = each.value.linux_virtual_machine_is_gallery_application_id_required == false ? [] : [each.value.linux_virtual_machine_is_gallery_application_id_required]
    content {
      version_id             = format("%s/%s/%s/%s/%s/%s/%s", data.azurerm_resource_group.resource_group_id[each.key].id, "providers/Microsoft.Compute/galleries", each.value.linux_virtual_machine_shared_image_gallery_name, "applications", each.value.linux_virtual_machine_gallery_application_name, "versions", each.value.linux_virtual_machine_gallery_application_version_name)
      configuration_blob_uri = data.azurerm_storage_blob.storage_blob_uri[each.key].url
      order                  = each.value.linux_virtual_machine_gallery_application.gallery_application_order
      tag                    = each.value.linux_virtual_machine_gallery_application.gallery_application_tag
    }
  }

  dynamic "identity" { #Required, if boot diagnostics is required
    for_each = each.value.linux_virtual_machine_identity != null ? [1] : []
    content {
      type = each.value.linux_virtual_machine_identity.identity_type
      identity_ids = each.value.linux_virtual_machine_identity.identity_type == "SystemAssigned, UserAssigned" || each.value.linux_virtual_machine_identity.identity_type == "UserAssigned" ? [
        for k, v in each.value.linux_virtual_machine_identity.linux_virtual_machine_user_assigned_identities : data.azurerm_user_assigned_identity.linux_user_identity["${each.key},${v.user_assigned_identities_name}"].id
      ] : null
    }
  }

  dynamic "plan" { #Required, if VM needs to deployed from a Marketplace image
    for_each = each.value.linux_virtual_machine_plan != null ? each.value.linux_virtual_machine_plan : []
    content {
      name      = plan.value.plan_name
      product   = plan.value.plan_product
      publisher = plan.value.plan_publisher
    }
  }

  dynamic "secret" {
    for_each = each.value.linux_virtual_machine_is_secret_required == false ? [] : toset(each.value.linux_virtual_machine_is_secret_required)
    content {
      key_vault_id = data.azurerm_key_vault.login_keys_key_vault_id[each.key].id
      certificate {
        url = data.azurerm_key_vault_certificate.secret_id[eack.key].secret_id
      }
    }
  }

  dynamic "source_image_reference" { #Required, if source_image_reference is required
    for_each = each.value.linux_virtual_machine_deploy_vm_using_source_image_reference == false ? [] : [each.value.linux_virtual_machine_deploy_vm_using_source_image_reference]
    content {
      publisher = each.value.linux_virtual_machine_source_image_reference.source_image_reference_publisher
      offer     = each.value.linux_virtual_machine_source_image_reference.source_image_reference_offer
      sku       = each.value.linux_virtual_machine_source_image_reference.source_image_reference_sku
      version   = each.value.linux_virtual_machine_source_image_reference.source_image_reference_version
    }
  }


  dynamic "termination_notification" {
    for_each = each.value.linux_virtual_machine_termination_notification != null ? toset(each.value.linux_virtual_machine_termination_notification) : []
    content {
      enabled = termination_notification.value.termination_notification_enabled
      timeout = termination_notification.value.termination_notification_timeout
    }
  }
  tags = merge(each.value.linux_virtual_machine_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}
