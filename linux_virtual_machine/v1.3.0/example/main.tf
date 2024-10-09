#RESOURCE GROUP
module "resource_group" {
  source = "../../../resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.linux_vm_sub
  }
  resource_group_variables = var.resource_group_variables
}

#RESOURCE GROUP FOR KEYVAULT
module "key_vault_resource_group" {
  source = "../../../resource_group/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  resource_group_variables = var.key_vault_resource_group_variables
}

#VIRTUAL NETWORK
module "virtual_network" {
  providers = {
    azurerm = azurerm.linux_vm_sub
  }
  source                    = "../../../virtual_network/v1.3.0"
  virtual_network_variables = var.virtual_network_variables
  depends_on                = [module.resource_group]
}

#SUBNET
module "subnet" {
  source = "../../../subnet/v1.3.0"
  providers = {
    azurerm = azurerm.linux_vm_sub
  }
  subnet_variables = var.subnet_variables
  depends_on       = [module.virtual_network]
}

#PUBLIC IP
module "public_ip" {
  source = "../../../public_ip/v1.3.0"
  providers = {
    azurerm = azurerm.linux_vm_sub
  }
  public_ip_variables = var.public_ip_variables
  depends_on          = [module.resource_group]
}

#USER ASSIGNED IDENTITY
module "user_assigned_identity" {
  source = "../../../user_assigned_identity/v1.3.0"
  providers = {
    azurerm = azurerm.linux_vm_sub
  }
  user_assigned_identity_variables = var.user_assigned_identity_variables
  depends_on                       = [module.resource_group]
}

#KEY VAULT (ADMIN SSH KEY)
module "key_vault" {
  source = "../../../key_vault/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_variables = var.key_vault_variables_ssh_keys
  depends_on          = [module.key_vault_resource_group]
}

#KEY VAULT (DISK ENCRYPTION SET)
module "key_vault_disk" {
  source = "../../../key_vault/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_variables = var.key_vault_variables_disk_encryption
  depends_on          = [module.key_vault_resource_group]
}

#KEY VAULT ACCESS POLICY
module "key_vault_access_policy" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                            = "../../../key_vault_access_policy/v1.3.0"
  key_vault_access_policy_variables = var.key_vault_access_policy_variables
  depends_on                        = [module.key_vault]
}

#KEY VAULT ACCESS POLICY (DISK ENCRYPTION SET)
module "key_vault_access_policy_disk" {
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  source                            = "../../../key_vault_access_policy/v1.3.0"
  key_vault_access_policy_variables = var.key_vault_access_policy_disk_variables
  depends_on                        = [module.key_vault_disk, module.user_assigned_identity]
}

#KEY VAULT SECRET
module "key_vault_secret" {
  source = "../../../key_vault_secret/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_secret_variables = var.key_vault_secret_variables
  depends_on                 = [module.key_vault_access_policy, module.key_vault_access_policy_disk, module.key_vault_disk, module.key_vault]
}

#KEY VAULT KEY (DISK ENCRYPTION SET)
module "key_vault_key" {
  source = "../../../key_vault_key/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_key_variables = var.key_vault_key_variables
  depends_on              = [module.key_vault_access_policy, module.key_vault_access_policy_disk, module.key_vault_disk, module.key_vault]
}

#KEY VAULT CERTIFICATE
module "key_vault_certificate" {
  source = "../../../key_vault_certificate/v1.3.0"
  providers = {
    azurerm = azurerm.key_vault_sub
  }
  key_vault_certificate_variables = var.key_vault_certificate_variables
  depends_on                      = [module.key_vault_access_policy]
}

#DISK ENCRYPTION SET
module "disk_encryption_set" {
  source = "../../../disk_encryption_set/v1.3.0"
  providers = {
    azurerm.key_vault_sub           = azurerm.linux_vm_sub
    azurerm.disk_encryption_set_sub = azurerm.linux_vm_sub
    azurerm.user_identity_sub       = azurerm.linux_vm_sub
  }
  disk_encryption_set_variables = var.disk_encryption_set_variables
  depends_on                    = [module.key_vault_disk, module.key_vault_access_policy_disk, module.user_assigned_identity]
}

#CAPACITY RESERVATION GROUP
module "capacity_reservation_group" {
  providers = {
    azurerm = azurerm.linux_vm_sub
  }
  source                               = "../../../capacity_reservation_group/v1.3.0"
  capacity_reservation_group_variables = var.capacity_reservation_group_variables
  depends_on                           = [module.resource_group]
}

