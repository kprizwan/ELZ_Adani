#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name       = "ploceusrg000001" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = "eastus"          #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = "ploceus"         #(Optional) The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {                       #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  },
  "resource_group_2" = {
    resource_group_name       = "ploceusrg000002" #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location   = "eastus"          #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = "ploceus"         #(Optional) The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {                       #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#USER ASSIGNED IDENTITY
user_assigned_identity_variables = {
  "user_assigned_identity_1" = {
    user_assigned_identity_name                = "ploceusuai000001" #(Required) Specifies the name of this User Assigned Identity. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_location            = "eastus"           #(Required) The Azure Region where the User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_resource_group_name = "ploceusrg000001"  #(Required) Specifies the name of the Resource Group within which this User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_tags = {                                 #(Optional) A mapping of tags which should be assigned to the User Assigned Identity.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#KEY VAULT
key_vault_variables = {
  "key_vault_1" = {
    key_vault_name                                  = "ploceuskeyvault000001" #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_location                              = "eastus"                #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_resource_group_name                   = "ploceusrg000002"       #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_enabled_for_disk_encryption           = true                    #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = true                    #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = true                    #(Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = false                   #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = "7"                     #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = false                   #(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
    key_vault_sku_name                              = "standard"              #(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium
    key_vault_access_container_agent_name           = null                    #(Optional) Self hosted conatiner agent name.
    key_vault_access_policy_application_id          = null                    #(Optional) The object ID of an Application in Azure Active Directory.
    key_vault_public_network_access_enabled         = true                    #(Optional) key_vault_public_network_access_enabled
    key_vault_access_policy_key_permissions         = []                      #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey.
    key_vault_access_policy_secret_permissions      = []                      #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                      #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = []                      #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_tags = {                                                        #(Optional) A mapping of tags which should be assigned to the key vault.
      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_network_acls_enabled          = false                #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass           = "AzureServices"      #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action   = "Deny"               #(Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
    key_vault_network_acls_ip_rules         = null                 #(Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.
    key_vault_network_acls_virtual_networks = []                   #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
    key_vault_contact_information_enabled   = false                #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email                 = "xxxxxx@ploceus.com" #(Required) E-mail address of the contact.
    key_vault_contact_name                  = null                 #(Optional) Name of the contact.
    key_vault_contact_phone                 = null                 #(Optional) Phone number of the contact.
  }
}

#KEY VAULT ACCESS POLICY
key_vault_access_policy_variables = {
  "key_vault_access_policy_1" = {
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Update", "Recover", "Backup", "Restore", "Purge", "GetRotationPolicy", "SetRotationPolicy"]                                                                #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge", "Set"]                                                                                                                       #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"] #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_name                                  = "ploceuskeyvault000001"                                                                                                                                                                         #(Required) Specifies the name of the Key Vault resource.
    key_vault_resource_group_name                   = "ploceusrg000002"                                                                                                                                                                               #(Required) Specifies the resource group name where the key vault resides in.
    key_vault_access_resource_name                  = "xxxxxx@ploceus.com"                                                                                                                                                                            #(Required) Specifies the resource name that needs an access policy to the key vault. Possible values are username, group name, service principal name and application name
    key_vault_access_resource_type                  = "User"                                                                                                                                                                                          #(Required) Specifies the type of resource that needs the access policy to the key vault. Possible values are User, SPN, Group, Application
  },
  "key_vault_access_policy_2" = {
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Update", "Recover", "Backup", "Restore", "Purge", "GetRotationPolicy", "SetRotationPolicy"]                                                                #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge", "Set"]                                                                                                                       #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"] #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_name                                  = "ploceuskeyvault000001"                                                                                                                                                                         #(Required) Specifies the name of the Key Vault resource.
    key_vault_resource_group_name                   = "ploceusrg000002"                                                                                                                                                                               #(Required) Specifies the resource group name where the key vault resides in.
    key_vault_access_resource_name                  = "ploceusuai000001"                                                                                                                                                                              #(Required) Specifies the resource name that needs an access policy to the key vault. Possible values are username, group name, service principal name and application name
    key_vault_access_resource_type                  = "SPN"                                                                                                                                                                                           #(Required) Specifies the type of resource that needs the access policy to the key vault. Possible values are User, SPN, Group, Application
  }
}

# KEY VAULT KEY
key_vault_key_variables = {
  "key_vault_key_1" = {
    key_vault_name                = "ploceuskeyvault000001"                                          #(Required) The name of the Key Vault where the Key should be created.
    key_vault_resource_group_name = "ploceusrg000002"                                                #(Required) The resource group name of the Key Vault where the Key should be created.
    key_vault_key_name            = "ploceuskvkey000001"                                             #(Required) Specifies the name of the Key Vault Key.
    key_vault_key_key_type        = "RSA"                                                            #(Required) Specifies the Key Type to use for this Key Vault Key. Possible values are EC (Elliptic Curve), EC-HSM, RSA and RSA-HSM.
    key_vault_key_key_size        = 2048                                                             #(Optional) Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048. Note: This field is required if key_type is RSA or RSA-HSM.
    key_vault_key_curve           = null                                                             #(Optional) Specifies the curve to use when creating an EC key. Possible values are P-256, P-256K, P-384, and P-521. This field will be required in a future release if key_type is EC or EC-HSM. The API will default to P-256 if nothing is specified.
    key_vault_key_key_opts        = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"] #(Required) A list of JSON web key operations. Possible values include: decrypt, encrypt, sign, unwrapKey, verify and wrapKey. Please note these values are case sensitive.
    key_vault_key_not_before_date = "2024-01-05T18:15:30Z"                                           #(Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_key_expiration_date = "2024-05-05T18:15:30Z"                                           #(Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z').
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

#VIRTUAL NETWORK
virtual_network_variables = {
  "virtual_network_1" = {
    virtual_network_name                    = "ploceusvnet000001"         #(Required) The name of the virtual network.
    virtual_network_location                = "eastus"                    #(Required) The location/region where the virtual network is created.
    virtual_network_resource_group_name     = "ploceusrg000001"           #(Required) The name of the resource group in which to create the virtual network.
    virtual_network_address_space           = ["10.0.0.0/16"]             #(Required) The address space that is used the virtual network.
    virtual_network_dns_servers             = null                        #(Optional) List of IP addresses of DNS servers.Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it.
    virtual_network_flow_timeout_in_minutes = null                        #(Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = null                        #(Optional) The BGP community attribute in format <as-number>:<community-value>.The as-number segment is the Microsoft ASN, which is always 12076 for now.
    virtual_network_edge_zone               = null                        #(Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_ddos_protection_plan = {                              #(Optional block) provide true for virtual_network_ddos_protection_enable incase ddos_protection needs to be enabled.
      virtual_network_ddos_protection_enable    = false                   #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = "ploceusddosplan000001" #(Required) Needed for ddos protection plan id.Provide the name of the ddos protection plan if above enable is true
    }
    virtual_network_encryption = [
      {
        virtual_network_encryption_enforcement = "AllowUnencrypted"
      }
    ]
    virtual_network_subnet = null #(Optional) Can be specified multiple times to define multiple subnets
    virtual_network_tags = {      #(Optional) A mapping of tags which should be assigned to the virtual network.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#SUBNET
subnet_variables = {
  "subnet_1" = {
    subnet_name                                          = "ploceussubnet000001"                                      #(Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "ploceusrg000001"                                          #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.0.1.0/24"]                                            #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "ploceusvnet000001"                                        #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled = null                                                       #(Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled     = null                                                       #(Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_service_endpoint_policy_ids                   = null                                                       #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                             = ["Microsoft.AzureActiveDirectory", "Microsoft.ServiceBus"] #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation = [{
      delegation_name            = "delegation000001"                                                                                                                                                                                                #(Required) A name for this delegation.
      service_delegation_name    = "Microsoft.Sql/managedInstances"                                                                                                                                                                                  #(Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"] #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }]
  }
}

#SERVICEBUS NAMESPACE
servicebus_namespace_variables = {
  "servicebus_namespace_1" = {
    servicebus_namespace_name                = "ploceussbns000001" #(Required) Specifies the name of the ServiceBus Namespace resource . Changing this forces a new resource to be created.
    servicebus_namespace_resource_group_name = "ploceusrg000001"   #(Required) The name of the resource group in which to create the namespace.
    servicebus_namespace_location            = "eastus"            #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    #Note: servicebus_namespace_sku 'Standard' does not support network rule set.
    servicebus_namespace_sku = "Standard"                  #(Required) Defines which tier to use. Options are Basic, Standard or Premium. Please note that setting this field to Premium will force the creation of a new resource.
    servicebus_namespace_identity = {                      #(Optional) An identity block as defined below.
      identity_type                     = "SystemAssigned" #(Required) Specifies the type of Managed Service Identity that should be configured on this ServiceBus Namespace. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      identity_user_assigned_identities = []
      /*Sample Code
       [{
        user_assigned_identities_name                = "ploceusuai000001" #(Optional) User assigned identity name. Provide value only if "identity_type" is set to UserAssigned or SystemAssigned, UserAssigned
        user_assigned_identities_resource_group_name = "ploceusrg000001" #(Optional) User assigned identity resource group name. Provide value only if "identity_type" is set to UserAssigned or SystemAssigned, UserAssigned
        }
      ] */
    }
    #Note: Service Bus SKU "Premium" only supports `capacity` of 1, 2, 4, 8 or 16
    servicebus_namespace_capacity             = 0 #(Optional) Specifies the capacity. When sku is Premium, capacity can be 1, 2, 4, 8 or 16. When sku is Basic or Standard, capacity can be 0 only.
    servicebus_namespace_customer_managed_key = null
    /*Sample Code
    {
      customer_managed_key_infrastructure_encryption_enabled = false #(Optional) Used to specify whether enable Infrastructure Encryption (Double Encryption).
    } */
    servicebus_namespace_local_auth_enabled               = true  #(Optional) Whether or not SAS authentication is enabled for the Service Bus namespace. Defaults to true.
    servicebus_namespace_public_network_access_enabled    = true  #(Optional) Is public network access enabled for the Service Bus Namespace? Defaults to true.
    servicebus_namespace_minimum_tls_version              = "1.2" #(Optional) The minimum supported TLS version for this Service Bus Namespace. Valid values are: 1.0, 1.1 and 1.2. The current default minimum TLS version is 1.2.
    servicebus_namespace_zone_redundant                   = false #(Optional) Whether or not this resource is zone redundant. sku needs to be Premium. Defaults to false.
    servicebus_namespace_is_customer_managed_key_required = false #(Required)Provide boolean value to check the condition
    servicebus_namespace_key_vault_name                   = null  #(Optional)Key vault name. Provide value only if "servicebus_namespace_is_customer_managed_key_required" is set to "true"
    servicebus_namespace_key_vault_resource_group_name    = null  #(Optional)Key vault resource group name. Provide value only if "servicebus_namespace_is_customer_managed_key_required" is set to "true"
    servicebus_namespace_key_vault_key_name               = null  #(Optional)Key vault key name. Provide value only if "servicebus_namespace_is_customer_managed_key_required" is set to "true"
    #Note: Only servicebus_namespace_sku 'Premium' supports network rule set.
    servicebus_namespace_network_rule_set = null /*{                           #(Optional) An network_rule_set block as defined below.
      default_action                = null                              #(Optional) Specifies the default action for the Network Rule Set. Possible values are Allow and Deny. Defaults to Deny.
      public_network_access_enabled = null                              #(Optional) Whether to allow traffic over public network. Possible values are true and false. Defaults to true.
      trusted_services_allowed      = null                              #(Optional) Are Azure Services that are known and trusted for this resource type are allowed to bypass firewall configuration? See Trusted Microsoft Services
      ip_rules                      = null                              #(Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the ServiceBus Namespace.
      network_rules = [{                                                #(Optional) One or more network_rules blocks as defined below.
        ignore_missing_vnet_service_endpoint = null                     #(Optional) Should the ServiceBus Namespace Network Rule Set ignore missing Virtual Network Service Endpoint option in the Subnet? Defaults to false.
        subnet_name                          = "ploceussubnet000001"    #(Required) The name of the subnet. Changing this forces a new resource to be created.
        subnet_resource_group_name           = "ploceusrg000001" #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
        subnet_virtual_network_name          = "ploceusvnet000001"     #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
      }]
    }*/
    servicebus_namespace_tags = { #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}