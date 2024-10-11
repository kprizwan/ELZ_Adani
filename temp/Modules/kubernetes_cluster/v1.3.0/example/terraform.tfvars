#RESOURCE GROUP FOR LOG ANALYTICS WORKSPACE
resource_group_log_analytics_workspace_oms_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000001" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location = "westus2"         #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_managed_by = "ploceus" #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#ROLE ASSIGNMENT
role_assignment_variables = {
  "role_assignment" = {
    role_assignment_role_definition_name                   = "Network Contributor"                                                                             # (Optional) A unique UUID/GUID for this Role Assignment - one will be generated if not specified. Changing this forces a new resource to be created.
    role_assignment_description                            = "Grants full access to manage all resources but does not allow you to assign roles in Azure RBAC" # (Optional) The description of the role
    role_assignment_target_resource_name                   = "b90c439e-9918-4c9f-a683-cd83f34078a4"                                                            # (Required) The name of the resource to which we are assigning role
    role_assignment_target_resource_type                   = "Subscription"                                                                                    # (Required) Possible values are Subscription, ManagementGroup or AzureResource
    role_assignment_management_group_name                  = null
    role_assignment_resource_group_name                    = null               # (Optional) The name of the management group. Please make as null if scope is not set as ManagementGroup
    role_assignment_principal_type                         = "ServicePrincipal" # (Optional) Type of the principal id. It maybe User, Group or ServicePrincipal
    is_group_principal_id_exists                           = false              # (Optional) Provide true when principal_type is "Group"
    role_assignment_group_principal_display_name           = null               # (Optional) give user_principal_name if is_group_principal_id_exists =true, and principal_type="Group".
    is_service_principal_id_exists                         = true               # (Optional) Provide true when principal_type is "ServicePrincipal"
    role_assignment_service_principal_display_name         = "ploceusuai000001" # (Optional) give service_principal_display_name if is_service_principal_id_exists =true, and principal_type="ServicePrincipal".
    is_user_principal_id_exists                            = false              # (Optional) Provide true when principle_type is "User"
    role_assignment_user_principal_name                    = null               # (Optional) give user_principal_name if is_user_principal_id_exists =true, and principal_type="User".
    role_assignment_condition                              = null               # (Optional) The condition that limits the resources that the role can be assigned to. Changing this forces a new resource to be created.
    role_assignment_security_enabled                       = true               # (Optional) Required for fetching group principal
    role_assignment_condition_version                      = null               # (Optional) The version of the condition. Possible values are 1.0 or 2.0. Changing this forces a new resource to be created.
    role_assignment_delegated_managed_identity_resource_id = null               # (Optional) The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created
    role_assignment_skip_service_principal_aad_check       = false              # (Optional) If the principal_id is a newly provisioned Service Principal set this value to true to skip the Azure Active Directory check which may fail due to replication lag. This argument is only valid if the principal_id is a Service Principal identity. Defaults to false.
  }
}

