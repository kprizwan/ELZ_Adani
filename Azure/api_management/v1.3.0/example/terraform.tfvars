#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000001" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location = "eastus2"         #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_managed_by = "ploceus" #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#USER ASSIGNED IDENTITY
user_assigned_identity_variables = {
  "user_assigned_identity_1" = {
    user_assigned_identity_name                = "ploceusuai000001" #(Required) Specifies the name of this User Assigned Identity. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_location            = "eastus2"          # (Required) The Azure Region where the User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_resource_group_name = "ploceusrg000001"  #Required) Specifies the name of the Resource Group within which this User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_tags = {                                 #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#NETWORK SECURITY GROUP
network_security_group_variables = {
  "network_security_group_1" = {
    network_security_group_name                = "ploceusnsg000001" # (Required) Specifies the name of the network security group
    network_security_group_resource_group_name = "ploceusrg000001"  # (Required) The name of the resource group in which to create the network security group
    network_security_group_location            = "eastus2"          # (Required) Specifies the supported Azure location where the resource exists
    network_security_group_security_rule = {                        # (Optional) Map of objects representing security rules
      "nsg_rule_01" = {
        security_rule_name                                           = "ploceusnsgrule000001" # (Required) The name of the security rule
        security_rule_application_security_group_resource_group_name = null                   # (Optional) The resource group name of the application security group
        security_rule_priority                                       = 100                    # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
        security_rule_direction                                      = "Inbound"              # (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.
        security_rule_access                                         = "Allow"                # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.
        security_rule_protocol                                       = "Tcp"                  # (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
        security_rule_source_port_range                              = "*"                    # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified
        security_rule_source_port_ranges                             = null                   # (Optional) List of source ports or port ranges. This is required if source_port_range is not specified
        security_rule_destination_port_range                         = "*"                    # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
        security_rule_destination_port_ranges                        = null                   # (Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified
        security_rule_source_address_prefix                          = "*"                    # (Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified.
        security_rule_source_address_prefixes                        = null                   # (Optional) List of source address prefixes. Tags may not be used. This is required if source_address_prefix is not specified.
        security_rule_destination_address_prefix                     = "*"                    # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if destination_address_prefixes is not specified.
        security_rule_destination_address_prefixes                   = null                   # (Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified.
        security_rule_description                                    = "InboundAllow100"      # (Optional) A description for this rule. Restricted to 140 characters
        security_rule_source_application_security_group_names        = null                   # (Optional) A List of source Application Security Group names
        security_rule_destination_application_security_group_names   = null                   # (Optional) A List of destination Application Security Group names
    } }
    network_security_group_tags = { #(Optional) A mapping of tags which should be assigned to the Network Security Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#VIRTUAL NETWORK
virtual_network_variables = {
  "virtual_network_1" = {
    virtual_network_name                    = "ploceusvnet000001"         #(Required) The name of the virtual network.
    virtual_network_location                = "eastus2"                   #(Required) The location/region where the virtual network is created.
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
    virtual_network_encryption = null /* [
      {
        virtual_network_encryption_enforcement = "AllowUnencrypted"
      }
    ] */
    virtual_network_subnet = [ #(Optional) Can be specified multiple times to define multiple subnets
      {
        virtual_network_subnet_name                                       = "ploceussubnet000001" #(Optional) Can be specified multiple times to define multiple subnets
        virtual_network_subnet_address_prefix                             = "10.0.0.0/24"         #(Required) The address prefix to use for the subnet.
        virtual_network_subnet_network_security_group_name                = "ploceusnsg000001"    #(Optional) The Network Security Group to associate with the subnet.
        virtual_network_subnet_network_security_group_resource_group_name = "ploceusrg000001"     #(Optional) The Network Security Group to associate with the subnet.
      },
      {
        virtual_network_subnet_name                                       = "ploceussubnet000002" #(Optional) Can be specified multiple times to define multiple subnets
        virtual_network_subnet_address_prefix                             = "10.0.1.0/24"         #(Required) The address prefix to use for the subnet.
        virtual_network_subnet_network_security_group_name                = null                  #(Optional) The Network Security Group to associate with the subnet.
        virtual_network_subnet_network_security_group_resource_group_name = null                  #(Optional) The Network Security Group to associate with the subnet.
      }
    ]
    virtual_network_tags = { #(Optional) A mapping of tags which should be assigned to the virtual network.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#SUBNET
subnet_variables = {
  "subnet_1" = {
    subnet_name                                          = "ploceussubnet000003"                                    # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "ploceusrg000001"                                        #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.0.2.0/24"]                                          #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "ploceusvnet000001"                                      #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled = null                                                     # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled     = null                                                     # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_service_endpoint_policy_ids                   = null                                                     #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                             = ["Microsoft.AzureActiveDirectory", "Microsoft.KeyVault"] #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation = [{
      delegation_name            = "delegation000001"                                                                                                                                                                                                #(Required) A name for this delegation.
      service_delegation_name    = "Microsoft.Sql/managedInstances"                                                                                                                                                                                  # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"] #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }]
  }
}

#KEY VAULT
key_vault_variables = {
  "key_vault_1" = {
    key_vault_name                                  = "ploceuskv000001"                                                                                                                                                                               #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_location                              = "eastus2"                                                                                                                                                                                       #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_resource_group_name                   = "ploceusrg000001"                                                                                                                                                                               #(Required) The name of the resource group in which to create the Key Vault.
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
    key_vault_access_policy_key_permissions         = ["Get", "List", "Get", "Create", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                             #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Get", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                       #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"] # (Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    #(Optional) A mapping of tags which should be assigned to the key vault.
    key_vault_tags = { #(Optional) A mapping of tags which should be assigned to the key vault.
      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_network_acls_enabled        = true            #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass         = "AzureServices" #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action = "Allow"         # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
    key_vault_network_acls_ip_rules       = null            # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.

    #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
    key_vault_network_acls_virtual_networks = [ #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
      {
        key_vault_network_acls_virtual_networks_virtual_network_name    = "ploceusvnet000001"              #(Required) Vitural Network name to be associated.
        key_vault_network_acls_virtual_networks_subnet_name             = "ploceussubnet000003"            #(Required) Subnet Name to be associated.
        key_vault_network_acls_virtual_networks_subscription_id         = "xxxxxx-xxxxxxxxx-xxxxxx-xxxxxx" #(Required) Subscription Id where Vnet is created.
        key_vault_network_acls_virtual_networks_virtual_network_rg_name = "ploceusrg000001"                #(Required) Resource group where Vnet is created.
      }
    ]
    key_vault_contact_information_enabled = false #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email               = null  #(Required) E-mail address of the contact.
    key_vault_contact_name                = null  #(Optional) Name of the contact.
    key_vault_contact_phone               = null  #(Optional) Phone number of the contact.
  }
}

#KEY VAULT ACCESS POLICY
key_vault_access_policy_variables = {
  "key_vault_access_policy_1" = {
    key_vault_access_policy_key_permissions         = ["Get", "List", "Get", "Create", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                             #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Get", "Delete", "Recover", "Backup", "Restore", "Purge", "Set"]                                                                                                                #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"] #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_name                                  = "ploceuskv000001"                                                                                                                                                                               #(Required) Specifies the name of the Key Vault resource.
    key_vault_resource_group_name                   = "ploceusrg000001"                                                                                                                                                                               #(Required) Specifies the resource group name where the key vault resides in.
    key_vault_access_resource_name                  = "xxxxxxxxx@ploceus.com"                                                                                                                                                                         #(Required) Specifies the resource name that needs the access policy to the key vault. Possible values are username, group name, service principal name and application name
    key_vault_access_resource_type                  = "User"                                                                                                                                                                                          #(Required) Specifies the type of resource that needs the access policy to the key vault. Possible values are User, SPN, Group, Application
  },
  "key_vault_access_policy_2" = {
    key_vault_access_policy_key_permissions         = ["Get", "List", "Get", "Create", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                             #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Get", "Delete", "Recover", "Backup", "Restore", "Purge", "Set"]                                                                                                                #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"] #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_name                                  = "ploceuskv000001"                                                                                                                                                                               #(Required) Specifies the name of the Key Vault resource.
    key_vault_resource_group_name                   = "ploceusrg000001"                                                                                                                                                                               #(Required) Specifies the resource group name where the key vault resides in.
    key_vault_access_resource_name                  = "ploceusuai000001"                                                                                                                                                                              #"XXXXXXXXXXX@ploceus.com"                                                                                                                                                                       #(Required) Specifies the resource name that needs the access policy to the key vault. Possible values are username, group name, service principal name and application name
    key_vault_access_resource_type                  = "SPN"                                                                                                                                                                                           #(Required) Specifies the type of resource that needs the access policy to the key vault. Possible values are User, SPN, Group, Application
  }
}

#KEY VAULT SECRET
key_vault_secret_variables = {
  "key_vault_secret_1" = {
    key_vault_name                       = "ploceuskv000001"             #(Required) Specifies the name of the Key Vault.
    key_vault_secret_value               = ""                            #(Required) Specifies the value of the Key Vault Secret
    key_vault_secret_content_type        = ""                            #(Optional) Specifies the content type for the Key Vault Secret
    key_vault_secret_not_before_date     = null                          #(Optional) Specifies that the key is not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_expiration_date     = null                          #(Optional) Specifies the expiration UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_resource_group_name = "ploceusrg000001"             #(Required) Specifies the name of the resource group, where the key_vault resides in
    key_vault_secret_name                = "ploceuskeyvaultsecret000001" #(Required) Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created

    key_vault_secret_tags = { #(Optional) A mapping of tags which should be assigned to the key vault secret.

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
    key_vault_certificate_name                          = "ploceuskvcert000001" #(Required) Specifies the name of the Key Vault Certificate. Changing this forces a new resource to be created.
    key_vault_certificate_key_vault_name                = "ploceuskv000001"     #(Required) The name of the Key Vault where the Certificate should be created.
    key_vault_certificate_key_vault_resource_group_name = "ploceusrg000001"     #(Required) The resource group name of the Key Vault where the Certificate should be created.

    key_vault_certificate_password_secret_name      = null  #(Optional) The password associated with the certificate. Use this if you are using an existing certificate stored in key vault, add password as a secret in key vault to fetch.
    key_vault_certificate_contents_secret_name      = null  #(Optional) The base64-encoded certificate contents stored as a secret in key vault. Provide this when 'key_vault_certificate_fetch_certificate_enabled' is true
    key_vault_certificate_file_path                 = null  #(Optional) This is required when you are not specifying 'key_vault_certificate_contents_secret_name', you can give in a relative file path to pointing to your certificate.
    key_vault_certificate_fetch_certificate_enabled = false #(Required) If true, certificate from key vault will be used, otherwise a new certificate will be created and 'key_vault_certificate_certificate_policy' is required. Defaults to false 

    key_vault_certificate_certificate_policy = { #(Optional) A `certificate_policy` block as defined below. Required when 'key_vault_certificate_fetch_certificate_enabled' is true. Changing this will create a new version of the Key Vault Certificate.
      certificate_policy_issuer_parameters = {   #(Required) A `issuer_parameters` block as defined below.
        issuer_parameters_name = "Self"          #(Required) The name of the Certificate Issuer. Possible values include `Self` (for self-signed certificate), or `Unknown` (for a certificate issuing authority like `Let's Encrypt` and Azure direct supported ones). Changing this forces a new resource to be created.
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
      certificate_policy_secret_properties = {                  #(Required) A `secret_properties` block as defined below.
        secret_properties_content_type = "application/x-pkcs12" #(Required) The Content-Type of the Certificate, such as `application/x-pkcs12` for a PFX or `application/x-pem-file` for a PEM. Changing this forces a new resource to be created.
      }
      certificate_policy_x509_certificate_properties = {                       #(Optional) A `x509_certificate_properties` block as defined below. Required when `certificate` block is not specified.
        x509_certificate_properties_extended_key_usage = ["1.3.6.1.5.5.7.3.1"] #(Optional) A list of Extended/Enhanced Key Usages. Changing this forces a new resource to be created.

        #(Required) A list of uses associated with this Key. Possible values include `cRLSign`, `dataEncipherment`, `decipherOnly`, `digitalSignature`, `encipherOnly`, `keyAgreement`, `keyCertSign`, `keyEncipherment` and `nonRepudiation` and are case-sensitive. Changing this forces a new resource to be created.
        x509_certificate_properties_key_usage          = ["cRLSign", "dataEncipherment", "decipherOnly", "digitalSignature", "encipherOnly", "keyAgreement", "keyCertSign", "keyEncipherment", "nonRepudiation"]
        x509_certificate_properties_subject            = "CN=ploceus.com"                              #(Required) The Certificate's Subject. Changing this forces a new resource to be created.
        x509_certificate_properties_validity_in_months = 12                                            #(Required) The Certificates Validity Period in Months. Changing this forces a new resource to be created.
        x509_certificate_properties_subject_alternative_names = {                                      #(Optional) A `subject_alternative_names` block as defined below. Changing this forces a new resource to be created.
          subject_alternative_names_dns_names = null                                                   #(Optional) A list of alternative DNS names (FQDNs) identified by the Certificate. Changing this forces a new resource to be created.
          subject_alternative_names_emails    = ["XXXXXXXXXXX@ploceus.com", "XXXXXXXXXXX@ploceus.org"] #(Optional) A list of email addresses identified by this Certificate. Changing this forces a new resource to be created.
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

#PUBLIC IP
public_ip_variables = {
  "public_ip_1" = {
    public_ip_name                                     = "ploceuspublicip000001"  # (Required) Specifies the name of the Public IP. 
    public_ip_resource_group_name                      = "ploceusrg000001"        # (Required) The name of the Resource Group where this Public IP should exist. 
    public_ip_location                                 = "eastus2"                # (Required) Specifies the supported Azure location where the Public IP should exist. 
    public_ip_ip_version                               = "IPv4"                   # (Optional) The IP Version to use, IPv6 or IPv4.
    public_ip_allocation_method                        = "Static"                 # (Required) Defines the allocation method for this IP address. Possible values are Static or Dynamic.
    public_ip_sku                                      = "Standard"               # (Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic.
    public_ip_sku_tier                                 = "Regional"               # (Optional) The SKU Tier that should be used for the Public IP. Possible values are Regional and Global. Defaults to Regional.
    public_ip_domain_name_label                        = "ploceuspublicip000002a" # (Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system.
    public_ip_prefix_id                                = null                     #  (Optional) If specified then public IP address allocated will be provided from the public IP prefix resource.
    public_ip_idle_timeout_in_minutes                  = "30"                     # (Optional) Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes.
    public_ip_zones                                    = ["1", "3"]               # (Optional) A collection containing the availability zone to allocate the Public IP in.
    public_ip_edge_zone                                = null                     # (Optional) Specifies the Edge Zone within the Azure Region where this Public IP should exist. 
    public_ip_reverse_fqdn                             = null                     # (Optional) A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN.
    public_ip_ip_tags                                  = null                     # (Optional) A mapping of IP tags to assign to the public IP.
    public_ip_is_ddos_protection_plan_enabled          = false                    # (Required) True if ddos_protection_plan enabled, else false
    public_ip_ddos_protection_plan_name                = "ploceusddospplan000001" # (Optional) The Name of DDoS protection plan associated with the public IP.
    public_ip_ddos_protection_plan_resource_group_name = "ploceusrg000001"        # (Optional) The Resource group name of DDoS protection plan associated with the public IP.
    public_ip_ddos_protection_mode                     = "Disabled"               # (Optional) The DDoS protection mode of the public IP. Possible values are Disabled, Enabled, and VirtualNetworkInherited. Defaults to VirtualNetworkInherited.
    public_ip_tags = {                                                            # (Optional) Public IP tags
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#API MANAGEMENT
api_management_variables = {
  api_1 = {
    api_management_name                                      = "ploceusapim000001"     #(Required) The name of the API Management Service. Changing this forces a new resource to be created.
    api_management_location                                  = "eastus2"               #(Required) The Azure location where the API Management Service exists. Changing this forces a new resource to be created.
    api_management_resource_group_name                       = "ploceusrg000001"       #(Required) The name of the Resource Group in which the API Management Service should be exist. Changing this forces a new resource to be created.
    api_management_publisher_name                            = "ploceus"               #(Required) The name of publisher/company.
    api_management_publisher_email                           = "xxxxxxxxx@ploceus.com" #(Required) The email of publisher/company.
    api_management_sku_name                                  = "Developer_1"           #(Required) sku_name is a string consisting of two parts separated by an underscore(_). The first part is the name, valid values include: Consumption, Developer, Basic, Standard and Premium. The second part is the capacity (e.g. the number of deployed units of the sku), which must be a positive integer (e.g. Developer_1).
    api_management_additional_location                       = null
    api_management_certificate_key_vault_name                = "ploceuskv000001" #(Optional) Only required if api_management_certificate block is passed. The key vault where Base64 encoded certificate and certificate password is stored
    api_management_certificate_key_vault_resource_group_name = "ploceusrg000001" #(Optional) Only required if api_management_certificate block is passed. The key vault resource group, where Base64 encoded certificate and certificate password is stored
    api_management_certificate = {                                               #(Optional) One or more (up to 10) certificate blocks as defined below.
      certificate_1 = {
        certificate_encoded_certificate_name         = "ploceuskvcert000001" #(Required) The key vault secret where Base64 Encoded PFX or Base64 Encoded X.509 Certificate is stored. this is referred from api_management_certificate_key_vault_name
        certificate_store_name                       = "Root"                #(Required) The name of the Certificate Store where this certificate should be stored. Possible values are CertificateAuthority and Root.
        certificate_certificate_password_secret_name = false                 #(Optional) The key vault secret where password for the certificate is stored. this is referred from api_management_certificate_key_vault_name
      }
    }
    api_management_delegation                 = null
    api_management_client_certificate_enabled = null  #(Optional) Enforce a client certificate to be presented on each request to the gateway? This is only supported when SKU type is Consumption.
    api_management_gateway_disabled           = false #(Optional) Disable the gateway in main region? This is only supported when additional_location is set.
    api_management_min_api_version            = null  #(Optional) The version which the control plane API calls to API Management service are limited with version equal to or newer than.
    api_management_zones                      = null  #(Optional) Specifies a list of Availability Zones in which this API Management service should be located. Changing this forces a new API Management service to be created.
    api_management_identity = {
      identity_type = "UserAssigned"
      identity_user_assigned_identities = [{              #(Optional) A list of User Assigned Managed Identity IDs to be assigned to this API Management Service. This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
        identity_name                = "ploceusuai000001" #user assigned identity name Required if identity type ="systemassigned" or "systemassigned,userassigned"
        identity_resource_group_name = "ploceusrg000001"  #resource group name of the user identity
      }]
    }
    api_management_hostname_configuration = null #(Optional) A hostname_configuration block as defined below.
    /*Sample Code
      hostname_configuration_key_vault_name                              = null #(Optional) The name of the Key Vault containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
      hostname_configuration_key_vault_resource_group_name               = null #(Optional) The resource group of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
      hostname_configuration_ssl_keyvault_identity_client_type           = null  # Possible values are SystemAssigned, UserAssigned
      hostname_configuration_ssl_keyvault_identity_client_id             = null
      hostname_configuration_ssl_keyvault_identity_client_name           = null #(Optional) The client id of the System or User Assigned Managed identity generated by Azure AD, which has GET access to the keyVault containing the SSL certificate. If User Assigned Managed identity is used in this field, please assign User Assigned Managed identity to the azurerm_api_management as well.
      hostname_configuration_ssl_keyvault_identity_client_resource_group = null #(Optional) The client id of the System or User Assigned Managed identity generated by Azure AD, which has GET access to the keyVault containing the SSL certificate. If User Assigned Managed identity is used in this field, please assign User Assigned Managed identity to the azurerm_api_management as well.
      hostname_configuration_management = [{                          #(Optional) One or more management blocks as documented below.
        management_host_name                    = "ploceushost000001" #(Required) The Hostname to use for the Management API.
        management_key_vault_secret_name        = null  #(Optional) The name of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12. Setting this field requires the identity block to be specified, since this identity is used for to retrieve the Key Vault Certificate. Auto-updating the Certificate from the Key Vault requires the Secret version isn't specified.
        management_negotiate_client_certificate = false               #(Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
        },
        {                                                               #(Optional) One or more management blocks as documented below.
          management_host_name                    = "ploceushost000002" #(Required) The Hostname to use for the Management API.
          management_key_vault_secret_name        = null  #(Optional) The name of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12. Setting this field requires the identity block to be specified, since this identity is used for to retrieve the Key Vault Certificate. Auto-updating the Certificate from the Key Vault requires the Secret version isn't specified.
          management_negotiate_client_certificate = false               #(Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
      }]
      hostname_configuration_portal = null
      hostname_configuration_developer_portal = null
      hostname_configuration_proxy = null
      hostname_configuration_scm = null
    }*/
    api_management_notification_sender_email = null #(Optional) Email address from which the notification will be sent.
    api_management_policy                    = null
    api_management_protocols                 = null
    api_management_security                  = null
    api_management_sign_in                   = null
    api_management_sign_up                   = null
    /* Sample Code
    {                                              #(Optional) A sign_up block as defined below.
      sign_up_enabled = true                       #(Required) Can users sign up on the development portal?
      sign_up_terms_of_service = {          #(Required) A terms_of_service block as defined below.
        terms_of_service_consent_required = true   #(Required) Should the user be asked for consent during sign up?
        terms_of_service_enabled          = true   #(Required) Should Terms of Service be displayed during sign up?.
        terms_of_service_text             = "Will Never pass the data" #(Required) The Terms of Service which users are required to agree to in order to sign up.
      }
    }*/
    api_management_tenant_access = { #(Optional) A tenant_access block as defined below.
      tenant_access_enabled = true   #(Required) Should the access to the management API be enabled?
    }
    api_management_public_ip_address_name                = "ploceuspublicip000001"     #(Optional) name of a standard SKU IPv4 Public IP.
    api_management_public_ip_address_resource_group_name = "ploceusrg000001"           #(Optional) resource group of a standard SKU IPv4 Public IP.
    api_management_public_network_access_enabled         = true                        #(Optional) Is public access to the service allowed?. Defaults to true
    api_management_virtual_network_type                  = "External"                  #(Optional) The type of virtual network you want to use, valid values include: None, External, Internal. virtual_network_type is Internal or External. And please ensure other necessary ports are open according to api management network configuration.
    api_management_virtual_network_configuration = {                                   #(Optional) A virtual_network_configuration block as defined below. Required when api_management_virtual_network_type is External or Internal.
      virtual_network_configuration_subnet_name                = "ploceussubnet000001" #(Required) The id of the subnet that will be used for the API Management.
      virtual_network_configuration_virtual_network_name       = "ploceusvnet000001"   #(Required) The id of the subnet that will be used for the API Management.
      virtual_network_configuration_subnet_resource_group_name = "ploceusrg000001"     #(Required) The id of the subnet that will be used for the API Management.
    }
    api_management_tags = { #(Optional) A mapping of tags assigned to the resource.
      Created_By = "Ploceus"
      Department = "CIS"
    }
  }
}

api_management_subscription_id = "xxxxxxx-xxxxxxx-xxxxxxxxx-xxxxxxxx"
api_management_tenant_id       = "xxxxxxx-xxxxxxx-xxxxxxxxx-xxxxxxxx"
key_vault_subscription_id      = "xxxxxxx-xxxxxxx-xxxxxxxxx-xxxxxxxx"
key_vault_tenant_id            = "xxxxxxx-xxxxxxx-xxxxxxxxx-xxxxxxxx"