#SHARED IMAGE GALLERY
module "shared_image_gallery" {
  providers = {
    azurerm = azurerm.gallery_sub
  }
  source                         = "../../../shared_image_gallery/v1.3.0"
  shared_image_gallery_variables = var.shared_image_gallery_variables
  depends_on                     = [module.resource_group]
}

#GALLERY APPLICATION
module "gallery_application" {
  providers = {
    azurerm = azurerm.gallery_sub
  }
  source                        = "../../../gallery_application/v1.3.0"
  gallery_application_variables = var.gallery_application_variables
  depends_on                    = [module.shared_image_gallery]
}

#STROAGE ACCOUNT (BOOT DIAGNOSTICS)
module "storage_account" {
  source = "../../../storage_account/v1.3.0"
  providers = {
    azurerm.storage_account_sub = azurerm.linux_vm_sub
    azurerm.key_vault_sub       = azurerm.linux_vm_sub
  }
  storage_account_variables = var.storage_account_variables
  depends_on                = [module.user_assigned_identity, module.key_vault_disk, module.key_vault_key]
}

#STORAGE CONTAINER
module "storage_container" {
  providers = {
    azurerm = azurerm.linux_vm_sub
  }
  source                      = "../../../storage_container/v1.3.0"
  storage_container_variables = var.storage_container_variables
  depends_on                  = [module.storage_account]
}

#STORAGE BLOB
module "storage_blob" {
  providers = {
    azurerm = azurerm.linux_vm_sub
  }
  source                 = "../../../storage_blob/v1.3.0"
  storage_blob_variables = var.storage_blob_variables
  depends_on             = [module.storage_container]
}

#GALLERY APPLICATION VERSION
module "gallery_application_version" {
  providers = {
    azurerm = azurerm.gallery_sub
  }
  source                                = "../../../gallery_application_version/v1.3.0"
  gallery_application_version_variables = var.gallery_application_version_variables
  depends_on                            = [module.gallery_application, module.storage_blob]
}

#LB
module "lb" {
  source = "../../../lb/v1.3.0"
  providers = {
    azurerm = azurerm.linux_vm_sub
  }
  lb_variables = var.lb_variables
  depends_on   = [module.subnet, module.public_ip]
}

#NETWORK INTERFACE
module "network_interface" {
  source = "../../../network_interface/v1.3.0"
  providers = {
    azurerm = azurerm.linux_vm_sub
  }
  network_interface_variables = var.network_interface_variables
  depends_on                  = [module.lb, module.subnet]
}

#NETWORK SECURITY GROUP
module "network_security_group" {
  source = "../../../network_security_group/v1.3.0"
  providers = {
    azurerm = azurerm.linux_vm_sub
  }
  network_security_group_variables = var.network_security_group_variables
  depends_on                       = [module.virtual_network, module.subnet, module.network_interface]
}

#NETWORK INTERFACE SECURITY GROUP ASSOCIATION
module "network_interface_security_group_association" {
  source = "../../../network_interface_security_group_association/v1.3.0"
  providers = {
    azurerm = azurerm.linux_vm_sub
  }
  network_interface_security_group_association_variables = var.network_interface_security_group_association_variables
  depends_on                                             = [module.network_security_group]
}

#SUBNET NETWORK SECURITY GROUP ASSOCIATION
module "subnet_network_security_group_association" {
  source = "../../../subnet_network_security_group_association/v1.3.0"
  providers = {
    azurerm = azurerm.linux_vm_sub
  }
  subnet_network_security_group_association_variables = var.subnet_network_security_group_association_variables
  depends_on                                          = [module.network_security_group]
}

#LINUX VM
module "linux_virtual_machine" {
  source = "../"
  providers = {
    azurerm.linux_vm_sub  = azurerm.linux_vm_sub
    azurerm.key_vault_sub = azurerm.key_vault_sub
    azurerm.gallery_sub   = azurerm.gallery_sub
  }
  linux_virtual_machine_variables = var.linux_virtual_machine_variables
  depends_on                      = [module.public_ip, module.storage_account, module.key_vault, module.disk_encryption_set, module.key_vault_disk, module.key_vault_certificate, module.network_security_group, module.gallery_application_version, module.capacity_reservation_group, module.user_assigned_identity]
}