#PRIVATE DNS ZONE
private_dns_zone_variables = {
  "dnszone1" = {
    private_dns_zone_name                = "privatelink.westus2.azmk8s.io" #(Required) The name of the DNS Zone. Must be a valid domain name.
    private_dns_zone_resource_group_name = "ploceusrg000003"               #(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.
    private_dns_zone_soa_record          = null                            #(Optional) An soa_record block as defined below. Changing this forces a new resource to be created.
    private_dns_zone_tags = {                                              #(Optional) A mapping of tags to assign to the Record Set.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#LOG ANALYTICS WORKSPACE
log_analytics_workspace_variables = {
  "log_analytics_workspace_1" = {
    log_analytics_workspace_name                                   = "ploceuslaw000001"      #(Required) Specifies the name of the Log Analytics Workspace. Workspace name should include 4-63 letters, digits or '-'. The '-' shouldn't be the first or the last symbol. Changing this forces a new resource to be created.
    log_analytics_workspace_resource_group_name                    = "ploceusrg000001"       #(Required) The name of the resource group in which the Log Analytics workspace is created. Changing this forces a new resource to be created.
    log_analytics_workspace_location                               = "westus2"               #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created
    log_analytics_workspace_allow_resource_only_permissions        = true                    #(Optional) Specifies if the log Analytics Workspace allow users accessing to data associated with resources they have permission to view, without permission to workspace. Defaults to true.
    log_analytics_workspace_local_authentication_disabled          = false                   #(Optional) Specifies if the log Analytics workspace should enforce authentication using Azure AD. Defaults to false.
    log_analytics_workspace_sku                                    = "PerGB2018"             #(Optional) Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018 (new SKU as of 2018-04-03). Defaults to PerGB2018
    log_analytics_workspace_retention_in_days                      = null                    #(Optional) The workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730.
    log_analytics_workspace_daily_quota_gb                         = null                    #(Optional) The workspace daily quota for ingestion in GB. Defaults to -1 (unlimited) if omitted.
    log_analytics_workspace_cmk_for_query_forced                   = false                   #(Optional) Is Customer Managed Storage mandatory for query management?
    log_analytics_workspace_internet_ingestion_enabled             = null                    #(Optional) Should the Log Analytics Workspace support ingestion over the Public Internet? Defaults to true
    log_analytics_workspace_internet_query_enabled                 = null                    #(Optional) Should the Log Analytics Workspace support querying over the Public Internet? Defaults to true
    log_analytics_workspace_reservation_capacity_in_gb_per_day     = null                    #(Optional) The capacity reservation level in GB for this workspace. Must be in increments of 100 between 100 and 5000
    log_analytics_workspace_data_collection_rule_id                = null                    #(Optional) The ID of the Data Collection Rule to use for this workspace.
    log_analytics_workspace_key_vault_name                         = "ploceuskeyvault000001" #(Required) specify the keyvault name to store the log analytics workspace keys.
    log_analytics_workspace_key_vault_resource_group_name          = "ploceusrg000002"       #(Required) The name of the resource group in which the keyvault is present.
    log_analytics_workspace_primary_shared_key_vault_secret_name   = "ploceuskvsn000001"     #(Required) The name of the keyvault secret where the primary shared key of log analytics workspace is stored
    log_analytics_workspace_secondary_shared_key_vault_secret_name = "ploceuskvsn000002"     #(Required) The name of the keyvault secret where the secondary shared key of log analytics workspace is stored
    log_analytics_workspace_tags = {                                                         #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#RESOURCE GROUP FOR KEY VAULT
resource_group_key_vault_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000002" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location = "westus2"         #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_managed_by = "ploceus" #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#KEY VAULT
key_vault_variables = {
  "key_vault_1" = {
    key_vault_name                                  = "ploceuskeyvault000001"                                                                                                                                                                         #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_location                              = "westus2"                                                                                                                                                                                       #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_resource_group_name                   = "ploceusrg000002"                                                                                                                                                                               #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_enabled_for_disk_encryption           = true                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = true                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = true                                                                                                                                                                                            # (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = false                                                                                                                                                                                           #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = "7"                                                                                                                                                                                             #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = false                                                                                                                                                                                           #(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
    key_vault_sku_name                              = "standard"                                                                                                                                                                                      #(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium
    key_vault_access_container_agent_name           = null                                                                                                                                                                                            #(Optional) Self hosted conatiner agent name.
    key_vault_access_policy_application_id          = null                                                                                                                                                                                            #(Optional) The object ID of an Application in Azure Active Directory.
    key_vault_public_network_access_enabled         = true                                                                                                                                                                                            #(Optional) key_vault_public_network_access_enabled
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                    #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                              #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"] # (Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    #(Optional) A mapping of tags which should be assigned to the key vault.
    key_vault_tags = { #(Optional) A mapping of tags which should be assigned to the key vault.
      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_network_acls_enabled        = false           #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass         = "AzureServices" #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action = "Deny"          # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
    key_vault_network_acls_ip_rules       = null            # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.

    #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
    key_vault_network_acls_virtual_networks = null
    key_vault_contact_information_enabled   = false #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email                 = null  #(Required) E-mail address of the contact.
    key_vault_contact_name                  = null  #(Optional) Name of the contact.
    key_vault_contact_phone                 = null  #(Optional) Phone number of the contact.

  }
}

#KEY VAULT ACCESS POLICY
key_vault_access_policy_variables = {
  "key_vault_access_policy_1" = {
    key_vault_access_policy_key_permissions         = ["Get", "List", "Update", "Create", "Delete", "Recover", "Backup", "Restore", "Purge", "GetRotationPolicy", "SetRotationPolicy"]                                                                #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge", "Set"]                                                                                                                       #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"] #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_name                                  = "ploceuskeyvault000001"                                                                                                                                                                         #(Required) Specifies the name of the Key Vault resource.
    key_vault_resource_group_name                   = "ploceusrg000002"                                                                                                                                                                               #(Required) Specifies the resource group name where the key vault resides in.
    key_vault_access_resource_name                  = "xxxxxxx@ploceus.com"                                                                                                                                                                           #(Required) Specifies the resource name that needs an access policy to the key vault. Possible values are username, group name, service principal name and application name
    key_vault_access_resource_type                  = "User"                                                                                                                                                                                          #(Required) Specifies the type of resource that needs the access policy to the key vault. Possible values are User, SPN, Group, Application
  }
}

# KEY VAULT KEY
key_vault_key_variables = {
  "key_vault_key_01" = {
    key_vault_name                = "ploceuskeyvault000001"                                          #(Required) The name of the Key Vault where the Key should be created.
    key_vault_resource_group_name = "ploceusrg000002"                                                #(Required) The resource group name of the Key Vault where the Key should be created.
    key_vault_key_name            = "ploceuskvkey000001"                                             #(Required) Specifies the name of the Key Vault Key.
    key_vault_key_key_type        = "RSA"                                                            #(Required) Specifies the Key Type to use for this Key Vault Key. Possible values are EC (Elliptic Curve), EC-HSM, RSA and RSA-HSM.
    key_vault_key_key_size        = 2048                                                             #(Optional) Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048. Note: This field is required if key_type is RSA or RSA-HSM.
    key_vault_key_curve           = null                                                             #(Optional) Specifies the curve to use when creating an EC key. Possible values are P-256, P-256K, P-384, and P-521. This field will be required in a future release if key_type is EC or EC-HSM. The API will default to P-256 if nothing is specified.
    key_vault_key_key_opts        = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"] #(Required) A list of JSON web key operations. Possible values include: decrypt, encrypt, sign, unwrapKey, verify and wrapKey. Please note these values are case sensitive.
    key_vault_key_not_before_date = "2023-01-05T18:15:30Z"                                           #(Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_key_expiration_date = "2023-05-05T18:15:30Z"                                           #(Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_key_rotation_policy = {                                                                #(Optional) A rotation_policy block as defined below.
      rotation_policy_expire_after         = "P90D"                                                  #(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration.
      rotation_policy_notify_before_expiry = "P29D"                                                  #(Optional) Notify at a given duration before expiry as an ISO 8601 duration. Default is P30D.
      rotation_policy_automatic = {                                                                  #(Optional) An automatic block as defined below.
        automatic_time_after_creation = "P50D"                                                       #(Optional) Rotate automatically at a duration after create as an ISO 8601 duration.
        automatic_time_before_expiry  = "P30D"                                                       #(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration.
      }
    }
    key_vault_key_tags = { #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus"
      Department = "CIS"
    }
  }
}

#KEY VAULT SECRET
key_vault_secret_variables = {
  "key_vault_secret_1" = {
    key_vault_name                       = "ploceuskeyvault000001"       #(Required) Specifies the name of the Key Vault.
    key_vault_secret_value               = "ploceusvalue000001"          #(Required) Specifies the value of the Key Vault Secret
    key_vault_secret_content_type        = ""                            #(Optional) Specifies the content type for the Key Vault Secret
    key_vault_secret_not_before_date     = null                          #(Optional) Specifies that the key is not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_expiration_date     = null                          #(Optional) Specifies the expiration UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_resource_group_name = "ploceusrg000002"             #(Required) Specifies the name of the resource group, where the key_vault resides in
    key_vault_secret_name                = "ploceuskeyvaultsecret000001" #(Required) Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created
    key_vault_secret_tags = {                                            #(Optional) A mapping of tags which should be assigned to the key vault secret.

      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_secret_min_upper   = 10 #(Optional)(Number) Minimum number of uppercase alphabet characters in the result. Default value is 0
    key_vault_secret_min_lower   = 5  #(Optional)(Number) Minimum number of lowercase alphabet characters in the result. Default value is 0
    key_vault_secret_min_numeric = 5  #(Optional)(Number) Minimum number of numeric characters in the result. Default value is 0
    key_vault_secret_min_special = 3  #(Optional)(Number) Minimum number of special characters in the result. Default value is 0
    key_vault_secret_length      = 32 #(Optional)(Number) The length of the string desired. The minimum value for length is 1 and, length must also be >= (min_upper + min_lower + min_numeric + min_special)
  }
}

#KEY VAULT CERTIFICATE
key_vault_certificate_variables = {
  "key_vault_certificate_1" = {
    key_vault_certificate_name                          = "ploceuskeyvaultcertificate000001" #(Required) Specifies the name of the Key Vault Certificate. Changing this forces a new resource to be created.
    key_vault_certificate_key_vault_name                = "ploceuskeyvault000001"            #(Required) The name of the Key Vault where the Certificate should be created.
    key_vault_certificate_key_vault_resource_group_name = "ploceusrg000002"                  #(Required) The resource group name of the Key Vault where the Certificate should be created.

    key_vault_certificate_password_secret_name      = null  #(Optional) The password associated with the certificate. Use this if you are using an existing certificate stored in key vault, add password as a secret in key vault to fetch.
    key_vault_certificate_contents_secret_name      = null  #(Optional) The base64-encoded certificate contents stored as a secret in key vault. Provide this when 'key_vault_certificate_fetch_certificate_enabled' is true
    key_vault_certificate_fetch_certificate_enabled = false #(Required) If true, certificate from key vault will be used, otherwise a new certificate will be created and 'key_vault_certificate_certificate_policy' is required. Defaults to false
    key_vault_certificate_file_path                 = null  #(Optional) This is required when you are not specifying 'key_vault_certificate_contents_secret_name', you can give in a relative file path to pointing to your certificate.
    key_vault_certificate_certificate_policy = {            #(Optional) A `certificate_policy` block as defined below. Required when 'key_vault_certificate_fetch_certificate_enabled' is true. Changing this will create a new version of the Key Vault Certificate.
      certificate_policy_issuer_parameters = {              #(Required) A `issuer_parameters` block as defined below.
        issuer_parameters_name = "Self"                     #(Required) The name of the Certificate Issuer. Possible values include `Self` (for self-signed certificate), or `Unknown` (for a certificate issuing authority like `Let's Encrypt` and Azure direct supported ones). Changing this forces a new resource to be created.
      }
      certificate_policy_key_properties = { #(Required) A `key_properties` block as defined below.
        key_properties_curve      = null    #(Optional) Specifies the curve to use when creating an `EC` key. Possible values are `P-256`, `P-256K`, `P-384`, and `P-521`. This field will be required in a future release if `key_type` is `EC` or `EC-HSM`. Changing this forces a new resource to be created.
        key_properties_exportable = true    #(Required) Is this certificate exportable? Changing this forces a new resource to be created.
        key_properties_key_size   = 2048    #(Optional) The size of the key used in the certificate. Possible values include `2048`, `3072`, and `4096` for `RSA` keys, or `256`, `384`, and `521` for `EC` keys. This property is required when using RSA keys. Changing this forces a new resource to be created.
        key_properties_key_type   = "RSA"   #(Required) Specifies the type of key. Possible values are `EC`, `EC-HSM`, `RSA`, `RSA-HSM` and `oct`. Changing this forces a new resource to be created.
        key_properties_reuse_key  = true    #(Required) Is the key reusable? Changing this forces a new resource to be created.
      }
      certificate_policy_lifetime_action = { #(Optional) A `lifetime_action` block as defined below.
        lifetime_action_action = {           #(Required) A `action` block as defined below.
          action_type = "AutoRenew"          #(Required) The Type of action to be performed when the lifetime trigger is triggerec. Possible values include `AutoRenew` and `EmailContacts`. Changing this forces a new resource to be created.
        }
        lifetime_action_trigger = {          #(Required) A `trigger` block as defined below.
          trigger_days_before_expiry  = null #(Optional) The number of days before the Certificate expires that the action associated with this Trigger should run. Changing this forces a new resource to be created. Conflicts with `lifetime_percentage`.
          trigger_lifetime_percentage = 90   #(Optional) The percentage at which during the Certificates Lifetime the action associated with this Trigger should run. Changing this forces a new resource to be created. Conflicts with `days_before_expiry`.
        }
      }
      certificate_policy_secret_properties = {                    #(Required) A `secret_properties` block as defined below.
        secret_properties_content_type = "application/x-pem-file" #(Required) The Content-Type of the Certificate, such as `application/x-pkcs12` for a PFX or `application/x-pem-file` for a PEM. Changing this forces a new resource to be created.
      }
      certificate_policy_x509_certificate_properties = {                       #(Optional) A `x509_certificate_properties` block as defined below. Required when `certificate` block is not specified.
        x509_certificate_properties_extended_key_usage = ["1.3.6.1.5.5.7.3.1"] #(Optional) A list of Extended/Enhanced Key Usages. Changing this forces a new resource to be created.

        #(Required) A list of uses associated with this Key. Possible values include `cRLSign`, `dataEncipherment`, `decipherOnly`, `digitalSignature`, `encipherOnly`, `keyAgreement`, `keyCertSign`, `keyEncipherment` and `nonRepudiation` and are case-sensitive. Changing this forces a new resource to be created.
        x509_certificate_properties_key_usage          = ["cRLSign", "dataEncipherment", "decipherOnly", "digitalSignature", "encipherOnly", "keyAgreement", "keyCertSign", "keyEncipherment", "nonRepudiation"]
        x509_certificate_properties_subject            = "CN=ploceus.com"                              #(Required) The Certificate's Subject. Changing this forces a new resource to be created.
        x509_certificate_properties_validity_in_months = 12                                            #(Required) The Certificates Validity Period in Months. Changing this forces a new resource to be created.
        x509_certificate_properties_subject_alternative_names = {                                      #(Optional) A `subject_alternative_names` block as defined below. Changing this forces a new resource to be created.
          subject_alternative_names_dns_names = null                                                   #(Optional) A list of alternative DNS names (FQDNs) identified by the Certificate. Changing this forces a new resource to be created.
          subject_alternative_names_emails    = ["XXXXxxxxxxx@ploceus.com", "XXXXXXXXXXX@ploceus.org"] #(Optional) A list of email addresses identified by this Certificate. Changing this forces a new resource to be created.
          subject_alternative_names_upns      = null                                                   #(Optional) A list of User Principal Names identified by the Certificate. Changing this forces a new resource to be created.
        }
      }
    }
    key_vault_certificate_tags = { #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#RESOURCE GROUP FOR AKS CLUSTER
resource_group_aks_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000003" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location = "westus2"         #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_managed_by = "ploceus" #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#VIRTUAL NETWORK
virtual_network_variables = {
  "virtual_network_1" = {
    virtual_network_name                    = "ploceusvnet000001"         #(Required) The name of the virtual network.
    virtual_network_location                = "westus2"                   #(Required) The location/region where the virtual network is created.
    virtual_network_resource_group_name     = "ploceusrg000003"           #(Required) The name of the resource group in which to create the virtual network.
    virtual_network_address_space           = ["10.30.0.0/16"]            #(Required) The address space that is used the virtual network.
    virtual_network_dns_servers             = null                        #(Optional) List of IP addresses of DNS servers.Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it.
    virtual_network_flow_timeout_in_minutes = null                        #(Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = null                        #(Optional) The BGP community attribute in format <as-number>:<community-value>.The as-number segment is the Microsoft ASN, which is always 12076 for now.
    virtual_network_edge_zone               = null                        #(Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_ddos_protection_plan = {                              #(Optional block) provide true for virtual_network_ddos_protection_enable incase ddos_protection needs to be enabled.
      virtual_network_ddos_protection_enable    = false                   #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = "ploceusddosplan000001" #(Required) Needed for ddos protection plan id.Provide the name of the ddos protection plan if above enable is true
    }
    virtual_network_encryption = null
    virtual_network_subnet     = null #(Optional) Can be specified multiple times to define multiple subnets
    virtual_network_tags = {          #(Optional) A mapping of tags which should be assigned to the virtual network.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#USER ASSIGNED IDENTITY
user_assigned_identity_variables = {
  "uai1" = {
    user_assigned_identity_name                = "ploceusuai000001" #(Required) Specifies the name of this User Assigned Identity. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_location            = "westus2"          #(Required) The Azure Region where the User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_resource_group_name = "ploceusrg000003"  #Required) Specifies the name of the Resource Group within which this User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#SUBNET
subnet_variables = {
  "subnet_1" = {
    subnet_name                                           = "ploceussubnet000001" #(Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                            = "ploceusrg000003"     #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                               = ["10.30.1.0/24"]      #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                           = "ploceusvnet000001"   #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled  = true                  #(Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled      = null                  #(Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_enforce_private_link_endpoint_network_policies = true                  #(Optional) Enable or Disable network policies for the private link endpoint on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false.
    subnet_enforce_private_link_service_network_policies  = null                  #(Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false.
    subnet_service_endpoint_policy_ids                    = null                  #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                              = null                  #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation                                            = null
  }
}

#KUBERNETES CLUSTER
kubernetes_cluster_variables = {
  "aks_1" = {
    kubernetes_cluster_name                                                            = "ploceusaks000001"      #(Required) The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created.
    kubernetes_cluster_location                                                        = "westus2"               #(Required) The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created.
    kubernetes_cluster_resource_group_name                                             = "ploceusrg000003"       # (Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_key_vault_name                                                  = "ploceuskeyvault000001" #(Optional) Incase if any secret value is passed for linux_profile, windows_profile, azure_active_directory_role_based_access_control(azure_active_directory_role_based_access_control_server_app_secret) or service_principal(client_secret). Pass null if not required
    kubernetes_cluster_key_vault_resource_group_name                                   = "ploceusrg000002"       #(Optional) To be provided for the kubernetes_cluster_key_vault_name  resource group
    kubernetes_cluster_key_vault_certificate_name                                      = null                    #(Optional) Specifies the name of the Key Vault Certificate which contain the list of up to 10 base64 encoded CAs that will be added to the trust store on nodes with the custom_ca_trust_enabled feature enabled.
    kubernetes_cluster_default_node_pool_name                                          = "pool000001"
    kubernetes_cluster_default_node_pool_capacity_reservation_group_name               = null                #(Optional) provide the linux kubernetes_cluster capacity reservation group name
    kubernetes_cluster_default_node_pool_capacity_reservation_resource_group_name      = null                #(Optional) provide the capacity reservation group resource group name
    kubernetes_cluster_default_node_pool_vm_size                                       = "standard_d2pds_v5" #(Required) The size of the Virtual Machine, such as Standard_DS2_v2. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_custom_ca_trust_enabled                       = false               #(Optional) Specifies whether to trust a Custom CA.
    kubernetes_cluster_default_node_pool_key_vault_certificate_name                    = null                #(Optional) Specifies the name of the Key Vault Certificate. If kubernetes_cluster_default_node_pool_custom_ca_trust_enabled = true, then this is Required.
    kubernetes_cluster_default_node_pool_enable_auto_scaling                           = false               #(Optional) Should the Kubernetes Auto Scaler be enabled for this Node Pool? Defaults to false. This requires that the type is set to VirtualMachineScaleSets
    kubernetes_cluster_default_node_pool_workload_runtime                              = "OCIContainer"      #(Optional) Specifies the workload runtime used by the node pool. Possible values are OCIContainer and KataMshvVmIsolation.
    kubernetes_cluster_default_node_pool_enable_host_encryption                        = false               #(Optional) Should the nodes in the Default Node Pool have host encryption enabled? Defaults to false
    kubernetes_cluster_default_node_pool_enable_node_public_ip                         = false               #(Optional) Should nodes in this Node Pool have a Public IP Address? Defaults to false. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_kubelet_config                                = null
    kubernetes_cluster_default_node_pool_linux_os_config                               = null
    kubernetes_cluster_default_node_pool_fips_enabled                                  = false #(Optional) Should the nodes in this Node Pool have Federal Information Processing Standard enabled? Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_kubelet_disk_type                             = null  #(Optional) The type of disk used by kubelet. Possible values are OS and Temporary.
    kubernetes_cluster_default_node_pool_max_pods                                      = 30    # (Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created.
    kubernetes_cluster_message_of_the_day                                              = null  # (Optional) A base64-encoded string which will be written to /etc/motd after decoding. This allows customization of the message of the day for Linux nodes. It cannot be specified for Windows nodes and must be a static string (i.e. will be printed raw and not executed as a script). Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_node_public_ip_prefix_name                    = null  #(Optional) Resource ID for the Public IP Addresses Prefix for the nodes in this Node Pool. enable_node_public_ip should be true. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_node_public_ip_prefix_resource_group_name     = null
    kubernetes_cluster_default_node_pool_is_host_group_id_required                     = false        #(Required)Boolean value if host group id required
    kubernetes_cluster_default_node_pool_dedicated_host_group_name                     = null         #(Optional) Specifies the Name of the Host Group within which this AKS Cluster should be created.
    kubernetes_cluster_default_node_pool_dedicated_host_group_resource_group_name      = null         #(Optional) Specifies the Resource Group Name of the Host Group
    kubernetes_cluster_default_node_pool_node_labels                                   = null         #(Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool.
    kubernetes_cluster_default_node_pool_only_critical_addons_enabled                  = false        #(Optional) Enabling this option will taint default node pool with CriticalAddonsOnly=true:NoSchedule taint. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_orchestrator_version                          = null         #(Optional) Version of Kubernetes used for the Agents. If not specified, the default node pool will be created with the version specified by kubernetes_version. If both are unspecified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). This version must be supported by the Kubernetes Cluster - as such the version of Kubernetes used on the Cluster/Control Plane may need to be upgraded first.
    kubernetes_cluster_default_node_pool_os_disk_size_gb                               = null         #(Optional) The size of the OS Disk which should be used for each agent in the Node Pool. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_os_disk_type                                  = null         #(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_os_sku                                        = null         #(Optional) OsSKU to be used to specify Linux OSType. Not applicable to Windows OSType. Possible values include: Ubuntu, CBLMariner. Defaults to Ubuntu. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_is_proximity_placement_group_id_required      = false        #(Required)Boolean value if proximity placement group id required
    kubernetes_cluster_default_node_pool_proximity_placement_group_name                = null         #(Optional) Provide proximity placement group name if kubernetes_cluster_is_proximity_placement_group_id_required is set to true
    kubernetes_cluster_default_node_pool_proximity_placement_group_resource_group_name = null         #(Optional) Provide proximity placement group resource group name if kubernetes_cluster_is_proximity_placement_group_id_required is set to true
    kubernetes_cluster_default_node_pool_pod_virtual_network_name                      = null         #(Optional) The name of the Subnet where the pods in the default Node Pool should exist.
    kubernetes_cluster_default_node_pool_pod_subnet_name                               = null         #(Optional) The name of the Subnet where the pods in the default Node Pool should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_pod_scale_down_mode                           = "Deallocate" #(Optional) Specifies the autoscaling behaviour of the Kubernetes Cluster. Allowed values are Delete and Deallocate. Defaults to Delete.
    kubernetes_cluster_default_node_pool_is_snapshot_id_required                       = false        #(Required)Boolean value if snapshot id required
    kubernetes_cluster_default_node_pool_snapshot_name                                 = null         #(Optional) Provide snapshot name if kubernetes_cluster_default_node_pool_is_snapshot_id_required is set to true
    kubernetes_cluster_default_node_pool_snapshot_resource_group_name                  = null         #(Optional) Provide snapshot resource group name if kubernetes_cluster_default_node_pool_is_snapshot_id_required is set to true
    kubernetes_cluster_default_node_pool_temporary_name_for_rotation                   = null         #(Optional) Specifies the name of the temporary node pool used to cycle the default node pool for VM resizing.
    kubernetes_cluster_default_node_pool_pod_virtual_network_resource_group_name       = null         #(Optional) The name of the resource_group where the pods in the default Node Pool should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_type                                          = null         #(Optional) The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets. Defaults to VirtualMachineScaleSets.
    kubernetes_cluster_default_node_pool_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
    kubernetes_cluster_default_node_pool_ultra_ssd_enabled                   = false #(Optional) Used to specify whether the UltraSSD is enabled in the Default Node Pool. Defaults to false
    kubernetes_cluster_node_network_profile                                  = null  #(Optional) Node Network Profile for Kubernetes Cluster
    kubernetes_cluster_default_node_pool_upgrade_settings                    = null
    kubernetes_cluster_default_node_pool_virtual_network_name                = "ploceusvnet000001" #(Optional) Name of VNet for assigning default node pool to a subnet
    kubernetes_cluster_default_node_pool_virtual_network_resource_group_name = "ploceusrg000003"
    kubernetes_cluster_default_node_pool_subnet_name                         = "ploceussubnet000001" #(Optional) Name of Subnet for assigning default node pool to a subnet . A Route Table must be configured on this Subnet.
    kubernetes_cluster_default_node_pool_max_count                           = null                  #(Optional) The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000.
    kubernetes_cluster_default_node_pool_min_count                           = null                  #(Optional) The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000
    kubernetes_cluster_default_node_pool_node_count                          = 2                     #(Optional) The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 and between min_count and max_count.
    kubernetes_cluster_default_node_pool_availability_zones                  = null                  #(Optional) Specifies a list of Availability Zones in which this Kubernetes Cluster should be located. Changing this forces a new Kubernetes Cluster to be created.
    kubernetes_cluster_dns_prefix                                            = "ploceusdnsprefix"    #(Optional) DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created. One of dns_prefix or dns_prefix_private_cluster must be specified. The dns_prefix must contain between 3 and 45 characters, and can contain only letters, numbers, and hyphens. It must start with a letter and must end with a letter or a number.
    kubernetes_cluster_dns_prefix_private_cluster                            = null                  #"ploceus"      #(Optional) Specifies the DNS prefix to use with private clusters. Changing this forces a new resource to be created. One of dns_prefix or dns_prefix_private_cluster must be specified. The dns_prefix must contain between 3 and 45 characters, and can contain only letters, numbers, and hyphens. It must start with a letter and must end with a letter or a number.
    kubernetes_cluster_aci_connector_linux                                   = null
    kubernetes_cluster_automatic_channel_upgrade                             = null #(Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, node-image and stable. Omitting this field sets this value to none. Cluster Auto-Upgrade will update the Kubernetes Cluster (and its Node Pools) to the latest GA version of Kubernetes automatically and will not update to Preview versions.
    kubernetes_cluster_api_server_authorized_ip_ranges                       = null # (Optional) The IP ranges to allow for incoming traffic to the server nodes.
    kubernetes_cluster_api_server_access_profile                             = null
    kubernetes_cluster_auto_scaler_profile                                   = null
    kubernetes_cluster_confidential_computing                                = null
    kubernetes_cluster_azure_active_directory_role_based_access_control      = null
    kubernetes_cluster_azure_policy_enabled                                  = false #(Optional) Should the Azure Policy Add-On be enabled
    kubernetes_cluster_disk_encryption_set_name                              = null  #(Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes. Set to null if not required.
    kubernetes_cluster_disk_encryption_set_resource_group_name               = null
    kubernetes_cluster_edge_zone                                             = null  #(Optional) Specifies the Edge Zone within the Azure Region where this Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_http_application_routing_enabled                      = false #(Optional) Should HTTP Application Routing be enabled
    kubernetes_cluster_image_cleaner_enabled                                 = false #(Optional) Specifies whether Image Cleaner is enabled.
    kubernetes_cluster_image_cleaner_interval_hours                          = null  #(Optional) Specifies the interval in hours when images should be cleaned up. Defaults to 48.
    kubernetes_cluster_http_proxy_config                                     = null
    kubernetes_cluster_identity = {  #One of either identity or service_principal must be specified. Assign null if not required. Defines the kubernetes cluster identity to be used
      identity_type = "UserAssigned" #(Required) Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      identity_ids = [{
        identity_name = "ploceusuai000001"
      identity_resource_group_name = "ploceusrg000003" }]
    }
    kubernetes_cluster_ingress_application_gateway = null
    #  {                                  #(Optional) Assign null if not required. Defines AGIC ingress controller application gateway
    #   ingress_application_gateway_exists                     = false                    #Required Assign true if the application gateway already exists. Assign false if new Application gateway needs to be created
    #   ingress_application_gateway_name                       = "ploceusapgwingressctrl" #Required  The name of the Application Gateway to be used or created in the Nodepool Resource Group, which in turn will be integrated with the ingress controller of this Kubernetes Cluster.
    #   ingress_application_gateway_resource_group_name        = "ploceusrg000001"
    #   ingress_application_gateway_subnet_exists              = false #Required. Assign true if the application gateway already exists. Assign false if new Application gateway needs to be created
    #   ingress_application_gateway_subnet_cidr                = null  #(Optional) The subnet CIDR to be used to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. Pass this value or either ingress_application_gateway_subnet_name
    #   ingress_application_gateway_subnet_name                = null  #(Optional) The name of the subnet on which to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. Pass this value or either ingress_application_gateway_subnet_cidr
    #   ingress_application_gateway_subnet_resource_group_name = null
    #   ingress_application_gateway_virtual_network_name       = null
    # }
    kubernetes_cluster_key_management_service     = null
    kubernetes_cluster_key_vault_secrets_provider = null
    kubernetes_cluster_kubelet_identity           = null
    kubernetes_cluster_kubernetes_version         = null #(Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). AKS does not require an exact patch version to be specified, minor version aliases such as 1.22 are also supported. - The minor version's latest GA patch is automatically chosen in that case.
    kubernetes_cluster_linux_profile              = null

    // {                                  #(Optional) Pass as null if not required. Changing any parameter forces a new resource to be created.
    //   linux_profile_admin_username_key_vault_secret_name = null           #(Required) Pass the secret name where the adminuser name is stored. Pass null if not stored in key vault
    //   linux_profile_admin_username                       = "adminuser"    #(Optional) The Admin Username for the Cluster if it is not present in key vault
    //   linux_profile_ssh_key_secret_exist                 = false          #(Required) Set true if the public key is present in key vault. Set false where a new public and private key is generated. Public key will be stored in name provided in linux_profile_ssh_key_secret_name, private key will be stored in the same secret name appended with private. Keys generated using RSA algo with 4096 rsa bits
    //   linux_profile_ssh_key_secret_name                  = "secretsshkey" #(Required) If linux_profile_ssh_key_secret_exist is true then the secret is fetched from the given secret name else the new public key generated is stored in given secret name
    // }
    kubernetes_cluster_local_account_disabled          = false #(Optional) If true local accounts will be disabled. Defaults to false. If local_account_disabled is set to true, it is required to enable Kubernetes RBAC and AKS-managed Azure AD integration.
    kubernetes_cluster_maintenance_window              = null
    kubernetes_cluster_maintenance_window_auto_upgrade = null
    kubernetes_cluster_maintenance_window_node_os      = null
    kubernetes_cluster_microsoft_defender              = null
    kubernetes_cluster_monitor_metrics                 = null #(Optional) Specifies a Prometheus add-on profile for the Kubernetes Cluster.
    kubernetes_cluster_network_profile = {
      network_profile_network_plugin        = "azure" #(Required) Network plugin to use for networking. Currently supported values are azure, kubenet and none. Changing this forces a new resource to be created.When network_plugin is set to azure - the vnet_subnet_id field in the default_node_pool block must be set and pod_cidr must not be set.
      network_profile_network_mode          = null    #(Optional) Network mode to be used with Azure CNI. Possible values are bridge and transparent. Changing this forces a new resource to be created. network_mode can only be set to bridge for existing Kubernetes Clusters and cannot be used to provision new Clusters - this will be removed by Azure in the future. This property can only be set when network_plugin is set to azure
      network_profile_network_policy        = "azure" #(Optional) Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created. When network_policy is set to azure, the network_plugin field can only be set to azure.
      network_profile_dns_service_ip        = null    #(Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created.
      network_profile_ebpf_data_plane       = null    #(Optional) Specifies the eBPF data plane used for building the Kubernetes network. Possible value is cilium. Disabling this forces a new resource to be created.
      network_profile_network_plugin_mode   = null    #(Optional) Specifies the network plugin mode used for building the Kubernetes network. Possible value is overlay.
      network_profile_outbound_type         = null    #(Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer, userDefinedRouting, managedNATGateway and userAssignedNATGateway. Defaults to loadBalancer.
      network_profile_pod_cidr              = null    #(Optional) The CIDR to use for pod IP addresses. This field can only be set when network_plugin is set to kubenet. Changing this forces a new resource to be created.
      network_profile_pod_cidrs             = null    # (Optional) A list of CIDRs to use for pod IP addresses. For single-stack networking a single IPv4 CIDR is expected. For dual-stack networking an IPv4 and IPv6 CIDR are expected. Changing this forces a new resource to be created.
      network_profile_service_cidr          = null    #(Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created. This range should not be used by any network element on or connected to this VNet. Service address CIDR must be smaller than /12. docker_bridge_cidr, dns_service_ip and service_cidr should all be empty or all should be set.
      network_profile_service_cidrs         = null    # (Optional) A list of CIDRs to use for Kubernetes services. For single-stack networking a single IPv4 CIDR is expected. For dual-stack networking an IPv4 and IPv6 CIDR are expected. Changing this forces a new resource to be created.
      network_profile_ip_versions           = null    #(Optional) Specifies a list of IP versions the Kubernetes Cluster will use to assign IP addresses to its nodes and pods. Possible values are IPv4 and/or IPv6. IPv4 must always be specified. Changing this forces a new resource to be created. To configure dual-stack networking ip_versions should be set to ["IPv4", "IPv6"]
      network_profile_load_balancer_sku     = null    #(Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard. Defaults to standard. (Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard. Defaults to standard. Changing this forces a new resource to be created.
      network_profile_load_balancer_profile = null
      network_profile_nat_gateway_profile   = null
    }
    kubernetes_cluster_node_os_channel_upgrade              = null  #(Optional) The upgrade channel for this Kubernetes Cluster Nodes' OS Image. Possible values are Unmanaged, SecurityPatch, NodeImage and None.
    kubernetes_cluster_node_resource_group_name             = null  #(Optional) The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created. Azure requires that a new, non-existent Resource Group is used, as otherwise the provisioning of the Kubernetes Service will fail.
    kubernetes_cluster_oidc_issuer_enabled                  = false #(Required) Enable or Disable the OIDC issuer URL
    kubernetes_cluster_oms_agent                            = null
    kubernetes_cluster_service_mesh_profile                 = null
    kubernetes_cluster_open_service_mesh_enabled            = false                           #(Optional) Open Service Mesh needs to be enabled
    kubernetes_cluster_private_cluster_enabled              = true                            #(Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created.
    kubernetes_cluster_private_dns_zone_name                = "privatelink.westus2.azmk8s.io" #"private.eastus2.azmk8s.io"  #(Optional)Use when kubernetes_cluster_private_cluster_enabled is set to true. Either the Name of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None. In case of None you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning. Changing this forces a new resource to be created.
    kubernetes_cluster_private_dns_zone_resource_group_name = "ploceusrg000003"               #(Optional)Resource Group name for kubernetes_cluster_private_dns_zone_name.
    kubernetes_cluster_private_cluster_public_fqdn_enabled  = false                           #(Optional) Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to false.
    kubernetes_cluster_workload_autoscaler_profile          = null
    # {                                        #(Optional) A workload_autoscaler_profile block defined below.
    #   workload_autoscaler_profile_keda_enabled = false                                        #(Optional) Specifies whether KEDA Autoscaler can be used for workloads.
    #   workload_autoscaler_profile_vertical_pod_autoscaler_enabled = bool #(Optional) Specifies whether Vertical Pod Autoscaler should be enabled.

    # }
    kubernetes_cluster_workload_identity_enabled         = false #(Optional) Specifies whether Azure AD Workload Identity should be enabled for the Cluster. Defaults to false
    kubernetes_cluster_public_network_access_enabled     = false #(Optional) Whether public network access is allowed for this Kubernetes Cluster. Defaults to true. Changing this forces a new resource to be created. When public_network_access_enabled is set to true, 0.0.0.0/32 must be added to api_server_authorized_ip_ranges
    kubernetes_cluster_role_based_access_control_enabled = true  #(Optional) - Whether Role Based Access Control for the Kubernetes Cluster should be enabled. Defaults to true. Changing this forces a new resource to be created.
    kubernetes_cluster_run_command_enabled               = false #(Optional) Whether to enable run command for the cluster or not. Defaults to true
    kubernetes_cluster_service_principal                 = null
    kubernetes_cluster_storage_profile                   = null
    kubernetes_cluster_sku_tier                          = "Free" #Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free.
    kubernetes_cluster_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
    kubernetes_cluster_web_app_routing = null #(Optional) A web_app_routing block as defined below
    #   web_app_routing_dns_zone_name = "ploceusdns000001"                      #(Required) Specifies the ID of the DNS Zone in which DNS entries are created for applications deployed to the cluster when Web App Routing is enabled.
    #   web_app_routing_dns_zone_resource_group = "ploceusrg000001"             #(Required) Specifies the ID of the DNS Zone in which DNS entries are created for applications deployed to the cluster when Web App Routing is enabled.
    # }
    kubernetes_cluster_windows_profile = {                                                 #(Optional) Pass as null if not required. Changing any parameter forces a new resource to be created.
      windows_profile_admin_username_key_vault_secret_name = "ploceuskeyvaultsecret000001" #(Required) Pass the secret name where the adminuser name is stored. Pass null if not stored in key vault
      windows_profile_admin_username                       = "admin123"                    #(Optional) The Admin Username for the Windows VMs if not present in key vault
      windows_profile_admin_password_secret_exist          = false                         #(Required) Set true if the password is present in key vault else new password will be generated
      windows_profile_admin_password_secret_name           = "akssecret111"                #(Required) If windows_profile_admin_password_secret_exist is true then the Admin Password is read from given secret else the new generated password is stored in the given secret. Length must be between 14 and 123 characters.
      windows_profile_admin_password_length                = 14                            #(Required) Password Length. Length must be between 14 and 123 characters. Password generated will contain minimum of 4 lower case, 4 upper case, 2 numeric and 2 special character
      windows_profile_license                              = "Windows_Server"              #(Optional) Specifies the type of on-premise license which should be used for Node Pool Windows Virtual Machine. At this time the only possible value is Windows_Server
      kubernetes_cluster_gmsa                              = null
      #     gmsa_dns_server       =   #(Required) Specifies the DNS server for Windows gMSA. Set this to an empty string if you have configured the DNS server in the VNet which was used to create the managed cluster.
      #     gmsa_root_domain      =   #(Required) Specifies the root domain name for Windows gMSA. Set this to an empty string if you have configured the DNS server in the VNet which was used to create the managed cluster.
      #   }
    }
  }

}

key_vault_subscription_id                   = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
key_vault_tenant_id                         = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
kubernetes_cluster_subscription_id          = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
kubernetes_cluster_tenant_id                = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
log_analytics_oms_subscription_id           = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
log_analytics_oms_tenant_id                 = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
log_analytics_defender_subscription_id      = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
log_analytics_defender_tenant_id            = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
private_dns_zone_subscription_id            = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
private_dns_zone_tenant_id                  = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
user_assigned_identity_subscription_id      = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
user_assigned_identity_tenant_id            = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
ingress_application_gateway_subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
ingress_application_gateway_tenant_id       = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"