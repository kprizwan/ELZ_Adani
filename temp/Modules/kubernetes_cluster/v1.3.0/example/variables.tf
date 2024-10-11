#RESOURCE GROUP VARIABLES
variable "resource_group_aks_variables" {
  type = map(object({
    resource_group_name       = string      #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = string      #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags       = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource group for aks"
  default = {
  }
}


#ROLE ASSIGNMENT VARIABLES
variable "role_assignment_variables" {
  type = map(object({
    role_assignment_role_definition_name                   = string # (Optional) A unique UUID/GUID for this Role Assignment - one will be generated if not specified. Changing this forces a new resource to be created.
    role_assignment_target_resource_type                   = string # (Required) Possible values are Subscription, ManagementGroup or AzureResource
    role_assignment_target_resource_name                   = string # (Required) The name of the resource to which we are assigning role
    role_assignment_description                            = string # (Optional) The description of the role
    role_assignment_management_group_name                  = string # (Optional) The name of the management group. Please make as null if scope is not set as ManagementGroup
    role_assignment_resource_group_name                    = string # (Optional) The name of the resource group. Please make as null if scope is not set as ResourceGroup
    role_assignment_principal_type                         = string # (Optional) Type of the principal id. It maybe User, Group or ServicePrincipal
    is_user_principal_id_exists                            = bool   # (Optional) Provide true when principle_type is "User" 
    is_service_principal_id_exists                         = bool   # (Optional) Provide true when principal_type is "ServicePrincipal"
    is_group_principal_id_exists                           = bool   # (Optional) Provide true when principal_type is "Group"
    role_assignment_user_principal_name                    = string # (Optional) give user_principal_name if is_user_principal_id_exists =true, and principal_type="User".
    role_assignment_service_principal_display_name         = string # (Optional) give service_principal_display_name if is_service_principal_id_exists =true, and principal_type="ServicePrincipal".
    role_assignment_group_principal_display_name           = string # (Optional) give user_principal_name if is_group_principal_id_exists =true, and principal_type="Group".
    role_assignment_condition                              = string # (Optional) The condition that limits the resources that the role can be assigned to. Changing this forces a new resource to be created.
    role_assignment_condition_version                      = string # (Optional) The version of the condition. Possible values are 1.0 or 2.0. Changing this forces a new resource to be created.
    role_assignment_delegated_managed_identity_resource_id = string # (Optional) The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created 
    role_assignment_skip_service_principal_aad_check       = bool   # (Optional) If the principal_id is a newly provisioned Service Principal set this value to true to skip the Azure Active Directory check which may fail due to replication lag. This argument is only valid if the principal_id is a Service Principal identity. Defaults to false.
    role_assignment_security_enabled                       = bool   # (Optional) Required for fetching group principal
  }))
  description = "Map of role assignment variables"
  default     = {}
}

#KEY VAULT RESOURCE GROUP VARIABLES 
variable "resource_group_key_vault_variables" {
  type = map(object({
    resource_group_name       = string      #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = string      #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags       = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource group for keyvault"
  default = {
  }
}

#LOG ANALYTICS WORKSPACE RESOURCE GROUP VARIABLES
variable "resource_group_log_analytics_workspace_oms_variables" {
  type = map(object({
    resource_group_name       = string      #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = string      #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags       = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups log analytics workspace"
  default = {
  }
}

#VIRTUAL NETWORK VARIABLES
variable "virtual_network_variables" {
  description = "Map of vnet objects. name, vnet_address_space, and dns_server supported"
  type = map(object({
    virtual_network_name                    = string       #(Required) the name of the virtual network. Changing this forces a new resource to be created.
    virtual_network_location                = string       #(Required) the location/region where the virtual network is created. Changing this forces a new resource to be created.
    virtual_network_resource_group_name     = string       #(Required) the name of the resource group in which to create the virtual network.
    virtual_network_address_space           = list(string) #(Required) the address space that is used the virtual network. You can supply more than one address space.
    virtual_network_dns_servers             = list(string) #(Optional) list of IP addresses of DNS servers.Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it.
    virtual_network_flow_timeout_in_minutes = number       #(Optional) the flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = string       #(Optional) the BGP community attribute in format <as-number>:<community-value>.
    virtual_network_ddos_protection_plan = object({        #(Optional) block for ddos protection
      virtual_network_ddos_protection_enable    = bool     #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = string   #(Required) for the ID of DDoS Protection Plan.
    })
    virtual_network_edge_zone = string                #(Optional) specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_encryption = list(object({        #(Optional) A encryption block as defined below.
      virtual_network_encryption_enforcement = string #(Required) Specifies if the encrypted Virtual Network allows VM that does not support encryption. Possible values are DropUnencrypted and AllowUnencrypted.
    }))
    virtual_network_subnet = list(object({                                       #(Optional) for the subnet block config. Set to null if not required
      virtual_network_subnet_name                                       = string #(Required) the subnet name to attach to vnet
      virtual_network_subnet_address_prefix                             = string #(Required) the address prefix to use for the subnet.
      virtual_network_subnet_network_security_group_name                = string #(Optional) the Network Security Group Name to associate with the subnet.
      virtual_network_subnet_network_security_group_resource_group_name = string #(Optional) the Network Security Group Resource Group to associate with the subnet.
    }))
    virtual_network_tags = map(string) #(Optional)a mapping of tags to assign to the resource.
  }))
  default = {}
}


#SUBNET VARIABLES
variable "subnet_variables" {
  description = "Map of Subnet Variables"
  type = map(object({
    subnet_name                                           = string       # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                            = string       #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_virtual_network_name                           = string       #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                               = list(string) #(Required) The address prefixes to use for the subnet.
    subnet_private_link_service_network_policies_enabled  = bool         # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled      = bool         # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_service_endpoints                              = list(string) #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    subnet_enforce_private_link_endpoint_network_policies = bool         #(Optional) Enable or Disable network policies for the private link endpoint on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false.
    subnet_enforce_private_link_service_network_policies  = bool         #(Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false.
    subnet_service_endpoint_policy_ids                    = list(string) #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    delegation = list(object({
      delegation_name            = string       #(Required) A name for this delegation.
      service_delegation_name    = string       # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = list(string) #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }))
  }))
  default = {}
}

#USER ASSIGNED IDENTITY VARIABLES
variable "user_assigned_identity_variables" {
  type = map(object({
    user_assigned_identity_name                = string      #(Required) Specifies the name of this User Assigned Identity. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_location            = string      # (Required) The Azure Region where the User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_resource_group_name = string      #Required) Specifies the name of the Resource Group within which this User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_tags                = map(string) #(Optional) A mapping of tags which should be assigned to the User Assigned Identity
  }))
  description = "Map of User Assigned Identities"
  default     = {}
}

#PRIVATE DNS ZONE VARIABLES
variable "private_dns_zone_variables" {
  type = map(object({
    private_dns_zone_name                = string #(Required) The name of the Private DNS Zone. Must be a valid domain name.
    private_dns_zone_resource_group_name = string #(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.
    private_dns_zone_soa_record = list(object({   #(Optional) An soa_record block as defined below. Changing this forces a new resource to be created.
      soa_record_email         = string           #(Required) The email contact for the SOA record.
      soa_record_expire_time   = number           #(Optional) The expire time for the SOA record. Defaults to 2419200.
      soa_record_minimum_ttl   = number           #(Optional) The minimum Time To Live for the SOA record. By convention, it is used to determine the negative caching duration. Defaults to 10.
      soa_record_refresh_time  = number           #(Optional) The refresh time for the SOA record. Defaults to 3600.
      soa_record_retry_time    = number           #(Optional) The retry time for the SOA record. Defaults to 300.
      soa_record_serial_number = number           #(optional) The serial number for the SOA record.
      soa_record_ttl           = number           #(Optional) The Time To Live of the SOA Record in seconds. Defaults to 3600.
      soa_record_tags          = map(string)      #(Optional) A mapping of tags to assign to the Record Set.
    }))
    private_dns_zone_tags = map(string)
  }))
  description = "Map of private dns zone"
  default     = {}
}

#KEY VAULT VARIABLES
variable "key_vault_variables" {
  type = map(object({
    key_vault_name                                  = string       #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_resource_group_name                   = string       #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_location                              = string       #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_enabled_for_disk_encryption           = bool         #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = bool         #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = bool         # (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = bool         #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = string       #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = bool         # (Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
    key_vault_sku_name                              = string       #(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium
    key_vault_access_container_agent_name           = string       #(Optional) Self hosted conatiner agent name.
    key_vault_access_policy_application_id          = string       #(Optional) The object ID of an Application in Azure Active Directory.
    key_vault_public_network_access_enabled         = bool         #(Optional) key_vault_public_network_access_enabled
    key_vault_access_policy_key_permissions         = list(string) #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey.
    key_vault_access_policy_secret_permissions      = list(string) #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = list(string) #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = list(string) #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update
    key_vault_tags                                  = map(string)  #(Optional) A mapping of tags which should be assigned to the key vault.
    key_vault_network_acls_enabled                  = bool         #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass                   = string       #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action           = string       # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
    key_vault_network_acls_ip_rules                 = list(string) # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.
    #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
    key_vault_network_acls_virtual_networks = list(object({
      key_vault_network_acls_virtual_networks_virtual_network_name    = string #(Required) Vitural Network name to be associated.
      key_vault_network_acls_virtual_networks_subnet_name             = string #(Required) Subnet Name to be associated.
      key_vault_network_acls_virtual_networks_subscription_id         = string #(Required) Subscription Id where Vnet is created.
      key_vault_network_acls_virtual_networks_virtual_network_rg_name = string #(Required) Resource group where Vnet is created.
    }))
    key_vault_contact_information_enabled = bool   #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email               = string #(Required) E-mail address of the contact.
    key_vault_contact_name                = string #(Optional) Name of the contact.
    key_vault_contact_phone               = string #(Optional) Phone number of the contact.
  }))
  description = "Map of Variables for Key Vault details"
  default     = {}
}

#KEY VAULT ACCESS POLICY VARIABLES
variable "key_vault_access_policy_variables" {
  type = map(object({
    key_vault_access_policy_key_permissions         = list(string) #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.
    key_vault_access_policy_secret_permissions      = list(string) #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = list(string) #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = list(string) #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_name                                  = string       #(Required) Specifies the name of the Key Vault resource.
    key_vault_resource_group_name                   = string       #(Required) Specifies the resource group name where the key vault resides in.
    key_vault_access_resource_name                  = string       #(Required) Specifies the resource name that needs the access policy to the key vault. Possible values are username, group name, service principal name and application name 
    key_vault_access_resource_type                  = string       #(Required) Specifies the type of resource that needs the access policy to the key vault. Possible values are User, SPN, Group, Application
  }))
  description = "Map of variables for key vault access policies"
  default     = {}
}

# KEY VAULT KEY VARIABLES
variable "key_vault_key_variables" {
  description = "Map of object of key vault key variables"
  type = map(object({
    key_vault_name                = string          #(Required) The name of the Key Vault where the Key should be created.
    key_vault_resource_group_name = string          #(Required) The resource group name of the Key Vault where the Key should be created.
    key_vault_key_name            = string          #(Required) Specifies the name of the Key Vault Key.
    key_vault_key_key_type        = string          #(Required) Specifies the Key Type to use for this Key Vault Key. Possible values are EC (Elliptic Curve), EC-HSM, RSA and RSA-HSM.
    key_vault_key_key_size        = number          #(Optional) Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048. Note: This field is required if key_type is RSA or RSA-HSM.
    key_vault_key_curve           = string          #(Optional) Specifies the curve to use when creating an EC key. Possible values are P-256, P-256K, P-384, and P-521. This field will be required in a future release if key_type is EC or EC-HSM. The API will default to P-256 if nothing is specified.
    key_vault_key_key_opts        = list(string)    #(Required) A list of JSON web key operations. Possible values include: decrypt, encrypt, sign, unwrapKey, verify and wrapKey. Please note these values are case sensitive.
    key_vault_key_not_before_date = string          #(Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_key_expiration_date = string          #(Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_key_rotation_policy = object({        #(Optional) A rotation_policy block as defined below.
      rotation_policy_expire_after         = string #(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration.
      rotation_policy_notify_before_expiry = string #(Optional) Notify at a given duration before expiry as an ISO 8601 duration. Default is P30D.
      rotation_policy_automatic = object({          #(Optional) An automatic block as defined below.
        automatic_time_after_creation = string      #(Optional) Rotate automatically at a duration after create as an ISO 8601 duration.
        automatic_time_before_expiry  = string      #(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration.
      })
    })
    key_vault_key_tags = map(string) #(Optional) A mapping of tags to assign to the resource.
  }))
  default = {}
}

#KEY VAULT SECRET VARIABLES
variable "key_vault_secret_variables" {
  type = map(object({
    key_vault_name                       = string      #(Required) Specifies the name of the Key Vault.
    key_vault_secret_resource_group_name = string      #(Required) Specifies the name of the resource group, where the key_vault resides in.
    key_vault_secret_name                = string      #(Required) Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created
    key_vault_secret_value               = string      #(Required) Specifies the value of the Key Vault Secret
    key_vault_secret_content_type        = string      #(Optional) Specifies the content type for the Key Vault Secret
    key_vault_secret_not_before_date     = string      #(Optional) Specifies that the key is not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z')
    key_vault_secret_expiration_date     = string      #(Optional) Specifies the expiration UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_secret_tags                = map(string) #(Optional) A mapping of tags which should be assigned to the key vault secret.
    key_vault_secret_min_upper           = number      #(Optional)(Number) Minimum number of uppercase alphabet characters in the result. Default value is 0
    key_vault_secret_min_lower           = number      #(Optional)(Number) Minimum number of lowercase alphabet characters in the result. Default value is 0
    key_vault_secret_min_numeric         = number      #(Optional)(Number) Minimum number of numeric characters in the result. Default value is 0
    key_vault_secret_min_special         = number      #(Optional)(Number) Minimum number of special characters in the result. Default value is 0
    key_vault_secret_length              = number      #(Optional)(Number) The length of the string desired. The minimum value for length is 1 and, length must also be >= (min_upper + min_lower + min_numeric + min_special)
  }))
  description = "Map of variables for key vault secrets"
  default     = {}
}

#KEY VAULT CERTIFICATE VARIABLES
variable "key_vault_certificate_variables" {
  description = "Map of Key Vault Certificate variables"
  type = map(object({
    key_vault_certificate_name                          = string #(Required) Specifies the name of the Key Vault Certificate. Changing this forces a new resource to be created.
    key_vault_certificate_key_vault_name                = string #(Required) The name of the Key Vault where the Certificate should be created.
    key_vault_certificate_key_vault_resource_group_name = string #(Required) The resource group name of the Key Vault where the Certificate should be created.

    key_vault_certificate_password_secret_name      = string #(Optional) The password associated with the certificate. Use this if you are using an existing certificate stored in key vault, add password as a secret in key vault to fetch.
    key_vault_certificate_contents_secret_name      = string #(Optional) The base64-encoded certificate contents stored as a secret in key vault. Provide this when 'key_vault_certificate_fetch_certificate_enabled' is true
    key_vault_certificate_file_path                 = string #(Optional) This is required when you are not specifying 'key_vault_certificate_contents_secret_name', you can give in a relative file path to pointing to your certificate.
    key_vault_certificate_fetch_certificate_enabled = bool   #(Required) If true, certificate from key vault will be used, otherwise a new certificate will be created and 'key_vault_certificate_certificate_policy' is required. Defaults to false 

    key_vault_certificate_certificate_policy = object({ #(Optional) A `certificate_policy` block as defined below. Required when 'key_vault_certificate_fetch_certificate_enabled' is true. Changing this will create a new version of the Key Vault Certificate.
      certificate_policy_issuer_parameters = object({   #(Required) A `issuer_parameters` block as defined below.
        issuer_parameters_name = string                 #(Required) The name of the Certificate Issuer. Possible values include `Self` (for self-signed certificate), or `Unknown` (for a certificate issuing authority like `Let's Encrypt` and Azure direct supported ones). Changing this forces a new resource to be created.
      })
      certificate_policy_key_properties = object({ #(Required) A `key_properties` block as defined below.
        key_properties_curve      = string         #(Optional) Specifies the curve to use when creating an `EC` key. Possible values are `P-256`, `P-256K`, `P-384`, and `P-521`. This field will be required in a future release if `key_type` is `EC` or `EC-HSM`. Changing this forces a new resource to be created.
        key_properties_exportable = bool           #(Required) Is this certificate exportable? Changing this forces a new resource to be created.
        key_properties_key_size   = number         #(Optional) The size of the key used in the certificate. Possible values include `2048`, `3072`, and `4096` for `RSA` keys, or `256`, `384`, and `521` for `EC` keys. This property is required when using RSA keys. Changing this forces a new resource to be created.
        key_properties_key_type   = string         #(Required) Specifies the type of key. Possible values are `EC`, `EC-HSM`, `RSA`, `RSA-HSM` and `oct`. Changing this forces a new resource to be created.
        key_properties_reuse_key  = bool           #(Required) Is the key reusable? Changing this forces a new resource to be created.
      })
      certificate_policy_lifetime_action = object({ #(Optional) A `lifetime_action` block as defined below.
        lifetime_action_action = object({           #(Required) A `action` block as defined below.
          action_type = string                      #(Required) The Type of action to be performed when the lifetime trigger is triggerec. Possible values include `AutoRenew` and `EmailContacts`. Changing this forces a new resource to be created.
        })
        lifetime_action_trigger = object({     #(Required) A `trigger` block as defined below.
          trigger_days_before_expiry  = number #(Optional) The number of days before the Certificate expires that the action associated with this Trigger should run. Changing this forces a new resource to be created. Conflicts with `lifetime_percentage`.
          trigger_lifetime_percentage = number #(Optional) The percentage at which during the Certificates Lifetime the action associated with this Trigger should run. Changing this forces a new resource to be created. Conflicts with `days_before_expiry`.
        })
      })
      certificate_policy_secret_properties = object({ #(Required) A `secret_properties` block as defined below.
        secret_properties_content_type = string       #(Required) The Content-Type of the Certificate, such as `application/x-pkcs12` for a PFX or `application/x-pem-file` for a PEM. Changing this forces a new resource to be created.
      })
      certificate_policy_x509_certificate_properties = object({          #(Optional) A `x509_certificate_properties` block as defined below. Required when `certificate` block is not specified.
        x509_certificate_properties_extended_key_usage = list(string)    #(Optional) A list of Extended/Enhanced Key Usages. Changing this forces a new resource to be created.
        x509_certificate_properties_key_usage          = set(string)     #(Required) A list of uses associated with this Key. Possible values include `cRLSign`, `dataEncipherment`, `decipherOnly`, `digitalSignature`, `encipherOnly`, `keyAgreement`, `keyCertSign`, `keyEncipherment` and `nonRepudiation` and are case-sensitive. Changing this forces a new resource to be created.
        x509_certificate_properties_subject            = string          #(Required) The Certificate's Subject. Changing this forces a new resource to be created.
        x509_certificate_properties_validity_in_months = number          #(Required) The Certificates Validity Period in Months. Changing this forces a new resource to be created.
        x509_certificate_properties_subject_alternative_names = object({ #(Optional) A `subject_alternative_names` block as defined below. Changing this forces a new resource to be created.
          subject_alternative_names_dns_names = set(string)              #(Optional) A list of alternative DNS names (FQDNs) identified by the Certificate. Changing this forces a new resource to be created.
          subject_alternative_names_emails    = set(string)              #(Optional) A list of email addresses identified by this Certificate. Changing this forces a new resource to be created.
          subject_alternative_names_upns      = set(string)              #(Optional) A list of User Principal Names identified by the Certificate. Changing this forces a new resource to be created.
        })
      })
    })
    key_vault_certificate_tags = map(string) #(Optional) A mapping of tags to assign to the resource.
  }))
  default = {}
}

#LOG ANALYTICS WORKSPACE VARIABLES
variable "log_analytics_workspace_variables" {
  description = "Map of objects of log analytics workspace"
  type = map(object({
    log_analytics_workspace_name                                   = string      #(Required) Specifies the name of the Log Analytics Workspace. Workspace name should include 4-63 letters, digits or '-'. The '-' shouldn't be the first or the last symbol. Changing this forces a new resource to be created.
    log_analytics_workspace_resource_group_name                    = string      #(Required) The name of the resource group in which the Log Analytics workspace is created. Changing this forces a new resource to be created.
    log_analytics_workspace_location                               = string      #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created
    log_analytics_workspace_allow_resource_only_permissions        = bool        #(Optional) Specifies if the log Analytics Workspace allow users accessing to data associated with resources they have permission to view, without permission to workspace. Defaults to true.
    log_analytics_workspace_local_authentication_disabled          = bool        #(Optional) Specifies if the log Analytics workspace should enforce authentication using Azure AD. Defaults to false.
    log_analytics_workspace_sku                                    = string      #(Optional) Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018 (new SKU as of 2018-04-03). Defaults to PerGB2018
    log_analytics_workspace_retention_in_days                      = number      #(Optional) The workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730.
    log_analytics_workspace_daily_quota_gb                         = number      #(Optional) The workspace daily quota for ingestion in GB. Defaults to -1 (unlimited) if omitted.
    log_analytics_workspace_cmk_for_query_forced                   = bool        #(Optional) Is Customer Managed Storage mandatory for query management?
    log_analytics_workspace_internet_ingestion_enabled             = bool        #(Optional) Should the Log Analytics Workspace support ingestion over the Public Internet? Defaults to true
    log_analytics_workspace_internet_query_enabled                 = bool        #(Optional) Should the Log Analytics Workspace support querying over the Public Internet? Defaults to true
    log_analytics_workspace_reservation_capacity_in_gb_per_day     = number      #(Optional) The capacity reservation level in GB for this workspace. Must be in increments of 100 between 100 and 5000
    log_analytics_workspace_data_collection_rule_id                = string      #(Optional) The ID of the Data Collection Rule to use for this workspace.
    log_analytics_workspace_tags                                   = map(string) #(Optional) A mapping of tags to assign to the resource.
    log_analytics_workspace_key_vault_name                         = string      #(Required) specify the keyvault name to store the log analytics workspace keys.
    log_analytics_workspace_key_vault_resource_group_name          = string      #(Required) The name of the resource group in which the keyvault is present. 
    log_analytics_workspace_primary_shared_key_vault_secret_name   = string      #(Required) The name of the keyvault secret where the primary shared key of log analytics workspace is stored
    log_analytics_workspace_secondary_shared_key_vault_secret_name = string      #(Required) The name of the keyvault secret where the secondary shared key of log analytics workspace is stored
  }))
  default = {}
}

#KUBERNETES CLUSTER VARIABLES
variable "kubernetes_cluster_variables" {
  description = "Map of Kubernetes cluster variables"
  type = map(object({
    kubernetes_cluster_name                                                       = string #(Required) The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created.
    kubernetes_cluster_location                                                   = string #(Required) The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created.
    kubernetes_cluster_resource_group_name                                        = string #(Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_key_vault_name                                             = string #(Optional) Incase if any secret value is passed for linux_profile, windows_profile, azure_active_directory_role_based_access_control(azure_active_directory_role_based_access_control_server_app_secret) or service_principal(client_secret). Pass null if not required
    kubernetes_cluster_key_vault_resource_group_name                              = string #(Optional) To be provided for the kubernetes_cluster_key_vault_name  resource group
    kubernetes_cluster_key_vault_certificate_name                                 = string #(Optional) Specifies the name of the Key Vault Certificate which contain the list of up to 10 base64 encoded CAs that will be added to the trust store on nodes with the custom_ca_trust_enabled feature enabled.
    kubernetes_cluster_default_node_pool_name                                     = string #(Required) The name which should be used for the default Kubernetes Node Pool. Changing this forces a new resource to be created.must start with a lowercase letter, have max length of 12, and only have characters a-z0-9.
    kubernetes_cluster_default_node_pool_capacity_reservation_group_name          = string #(Optional) provide the linux kubernetes_cluster capacity reservation group name
    kubernetes_cluster_default_node_pool_capacity_reservation_resource_group_name = string #(Optional) provide the capacity reservation group resource group name
    kubernetes_cluster_default_node_pool_vm_size                                  = string #(Required) The size of the Virtual Machine, such as Standard_DS2_v2. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_custom_ca_trust_enabled                  = bool   #(Optional) Specifies whether to trust a Custom CA.
    kubernetes_cluster_default_node_pool_key_vault_certificate_name               = string #(Optional) Specifies the name of the Key Vault Certificate. If kubernetes_cluster_default_node_pool_custom_ca_trust_enabled is set to true, then this is Required.
    kubernetes_cluster_default_node_pool_enable_auto_scaling                      = bool   #(Optional) Should the Kubernetes Auto Scaler be enabled for this Node Pool? Defaults to false. This requires that the type is set to VirtualMachineScaleSets
    kubernetes_cluster_default_node_pool_workload_runtime                         = string #(Optional) Specifies the workload runtime used by the node pool. Possible values are OCIContainer and KataMshvVmIsolation.
    kubernetes_cluster_default_node_pool_enable_host_encryption                   = bool   #(Optional) Should the nodes in the Default Node Pool have host encryption enabled? Defaults to false
    kubernetes_cluster_default_node_pool_enable_node_public_ip                    = bool   #(Optional) Should nodes in this Node Pool have a Public IP Address? Defaults to false. Changing this forces a new resource to be created.
    kubernetes_cluster_workload_identity_enabled                                  = bool   #(Optional) Specifies whether Azure AD Workload Identity should be enabled for the Cluster. Defaults to false.
    kubernetes_cluster_default_node_pool_kubelet_config = object({                         #(Optional) Configures the nodes kublet service config. Assign as null if not required 
      kubelet_config_allowed_unsafe_sysctls    = list(string)                              #(Optional) Specifies the allow list of unsafe sysctls command or patterns (ending in *). Changing this forces a new resource to be created.
      kubelet_config_container_log_max_line    = number                                    #(Optional) Specifies the maximum number of container log files that can be present for a container. must be at least 2. Changing this forces a new resource to be created.
      kubelet_config_container_log_max_size_mb = string                                    #(Optional) Specifies the maximum size (e.g. 10MB) of container log file before it is rotated. Changing this forces a new resource to be created.
      kubelet_config_cpu_cfs_quota_enabled     = bool                                      #(Optional) Is CPU CFS quota enforcement for containers enabled? Changing this forces a new resource to be created.
      kubelet_config_cpu_cfs_quota_period      = number                                    #(Optional) Specifies the CPU CFS quota period value. Changing this forces a new resource to be created.
      kubelet_config_cpu_manager_policy        = string                                    #(Optional) Specifies the CPU Manager policy to use. Possible values are none and static, Changing this forces a new resource to be created.
      kubelet_config_image_gc_high_threshold   = number                                    #(Optional) Specifies the percent of disk usage above which image garbage collection is always run. Must be between 0 and 100. Changing this forces a new resource to be created.
      kubelet_config_image_gc_low_threshold    = number                                    #(Optional) Specifies the percent of disk usage lower than which image garbage collection is never run. Must be between 0 and 100. Changing this forces a new resource to be created.
      kubelet_config_pod_max_pid               = number                                    #(Optional) Specifies the maximum number of processes per pod. Changing this forces a new resource to be created.
      kubelet_config_topology_manager_policy   = string                                    #(Optional) Specifies the Topology Manager policy to use. Possible values are none, best-effort, restricted or single-numa-node. Changing this forces a new resource to be created.
    })
    kubernetes_cluster_default_node_pool_linux_os_config = object({ #Optional.  Assign as null if not required
      linux_os_config_swap_file_size_mb = number                    #(Optional) Specifies the size of swap file on each node in MB. Changing this forces a new resource to be created.
      sysctl_config = object({                                      #(Optional) A sysctl_config block as defined below. Assign as null if not required. Changing this forces a new resource to be created.
        sysctl_config_fs_aio_max_nr                      = number   #(Optional) The sysctl setting fs.aio-max-nr. Must be between 65536 and 6553500. 
        sysctl_config_fs_file_max                        = number   #(Optional) The sysctl setting fs.file-max. Must be between 8192 and 12000500. 
        sysctl_config_fs_inotify_max_user_watches        = number   #(Optional) The sysctl setting fs.inotify.max_user_watches. Must be between 781250 and 2097152. 
        sysctl_config_fs_nr_open                         = number   #(Optional) The sysctl setting fs.nr_open. Must be between 8192 and 20000500. 
        sysctl_config_kernel_threads_max                 = number   #(Optional) The sysctl setting kernel.threads-max. Must be between 20 and 513785. 
        sysctl_config_net_core_netdev_max_backlog        = number   #(Optional) The sysctl setting net.core.netdev_max_backlog. Must be between 1000 and 3240000. 
        sysctl_config_net_core_optmem_max                = number   #(Optional) The sysctl setting net.core.optmem_max. Must be between 20480 and 4194304. 
        sysctl_config_net_core_rmem_default              = number   #(Optional) The sysctl setting net.core.rmem_default. Must be between 212992 and 134217728. 
        sysctl_config_net_core_rmem_max                  = number   #(Optional) The sysctl setting net.core.rmem_max. Must be between 212992 and 134217728. 
        sysctl_config_net_core_somaxconn                 = number   #(Optional) The sysctl setting net.core.somaxconn. Must be between 4096 and 3240000. 
        sysctl_config_net_core_wmem_default              = number   #(Optional) The sysctl setting net.core.wmem_default. Must be between 212992 and 134217728. 
        sysctl_config_net_core_wmem_max                  = number   #(Optional) The sysctl setting net.core.wmem_max. Must be between 212992 and 134217728. 
        sysctl_config_net_ipv4_ip_local_port_range_max   = number   #(Optional) The sysctl setting net.ipv4.ip_local_port_range max value. Must be between 1024 and 60999. 
        sysctl_config_net_ipv4_ip_local_port_range_min   = number   #(Optional) The sysctl setting net.ipv4.ip_local_port_range min value. Must be between 1024 and 60999.
        sysctl_config_net_ipv4_neigh_default_gc_thresh1  = number   #(Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh1. Must be between 128 and 80000. 
        sysctl_config_net_ipv4_neigh_default_gc_thresh2  = number   #(Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh2. Must be between 512 and 90000. 
        sysctl_config_net_ipv4_neigh_default_gc_thresh3  = number   #(Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh3. Must be between 1024 and 100000. 
        sysctl_config_net_ipv4_tcp_fin_timeout           = number   #(Optional) The sysctl setting net.ipv4.tcp_fin_timeout. Must be between 5 and 120.
        sysctl_config_net_ipv4_tcp_keepalive_intvl       = number   #(Optional) The sysctl setting net.ipv4.tcp_keepalive_intvl. Must be between 10 and 75.
        sysctl_config_net_ipv4_tcp_keepalive_probes      = number   #(Optional) The sysctl setting net.ipv4.tcp_keepalive_probes. Must be between 1 and 15.
        sysctl_config_net_ipv4_tcp_keepalive_time        = number   #(Optional) The sysctl setting net.ipv4.tcp_keepalive_time. Must be between 30 and 432000
        sysctl_config_net_ipv4_tcp_max_syn_backlog       = number   #(Optional) The sysctl setting net.ipv4.tcp_max_syn_backlog. Must be between 128 and 3240000.
        sysctl_config_net_ipv4_tcp_max_tw_buckets        = number   #(Optional) The sysctl setting net.ipv4.tcp_max_tw_buckets. Must be between 8000 and 1440000.
        sysctl_config_net_ipv4_tcp_tw_reuse              = bool     #(Optional) The sysctl setting net.ipv4.tcp_tw_reuse. 
        sysctl_config_net_netfilter_nf_conntrack_buckets = number   #(Optional) The sysctl setting net.netfilter.nf_conntrack_buckets. Must be between 65536 and 147456
        sysctl_config_net_netfilter_nf_conntrack_max     = number   #(Optional) The sysctl setting net.netfilter.nf_conntrack_max. Must be between 131072 and 1048576
        sysctl_config_vm_max_map_count                   = number   #(Optional) The sysctl setting vm.max_map_count. Must be between 65530 and 262144. 
        sysctl_config_vm_swappiness                      = number   #(Optional) The sysctl setting vm.swappiness. Must be between 0 and 100.
        sysctl_config_vm_vfs_cache_pressure              = number   #(Optional) The sysctl setting vm.vfs_cache_pressure. Must be between 0 and 100
      })
      linux_os_config_transparent_huge_page_defrag  = string #(Optional) specifies the defrag configuration for Transparent Huge Page. Possible values are always, defer, defer+madvise, madvise and never. Changing this forces a new resource to be created.
      linux_os_config_transparent_huge_page_enabled = string #(Optional) Specifies the Transparent Huge Page enabled configuration. Possible values are always, madvise and never. Changing this forces a new resource to be created.
    })
    kubernetes_cluster_default_node_pool_fips_enabled                                  = bool        #(Optional) Should the nodes in this Node Pool have Federal Information Processing Standard enabled? Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_kubelet_disk_type                             = string      #(Optional) The type of disk used by kubelet. Possible values are OS and Temporary.
    kubernetes_cluster_default_node_pool_max_pods                                      = number      #(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created.
    kubernetes_cluster_message_of_the_day                                              = string      #(Optional) A base64-encoded string which will be written to /etc/motd after decoding. This allows customization of the message of the day for Linux nodes. It cannot be specified for Windows nodes and must be a static string (i.e. will be printed raw and not executed as a script). Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_node_public_ip_prefix_name                    = string      #(Optional) Resource name for the Public IP Addresses Prefix for the nodes in this Node Pool. enable_node_public_ip should be true. Changing this forces a new resource to be created. 
    kubernetes_cluster_default_node_pool_node_public_ip_prefix_resource_group_name     = string      #(Optional) Resource group name for the Public IP Addresses Prefix for the nodes in this Node Pool. enable_node_public_ip should be true. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_is_host_group_id_required                     = bool        #(Required)Boolean value if host group id required
    kubernetes_cluster_default_node_pool_dedicated_host_group_name                     = string      #(Optional) Specifies the Name of the Host Group within which this AKS Cluster should be created. Required if kubernetes_cluster_is_host_group_id_required is set to true.
    kubernetes_cluster_default_node_pool_dedicated_host_group_resource_group_name      = string      #(Optional) Specifies the Resource Group Name of the Host Group. Required if  kubernetes_cluster_is_host_group_id_required is set to true.
    kubernetes_cluster_default_node_pool_node_labels                                   = map(string) #(Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool.
    kubernetes_cluster_default_node_pool_only_critical_addons_enabled                  = bool        #(Optional) Enabling this option will taint default node pool with CriticalAddonsOnly=true:NoSchedule taint. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_orchestrator_version                          = string      #(Optional) Version of Kubernetes used for the Agents. If not specified, the default node pool will be created with the version specified by kubernetes_version. If both are unspecified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). This version must be supported by the Kubernetes Cluster - as such the version of Kubernetes used on the Cluster/Control Plane may need to be upgraded first.
    kubernetes_cluster_default_node_pool_os_disk_size_gb                               = number      #(Optional) The size of the OS Disk which should be used for each agent in the Node Pool. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_os_disk_type                                  = string      #(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_os_sku                                        = string      #(Optional) OsSKU to be used to specify Linux OSType. Not applicable to Windows OSType. Possible values include: Ubuntu, CBLMariner. Defaults to Ubuntu. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_is_proximity_placement_group_id_required      = bool        #(Required)Boolean value if proximity placement group id required
    kubernetes_cluster_default_node_pool_proximity_placement_group_name                = string      #(Optional) Provide proximity placement group name if kubernetes_cluster_is_proximity_placement_group_id_required is set to true
    kubernetes_cluster_default_node_pool_proximity_placement_group_resource_group_name = string      #(Optional) Provide proximity placement group resource group name if kubernetes_cluster_is_proximity_placement_group_id_required is set to true
    kubernetes_cluster_default_node_pool_pod_scale_down_mode                           = string      #(Optional) Specifies the autoscaling behaviour of the Kubernetes Cluster. Allowed values are Delete and Deallocate. Defaults to Delete.
    kubernetes_cluster_default_node_pool_is_snapshot_id_required                       = bool        #(Required)Boolean value if snapshot id required
    kubernetes_cluster_default_node_pool_snapshot_name                                 = string      #(Optional) Provide snapshot name if kubernetes_cluster_default_node_pool_is_snapshot_id_required is set to true
    kubernetes_cluster_default_node_pool_snapshot_resource_group_name                  = string      #(Optional) Provide snapshot resource group name if kubernetes_cluster_default_node_pool_is_snapshot_id_required is set to true
    kubernetes_cluster_default_node_pool_temporary_name_for_rotation                   = string      #(Optional) Specifies the name of the temporary node pool used to cycle the default node pool for VM resizing.
    kubernetes_cluster_default_node_pool_pod_virtual_network_name                      = string      #(Optional) The name of the Virtual Network where the pods in the default Node Pool should exist.
    kubernetes_cluster_default_node_pool_pod_subnet_name                               = string      #(Optional) The name of the Subnet where the pods in the default Node Pool should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_pod_virtual_network_resource_group_name       = string      #(Optional) The name of the Resource Group where the pods Virtual Network exist
    kubernetes_cluster_default_node_pool_type                                          = string      #(Optional) The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets. Defaults to VirtualMachineScaleSets.
    kubernetes_cluster_default_node_pool_tags                                          = map(string) #(Optional) A mapping of tags to assign to the Node Pool.
    kubernetes_cluster_default_node_pool_ultra_ssd_enabled                             = bool        #(Optional) Used to specify whether the UltraSSD is enabled in the Default Node Pool. Defaults to false
    kubernetes_cluster_node_network_profile = object({                                               #(Optional) Node Network Profile for Kubernetes Cluster
      node_network_profile_node_public_ip_tags = map(string)                                         #(Optional) Specifies a mapping of tags to the instance-level public IPs. Changing this forces a new resource to be created.                              
    })
    kubernetes_cluster_default_node_pool_upgrade_settings = object({ #(Optional) upgrade_settings
      upgrade_settings_max_surge = number                            #(Required) The maximum number or percentage of nodes which will be added to the Node Pool size during an upgrade.
    })
    kubernetes_cluster_default_node_pool_virtual_network_name                = string       #(Optional) Name of VNet for assigning default node pool to a subnet
    kubernetes_cluster_default_node_pool_virtual_network_resource_group_name = string       #(Optional) Name of VNet's resource group for assigning default node pool to a subnet
    kubernetes_cluster_default_node_pool_subnet_name                         = string       #(Optional) Name of Subnet for assigning default node pool to a subnet . A Route Table must be configured on this Subnet.
    kubernetes_cluster_default_node_pool_max_count                           = number       #(Optional) The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000.
    kubernetes_cluster_default_node_pool_min_count                           = number       #(Optional) The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000
    kubernetes_cluster_default_node_pool_node_count                          = number       #(Optional) The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 and between min_count and max_count.
    kubernetes_cluster_default_node_pool_availability_zones                  = list(string) #(Optional) Specifies a list of Availability Zones in which this Kubernetes Cluster should be located. Changing this forces a new Kubernetes Cluster to be created.  
    kubernetes_cluster_dns_prefix                                            = string       #(Optional) DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created. One of dns_prefix or dns_prefix_private_cluster must be specified. The dns_prefix must contain between 3 and 45 characters, and can contain only letters, numbers, and hyphens. It must start with a letter and must end with a letter or a number.
    kubernetes_cluster_dns_prefix_private_cluster                            = string       #(Optional) Specifies the DNS prefix to use with private clusters. Changing this forces a new resource to be created. One of dns_prefix or dns_prefix_private_cluster must be specified. The dns_prefix must contain between 3 and 45 characters, and can contain only letters, numbers, and hyphens. It must start with a letter and must end with a letter or a number.
    kubernetes_cluster_aci_connector_linux = object({                                       #(Optional) Set this up to use Virtual Nodes. Assign null if not required.
      aci_connector_linux_subnet_name = string                                              #(Required) The subnet name for the virtual nodes to run. AKS will add a delegation to the subnet named here. To prevent further runs from failing you should make sure that the subnet you create for virtual nodes has a delegation
    })
    kubernetes_cluster_automatic_channel_upgrade       = string       #(Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, node-image and stable. Omitting this field sets this value to none. Cluster Auto-Upgrade will update the Kubernetes Cluster (and its Node Pools) to the latest GA version of Kubernetes automatically and will not update to Preview versions.
    kubernetes_cluster_api_server_authorized_ip_ranges = list(string) # (Optional) The IP ranges to allow for incoming traffic to the server nodes.

    kubernetes_cluster_api_server_access_profile = object({               #(Optional) For API Server Access Profile setup. Assign null if not required
      api_server_access_profile_authorized_ip_ranges       = list(string) #(Optional) Set of authorized IP ranges to allow access to API server, e.g. ["198.51.100.0/24"].
      api_server_access_profile_vnet_integration_enabled   = bool         #(Optional) Should API Server VNet Integration be enabled?
      api_server_access_profile_subnet_exists              = bool         #(Required). Assign true if the Subnet where the API server endpoint is delegated to exists.
      api_server_access_profile_subnet_name                = string       #(Optional) The name of the subnet where the API server endpoint is delegated to.
      api_server_access_profile_subnet_resource_group_name = string       #(Optional) Name of the resource group where the subnet exist
      api_server_access_profile_virtual_network_name       = string       #(Optional) Name of the virtual network which the subnet belongs to
    })

    kubernetes_cluster_auto_scaler_profile = object({               #(Optional) For auto scaler setup. Assign null if not required
      auto_scaler_profile_balance_similar_node_groups      = bool   #Detect similar node groups and balance the number of nodes between them. Defaults to false
      auto_scaler_profile_expander                         = string #Expander to use. Possible values are least-waste, priority, most-pods and random. Defaults to random
      auto_scaler_profile_max_graceful_termination_sec     = number #Maximum number of seconds the cluster autoscaler waits for pod termination when trying to scale down a node. Defaults to 600
      auto_scaler_profile_max_node_provisioning_time       = string # Maximum time the autoscaler waits for a node to be provisioned. Defaults to 15m.
      auto_scaler_profile_max_unready_nodes                = number #Maximum Number of allowed unready nodes. Defaults to 3
      auto_scaler_profile_max_unready_percentage           = number #Maximum percentage of unready nodes the cluster autoscaler will stop if the percentage is exceeded. Defaults to 45
      auto_scaler_profile_new_pod_scale_up_delay           = string #For scenarios like burst/batch scale where you don't want CA to act before the kubernetes scheduler could schedule all the pods, you can tell CA to ignore unscheduled pods before they're a certain age. Defaults to 10s.
      auto_scaler_profile_scale_down_delay_after_add       = string #How long after the scale up of AKS nodes the scale down evaluation resumes. Defaults to 10m
      auto_scaler_profile_scale_down_delay_after_delete    = string #How long after node deletion that scale down evaluation resumes. Defaults to the value used for scan_interval
      auto_scaler_profile_scale_down_delay_after_failure   = string #How long after scale down failure that scale down evaluation resumes. Defaults to 3m
      auto_scaler_profile_scan_interval                    = string #How often the AKS Cluster should be re-evaluated for scale up/down. Defaults to 10s
      auto_scaler_profile_scale_down_unneeded              = string #How long a node should be unneeded before it is eligible for scale down. Defaults to 10m
      auto_scaler_profile_scale_down_unready               = string #How long an unready node should be unneeded before it is eligible for scale down. Defaults to 20m
      auto_scaler_profile_scale_down_utilization_threshold = number #Node utilization level, defined as sum of requested resources divided by capacity, below which a node can be considered for scale down. Defaults to 0.5.
      auto_scaler_profile_empty_bulk_delete_max            = number #Maximum number of empty nodes that can be deleted at the same time. Defaults to 10
      auto_scaler_profile_skip_nodes_with_local_storage    = bool   #If true cluster autoscaler will never delete nodes with pods with local storage, for example, EmptyDir or HostPath. Defaults to true
      auto_scaler_profile_skip_nodes_with_system_pods      = bool   #If true cluster autoscaler will never delete nodes with pods from kube-system (except for DaemonSet or mirror pods). Defaults to true
    })
    kubernetes_cluster_azure_active_directory_role_based_access_control = object({ #(Optional) Assign null if not required. Defines azure AD based RBAC settings 
      azure_active_directory_role_based_access_control_managed   = bool            #(Optional) Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration.
      azure_active_directory_role_based_access_control_tenant_id = string          #(Optional) The Tenant ID used for Azure Active Directory Application. If this isn't specified the Tenant ID of the current Subscription is used.
      # azure_active_directory_role_based_access_control_managed is set to true for using below properties
      azure_active_directory_role_based_access_control_admin_group_object_ids = list(string) #(Optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster.
      azure_active_directory_role_based_access_control_azure_rbac_enabled     = bool         #(Optional) Is Role Based Access Control based on Azure AD enabled
      # azure_active_directory_role_based_access_control_managed must be set to false to use below properties
      azure_active_directory_role_based_access_control_client_app_id          = string #(Required) The Client ID of an Azure Active Directory Application.
      azure_active_directory_role_based_access_control_server_app_id          = string #(Required) The Server ID of an Azure Active Directory Application.
      azure_active_directory_role_based_access_control_server_app_secret_name = string #(Required) The Server Secret of an Azure Active Directory Application.
    })

    kubernetes_cluster_confidential_computing = object({     #(Optional) A confidential_computing block as defined below
      confidential_computing_sgx_quote_helper_enabled = bool #(Required) Should the SGX quote helper be enabled?
    })

    kubernetes_cluster_workload_autoscaler_profile = object({            #(Optional) A workload_autoscaler_profile block defined below.
      workload_autoscaler_profile_keda_enabled                    = bool #(Optional) Specifies whether KEDA Autoscaler can be used for workloads.
      workload_autoscaler_profile_vertical_pod_autoscaler_enabled = bool #(Optional) Specifies whether Vertical Pod Autoscaler should be enabled.
    })
    kubernetes_cluster_azure_policy_enabled = bool #(Optional) Should the Azure Policy Add-On be enabled

    kubernetes_cluster_disk_encryption_set_name                = string #(Optional) The name of the Disk Encryption Set which should be used for the Nodes and Volumes. Set to null if not required.
    kubernetes_cluster_disk_encryption_set_resource_group_name = string #(Optional) The resource group of the Disk Encryption Set which should be used for the Nodes and Volumes. Set to null if not required.
    kubernetes_cluster_edge_zone                               = string #(Optional) Specifies the Edge Zone within the Azure Region where this Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_http_application_routing_enabled        = bool   #(Optional) Should HTTP Application Routing be enabled
    kubernetes_cluster_image_cleaner_enabled                   = bool   #(Optional) Specifies whether Image Cleaner is enabled.
    kubernetes_cluster_image_cleaner_interval_hours            = number #(Optional) Specifies the interval in hours when images should be cleaned up. Defaults to 48.
    kubernetes_cluster_http_proxy_config = object({                     #Optional. Pass as null if not required
      http_proxy_config_http_proxy  = string                            #(Optional) The proxy address to be used when communicating over HTTP.
      http_proxy_config_https_proxy = string                            #(Optional) The proxy address to be used when communicating over HTTPS.
      http_proxy_config_no_proxy    = string                            #(Optional) The list of domains that will not use the proxy for communication.
      http_proxy_trusted_ca         = string                            #(Optional) The base64 encoded alternative CA certificate content in PEM format.
    })
    kubernetes_cluster_identity = object({ #One of either identity or service_principal must be specified. Assign null if not required. Defines the kubernetes cluster identity to be used
      identity_type = string               #(Required) Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      identity_ids = list(object({         #(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster.    
        identity_name                = string
        identity_resource_group_name = string
      }))
    })
    kubernetes_cluster_web_app_routing = object({      #(Required) Specifies the ID of the DNS Zone in which DNS entries are created for applications deployed to the cluster when Web App Routing is enabled.
      web_app_routing_dns_zone_name           = string #(Required) Specifies the name of the DNS Zone in which DNS entries are created for applications deployed to the cluster when Web App Routing is enabled.  
      web_app_routing_dns_zone_resource_group = string #(Required) Specifies the resourec group of the DNS Zone in which DNS entries are created for applications deployed to the cluster when Web App Routing is enabled.
    })

    kubernetes_cluster_ingress_application_gateway = object({         #(Optional) Assign null if not required. Defines AGIC ingress controller application gateway 
      ingress_application_gateway_exists                     = bool   #(Required) Assign true if the application gateway already exists. Assign false if new Application gateway needs to be created
      ingress_application_gateway_resource_group_name        = string #(Optional) Name of the resource group where the ingress application gateway exists
      ingress_application_gateway_name                       = string #(Required)  The name of the Application Gateway to be used or created in the Nodepool Resource Group, which in turn will be integrated with the ingress controller of this Kubernetes Cluster.
      ingress_application_gateway_subnet_exists              = bool   #(Required). Assign true if the application gateway already exists. Assign false if new Application gateway needs to be created
      ingress_application_gateway_subnet_cidr                = string #(Optional) The subnet CIDR to be used to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. Pass this value or either ingress_application_gateway_subnet_name
      ingress_application_gateway_subnet_name                = string #(Optional) The name of the subnet on which to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. Pass this value or either ingress_application_gateway_subnet_cidr
      ingress_application_gateway_subnet_resource_group_name = string #(Optional) Name of the resource group where the subnet exist
      ingress_application_gateway_virtual_network_name       = string #(Optional) Name of the virtual network which the subnet belongs to
    })

    kubernetes_cluster_key_management_service = object({       #(Optional) Assign null if not required. refer https://learn.microsoft.com/en-us/azure/aks/use-kms-etcd-encryption for details 
      key_management_service_key_vault_key_name       = string #(Required) Name of Azure Key Vault key. When Azure Key Vault key management service is enabled, this field is required and must be a valid key identifier. When enabled is false, leave the field empty. 
      key_management_service_key_vault_network_access = string # (Optional) Network access of the key vault Network access of key vault. The possible values are Public and Private. Public means the key vault allows public access from all networks. Private means the key vault disables public access and enables private link. The default value is Public.
    })

    kubernetes_cluster_key_vault_secrets_provider = object({       #(Optional) Assign null if not required. refer https://learn.microsoft.com/en-us/azure/aks/csi-secrets-store-driver for details 
      key_vault_secrets_provider_secret_rotation_enabled  = bool   #(Optional) Should the secret store CSI driver on the AKS cluster be enabled?
      key_vault_secrets_provider_secret_rotation_interval = string #(Required) The interval to poll for secret rotation. This attribute is only set when secret_rotation is true and defaults to 2m
    })

    kubernetes_cluster_kubelet_identity = object({                    #Optional. Pass as null if not required. Block defines the identities to be assigned to kubelet
      kubelet_identity_client_id                             = string #(Required) The Client ID of the user-defined Managed Identity to be assigned to the Kubelets. If not specified a Managed Identity is created automatically.
      kubelet_identity_object_id                             = string #(Required) The Object ID of the user-defined Managed Identity assigned to the Kubelets.If not specified a Managed Identity is created automatically.
      kubelet_identity_user_assigned_identity_name           = string #(Required) The ID of the User Assigned Identity assigned to the Kubelets. If not specified a Managed Identity is created automatically.
      kubelet_identity_user_assigned_identity_resource_group = string #(Required) The ID of the User Assigned Identity assigned to the Kubelets. If not specified a Managed Identity is created automatically.
    })

    kubernetes_cluster_kubernetes_version = string                #(Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade).
    kubernetes_cluster_linux_profile = object({                   #(Optional) Pass as null if not required. Changing any parameter forces a new resource to be created.
      linux_profile_admin_username_key_vault_secret_name = string #(Required) Pass the secret name where the adminuser name is stored. Pass null if not stored in key vault
      linux_profile_admin_username                       = string #(Optional) The Admin Username for the Cluster if it is not present in key vault 
      linux_profile_ssh_key_secret_exist                 = bool   #(Required) Set true if the public key is present in key vault. Set false where a new public and private key is generated. Public key will be stored in name provided in linux_profile_ssh_key_secret_name, private key will be stored in the same secret name appended with private. Keys generated using RSA algo with 4096 rsa bits
      linux_profile_ssh_key_secret_name                  = string #(Required) If linux_profile_ssh_key_secret_exist is true then the secret is fetched from the given secret name else the new public key generated is stored in given secret name
    })
    kubernetes_cluster_local_account_disabled = bool #(Optional) If true local accounts will be disabled. Defaults to false. If local_account_disabled is set to true, it is required to enable Kubernetes RBAC and AKS-managed Azure AD integration. 
    kubernetes_cluster_maintenance_window = object({ #(Optional) Pass as null if not required.
      maintenance_window_allowed = list(object({     #(Optional) Pass as null if not required.
        allowed_day   = string                       #(Required) A day in a week. Possible values are Sunday, Monday, Tuesday, Wednesday, Thursday, Friday and Saturday.
        allowed_hours = number                       #(Required) An array of hour slots in a day. For example, specifying 1 will allow maintenance from 1:00am to 2:00am. Specifying 1, 2 will allow maintenance from 1:00am to 3:00m. Possible values are between 0 and 23.
      }))
      maintenance_window_not_allowed = list(object({ #(Optional) Pass as null if not required.
        not_allowed_end   = string                   #(Required) The end of a time span, formatted as an RFC3339 string.
        not_allowed_start = string                   #(Required) The start of a time span, formatted as an RFC3339 string.
      }))
    })

    kubernetes_cluster_maintenance_window_auto_upgrade = object({ #(Optional) Pass as null if not required.
      maintenance_window_auto_upgrade_frequency   = string        #(Required) Frequency of maintenance. Possible options are Weekly, AbsoluteMonthly and RelativeMonthly.
      maintenance_window_auto_upgrade_interval    = string        #(Required) The interval for maintenance runs. Depending on the frequency this interval is week or month based.
      maintenance_window_auto_upgrade_duration    = number        #(Required) The duration of the window for maintenance to run in hours.
      maintenance_window_auto_upgrade_day_of_week = string        #(Optional) The day of the week for the maintenance run. Options are Monday, Tuesday, Wednesday, Thurday, Friday, Saturday and Sunday. Required in combination with weekly frequency.
      maintenance_window_auto_upgrade_week_index  = string        #(Optional) The week in the month used for the maintenance run. Options are First, Second, Third, Fourth, and Last. Required in combination with relative monthly frequency.
      maintenance_window_auto_upgrade_start_time  = string        #(Optional) The time for maintenance to begin, based on the timezone determined by utc_offset. Format is HH:mm.
      maintenance_window_auto_upgrade_utc_offset  = string        #(Optional) Used to determine the timezone for cluster maintenance.
      maintenance_window_auto_upgrade_start_date  = string        #(Optional) The date on which the maintenance window begins to take effect.
      maintenance_window_auto_upgrade_not_allowed = list(object({ #(Optional) Pass as null if not required.
        not_allowed_end   = string                                #(Required) The end of a time span, formatted as an RFC3339 string.
        not_allowed_start = string                                #(Required) The start of a time span, formatted as an RFC3339 string.
      }))
    })

    kubernetes_cluster_maintenance_window_node_os = object({ #(Optional) Pass as null if not required.
      maintenance_window_node_os_frequency   = string        #(Required) Frequency of maintenance. Possible options are Weekly, AbsoluteMonthly and RelativeMonthly.
      maintenance_window_node_os_interval    = string        #(Required) The interval for maintenance runs. Depending on the frequency this interval is week or month based.
      maintenance_window_node_os_duration    = number        #(Required) The duration of the window for maintenance to run in hours.
      maintenance_window_node_os_day_of_week = string        #(Optional) The day of the week for the maintenance run. Options are Monday, Tuesday, Wednesday, Thurday, Friday, Saturday and Sunday. Required in combination with weekly frequency.
      maintenance_window_node_os_week_index  = string        #(Optional) The week in the month used for the maintenance run. Options are First, Second, Third, Fourth, and Last. Required in combination with relative monthly frequency.
      maintenance_window_node_os_start_time  = string        #(Optional) The time for maintenance to begin, based on the timezone determined by utc_offset. Format is HH:mm.
      maintenance_window_node_os_utc_offset  = string        #(Optional) Used to determine the timezone for cluster maintenance.
      maintenance_window_node_os_start_date  = string        #(Optional) The date on which the maintenance window begins to take effect.
      maintenance_window_node_os_not_allowed = list(object({ #(Optional) Pass as null if not required.
        not_allowed_end   = string                           #(Required) The end of a time span, formatted as an RFC3339 string.
        not_allowed_start = string                           #(Required) The start of a time span, formatted as an RFC3339 string.
      }))
    })

    kubernetes_cluster_microsoft_defender = object({                #(Optional) Pass as null if not required.
      microsoft_defender_log_analytics_workspace_name      = string #(Required) Specifies the name of the Log Analytics Workspace where the audit logs collected by Microsoft Defender should be sent to.
      microsoft_defender_log_analytics_resource_group_name = string ##(Required) Specifies the resource group name of the Log Analytics Workspace where the audit logs collected by Microsoft Defender should be sent to.
    })

    kubernetes_cluster_monitor_metrics = object({        #(Optional) Specifies a Prometheus add-on profile for the Kubernetes Cluster. 
      monitor_metrics_annotations_allowed = list(string) #(Optional) Specifies a comma-separated list of Kubernetes annotation keys that will be used in the resource's labels metric.
      monitor_metrics_labels_allowed      = list(string) #(Optional) Specifies a Comma-separated list of additional Kubernetes label keys that will be used in the resource's labels metric.
    })

    kubernetes_cluster_network_profile = object({                 #(Optional) Pass as null if not required.
      network_profile_network_plugin      = string                #(Required) Network plugin to use for networking. Currently supported values are azure, kubenet and none. Changing this forces a new resource to be created.When network_plugin is set to azure - the vnet_subnet_id field in the default_node_pool block must be set and pod_cidr must not be set.
      network_profile_network_mode        = string                #(Optional) Network mode to be used with Azure CNI. Possible values are bridge and transparent. Changing this forces a new resource to be created. network_mode can only be set to bridge for existing Kubernetes Clusters and cannot be used to provision new Clusters - this will be removed by Azure in the future. This property can only be set when network_plugin is set to azure 
      network_profile_network_policy      = string                #(Optional) Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created. When network_policy is set to azure, the network_plugin field can only be set to azure.
      network_profile_dns_service_ip      = string                #(Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created.
      network_profile_ebpf_data_plane     = string                #(Optional) Specifies the eBPF data plane used for building the Kubernetes network. Possible value is cilium. Disabling this forces a new resource to be created.
      network_profile_network_plugin_mode = string                #(Optional) Specifies the network plugin mode used for building the Kubernetes network. Possible value is overlay.
      network_profile_outbound_type       = string                #(Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer, userDefinedRouting, managedNATGateway and userAssignedNATGateway. Defaults to loadBalancer. Defaults to loadBalancer. Changing this forces a new resource to be created.
      network_profile_pod_cidr            = string                #(Optional) The CIDR to use for pod IP addresses. This field can only be set when network_plugin is set to kubenet. Changing this forces a new resource to be created.
      network_profile_pod_cidrs           = string                #(Optional) A list of CIDRs to use for pod IP addresses. For single-stack networking a single IPv4 CIDR is expected. For dual-stack networking an IPv4 and IPv6 CIDR are expected. Changing this forces a new resource to be created.
      network_profile_service_cidr        = string                #(Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created. This range should not be used by any network element on or connected to this VNet. Service address CIDR must be smaller than /12. docker_bridge_cidr, dns_service_ip and service_cidr should all be empty or all should be set.
      network_profile_service_cidrs       = list(string)          #(Optional) A list of CIDRs to use for Kubernetes services. For single-stack networking a single IPv4 CIDR is expected. For dual-stack networking an IPv4 and IPv6 CIDR are expected. Changing this forces a new resource to be created.
      network_profile_ip_versions         = list(string)          #(Optional) Specifies a list of IP versions the Kubernetes Cluster will use to assign IP addresses to its nodes and pods. Possible values are IPv4 and/or IPv6. IPv4 must always be specified. Changing this forces a new resource to be created. To configure dual-stack networking ip_versions should be set to ["IPv4", "IPv6"]
      network_profile_load_balancer_sku   = string                #(Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard. Defaults to standard. (Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard. Defaults to standard. Changing this forces a new resource to be created.
      network_profile_load_balancer_profile = object({            # (Optional) A load_balancer_profile block. This can only be specified when load_balancer_sku is set to standard. Pass as null if not required.
        load_balancer_profile_idle_timeout_in_minutes   = number  #(Optional) Desired outbound flow idle timeout in minutes for the cluster load balancer. Must be between 4 and 120 inclusive. Defaults to 30.
        load_balancer_profile_managed_outbound_ip_count = number  #(Optional) Count of desired managed outbound IPs for the cluster load balancer. Must be between 1 and 100 inclusive.
        load_balancer_profile_outbound_ip_address = list(object({ #(Optional) Pass as null if not required. 
          outbound_ip_address_name                = string        #(Optional) The names of the Public IP Addresses which should be used for outbound communication for the cluster load balancer.
          outbound_ip_address_resource_group_name = string        #(Optional) The names of the Public IP Addresses which should be used for outbound communication for the cluster load balancer.
        }))
        load_balancer_profile_outbound_ip_prefix_name                = string #(Optional) The name of the outbound Public IP Address Prefixes which should be used for the cluster load balancer.
        load_balancer_profile_outbound_ip_prefix_resource_group_name = string #(Optional) The resource group name of the outbound Public IP Address Prefixes which should be used for the cluster load balancer.
        load_balancer_profile_outbound_ports_allocated               = number #(Optional) Number of desired SNAT port for each VM in the clusters load balancer. Must be between 0 and 64000 inclusive. Defaults to 0.
        load_balancer_profile_managed_outbound_ipv6_count            = number # (Optional) The desired number of IPv6 outbound IPs created and managed by Azure for the cluster load balancer. Must be in the range of 1 to 100 (inclusive). The default value is 0 for single-stack and 1 for dual-stack. 
      })
      network_profile_nat_gateway_profile = object({           #(Optional) A nat_gateway_profile block. This can only be specified when load_balancer_sku is set to standard and outbound_type is set to managedNATGateway or userAssignedNATGateway.
        nat_gateway_profile_idle_timeout_in_minutes   = number #(Optional) Desired outbound flow idle timeout in minutes for the cluster load balancer. Must be between 4 and 120 inclusive. Defaults to 4.
        nat_gateway_profile_managed_outbound_ip_count = number #(Optional) Count of desired managed outbound IPs for the cluster load balancer. Must be between 1 and 100 inclusive.
      })
    })
    kubernetes_cluster_node_os_channel_upgrade  = string   #(Optional) The upgrade channel for this Kubernetes Cluster Nodes' OS Image. Possible values are Unmanaged, SecurityPatch, NodeImage and None.
    kubernetes_cluster_node_resource_group_name = string   #(Optional) The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created. Azure requires that a new, non-existent Resource Group is used, as otherwise the provisioning of the Kubernetes Service will fail.
    kubernetes_cluster_oidc_issuer_enabled      = bool     #Required) Enable or Disable the OIDC issuer URL
    kubernetes_cluster_oms_agent = object({                #(Optional) Pass as null if not required.
      oms_agent_log_analytics_workspace_name      = string #(Required) The Name of the Log Analytics Workspace which the OMS Agent should send data to.
      oms_agent_log_analytics_resource_group_name = string #(Required) The Resource Group of the Log Analytics Workspace which the OMS Agent should send data to.
      oms_agent_msi_auth_for_monitoring_enabled   = bool   #Is managed identity authentication for monitoring enabled?
    })

    kubernetes_cluster_service_mesh_profile = object({               #(Optional) Pass as null if not required.
      service_mesh_profile_mode                             = string #(Required) The mode of the service mesh. Possible value is Istio.
      service_mesh_profile_internal_ingress_gateway_enabled = bool   #(Optional) Is Istio Internal Ingress Gateway enabled?
      service_mesh_profile_external_ingress_gateway_enabled = bool   #(Optional) Is Istio External Ingress Gateway enabled?
    })

    kubernetes_cluster_open_service_mesh_enabled            = bool   #(Optional) Open Service Mesh needs to be enabled
    kubernetes_cluster_private_cluster_enabled              = bool   #(Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created.
    kubernetes_cluster_private_dns_zone_name                = string #(Optional)Use when kubernetes_cluster_private_cluster_enabled is set to true. Either the Name of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None. In case of None you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning. Changing this forces a new resource to be created.
    kubernetes_cluster_private_dns_zone_resource_group_name = string #(Optional)Resource Group name for kubernetes_cluster_private_dns_zone_name Assign null if not required.
    kubernetes_cluster_private_cluster_public_fqdn_enabled  = bool   #(Optional) Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to false.
    kubernetes_cluster_public_network_access_enabled        = bool   #(Optional) Whether public network access is allowed for this Kubernetes Cluster. Defaults to true. Changing this forces a new resource to be created. When public_network_access_enabled is set to true, 0.0.0.0/32 must be added to api_server_authorized_ip_ranges
    kubernetes_cluster_role_based_access_control_enabled    = bool   #(Optional) - Whether Role Based Access Control for the Kubernetes Cluster should be enabled. Defaults to true. Changing this forces a new resource to be created.
    kubernetes_cluster_run_command_enabled                  = bool   #(Optional) Whether to enable run command for the cluster or not. Defaults to true
    kubernetes_cluster_service_principal = object({                  #(Optional) A service_principal block as documented below. One of either identity or service_principal must be specified. Pass as null if not required
      service_principal_client_id          = string                  #(Required) The Client ID for the Service Principal.
      service_principal_client_secret_name = string                  #(Required) The Client Secret for the Service Principal.
    })

    kubernetes_cluster_storage_profile = object({          #(Optional) A storage_profile block as defined below.
      storage_profile_blob_driver_enabled         = bool   #(Optional) Is the Blob CSI driver enabled? Defaults to false.
      storage_profile_disk_driver_enabled         = bool   #(Optional) Is the Disk CSI driver enabled? Defaults to true.
      storage_profile_disk_driver_version         = string #(Optional) Disk CSI Driver version to be used. Possible values are v1 and v2. Defaults to v1.
      storage_profile_file_driver_enabled         = bool   #(Optional) Is the File CSI driver enabled? Defaults to true.
      storage_profile_snapshot_controller_enabled = bool   #(Optional) Is the Snapshot Controller enabled? Defaults to true.
    })

    kubernetes_cluster_sku_tier = string                            #(Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free.
    kubernetes_cluster_tags     = map(string)                       #(Optional) A mapping of tags to assign to the resource.   
    kubernetes_cluster_windows_profile = object({                   #(Optional) Pass as null if not required. Changing any parameter forces a new resource to be created.
      windows_profile_admin_username_key_vault_secret_name = string #(Required) Pass the secret name where the adminuser name is stored. Pass null if not stored in key vault
      windows_profile_admin_username                       = string #(Optional) The Admin Username for the Windows VMs if not present in key vault
      windows_profile_admin_password_secret_exist          = bool   #(Required) Set true if the password is present in key vault else new password will be generated 
      windows_profile_admin_password_secret_name           = string #(Required) If windows_profile_admin_password_secret_exist is true then the Admin Password is read from given secret else the new generated password is stored in the given secret. Length must be between 14 and 123 characters.
      windows_profile_admin_password_length                = number #(Required) Password Length. Length must be between 14 and 123 characters. Password generated will contain minimum of 4 lower case, 4 upper case, 2 numeric and 2 special character
      windows_profile_license                              = string #(Optional) Specifies the type of on-premise license which should be used for Node Pool Windows Virtual Machine. At this time the only possible value is Windows_Server
      kubernetes_cluster_gmsa = list(object({                       #(Optional) A gmsa block as defined below.
        gmsa_dns_server  = string                                   #(Required) Specifies the DNS server for Windows gMSA. Set this to an empty string if you have configured the DNS server in the VNet which was used to create the managed cluster.
        gmsa_root_domain = string                                   #(Required) Specifies the root domain name for Windows gMSA. Set this to an empty string if you have configured the DNS server in the VNet which was used to create the managed cluster.
      }))
    })
  }))
  default = {}
}
