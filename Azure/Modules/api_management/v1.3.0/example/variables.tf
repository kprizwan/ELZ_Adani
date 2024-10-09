#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  type = map(object({
    resource_group_name       = string      #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = string      #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags       = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups"
  default = {
  }
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

#NETWORK SECURITY GROUP VARIABLES
variable "network_security_group_variables" {
  type = map(object({
    network_security_group_name                = string                           # (Required) Specifies the name of the network security group
    network_security_group_resource_group_name = string                           # (Required) The name of the resource group in which to create the network security group
    network_security_group_location            = string                           # (Required) Specifies the supported Azure location where the resource exists
    network_security_group_security_rule = map(object({                           # (Optional) List of objects representing security rules
      security_rule_name                                           = string       # (Required) The name of the security rule
      security_rule_application_security_group_resource_group_name = string       # (Optional) The resource group name of the application security group
      security_rule_description                                    = string       # (Optional) A description for this rule. Restricted to 140 characters 
      security_rule_protocol                                       = string       # (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
      security_rule_source_port_range                              = string       # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified.
      security_rule_source_port_ranges                             = list(string) # (Optional) List of source ports or port ranges. This is required if source_port_range is not specified
      security_rule_destination_port_range                         = string       # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
      security_rule_destination_port_ranges                        = list(string) # (Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified.
      security_rule_source_address_prefix                          = string       # (Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified
      security_rule_source_address_prefixes                        = list(string) # (Optional) Tags may not be used. This is required if source_address_prefix is not specified.
      security_rule_source_application_security_group_names = map(object({
        application_security_group_name                = string
        application_security_group_resource_group_name = string
      }))                                                       # (Optional) A list of source application security group ids
      security_rule_destination_address_prefix   = string       # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if destination_address_prefixes is not specified.
      security_rule_destination_address_prefixes = list(string) # (Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified
      security_rule_destination_application_security_group_names = map(object({
        application_security_group_name                = string
        application_security_group_resource_group_name = string
      }))                              # (Optional) A list of destination application security group ids
      security_rule_access    = string # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny
      security_rule_priority  = string # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule
      security_rule_direction = string # (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound
    }))
    network_security_group_tags = map(string) #(Optional) A mapping of tags which should be assigned to the Network Security Group.
  }))
  description = "Map of object for network security group details"
  default     = {}
}



#VIRTUAL NETWORK VARIABLE
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
  type = map(object({
    subnet_name                                          = string       # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = string       #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_virtual_network_name                          = string       #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = list(string) #(Required) The address prefixes to use for the subnet.
    subnet_private_link_service_network_policies_enabled = bool         # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled     = bool         # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_service_endpoints                             = list(string) #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    subnet_service_endpoint_policy_ids                   = list(string) #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    delegation = list(object({
      delegation_name            = string       #(Required) A name for this delegation.
      service_delegation_name    = string       # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = list(string) #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }))
  }))
  default = {}
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
    key_vault_purge_protection_enabled              = bool         #(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
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
  default = {
  }
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
}

#PUBLIC IP VARIABLES
variable "public_ip_variables" {
  type = map(object({
    public_ip_name                                     = string       # (Required) Specifies the name of the Public IP. 
    public_ip_resource_group_name                      = string       # (Required) The name of the Resource Group where this Public IP should exist. 
    public_ip_location                                 = string       # (Required) Specifies the supported Azure location where the Public IP should exist. 
    public_ip_ip_version                               = string       # (Optional) The IP Version to use, IPv6 or IPv4.
    public_ip_allocation_method                        = string       # (Required) Defines the allocation method for this IP address. Possible values are Static or Dynamic.
    public_ip_sku                                      = string       # (Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic.
    public_ip_sku_tier                                 = string       # (Optional) The SKU Tier that should be used for the Public IP. Possible values are Regional and Global. Defaults to Regional.
    public_ip_zones                                    = list(string) # (Optional) A collection containing the availability zone to allocate the Public IP in.
    public_ip_edge_zone                                = string       # (Optional) Specifies the Edge Zone within the Azure Region where this Public IP should exist. 
    public_ip_domain_name_label                        = string       # (Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system.
    public_ip_idle_timeout_in_minutes                  = string       # (Optional) Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes.
    public_ip_reverse_fqdn                             = string       # (Optional) A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN.
    public_ip_prefix_id                                = string       # (Optional) If specified then public IP address allocated will be provided from the public IP prefix resource.
    public_ip_ip_tags                                  = map(string)  # (Optional) A mapping of IP tags to assign to the public IP.
    public_ip_is_ddos_protection_plan_enabled          = bool         # (Required) True if ddos_protection_plan enabled, else false
    public_ip_ddos_protection_plan_name                = string       # (Optional) The Name of DDoS protection plan associated with the public IP.
    public_ip_ddos_protection_plan_resource_group_name = string       # (Optional) The Resource group name of DDoS protection plan associated with the public IP.
    public_ip_ddos_protection_mode                     = string       # (Optional) The DDoS protection mode of the public IP. Possible values are Disabled, Enabled, and VirtualNetworkInherited. Defaults to VirtualNetworkInherited.
    public_ip_tags                                     = map(string)  # (Optional) Public IP tags
  }))
  description = "Map of object of Pubic IP variables"
  default     = {}
}

