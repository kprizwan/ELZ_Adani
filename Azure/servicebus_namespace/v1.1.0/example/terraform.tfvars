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

#RESOURCE GROUP
key_vault_resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000002"
    location = "westus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#KEY VAULT
key_vault_variables = {
  "key_vault_1" = {
    key_vault_name                                  = "ploceuskeyvault000001"
    key_vault_location                              = "westus2"
    key_vault_resource_group_name                   = "ploceusrg000002"
    key_vault_enabled_for_disk_encryption           = true
    key_vault_enabled_for_deployment                = true
    key_vault_enabled_for_template_deployment       = true
    key_vault_enable_rbac_authorization             = false
    key_vault_soft_delete_retention_days            = "7"
    key_vault_purge_protection_enabled              = false
    key_vault_sku_name                              = "standard"
    key_vault_access_container_agent_name           = null
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore", "Purge"]
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge"]
    key_vault_access_policy_storage_permissions     = []
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]
    key_vault_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_network_acls_enabled          = false
    key_vault_network_acls_virtual_networks = []
    key_vault_network_acls_bypass           = "AzureServices"
    key_vault_network_acls_default_action   = "Allow"
    key_vault_network_acls_ip_rules         = null
    key_vault_contact_information_enabled   = false
    key_vault_contact_email                 = null
    key_vault_contact_name                  = null
    key_vault_contact_phone                 = null

  }
}

#KEY VAULT KEY
key_vault_key_variables = {
  "key_vault_key_1" = {
    name                = "ploceuskeyvaultkey000001"
    resource_group_name = "ploceusrg000002"
    key_vault_name      = "ploceuskeyvault000001"
    key_type            = "RSA"
    key_size            = 2048
    curve               = null
    key_opts            = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
    not_before_date     = null
    expiration_date     = null
    key_vault_key_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#USER ASSIGNED IDENTITY
user_assigned_identity_variables = {
  "uai1" = {
    user_assigned_identity_name                = "ploceusuai000001"
    user_assigned_identity_location            = "westus2"
    user_assigned_identity_resource_group_name = "ploceusrg000001"
    user_assigned_identity_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#Servicebus namespace variables
servicebus_namespace_variables = {
  "servicebus_namespace_1" = {
    servicebus_namespace_name                = "ploceussbns000001" #(Required) Specifies the name of the ServiceBus Namespace resource . Changing this forces a new resource to be created.
    servicebus_namespace_resource_group_name = "ploceusrg000001"   #(Required) The name of the resource group in which to create the namespace.
    servicebus_namespace_location            = "westus2"           #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    servicebus_namespace_sku                 = "Standard"          # (Required) Defines which tier to use. Options are Basic, Standard or Premium. Please note that setting this field to Premium will force the creation of a new resource.
    servicebus_namespace_identity = {                              #(Optional) An identity block as defined below.
      identity_type                     = "SystemAssigned"         #(Required) Specifies the type of Managed Service Identity that should be configured on this ServiceBus Namespace. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      identity_user_assigned_identities = []
      /*Sample Code
       [{
        user_assigned_identities_name                = "PloceusUserAssignedIdentity1" #(Optional) User assigned identity name. Provide value only if "identity_type" is set to UserAssigned or SystemAssigned, UserAssigned
        user_assigned_identities_resource_group_name = "ploceusrg000001" #(Optional) User assigned identity resource group name. Provide value only if "identity_type" is set to UserAssigned or SystemAssigned, UserAssigned
        },
        {
          user_assigned_identities_name                = "PloceusUserAssignedIdentity2"
          user_assigned_identities_resource_group_name = "ploceusrg000001"
        },
        {
          user_assigned_identities_name                = "PloceusUserAssignedIdentity3"
          user_assigned_identities_resource_group_name = "ploceusrg000001"
      }] */
    }
    servicebus_namespace_capacity             = 0 #(Optional) Specifies the capacity. When sku is Premium, capacity can be 1, 2, 4, 8 or 16. When sku is Basic or Standard, capacity can be 0 only.
    servicebus_namespace_customer_managed_key = null
    /*Sample Code
    {
      customer_managed_key_infrastructure_encryption_enabled = false #(Optional) Used to specify whether enable Infrastructure Encryption (Double Encryption).
    } */
    servicebus_namespace_local_auth_enabled               = true  #(Optional) Whether or not SAS authentication is enabled for the Service Bus namespace. Defaults to true.
    servicebus_namespace_zone_redundant                   = false #(Optional) Whether or not this resource is zone redundant. sku needs to be Premium. Defaults to false.
    servicebus_namespace_is_customer_managed_key_required = false #(Required)Provide boolean value to check the condition
    servicebus_namespace_key_vault_name                   = null  #(Optional)Key vault name. Provide value only if "servicebus_namespace_is_customer_managed_key_required" is set to "true"
    servicebus_namespace_key_vault_resource_group_name    = null  #(Optional)Key vault resource group name. Provide value only if "servicebus_namespace_is_customer_managed_key_required" is set to "true"
    servicebus_namespace_key_vault_key_name               = null  #(Optional)Key vault key name. Provide value only if "servicebus_namespace_is_customer_managed_key_required" is set to "true"
    servicebus_namespace_tags = {                                 #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

servicebus_subscription_id = "xxxxxxxxx-xxxx-xxxxx-xxxx-xxxxxxxxxxxx"
servicebus_tenant_id       = "xxxxxxxxx-xxxx-xxxxx-xxxx-xxxxxxxxxxxx"
keyvault_subscription_id   = "xxxxxxxxx-xxxx-xxxxx-xxxx-xxxxxxxxxxxx"
keyvault_tenant_id         = "xxxxxxxxx-xxxx-xxxxx-xxxx-xxxxxxxxxxxx"