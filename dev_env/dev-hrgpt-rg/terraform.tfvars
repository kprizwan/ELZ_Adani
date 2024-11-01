# Stage Subscription Medium

#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "sd-common-dev-hrgpt-rg" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location = "Central India"             #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_managed_by = null #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {
      BU             = "ELZ",
      Role           = "Dev",
      Environment    = "PLZ-Dev",
      Owner          = "Manish Kumar",
      Criticality    = "Medium",
      Classification = "Gold",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}

#CONTAINER REGISTRY
container_registry_variables = {
  "container_registry_1" = {
    container_registry_name                          = "sddevadaniaesl"     #(Required) Specifies the name of the Container Registry. Only Alphanumeric characters allowed. Changing this forces a new resource to be created.
    container_registry_location                      = "Central India"        # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    container_registry_resource_group_name           = "sd-common-dev-hrgpt-rg" # (Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created.
    container_registry_sku                           = "Standard"              # (Required) The SKU name of the container registry. Possible values are Basic, Standard and Premium.
    container_registry_admin_enabled                 = true                   # (Optional) Specifies whether the admin user is enabled. Defaults to false.
    container_registry_export_policy_enabled         = null                   # (Optional) Boolean value that indicates whether export policy is enabled. Defaults to true. In order to set it to false, make sure the public_network_access_enabled is also set to false.
    container_registry_public_network_access_enabled = true                   # (Optional) Whether public network access is allowed for the container registry. Defaults to true.
    container_registry_quarantine_policy_enabled     = false                  # (Optional) Boolean value that indicates whether quarantine policy is enabled. Defaults to false.
    container_registry_zone_redundancy_enabled       = false                  # (Optional) Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created. Defaults to false.
    container_registry_anonymous_pull_enabled        = false                  # (Optional) Whether allows anonymous (unauthenticated) pull access to this Container Registry? Defaults to false. This is only supported on resources with the Standard or Premium SKU.
    container_registry_retention_policy = null/*{
      retention_policy_days    = 7   # (Optional) The number of days to retain an untagged manifest after which it gets purged. Default is 7.
      retention_policy_enabled = true # (Optional) Boolean value that indicates whether the policy is enabled.
    }*/
    container_registry_trust_policy = { # (Optional) Set to null if it is not required.
      trust_policy_enabled = false      #  (Optional) Boolean value that indicates whether the policy is enabled.
    }
    container_registry_georeplication_enabled     = false #(Required) Whether georeplications should be enabled for the container registry.If the this is true, Provide values to georeplications block
    container_registry_georeplications            = null
    container_registry_data_endpoint_enabled      = false           # (Optional) Whether to enable dedicated data endpoints for this Container Registry? Defaults to false. This is only supported on resources with the Premium SKU.
    container_registry_network_rule_bypass_option = "AzureServices" # (Optional) Whether to allow trusted Azure services to access a network restricted Container Registry? Possible values are None and AzureServices. Defaults to AzureServices.
    container_registry_encryption = {
      encryption_enabled                      = false #  (Required) Boolean value that indicates whether encryption is enabled. Set to false, if customer managed encryption is not required.
      encryption_keyvault_name                = null  # (Required)The name of the KeyVault where key is stored
      encryption_keyvault_key_name            = null  # (Required) # The name of the keyvault key name
      encryption_keyvault_resource_group_name = null  #(Required) # Resource group of the KeyVault
      encryption_identity_name                = null  # (Required) The Name of the managed identity
      encryption_identity_resource_group_name = null  # (Required) The name of resource group where identity is created.
    }
    container_registry_identity                 = null
    container_registry_network_rule_set_enabled = false #(Required) Whether network rule set to be enabled for the container registry. if the value is true, Provide values to container_registry_network_rule_set block.
    container_registry_network_rule_set = {
      network_rule_set_default_action  = null #  (Optional) The behaviour for requests matching no rules. Either Allow or Deny. Defaults to Allow
      network_rule_set_ip_rule         = null
      network_rule_set_virtual_network = null
    }
    container_registry_tags = { # (Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Dev",
      Environment    = "PLZ-Dev",
      Owner          = "Manish Kumar",
      Criticality    = "Medium",
      Classification = "Gold",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  },
  "container_registry_2" = {
    container_registry_name                          = "sddevadanitapregistry"     #(Required) Specifies the name of the Container Registry. Only Alphanumeric characters allowed. Changing this forces a new resource to be created.
    container_registry_location                      = "Central India"        # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    container_registry_resource_group_name           = "sd-common-dev-hrgpt-rg" # (Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created.
    container_registry_sku                           = "Standard"              # (Required) The SKU name of the container registry. Possible values are Basic, Standard and Premium.
    container_registry_admin_enabled                 = true                   # (Optional) Specifies whether the admin user is enabled. Defaults to false.
    container_registry_export_policy_enabled         = null                   # (Optional) Boolean value that indicates whether export policy is enabled. Defaults to true. In order to set it to false, make sure the public_network_access_enabled is also set to false.
    container_registry_public_network_access_enabled = true                   # (Optional) Whether public network access is allowed for the container registry. Defaults to true.
    container_registry_quarantine_policy_enabled     = false                  # (Optional) Boolean value that indicates whether quarantine policy is enabled. Defaults to false.
    container_registry_zone_redundancy_enabled       = false                  # (Optional) Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created. Defaults to false.
    container_registry_anonymous_pull_enabled        = false                  # (Optional) Whether allows anonymous (unauthenticated) pull access to this Container Registry? Defaults to false. This is only supported on resources with the Standard or Premium SKU.
    container_registry_retention_policy =null/* {
      retention_policy_days    = 7    # (Optional) The number of days to retain an untagged manifest after which it gets purged. Default is 7.
      retention_policy_enabled = true # (Optional) Boolean value that indicates whether the policy is enabled.
    }*/
    container_registry_trust_policy = { # (Optional) Set to null if it is not required.
      trust_policy_enabled = false      #  (Optional) Boolean value that indicates whether the policy is enabled.
    }
    container_registry_georeplication_enabled     = false #(Required) Whether georeplications should be enabled for the container registry.If the this is true, Provide values to georeplications block
    container_registry_georeplications            = null
    container_registry_data_endpoint_enabled      = false           # (Optional) Whether to enable dedicated data endpoints for this Container Registry? Defaults to false. This is only supported on resources with the Premium SKU.
    container_registry_network_rule_bypass_option = "AzureServices" # (Optional) Whether to allow trusted Azure services to access a network restricted Container Registry? Possible values are None and AzureServices. Defaults to AzureServices.
    container_registry_encryption = {
      encryption_enabled                      = false #  (Required) Boolean value that indicates whether encryption is enabled. Set to false, if customer managed encryption is not required.
      encryption_keyvault_name                = null  # (Required)The name of the KeyVault where key is stored
      encryption_keyvault_key_name            = null  # (Required) # The name of the keyvault key name
      encryption_keyvault_resource_group_name = null  #(Required) # Resource group of the KeyVault
      encryption_identity_name                = null  # (Required) The Name of the managed identity
      encryption_identity_resource_group_name = null  # (Required) The name of resource group where identity is created.
    }
    container_registry_identity                 = null
    container_registry_network_rule_set_enabled = false #(Required) Whether network rule set to be enabled for the container registry. if the value is true, Provide values to container_registry_network_rule_set block.
    container_registry_network_rule_set = {
      network_rule_set_default_action  = null #  (Optional) The behaviour for requests matching no rules. Either Allow or Deny. Defaults to Allow
      network_rule_set_ip_rule         = null
      network_rule_set_virtual_network = null
    }
    container_registry_tags = { # (Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Dev",
      Environment    = "PLZ-Dev",
      Owner          = "Manish Kumar",
      Criticality    = "Medium",
      Classification = "Gold",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  },
    "container_registry_3" = {
    container_registry_name                          = "sddevsteelbot"     #(Required) Specifies the name of the Container Registry. Only Alphanumeric characters allowed. Changing this forces a new resource to be created.
    container_registry_location                      = "Central India"        # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    container_registry_resource_group_name           = "sd-common-dev-hrgpt-rg" # (Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created.
    container_registry_sku                           = "Standard"              # (Required) The SKU name of the container registry. Possible values are Basic, Standard and Premium.
    container_registry_admin_enabled                 = true                   # (Optional) Specifies whether the admin user is enabled. Defaults to false.
    container_registry_export_policy_enabled         = null                   # (Optional) Boolean value that indicates whether export policy is enabled. Defaults to true. In order to set it to false, make sure the public_network_access_enabled is also set to false.
    container_registry_public_network_access_enabled = true                   # (Optional) Whether public network access is allowed for the container registry. Defaults to true.
    container_registry_quarantine_policy_enabled     = false                  # (Optional) Boolean value that indicates whether quarantine policy is enabled. Defaults to false.
    container_registry_zone_redundancy_enabled       = false                  # (Optional) Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created. Defaults to false.
    container_registry_anonymous_pull_enabled        = false                  # (Optional) Whether allows anonymous (unauthenticated) pull access to this Container Registry? Defaults to false. This is only supported on resources with the Standard or Premium SKU.
    container_registry_retention_policy =null/* {
      retention_policy_days    = 7    # (Optional) The number of days to retain an untagged manifest after which it gets purged. Default is 7.
      retention_policy_enabled = true # (Optional) Boolean value that indicates whether the policy is enabled.
    }*/
    container_registry_trust_policy = { # (Optional) Set to null if it is not required.
      trust_policy_enabled = false      #  (Optional) Boolean value that indicates whether the policy is enabled.
    }
    container_registry_georeplication_enabled     = false #(Required) Whether georeplications should be enabled for the container registry.If the this is true, Provide values to georeplications block
    container_registry_georeplications            = null
    container_registry_data_endpoint_enabled      = false           # (Optional) Whether to enable dedicated data endpoints for this Container Registry? Defaults to false. This is only supported on resources with the Premium SKU.
    container_registry_network_rule_bypass_option = "AzureServices" # (Optional) Whether to allow trusted Azure services to access a network restricted Container Registry? Possible values are None and AzureServices. Defaults to AzureServices.
    container_registry_encryption = {
      encryption_enabled                      = false #  (Required) Boolean value that indicates whether encryption is enabled. Set to false, if customer managed encryption is not required.
      encryption_keyvault_name                = null  # (Required)The name of the KeyVault where key is stored
      encryption_keyvault_key_name            = null  # (Required) # The name of the keyvault key name
      encryption_keyvault_resource_group_name = null  #(Required) # Resource group of the KeyVault
      encryption_identity_name                = null  # (Required) The Name of the managed identity
      encryption_identity_resource_group_name = null  # (Required) The name of resource group where identity is created.
    }
    container_registry_identity                 = null
    container_registry_network_rule_set_enabled = false #(Required) Whether network rule set to be enabled for the container registry. if the value is true, Provide values to container_registry_network_rule_set block.
    container_registry_network_rule_set = {
      network_rule_set_default_action  = null #  (Optional) The behaviour for requests matching no rules. Either Allow or Deny. Defaults to Allow
      network_rule_set_ip_rule         = null
      network_rule_set_virtual_network = null
    }
    container_registry_tags = { # (Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Dev",
      Environment    = "PLZ-Dev",
      Owner          = "Manish Kumar",
      Criticality    = "Medium",
      Classification = "Gold",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
}
}

#KEY VAULT
key_vault_variables = {
 /* "key_vault_1" = {
    key_vault_name                                  = "sddevailabaml01se"                                                                                                                                                                               #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_location                              = "SE Asia"                                                                                                                                                                                 #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_resource_group_name                   = "sd-common-dev-hrgpt-rg"                                                                                                                                                                          #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_enabled_for_disk_encryption           = true                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = true                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = true                                                                                                                                                                                            # (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = false                                                                                                                                                                                           #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = "7"                                                                                                                                                                                             #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = false                                                                                                                                                                                           #(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
    key_vault_sku_name                              = "standard"                                                                                                                                                                                      #(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium
    key_vault_access_container_agent_name           = "SDLADOVM01"                                                                                                                                                                                    #(Optional) Self hosted conatiner agent name.
    key_vault_access_policy_application_id          = null                                                                                                                                                                                            #(Optional) The object ID of an Application in Azure Active Directory.
    key_vault_public_network_access_enabled         = true                                                                                                                                                                                           #(Optional) key_vault_public_network_access_enabled
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                    #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                              #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"] # (Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    #(Optional) A mapping of tags which should be assigned to the key vault.
    key_vault_tags = { #(Optional) A mapping of tags which should be assigned to the key vault.
      BU             = "ELZ",
      Role           = "Dev",
      Environment    = "PLZ-Dev",
      Owner          = "Manish Kumar",
      Criticality    = "Medium",
      Classification = "Gold",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
    key_vault_network_acls_enabled        = false           #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass         = "AzureServices" #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action = null            # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
    key_vault_network_acls_ip_rules       = null            # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.

    #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
    key_vault_network_acls_virtual_networks = null /* [ #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
      {
        key_vault_network_acls_virtual_networks_virtual_network_name    =  null                    #(Required) Vitural Network name to be associated.
        key_vault_network_acls_virtual_networks_subnet_name             =  null                    #(Required) Subnet Name to be associated.
        key_vault_network_acls_virtual_networks_subscription_id         =  null                    #(Required) Subscription Id where Vnet is created.
        key_vault_network_acls_virtual_networks_virtual_network_rg_name =  null                    #(Required) Resource group where Vnet is created.
      }
    ]*//*
    key_vault_contact_information_enabled   = false #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email                 = null  #(Required) E-mail address of the contact.
    key_vault_contact_name                  = null  #(Optional) Name of the contact.
    key_vault_contact_phone                 = null  #(Optional) Phone number of the contact.
  },*/
  

  "key_vault_2" = {
    key_vault_name                                  = "sddevkvsi"                                                                                                                                                                               #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_location                              = "South India"                                                                                                                                                                                 #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_resource_group_name                   = "sd-common-dev-hrgpt-rg"                                                                                                                                                                          #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_enabled_for_disk_encryption           = true                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = true                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = true                                                                                                                                                                                            # (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = false                                                                                                                                                                                           #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = "7"                                                                                                                                                                                             #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = false                                                                                                                                                                                           #(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
    key_vault_sku_name                              = "standard"                                                                                                                                                                                      #(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium
    key_vault_access_container_agent_name           = "SDLADOVM01"                                                                                                                                                                                    #(Optional) Self hosted conatiner agent name.
    key_vault_access_policy_application_id          = null                                                                                                                                                                                            #(Optional) The object ID of an Application in Azure Active Directory.
    key_vault_public_network_access_enabled         = true                                                                                                                                                                                           #(Optional) key_vault_public_network_access_enabled
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                    #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                              #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"] # (Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    #(Optional) A mapping of tags which should be assigned to the key vault.
    key_vault_tags = { #(Optional) A mapping of tags which should be assigned to the key vault.
      BU             = "ELZ",
      Role           = "Dev",
      Environment    = "PLZ-Dev",
      Owner          = "Manish Kumar",
      Criticality    = "Medium",
      Classification = "Gold",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
    key_vault_network_acls_enabled        = false           #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass         = "AzureServices" #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action = null            # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
    key_vault_network_acls_ip_rules       = null            # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.

    #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
    key_vault_network_acls_virtual_networks = null /* [ #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
      {
        key_vault_network_acls_virtual_networks_virtual_network_name    =  null                    #(Required) Vitural Network name to be associated.
        key_vault_network_acls_virtual_networks_subnet_name             =  null                    #(Required) Subnet Name to be associated.
        key_vault_network_acls_virtual_networks_subscription_id         =  null                    #(Required) Subscription Id where Vnet is created.
        key_vault_network_acls_virtual_networks_virtual_network_rg_name =  null                    #(Required) Resource group where Vnet is created.
      }
    ]*/
    key_vault_contact_information_enabled   = false #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email                 = null  #(Required) E-mail address of the contact.
    key_vault_contact_name                  = null  #(Optional) Name of the contact.
    key_vault_contact_phone                 = null  #(Optional) Phone number of the contact.

  },

  "key_vault_3" = {
    key_vault_name                                  = "sddevrecruitbot"                                                                                                                                                                               #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_location                              = "Central India"                                                                                                                                                                                 #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_resource_group_name                   = "sd-common-dev-hrgpt-rg"                                                                                                                                                                          #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_enabled_for_disk_encryption           = true                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = true                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = true                                                                                                                                                                                            # (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = false                                                                                                                                                                                           #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = "7"                                                                                                                                                                                             #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = false                                                                                                                                                                                           #(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
    key_vault_sku_name                              = "standard"                                                                                                                                                                                      #(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium
    key_vault_access_container_agent_name           = "SDLADOVM01"                                                                                                                                                                                    #(Optional) Self hosted conatiner agent name.
    key_vault_access_policy_application_id          = null                                                                                                                                                                                            #(Optional) The object ID of an Application in Azure Active Directory.
    key_vault_public_network_access_enabled         = true                                                                                                                                                                                           #(Optional) key_vault_public_network_access_enabled
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                    #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                              #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"] # (Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    #(Optional) A mapping of tags which should be assigned to the key vault.
    key_vault_tags = { #(Optional) A mapping of tags which should be assigned to the key vault.
      BU             = "ELZ",
      Role           = "Dev",
      Environment    = "PLZ-Dev",
      Owner          = "Manish Kumar",
      Criticality    = "Medium",
      Classification = "Gold",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
    key_vault_network_acls_enabled        = false           #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass         = "AzureServices" #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action = null            # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
    key_vault_network_acls_ip_rules       = null            # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.

    #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
    key_vault_network_acls_virtual_networks = null /* [ #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
      {
        key_vault_network_acls_virtual_networks_virtual_network_name    =  null                    #(Required) Vitural Network name to be associated.
        key_vault_network_acls_virtual_networks_subnet_name             =  null                    #(Required) Subnet Name to be associated.
        key_vault_network_acls_virtual_networks_subscription_id         =  null                    #(Required) Subscription Id where Vnet is created.
        key_vault_network_acls_virtual_networks_virtual_network_rg_name =  null                    #(Required) Resource group where Vnet is created.
      }
    ]*/
    key_vault_contact_information_enabled   = false #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email                 = null  #(Required) E-mail address of the contact.
    key_vault_contact_name                  = null  #(Optional) Name of the contact.
    key_vault_contact_phone                 = null  #(Optional) Phone number of the contact.

  },

  "key_vault_4" = {
    key_vault_name                                  = "sddevailabaml02ci"                                                                                                                                                                               #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_location                              = "Central India"                                                                                                                                                                                 #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_resource_group_name                   = "sd-common-dev-hrgpt-rg"                                                                                                                                                                          #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_enabled_for_disk_encryption           = true                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = true                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = true                                                                                                                                                                                            # (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = false                                                                                                                                                                                           #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = "7"                                                                                                                                                                                             #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = false                                                                                                                                                                                           #(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
    key_vault_sku_name                              = "standard"                                                                                                                                                                                      #(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium
    key_vault_access_container_agent_name           = "SDLADOVM01"                                                                                                                                                                                    #(Optional) Self hosted conatiner agent name.
    key_vault_access_policy_application_id          = null                                                                                                                                                                                            #(Optional) The object ID of an Application in Azure Active Directory.
    key_vault_public_network_access_enabled         = true                                                                                                                                                                                           #(Optional) key_vault_public_network_access_enabled
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                    #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                              #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"] # (Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    #(Optional) A mapping of tags which should be assigned to the key vault.
    key_vault_tags = { #(Optional) A mapping of tags which should be assigned to the key vault.
      BU             = "ELZ",
      Role           = "Dev",
      Environment    = "PLZ-Dev",
      Owner          = "Manish Kumar",
      Criticality    = "Medium",
      Classification = "Gold",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
    key_vault_network_acls_enabled        = false           #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass         = "AzureServices" #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action = null            # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
    key_vault_network_acls_ip_rules       = null            # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.

    #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
    key_vault_network_acls_virtual_networks = null /* [ #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
      {
        key_vault_network_acls_virtual_networks_virtual_network_name    =  null                    #(Required) Vitural Network name to be associated.
        key_vault_network_acls_virtual_networks_subnet_name             =  null                    #(Required) Subnet Name to be associated.
        key_vault_network_acls_virtual_networks_subscription_id         =  null                    #(Required) Subscription Id where Vnet is created.
        key_vault_network_acls_virtual_networks_virtual_network_rg_name =  null                    #(Required) Resource group where Vnet is created.
      }
    ]*/
    key_vault_contact_information_enabled   = false #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email                 = null  #(Required) E-mail address of the contact.
    key_vault_contact_name                  = null  #(Optional) Name of the contact.
    key_vault_contact_phone                 = null  #(Optional) Phone number of the contact.

  }
}

storage_account_variables = {
  "storage_account_1" = {
    storage_account_key_vault_name                                     = null #(Optional) The name of the Key Vault.
    storage_account_is_key_vault_key_versionless                       = true
    storage_account_key_vault_resource_group_name                      = null    #(Optional) The resource group name of the Key Vault.
    storage_account_key_vault_key_name                                 = null #(Optional) The name of the Key Vault key required for customer managed key.
    storage_account_user_assigned_identity_name_for_cmk                = null   #(Optional) The name of a user assigned identity for customer managed key.
    storage_account_user_assigned_identity_resource_group_name_for_cmk = null    #(Optional) The resource group name of a user assigned identity for customer managed key.
    storage_account_identity_type_for_cmk                              = "SystemAssigned"     #(Optional) The identity type of a user assigned identity for customer managed key.Only Possible value could be "UserAssigned" in order to use customer managed key. Other Possible values are "SystemAssigned", "SystemAssigned, UserAssigned"
    storage_account_name                                               = "sddevailabshrblob"    #(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed.This must be unique across the entire Azure service, not just within the resource group.
    storage_account_resource_group_name                                = "sd-common-dev-hrgpt-rg"    #(Required) The name of the resource group in which to create the storage account.
    storage_account_location                                           = "Central India"             #(Required) Specifies the supported Azure location where the resource exists.
    storage_account_account_kind                                       = "StorageV2"          #(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2.
    storage_account_account_tier                                       = "Standard"           #(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    storage_account_account_replication_type                           = "LRS"                #(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa.
    storage_account_cross_tenant_replication_enabled                   = true                 #(Optional) Should cross Tenant replication be enabled? Defaults to true.
    storage_account_access_tier                                        = "Hot"                #(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot.
    storage_account_edge_zone                                          = null                 #(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist.
    storage_account_enable_https_traffic_only                          = true                 #(Optional) Boolean flag which forces HTTPS if enabled. Defaults to true.
    storage_account_min_tls_version                                    = "TLS1_2"             #(Optional) The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts.
    storage_account_allow_nested_items_to_be_public                    = true                 #Allow or disallow nested items within this Account to opt into being public. Defaults to true.
    storage_account_shared_access_key_enabled                          = true                 #Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true.
    storage_account_public_network_access_enabled                      = true                 #(Optional) Whether the public network access is enabled? Defaults to true.
    storage_account_default_to_oauth_authentication                    = false                #(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false
    storage_account_is_hns_enabled                                     = false                #(Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2.
    storage_account_nfsv3_enabled                                      = false                #(Optional) Is NFSv3 protocol enabled? Defaults to false.
    storage_account_large_file_share_enabled                           = false                #(Optional) Is Large File Share Enabled?
    storage_account_queue_encryption_key_type                          = "Service"            #(Optional) The encryption type of the queue service. Possible values are Service and Account.Default value is Service.
    storage_account_table_encryption_key_type                          = "Service"            #(Optional) The encryption type of the table service. Possible values are Service and Account. Default value is Service.
    storage_account_infrastructure_encryption_enabled                  = false                #(Optional) Is infrastructure encryption enabled? Defaults to false.
    storage_account_allowed_copy_scope                                 = null                 #(Optional) Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values are AAD and PrivateLink.
    storage_account_sftp_enabled                                       = false                #(Optional) Boolean, enable SFTP for the storage account, to enable this, is_hns_enabled should be true as well
    storage_account_custom_domain                                      = null
    # storage_account_custom_domain = {
    #     custom_domain_name = "www.ploceus.com" #(Required) The Custom Domain Name to use for the Storage Account, which will be validated by Azure.
    #     custom_domain_use_subdomain = false #(Optional) Should the Custom Domain Name be validated by using indirect CNAME validation?
    # }

    storage_account_identity = null
    # storage_account_identity = {
    #   storage_account_identity_type = "UserAssigned" # Possible values could be "UserAssigned", "SystemAssigned", "SystemAssigned, UserAssigned"
    #   # storage_account_user_assigned_identity_ids = null
    #   storage_account_user_assigned_identity_ids = [{ # This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
    #     identity_name                = "ploceusuai000002"
    #     identity_resource_group_name = "loceusrg000005"
    #   }]
    # }

    storage_account_blob_properties = {
      versioning_enabled            = true         #(Optional) Is versioning enabled? Default to false.
      change_feed_enabled           = true         #(Optional) Is the blob service properties for change feed events enabled? Default to false.
      change_feed_retention_in_days = 7            #(Optional) The duration of change feed events retention in days. The possible values are between 1 and 146000 days (400 years). Setting this to null (or omit this in the configuration file) indicates an infinite retention of the change feed.
      default_service_version       = "2020-06-12" #(Optional) The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version. Defaults to 2020-06-12.
      last_access_time_enabled      = true         #(Optional) Is the last access time based tracking enabled? Default to false.

      cors_enabled = true #(optional) Should cross origin resource sharing be enabled.
      cors_rule = {
        allowed_headers    = ["*"]                                                                 #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = ["DELETE", "GET", "HEAD", "MERGE", "POST", "OPTIONS", "PUT", "PATCH"] #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = ["*"]                                                                 #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = ["*", ]                                                               #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = 60                                                                    #(Required) The number of seconds the client should cache a preflight response.
      }
      restore_policy = {
        restore_policy_days = "4" #(Required) Specifies the number of days that the blob can be restored, between 1 and 365 days. This must be less than the days specified for delete_retention_policy.
      }
      delete_retention_policy = {
        delete_retention_policy_days = "7" #(Optional) Specifies the number of days that the blob should be retained, between 1 and 365 days. Defaults to 7.
      }

      container_delete_retention_policy = {
        container_delete_retention_policy_days = "7" #(Optional) Specifies the number of days that the container should be retained, between 1 and 365 days. Defaults to 7.
      }
    }

    storage_account_queue_properties = {
      cors_enabled = true #(optional) Should cross origin resource sharing be enabled.
      cors_rule = {
        allowed_headers    = ["*"]                                   #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = ["GET", "HEAD", "MERGE", "POST", "PUT"] #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = ["*"]                                   #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = ["*"]                                   #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = 60                                      #(Required) The number of seconds the client should cache a preflight response.
      }

      logging_enabled = true #Should storage account queue properties logging be enabled.
      logging = {
        delete                = true  #(Required) Indicates whether all delete requests should be logged.
        read                  = true  #(Required) Indicates whether all read requests should be logged.
        version               = "1.0" #(Required) The version of storage analytics to configure.
        write                 = true  #(Required) Indicates whether all write requests should be logged.
        retention_policy_days = 7     #(Optional) Specifies the number of days that logs will be retained.
      }

      minute_metrics = {
        enabled               = true  #(Required) Indicates whether minute metrics are enabled for the Queue service.
        version               = "1.0" #(Required) The version of storage analytics to configure.
        include_apis          = true  #(Optional) Indicates whether metrics should generate summary statistics for called API operations.
        retention_policy_days = 7     #(Optional) Specifies the number of days that logs will be retained.
      }

      hour_metrics = {
        enabled               = true  #(Required) Indicates whether minute metrics are enabled for the Queue service.
        version               = "1.0" #(Required) The version of storage analytics to configure.
        include_apis          = true  #(Optional) Indicates whether metrics should generate summary statistics for called API operations.
        retention_policy_days = 7     #(Optional) Specifies the number of days that logs will be retained.
      }
    }
    storage_account_static_website = {
      index_document     = "index.html" #Optional) The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive.
      error_404_document = "404.html"   #(Optional) The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file.
    }

    storage_account_share_properties = {
      cors_enabled = true #(optional) Should cross origin resource sharing be enabled.
      cors_rule = {
        allowed_headers    = ["*"]                                   #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = ["GET", "HEAD", "MERGE", "POST", "PUT"] #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = ["*"]                                   #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = ["*"]                                   #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = 60                                      #(Required) The number of seconds the client should cache a preflight response.
      }

      retention_policy = {
        retention_policy_days = 7 #(Optional) Specifies the number of days that the azurerm_storage_share should be retained, between 1 and 365 days. Defaults to 7.
      }

      smb = {
        smb_versions                        = ["SMB2.1"]      #(Optional) A set of SMB protocol versions. Possible values are SMB2.1, SMB3.0, and SMB3.1.1.
        smb_authentication_types            = ["NTLMv2"]      #(Optional) A set of SMB authentication methods. Possible values are NTLMv2, and Kerberos.
        smb_kerberos_ticket_encryption_type = ["RC4-HMAC"]    #(Optional) A set of Kerberos ticket encryption. Possible values are RC4-HMAC, and AES-256.
        smb_channel_encryption_type         = ["AES-128-CCM"] #(Optional) A set of SMB channel encryption. Possible values are AES-128-CCM, AES-128-GCM, and AES-256-GCM.
        smb_multichannel_enabled            = false           #(Optional) Indicates whether multichannel is enabled. Defaults to false. This is only supported on Premium storage accounts.
      }
    }

    storage_account_network_rules = null /* {
      default_action = "Deny"                 #(Required) Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow.
      bypass         = ["Logging", "Metrics"] #(Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None.
      ip_rules       = ["8.29.228.191"]        #(Optional) List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed.

      storage_account_network_rules_vnet_subnets = [{
        storage_account_network_rules_virtual_network_name = "ploceusvnet000001"                   #(Required) Vitural Network name to be associated.
        storage_account_network_rules_subnet_name          = "ploceussubnet000001"                 #(Required) Subnet Name to be associated.
        storage_account_network_rules_vnet_subscription_id = "xxxxxxx-xxxxxxx-xxxxxxxxx-xxxxxxxxx" #(Required) Subscription Id where Vnet is created.
        storage_account_network_rules_vnet_rg_name         = "ploceusrg000001"                     #(Required) Resource group where Vnet is created.
        }]

      private_link_access = null /*{
        "private_link_access_1" = {
          endpoint_resource_id = "/subscriptions/XXXXXXXXXXXXXXXXXXXXXXX/resourceGroups/XXXXXXXXXXXXXXXXXXXX/providers/Microsoft.Sql/servers/XXXXXXXXXXXXXXXXXXXX"
          endpoint_tenant_id   = "xxxxxxxxx-xxxxxxxxx-xxxxxxxxxx-xxxxxxxxx"
        }
      }
    } */

    storage_account_azure_files_authentication = null
    # storage_account_azure_files_authentication = {  # Use this block when need to authenticate with Azure active directory domain services or Active Directory.
    #   directory_type = "AADDS" #(Required) Specifies the directory service used. Possible values are AADDS and AD.
    #   active_directory = {
    #     storage_sid         = "xxxxxxxxxx" #(Required) Specifies the security identifier (SID) for Azure Storage.
    #     domain_name         = "www.ploceus1.com" #(Required) Specifies the primary domain that the AD DNS server is authoritative for.
    #     domain_sid          = "xxxxxxxxxx" #(Required) Specifies the security identifier (SID).
    #     domain_guid         = "xxxxxxxxxx" #(Required) Specifies the domain GUID.
    #     forest_name         = "xxxxxxxxxx" #(Required) Specifies the Active Directory forest.
    #     netbios_domain_name = "www.ploceus2.com" #(Required) Specifies the NetBIOS domain name.
    #   }
    # }

    storage_account_routing = {
      publish_internet_endpoints  = false             #(Optional) Should internet routing storage endpoints be published? Defaults to false.
      publish_microsoft_endpoints = false             #(Optional) Should Microsoft routing storage endpoints be published? Defaults to false.
      choice                      = "InternetRouting" #(Optional) Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting. Defaults to MicrosoftRouting.
    }

    storage_account_immutability_policy = null /* {
      allow_protected_append_writes = false      #(Required) When enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted.
      state                         = "Disabled" #(Required) Defines the mode of the policy. Disabled state disables the policy, Unlocked state allows increase and decrease of immutability retention time and also allows toggling allowProtectedAppendWrites property, Locked state only allows the increase of the immutability retention time. A policy can only be created in a Disabled or Unlocked state and can be toggled between the two states. Only a policy in an Unlocked state can transition to a Locked state which cannot be reverted.
      period_since_creation_in_days = 7          #(Required) The immutability period for the blobs in the container since the policy creation, in days.
    } */

    storage_account_sas_policy = {
      expiration_period = "11:12:13:14" #(Required) The SAS expiration period in format of DD.HH:MM:SS.
      expiration_action = "Log"         #(Optional) The SAS expiration action. The only possible value is Log at this moment. Defaults to Log.
    }

    storage_account_tags = { #(Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Dev",
      Environment    = "PLZ-Dev",
      Owner          = "Manish Kumar",
      Criticality    = "Medium",
      Classification = "Gold",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }

  },

   "storage_account_2" = {
    storage_account_key_vault_name                                     = null #(Optional) The name of the Key Vault.
    storage_account_is_key_vault_key_versionless                       = true
    storage_account_key_vault_resource_group_name                      = null    #(Optional) The resource group name of the Key Vault.
    storage_account_key_vault_key_name                                 = null #(Optional) The name of the Key Vault key required for customer managed key.
    storage_account_user_assigned_identity_name_for_cmk                = null   #(Optional) The name of a user assigned identity for customer managed key.
    storage_account_user_assigned_identity_resource_group_name_for_cmk = null    #(Optional) The resource group name of a user assigned identity for customer managed key.
    storage_account_identity_type_for_cmk                              = "SystemAssigned"     #(Optional) The identity type of a user assigned identity for customer managed key.Only Possible value could be "UserAssigned" in order to use customer managed key. Other Possible values are "SystemAssigned", "SystemAssigned, UserAssigned"
    storage_account_name                                               = "sddevailabaml01"    #(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed.This must be unique across the entire Azure service, not just within the resource group.
    storage_account_resource_group_name                                = "sd-common-dev-hrgpt-rg"    #(Required) The name of the resource group in which to create the storage account.
    storage_account_location                                           = "Central India"             #(Required) Specifies the supported Azure location where the resource exists.
    storage_account_account_kind                                       = "StorageV2"          #(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2.
    storage_account_account_tier                                       = "Standard"           #(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    storage_account_account_replication_type                           = "LRS"                #(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa.
    storage_account_cross_tenant_replication_enabled                   = true                 #(Optional) Should cross Tenant replication be enabled? Defaults to true.
    storage_account_access_tier                                        = "Hot"                #(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot.
    storage_account_edge_zone                                          = null                 #(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist.
    storage_account_enable_https_traffic_only                          = true                 #(Optional) Boolean flag which forces HTTPS if enabled. Defaults to true.
    storage_account_min_tls_version                                    = "TLS1_2"             #(Optional) The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts.
    storage_account_allow_nested_items_to_be_public                    = true                 #Allow or disallow nested items within this Account to opt into being public. Defaults to true.
    storage_account_shared_access_key_enabled                          = true                 #Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true.
    storage_account_public_network_access_enabled                      = true                 #(Optional) Whether the public network access is enabled? Defaults to true.
    storage_account_default_to_oauth_authentication                    = false                #(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false
    storage_account_is_hns_enabled                                     = false                #(Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2.
    storage_account_nfsv3_enabled                                      = false                #(Optional) Is NFSv3 protocol enabled? Defaults to false.
    storage_account_large_file_share_enabled                           = false                #(Optional) Is Large File Share Enabled?
    storage_account_queue_encryption_key_type                          = "Service"            #(Optional) The encryption type of the queue service. Possible values are Service and Account.Default value is Service.
    storage_account_table_encryption_key_type                          = "Service"            #(Optional) The encryption type of the table service. Possible values are Service and Account. Default value is Service.
    storage_account_infrastructure_encryption_enabled                  = false                #(Optional) Is infrastructure encryption enabled? Defaults to false.
    storage_account_allowed_copy_scope                                 = null                 #(Optional) Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values are AAD and PrivateLink.
    storage_account_sftp_enabled                                       = false                #(Optional) Boolean, enable SFTP for the storage account, to enable this, is_hns_enabled should be true as well
    storage_account_custom_domain                                      = null
    # storage_account_custom_domain = {
    #     custom_domain_name = "www.ploceus.com" #(Required) The Custom Domain Name to use for the Storage Account, which will be validated by Azure.
    #     custom_domain_use_subdomain = false #(Optional) Should the Custom Domain Name be validated by using indirect CNAME validation?
    # }

    storage_account_identity = null
    # storage_account_identity = {
    #   storage_account_identity_type = "UserAssigned" # Possible values could be "UserAssigned", "SystemAssigned", "SystemAssigned, UserAssigned"
    #   # storage_account_user_assigned_identity_ids = null
    #   storage_account_user_assigned_identity_ids = [{ # This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
    #     identity_name                = "ploceusuai000002"
    #     identity_resource_group_name = "loceusrg000005"
    #   }]
    # }

    storage_account_blob_properties = {
      versioning_enabled            = true         #(Optional) Is versioning enabled? Default to false.
      change_feed_enabled           = true         #(Optional) Is the blob service properties for change feed events enabled? Default to false.
      change_feed_retention_in_days = 7            #(Optional) The duration of change feed events retention in days. The possible values are between 1 and 146000 days (400 years). Setting this to null (or omit this in the configuration file) indicates an infinite retention of the change feed.
      default_service_version       = "2020-06-12" #(Optional) The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version. Defaults to 2020-06-12.
      last_access_time_enabled      = true         #(Optional) Is the last access time based tracking enabled? Default to false.

      cors_enabled = true #(optional) Should cross origin resource sharing be enabled.
      cors_rule = {
        allowed_headers    = ["*"]                                                                 #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = ["DELETE", "GET", "HEAD", "MERGE", "POST", "OPTIONS", "PUT", "PATCH"] #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = ["*"]                                                                 #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = ["*", ]                                                               #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = 60                                                                    #(Required) The number of seconds the client should cache a preflight response.
      }
      restore_policy = {
        restore_policy_days = "4" #(Required) Specifies the number of days that the blob can be restored, between 1 and 365 days. This must be less than the days specified for delete_retention_policy.
      }
      delete_retention_policy = {
        delete_retention_policy_days = "7" #(Optional) Specifies the number of days that the blob should be retained, between 1 and 365 days. Defaults to 7.
      }

      container_delete_retention_policy = {
        container_delete_retention_policy_days = "7" #(Optional) Specifies the number of days that the container should be retained, between 1 and 365 days. Defaults to 7.
      }
    }

    storage_account_queue_properties = {
      cors_enabled = true #(optional) Should cross origin resource sharing be enabled.
      cors_rule = {
        allowed_headers    = ["*"]                                   #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = ["GET", "HEAD", "MERGE", "POST", "PUT"] #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = ["*"]                                   #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = ["*"]                                   #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = 60                                      #(Required) The number of seconds the client should cache a preflight response.
      }

      logging_enabled = true #Should storage account queue properties logging be enabled.
      logging = {
        delete                = true  #(Required) Indicates whether all delete requests should be logged.
        read                  = true  #(Required) Indicates whether all read requests should be logged.
        version               = "1.0" #(Required) The version of storage analytics to configure.
        write                 = true  #(Required) Indicates whether all write requests should be logged.
        retention_policy_days = 7     #(Optional) Specifies the number of days that logs will be retained.
      }

      minute_metrics = {
        enabled               = true  #(Required) Indicates whether minute metrics are enabled for the Queue service.
        version               = "1.0" #(Required) The version of storage analytics to configure.
        include_apis          = true  #(Optional) Indicates whether metrics should generate summary statistics for called API operations.
        retention_policy_days = 7     #(Optional) Specifies the number of days that logs will be retained.
      }

      hour_metrics = {
        enabled               = true  #(Required) Indicates whether minute metrics are enabled for the Queue service.
        version               = "1.0" #(Required) The version of storage analytics to configure.
        include_apis          = true  #(Optional) Indicates whether metrics should generate summary statistics for called API operations.
        retention_policy_days = 7     #(Optional) Specifies the number of days that logs will be retained.
      }
    }
    storage_account_static_website = {
      index_document     = "index.html" #Optional) The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive.
      error_404_document = "404.html"   #(Optional) The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file.
    }

    storage_account_share_properties = {
      cors_enabled = true #(optional) Should cross origin resource sharing be enabled.
      cors_rule = {
        allowed_headers    = ["*"]                                   #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = ["GET", "HEAD", "MERGE", "POST", "PUT"] #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = ["*"]                                   #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = ["*"]                                   #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = 60                                      #(Required) The number of seconds the client should cache a preflight response.
      }

      retention_policy = {
        retention_policy_days = 7 #(Optional) Specifies the number of days that the azurerm_storage_share should be retained, between 1 and 365 days. Defaults to 7.
      }

      smb = {
        smb_versions                        = ["SMB2.1"]      #(Optional) A set of SMB protocol versions. Possible values are SMB2.1, SMB3.0, and SMB3.1.1.
        smb_authentication_types            = ["NTLMv2"]      #(Optional) A set of SMB authentication methods. Possible values are NTLMv2, and Kerberos.
        smb_kerberos_ticket_encryption_type = ["RC4-HMAC"]    #(Optional) A set of Kerberos ticket encryption. Possible values are RC4-HMAC, and AES-256.
        smb_channel_encryption_type         = ["AES-128-CCM"] #(Optional) A set of SMB channel encryption. Possible values are AES-128-CCM, AES-128-GCM, and AES-256-GCM.
        smb_multichannel_enabled            = false           #(Optional) Indicates whether multichannel is enabled. Defaults to false. This is only supported on Premium storage accounts.
      }
    }

    storage_account_network_rules = null /* {
      default_action = "Deny"                 #(Required) Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow.
      bypass         = ["Logging", "Metrics"] #(Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None.
      ip_rules       = ["8.29.228.191"]        #(Optional) List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed.

      storage_account_network_rules_vnet_subnets = [{
        storage_account_network_rules_virtual_network_name = "ploceusvnet000001"                   #(Required) Vitural Network name to be associated.
        storage_account_network_rules_subnet_name          = "ploceussubnet000001"                 #(Required) Subnet Name to be associated.
        storage_account_network_rules_vnet_subscription_id = "xxxxxxx-xxxxxxx-xxxxxxxxx-xxxxxxxxx" #(Required) Subscription Id where Vnet is created.
        storage_account_network_rules_vnet_rg_name         = "ploceusrg000001"                     #(Required) Resource group where Vnet is created.
        }]

      private_link_access = null /*{
        "private_link_access_1" = {
          endpoint_resource_id = "/subscriptions/XXXXXXXXXXXXXXXXXXXXXXX/resourceGroups/XXXXXXXXXXXXXXXXXXXX/providers/Microsoft.Sql/servers/XXXXXXXXXXXXXXXXXXXX"
          endpoint_tenant_id   = "xxxxxxxxx-xxxxxxxxx-xxxxxxxxxx-xxxxxxxxx"
        }
      }
    } */

    storage_account_azure_files_authentication = null
    # storage_account_azure_files_authentication = {  # Use this block when need to authenticate with Azure active directory domain services or Active Directory.
    #   directory_type = "AADDS" #(Required) Specifies the directory service used. Possible values are AADDS and AD.
    #   active_directory = {
    #     storage_sid         = "xxxxxxxxxx" #(Required) Specifies the security identifier (SID) for Azure Storage.
    #     domain_name         = "www.ploceus1.com" #(Required) Specifies the primary domain that the AD DNS server is authoritative for.
    #     domain_sid          = "xxxxxxxxxx" #(Required) Specifies the security identifier (SID).
    #     domain_guid         = "xxxxxxxxxx" #(Required) Specifies the domain GUID.
    #     forest_name         = "xxxxxxxxxx" #(Required) Specifies the Active Directory forest.
    #     netbios_domain_name = "www.ploceus2.com" #(Required) Specifies the NetBIOS domain name.
    #   }
    # }

    storage_account_routing = {
      publish_internet_endpoints  = false             #(Optional) Should internet routing storage endpoints be published? Defaults to false.
      publish_microsoft_endpoints = false             #(Optional) Should Microsoft routing storage endpoints be published? Defaults to false.
      choice                      = "InternetRouting" #(Optional) Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting. Defaults to MicrosoftRouting.
    }

    storage_account_immutability_policy = null /* {
      allow_protected_append_writes = false      #(Required) When enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted.
      state                         = "Disabled" #(Required) Defines the mode of the policy. Disabled state disables the policy, Unlocked state allows increase and decrease of immutability retention time and also allows toggling allowProtectedAppendWrites property, Locked state only allows the increase of the immutability retention time. A policy can only be created in a Disabled or Unlocked state and can be toggled between the two states. Only a policy in an Unlocked state can transition to a Locked state which cannot be reverted.
      period_since_creation_in_days = 7          #(Required) The immutability period for the blobs in the container since the policy creation, in days.
    } */

    storage_account_sas_policy = {
      expiration_period = "11:12:13:14" #(Required) The SAS expiration period in format of DD.HH:MM:SS.
      expiration_action = "Log"         #(Optional) The SAS expiration action. The only possible value is Log at this moment. Defaults to Log.
    }

    storage_account_tags = { #(Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Dev",
      Environment    = "PLZ-Dev",
      Owner          = "Manish Kumar",
      Criticality    = "Medium",
      Classification = "Gold",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }

    
  }/*,

   "storage_account_3" = {
    storage_account_key_vault_name                                     = null #(Optional) The name of the Key Vault.
    storage_account_is_key_vault_key_versionless                       = true
    storage_account_key_vault_resource_group_name                      = null    #(Optional) The resource group name of the Key Vault.
    storage_account_key_vault_key_name                                 = null #(Optional) The name of the Key Vault key required for customer managed key.
    storage_account_user_assigned_identity_name_for_cmk                = null   #(Optional) The name of a user assigned identity for customer managed key.
    storage_account_user_assigned_identity_resource_group_name_for_cmk = null    #(Optional) The resource group name of a user assigned identity for customer managed key.
    storage_account_identity_type_for_cmk                              = "SystemAssigned"     #(Optional) The identity type of a user assigned identity for customer managed key.Only Possible value could be "UserAssigned" in order to use customer managed key. Other Possible values are "SystemAssigned", "SystemAssigned, UserAssigned"
    storage_account_name                                               = "sddevailabaml02"    #(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed.This must be unique across the entire Azure service, not just within the resource group.
    storage_account_resource_group_name                                = "sd-common-dev-hrgpt-rg"    #(Required) The name of the resource group in which to create the storage account.
    storage_account_location                                           = "SE Asia"             #(Required) Specifies the supported Azure location where the resource exists.
    storage_account_account_kind                                       = "StorageV2"          #(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2.
    storage_account_account_tier                                       = "Standard"           #(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    storage_account_account_replication_type                           = "LRS"                #(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa.
    storage_account_cross_tenant_replication_enabled                   = true                 #(Optional) Should cross Tenant replication be enabled? Defaults to true.
    storage_account_access_tier                                        = "Hot"                #(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot.
    storage_account_edge_zone                                          = null                 #(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist.
    storage_account_enable_https_traffic_only                          = true                 #(Optional) Boolean flag which forces HTTPS if enabled. Defaults to true.
    storage_account_min_tls_version                                    = "TLS1_2"             #(Optional) The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts.
    storage_account_allow_nested_items_to_be_public                    = true                 #Allow or disallow nested items within this Account to opt into being public. Defaults to true.
    storage_account_shared_access_key_enabled                          = true                 #Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true.
    storage_account_public_network_access_enabled                      = true                 #(Optional) Whether the public network access is enabled? Defaults to true.
    storage_account_default_to_oauth_authentication                    = false                #(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false
    storage_account_is_hns_enabled                                     = false                #(Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2.
    storage_account_nfsv3_enabled                                      = false                #(Optional) Is NFSv3 protocol enabled? Defaults to false.
    storage_account_large_file_share_enabled                           = false                #(Optional) Is Large File Share Enabled?
    storage_account_queue_encryption_key_type                          = "Service"            #(Optional) The encryption type of the queue service. Possible values are Service and Account.Default value is Service.
    storage_account_table_encryption_key_type                          = "Service"            #(Optional) The encryption type of the table service. Possible values are Service and Account. Default value is Service.
    storage_account_infrastructure_encryption_enabled                  = false                #(Optional) Is infrastructure encryption enabled? Defaults to false.
    storage_account_allowed_copy_scope                                 = null                 #(Optional) Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values are AAD and PrivateLink.
    storage_account_sftp_enabled                                       = false                #(Optional) Boolean, enable SFTP for the storage account, to enable this, is_hns_enabled should be true as well
    storage_account_custom_domain                                      = null
    # storage_account_custom_domain = {
    #     custom_domain_name = "www.ploceus.com" #(Required) The Custom Domain Name to use for the Storage Account, which will be validated by Azure.
    #     custom_domain_use_subdomain = false #(Optional) Should the Custom Domain Name be validated by using indirect CNAME validation?
    # }

    storage_account_identity = null
    # storage_account_identity = {
    #   storage_account_identity_type = "UserAssigned" # Possible values could be "UserAssigned", "SystemAssigned", "SystemAssigned, UserAssigned"
    #   # storage_account_user_assigned_identity_ids = null
    #   storage_account_user_assigned_identity_ids = [{ # This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
    #     identity_name                = "ploceusuai000002"
    #     identity_resource_group_name = "loceusrg000005"
    #   }]
    # }

    storage_account_blob_properties = {
      versioning_enabled            = true         #(Optional) Is versioning enabled? Default to false.
      change_feed_enabled           = true         #(Optional) Is the blob service properties for change feed events enabled? Default to false.
      change_feed_retention_in_days = 7            #(Optional) The duration of change feed events retention in days. The possible values are between 1 and 146000 days (400 years). Setting this to null (or omit this in the configuration file) indicates an infinite retention of the change feed.
      default_service_version       = "2020-06-12" #(Optional) The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version. Defaults to 2020-06-12.
      last_access_time_enabled      = true         #(Optional) Is the last access time based tracking enabled? Default to false.

      cors_enabled = true #(optional) Should cross origin resource sharing be enabled.
      cors_rule = {
        allowed_headers    = ["*"]                                                                 #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = ["DELETE", "GET", "HEAD", "MERGE", "POST", "OPTIONS", "PUT", "PATCH"] #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = ["*"]                                                                 #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = ["*", ]                                                               #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = 60                                                                    #(Required) The number of seconds the client should cache a preflight response.
      }
      restore_policy = {
        restore_policy_days = "4" #(Required) Specifies the number of days that the blob can be restored, between 1 and 365 days. This must be less than the days specified for delete_retention_policy.
      }
      delete_retention_policy = {
        delete_retention_policy_days = "7" #(Optional) Specifies the number of days that the blob should be retained, between 1 and 365 days. Defaults to 7.
      }

      container_delete_retention_policy = {
        container_delete_retention_policy_days = "7" #(Optional) Specifies the number of days that the container should be retained, between 1 and 365 days. Defaults to 7.
      }
    }

    storage_account_queue_properties = {
      cors_enabled = true #(optional) Should cross origin resource sharing be enabled.
      cors_rule = {
        allowed_headers    = ["*"]                                   #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = ["GET", "HEAD", "MERGE", "POST", "PUT"] #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = ["*"]                                   #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = ["*"]                                   #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = 60                                      #(Required) The number of seconds the client should cache a preflight response.
      }

      logging_enabled = true #Should storage account queue properties logging be enabled.
      logging = {
        delete                = true  #(Required) Indicates whether all delete requests should be logged.
        read                  = true  #(Required) Indicates whether all read requests should be logged.
        version               = "1.0" #(Required) The version of storage analytics to configure.
        write                 = true  #(Required) Indicates whether all write requests should be logged.
        retention_policy_days = 7     #(Optional) Specifies the number of days that logs will be retained.
      }

      minute_metrics = {
        enabled               = true  #(Required) Indicates whether minute metrics are enabled for the Queue service.
        version               = "1.0" #(Required) The version of storage analytics to configure.
        include_apis          = true  #(Optional) Indicates whether metrics should generate summary statistics for called API operations.
        retention_policy_days = 7     #(Optional) Specifies the number of days that logs will be retained.
      }

      hour_metrics = {
        enabled               = true  #(Required) Indicates whether minute metrics are enabled for the Queue service.
        version               = "1.0" #(Required) The version of storage analytics to configure.
        include_apis          = true  #(Optional) Indicates whether metrics should generate summary statistics for called API operations.
        retention_policy_days = 7     #(Optional) Specifies the number of days that logs will be retained.
      }
    }
    storage_account_static_website = {
      index_document     = "index.html" #Optional) The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive.
      error_404_document = "404.html"   #(Optional) The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file.
    }

    storage_account_share_properties = {
      cors_enabled = true #(optional) Should cross origin resource sharing be enabled.
      cors_rule = {
        allowed_headers    = ["*"]                                   #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = ["GET", "HEAD", "MERGE", "POST", "PUT"] #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = ["*"]                                   #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = ["*"]                                   #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = 60                                      #(Required) The number of seconds the client should cache a preflight response.
      }

      retention_policy = {
        retention_policy_days = 7 #(Optional) Specifies the number of days that the azurerm_storage_share should be retained, between 1 and 365 days. Defaults to 7.
      }

      smb = {
        smb_versions                        = ["SMB2.1"]      #(Optional) A set of SMB protocol versions. Possible values are SMB2.1, SMB3.0, and SMB3.1.1.
        smb_authentication_types            = ["NTLMv2"]      #(Optional) A set of SMB authentication methods. Possible values are NTLMv2, and Kerberos.
        smb_kerberos_ticket_encryption_type = ["RC4-HMAC"]    #(Optional) A set of Kerberos ticket encryption. Possible values are RC4-HMAC, and AES-256.
        smb_channel_encryption_type         = ["AES-128-CCM"] #(Optional) A set of SMB channel encryption. Possible values are AES-128-CCM, AES-128-GCM, and AES-256-GCM.
        smb_multichannel_enabled            = false           #(Optional) Indicates whether multichannel is enabled. Defaults to false. This is only supported on Premium storage accounts.
      }
    }

    storage_account_network_rules = null /* {
      default_action = "Deny"                 #(Required) Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow.
      bypass         = ["Logging", "Metrics"] #(Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None.
      ip_rules       = ["8.29.228.191"]        #(Optional) List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed.

      storage_account_network_rules_vnet_subnets = [{
        storage_account_network_rules_virtual_network_name = "ploceusvnet000001"                   #(Required) Vitural Network name to be associated.
        storage_account_network_rules_subnet_name          = "ploceussubnet000001"                 #(Required) Subnet Name to be associated.
        storage_account_network_rules_vnet_subscription_id = "xxxxxxx-xxxxxxx-xxxxxxxxx-xxxxxxxxx" #(Required) Subscription Id where Vnet is created.
        storage_account_network_rules_vnet_rg_name         = "ploceusrg000001"                     #(Required) Resource group where Vnet is created.
        }]

      private_link_access = null /*{
        "private_link_access_1" = {
          endpoint_resource_id = "/subscriptions/XXXXXXXXXXXXXXXXXXXXXXX/resourceGroups/XXXXXXXXXXXXXXXXXXXX/providers/Microsoft.Sql/servers/XXXXXXXXXXXXXXXXXXXX"
          endpoint_tenant_id   = "xxxxxxxxx-xxxxxxxxx-xxxxxxxxxx-xxxxxxxxx"
        }
      }
    } */
/*
    storage_account_azure_files_authentication = null
    # storage_account_azure_files_authentication = {  # Use this block when need to authenticate with Azure active directory domain services or Active Directory.
    #   directory_type = "AADDS" #(Required) Specifies the directory service used. Possible values are AADDS and AD.
    #   active_directory = {
    #     storage_sid         = "xxxxxxxxxx" #(Required) Specifies the security identifier (SID) for Azure Storage.
    #     domain_name         = "www.ploceus1.com" #(Required) Specifies the primary domain that the AD DNS server is authoritative for.
    #     domain_sid          = "xxxxxxxxxx" #(Required) Specifies the security identifier (SID).
    #     domain_guid         = "xxxxxxxxxx" #(Required) Specifies the domain GUID.
    #     forest_name         = "xxxxxxxxxx" #(Required) Specifies the Active Directory forest.
    #     netbios_domain_name = "www.ploceus2.com" #(Required) Specifies the NetBIOS domain name.
    #   }
    # }

    storage_account_routing = {
      publish_internet_endpoints  = false             #(Optional) Should internet routing storage endpoints be published? Defaults to false.
      publish_microsoft_endpoints = false             #(Optional) Should Microsoft routing storage endpoints be published? Defaults to false.
      choice                      = "InternetRouting" #(Optional) Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting. Defaults to MicrosoftRouting.
    }

    storage_account_immutability_policy = null /* {
      allow_protected_append_writes = false      #(Required) When enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted.
      state                         = "Disabled" #(Required) Defines the mode of the policy. Disabled state disables the policy, Unlocked state allows increase and decrease of immutability retention time and also allows toggling allowProtectedAppendWrites property, Locked state only allows the increase of the immutability retention time. A policy can only be created in a Disabled or Unlocked state and can be toggled between the two states. Only a policy in an Unlocked state can transition to a Locked state which cannot be reverted.
      period_since_creation_in_days = 7          #(Required) The immutability period for the blobs in the container since the policy creation, in days.
    } */
/*
    storage_account_sas_policy = {
      expiration_period = "11:12:13:14" #(Required) The SAS expiration period in format of DD.HH:MM:SS.
      expiration_action = "Log"         #(Optional) The SAS expiration action. The only possible value is Log at this moment. Defaults to Log.
    }

    storage_account_tags = { #(Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Dev",
      Environment    = "PLZ-Dev",
      Owner          = "Manish Kumar",
      Criticality    = "Medium",
      Classification = "Gold",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
*/
}