#API MANAGEMENT VARIABLES
variable "api_management_variables" {
  type = map(object({
    api_management_name                = string #(Required) The name of the API Management Service. Changing this forces a new resource to be created.
    api_management_location            = string #(Required) The Azure location where the API Management Service exists. Changing this forces a new resource to be created.
    api_management_resource_group_name = string #(Required) The name of the Resource Group in which the API Management Service should be exist. Changing this forces a new resource to be created.
    api_management_publisher_name      = string #(Required) The name of publisher/company.
    api_management_publisher_email     = string #(Required) The email of publisher/company.
    api_management_sku_name            = string #(Required) sku_name is a string consisting of two parts separated by an underscore(_). The first part is the name, valid values include: Consumption, Developer, Basic, Standard and Premium. The second part is the capacity (e.g. the number of deployed units of the sku), which must be a positive integer (e.g. Developer_1).

    api_management_additional_location = list(object({                         #(Optional) One or more additional_location blocks as defined below.
      additional_location_location                              = string       #(Required) The name of the Azure Region in which the API Management Service should be expanded to.
      additional_location_capacity                              = number       #(Optional) The number of compute units in this region. Defaults to the capacity of the main region.
      additional_location_zones                                 = list(string) #(Optional) A list of availability zones.
      additional_location_public_ip_address_name                = string       #(Optional) name of a standard SKU IPv4 Public IP.
      additional_location_public_ip_address_resource_group_name = string       #(Optional) resource group name of a standard SKU IPv4 Public IP.
      additional_location_virtual_network_configuration = object({             #(Optional) A virtual_network_configuration block as defined below. Required when virtual_network_type is External or Internal.
        virtual_network_configuration_subnet_name                = string      #(Required) The id of the subnet that will be used for the API Management.
        virtual_network_configuration_virtual_network_name       = string      #(Required) The id of the subnet that will be used for the API Management.
        virtual_network_configuration_subnet_resource_group_name = string      #(Required) The id of the subnet that will be used for the API Management.
      })
      additional_location_gateway_disabled = string #(Optional) Only valid for an Api Management service deployed in multiple locations. This can be used to disable the gateway in this additional location.  
    }))

    api_management_certificate_key_vault_name                = string #(Optional) Only required if api_management_certificate block is passed. The key vault where Base64 encoded certificate and certificate password is stored
    api_management_certificate_key_vault_resource_group_name = string #(Optional) Only required if api_management_certificate block is passed. The key vault resource group, where Base64 encoded certificate and certificate password is stored

    api_management_certificate = map(object({               #(Optional) One or more (up to 10) certificate blocks as defined below.
      certificate_encoded_certificate_name         = string #(Required) The key vault secret where Base64 Encoded PFX or Base64 Encoded X.509 Certificate is stored. this is referred from api_management_certificate_key_vault_name
      certificate_store_name                       = string #(Required) The name of the Certificate Store where this certificate should be stored. Possible values are CertificateAuthority and Root.
      certificate_certificate_password_secret_name = bool   #(Optional) The key vault secret where password for the certificate is stored. this is referred from api_management_certificate_key_vault_name
    }))

    api_management_delegation = object({
      delegation_subscriptions_enabled     = bool   #(Optional) Should subscription requests be delegated to an external url? Defaults to false.
      delegation_user_registration_enabled = bool   #(Optional) Should user registration requests be delegated to an external url? Defaults to false.
      delegation_url                       = string #(Optional) The delegation URL.
      delegation_validation_key            = string #(Optional) A base64-encoded validation key to validate, that a request is coming from Azure API Management.
    })

    api_management_client_certificate_enabled = bool         #(Optional) Enforce a client certificate to be presented on each request to the gateway? This is only supported when SKU type is Consumption.
    api_management_gateway_disabled           = bool         #(Optional) Disable the gateway in main region? This is only supported when additional_location is set.
    api_management_min_api_version            = string       #(Optional) The version which the control plane API calls to API Management service are limited with version equal to or newer than.
    api_management_zones                      = list(string) #(Optional) Specifies a list of Availability Zones in which this API Management service should be located. Changing this forces a new API Management service to be created.

    api_management_identity = object({                  #(Optional) An identity block as defined below.
      identity_type = string                            #(Required) Specifies the type of Managed Service Identity that should be configured on this API Management Service. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      identity_user_assigned_identities = list(object({ #(Optional) A list of User Assigned Managed Identity IDs to be assigned to this API Management Service. This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
        identity_name                = string           #user assigned identity name Required if identity type ="systemassigned" or "systemassigned,userassigned"
        identity_resource_group_name = string           #resource group name of the user identity
      }))
    })

    api_management_hostname_configuration = object({                              #(Optional) A hostname_configuration block as defined below.
      hostname_configuration_key_vault_name                              = string #(Optional) The name of the Key Vault containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
      hostname_configuration_key_vault_resource_group_name               = string #(Optional) The resource group of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
      hostname_configuration_ssl_keyvault_identity_client_type           = string #(Optional) Possible values are SystemAssigned, UserAssigned. Pass null if not required
      hostname_configuration_ssl_keyvault_identity_client_id             = string #(Optional) The client id of the System or User Assigned Managed identity generated by Azure AD, which has GET access to the keyVault containing the SSL certificate. If User Assigned Managed identity is used in this field, please assign User Assigned Managed identity to the azurerm_api_management as well.
      hostname_configuration_ssl_keyvault_identity_client_name           = string #(Optional) The User Assigned Managed identity name , which has GET access to the keyVault containing the SSL certificate. If User Assigned Managed identity is used in this field, please assign User Assigned Managed identity to the azurerm_api_management as well.
      hostname_configuration_ssl_keyvault_identity_client_resource_group = string #(Optional) The User Assigned Managed identity resource group name , which has GET access to the keyVault containing the SSL certificate. If User Assigned Managed identity is used in this field, please assign User Assigned Managed identity to the azurerm_api_management as well.
      hostname_configuration_management = list(object({                           #(Optional) One or more management blocks as documented below.
        management_host_name                    = string                          #(Required) The Hostname to use for the Management API.
        management_key_vault_secret_name        = string                          #(Optional) The name of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12. Setting this field requires the identity block to be specified, since this identity is used for to retrieve the Key Vault Certificate. Auto-updating the Certificate from the Key Vault requires the Secret version isn't specified.
        management_negotiate_client_certificate = bool                            #(Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
      }))

      hostname_configuration_portal = list(object({  #(Optional) One or more portal blocks as documented below.
        portal_host_name                    = string #(Required) The Hostname to use for the Management API.
        portal_key_vault_secret_name        = string #(Optional) The name of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
        portal_negotiate_client_certificate = bool   #(Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
      }))

      hostname_configuration_developer_portal = list(object({  #(Optional) One or more developer_portal blocks as documented below.
        developer_portal_host_name                    = string #(Required) The Hostname to use for the Management API.
        developer_portal_key_vault_secret_name        = string #(Optional) The name of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
        developer_portal_negotiate_client_certificate = bool   #(Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
      }))

      hostname_configuration_proxy = list(object({  #(Optional) One or more proxy blocks as documented below.
        proxy_default_ssl_binding          = bool   #(Optional) Is the certificate associated with this Hostname the Default SSL Certificate? This is used when an SNI header isn't specified by a client. Defaults to false.
        proxy_host_name                    = string #(Required) The Hostname to use for the Management API.
        proxy_key_vault_secret_name        = string #(Optional) The name of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
        proxy_negotiate_client_certificate = bool   #(Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
      }))
      hostname_configuration_scm = list(object({  #(Optional) One or more scm blocks as documented below.
        scm_host_name                    = string #(Required) The Hostname to use for the Management API.
        scm_key_vault_secret_name        = string #(Optional) The name of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
        scm_negotiate_client_certificate = bool   #(Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
      }))
    })

    api_management_notification_sender_email = string #(Optional) Email address from which the notification will be sent.

    api_management_policy = object({ #(Optional) A policy block as defined below.
      policy_xml_content = string    #(Optional) The XML Content for this Policy.
      policy_xml_link    = string    #(Optional) A link to an API Management Policy XML Document, which must be publicly available.
    })

    api_management_protocols = object({ #(Optional) A protocols block as defined below.
      protocols_enable_http2 = bool     #(Optional) Should HTTP/2 be supported by the API Management Service? Defaults to false.
    })

    api_management_security = object({                                    #(Optional) A security block as defined below.
      security_enable_backend_ssl30                                = bool #(Optional) Should SSL 3.0 be enabled on the backend of the gateway? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Ssl30 field
      security_enable_backend_tls10                                = bool #(Optional) Should TLS 1.0 be enabled on the backend of the gateway? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls10 field
      security_enable_backend_tls11                                = bool #(Optional) Should TLS 1.1 be enabled on the backend of the gateway? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls11 field
      security_enable_frontend_ssl30                               = bool #(Optional) Should SSL 3.0 be enabled on the frontend of the gateway? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Ssl30 field
      security_enable_frontend_tls10                               = bool #(Optional) Should TLS 1.0 be enabled on the frontend of the gateway? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10 field
      security_enable_frontend_tls11                               = bool #(Optional) Should TLS 1.1 be enabled on the frontend of the gateway? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11 field
      security_tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = bool #(Optional) Should the TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA field
      security_tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = bool #(Optional) Should the TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA field
      security_tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = bool #(Optional) Should the TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA field
      security_tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = bool #(Optional) Should the TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA field
      security_tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = bool #(Optional) Should the TLS_RSA_WITH_AES_128_CBC_SHA256 cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_128_CBC_SHA256 field
      security_tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = bool #(Optional) Should the TLS_RSA_WITH_AES_128_CBC_SHA cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_128_CBC_SHA field
      security_tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = bool #(Optional) Should the TLS_RSA_WITH_AES_128_GCM_SHA256 cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_128_GCM_SHA256 field
      security_tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = bool #(Optional) Should the TLS_RSA_WITH_AES_256_CBC_SHA256 cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_256_CBC_SHA256 field
      security_tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = bool #(Optional) Should the TLS_RSA_WITH_AES_256_CBC_SHA cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_256_CBC_SHA field
      security_triple_des_ciphers_enabled                          = bool #(Optional) Should the TLS_RSA_WITH_3DES_EDE_CBC_SHA cipher be enabled for alL TLS versions (1.0, 1.1 and 1.2)? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TripleDes168 field
    })

    api_management_sign_in = object({ #(Optional) A sign_in block as defined below.
      sign_in_enabled = bool          #(Required) Should anonymous users be redirected to the sign in page?
    })

    api_management_sign_up = object({              #(Optional) A sign_up block as defined below.
      sign_up_enabled = bool                       #(Required) Can users sign up on the development portal?
      sign_up_terms_of_service = object({          #(Required) A terms_of_service block as defined below.
        terms_of_service_consent_required = bool   #(Required) Should the user be asked for consent during sign up?
        terms_of_service_enabled          = bool   #(Required) Should Terms of Service be displayed during sign up?.
        terms_of_service_text             = string #(Required) The Terms of Service which users are required to agree to in order to sign up.
      })
    })

    api_management_tenant_access = object({ #(Optional) A tenant_access block as defined below.
      tenant_access_enabled = bool          #(Required) Should the access to the management API be enabled?
    })

    api_management_public_ip_address_name                = string #(Optional) name of a standard SKU IPv4 Public IP.
    api_management_public_ip_address_resource_group_name = string #(Optional) resource group of a standard SKU IPv4 Public IP.
    api_management_public_network_access_enabled         = bool   #(Optional) Is public access to the service allowed?. Defaults to true
    api_management_virtual_network_type                  = string #(Optional) The type of virtual network you want to use, valid values include: None, External, Internal. virtual_network_type is Internal or External. And please ensure other necessary ports are open according to api management network configuration.

    api_management_virtual_network_configuration = object({             #(Optional) A virtual_network_configuration block as defined below. Required when virtual_network_type is External or Internal.
      virtual_network_configuration_subnet_name                = string #(Required) The id of the subnet that will be used for the API Management.
      virtual_network_configuration_virtual_network_name       = string #(Required) The id of the subnet that will be used for the API Management.
      virtual_network_configuration_subnet_resource_group_name = string #(Required) The id of the subnet that will be used for the API Management.
    })

    api_management_tags = map(string) #(Optional) A mapping of tags assigned to the resource.
  }))
  description = "Map of API Management Object"
  default     = {}
}
