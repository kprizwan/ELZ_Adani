#KEY VAULT
key_vault_variables = {
  "key_vault_1" = {
    key_vault_name                                  = "sdplzmgmtdckv01"                                                                                                                                                                               #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_location                              = "Central India"                                                                                                                                                                                 #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_resource_group_name                   = "sd-plz-management-rg"                                                                                                                                                                          #(Required) The name of the resource group in which to create the Key Vault.
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
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
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

#PRIVATE_DNS_ZONE
private_dns_zone_variables = {
  "dnszone1" = {
    private_dns_zone_name                = "privatelink.vaultcore.azure.net" #(Required) The name of the Private DNS Zone. Must be a valid domain name.
    private_dns_zone_resource_group_name = "sd-plz-management-rg"            #(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.
    private_dns_zone_soa_record          = null                              ##(Optional) An soa_record block as defined below. Changing this forces a new resource to be created.
    private_dns_zone_tags = {
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }

}

#PRIVATE ENDPOINT
private_endpoint_variables = {
  "private_endpoint_1" = {

    private_endpoint_name                                = "sdplzmgmtdckv01-vault-pep"         # (Required) private endpoint name
    private_endpoint_resource_group_name                 = "sd-plz-management-rg"              # (Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created.
    private_endpoint_location                            = "Central India"                     #  (Required) The supported Azure location where the resource exists. Changing this forces a new resource to be created.
    private_endpoint_virtual_network_name                = "sd-plz-management-vnet"            #The name of the network interface associated with the private_endpoint
    private_endpoint_virtual_network_resource_group_name = "sd-plz-management-rg"              #(Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created.
    private_endpoint_subnet_name                         = "sd-plz-management-vnet-pe-snet-01" # (Required) subnet in which private endpoint is hosting
    custom_network_interface_name                        = "sdplzmgmtdckv01-vault-pep-nic-01"  #(Optional) The custom name of the network interface attached to the private endpoint. Changing this forces a new resource to be created.
    private_endpoint_private_dns_zone_group = {                                                #(Optional) A private_dns_zone_group block as defined below.  
      private_dns_zone_group_name          = "default"                                         #(Required) Specifies the Name of the Private DNS Zone Group.
      private_dns_zone_names               = ["privatelink.vaultcore.azure.net"]               #(Required) Specifies the list of Private DNS Zones names to include within the private_dns_zone_group.These names will be fetched by the data resource of private_dns_zone name.
      private_dns_zone_resource_group_name = "sd-plz-management-rg"                            #(Required) Specifies the resource group name of Private DNS Zones to include within the private_dns_zone_group.This will be fetched by the data resource of private_dns_zone resource group name.
    }
    private_endpoint_private_service_connection = {                                 #(Required) A private_service_connection block as defined below.
      private_service_connection_name                 = "sdplzmgmtdckv01-vault-pep" #(Required) Specifies the Name of the Private Service Connection. Changing this forces a new resource to be created.
      private_service_connection_is_manual_connection = false                       #(Required) set true if resource_alias != null
      private_connection_resource_name                = "sdplzmgmtdckv01"           #(Optional) The Service Name of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
      private_connection_resource_resource_group_name = "sd-plz-management-rg"      #(Optional) The Service Resource Group Name of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
      private_connection_resource_alias               = null                        #(Optional) The Service Alias of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
      request_message                                 = null                        #(Optional) Should be enabled if the is_manual_connection is set as true.  A message passed to the owner of the remote resource
      subresource_names                               = ["vault"]                   # (Optional) A list of subresource names which the Private Endpoint is able to connect to.
    }
    private_endpoint_ip_configuration = null
    private_endpoint_tags = { #(Optional)A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}

#CONTAINER REGISTRY
container_registry_variables = {
  "container_registry_1" = {
    container_registry_name                          = "sdplzmgmtdcacr01"     #(Required) Specifies the name of the Container Registry. Only Alphanumeric characters allowed. Changing this forces a new resource to be created.
    container_registry_location                      = "Central India"        # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    container_registry_resource_group_name           = "sd-plz-management-rg" # (Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created.
    container_registry_sku                           = "Premium"              # (Required) The SKU name of the container registry. Possible values are Basic, Standard and Premium.
    container_registry_admin_enabled                 = true                   # (Optional) Specifies whether the admin user is enabled. Defaults to false.
    container_registry_export_policy_enabled         = null                   # (Optional) Boolean value that indicates whether export policy is enabled. Defaults to true. In order to set it to false, make sure the public_network_access_enabled is also set to false.
    container_registry_public_network_access_enabled = true                   # (Optional) Whether public network access is allowed for the container registry. Defaults to true.
    container_registry_quarantine_policy_enabled     = false                  # (Optional) Boolean value that indicates whether quarantine policy is enabled. Defaults to false.
    container_registry_zone_redundancy_enabled       = false                  # (Optional) Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created. Defaults to false.
    container_registry_anonymous_pull_enabled        = false                  # (Optional) Whether allows anonymous (unauthenticated) pull access to this Container Registry? Defaults to false. This is only supported on resources with the Standard or Premium SKU.
    container_registry_retention_policy = {
      retention_policy_days    = 7    # (Optional) The number of days to retain an untagged manifest after which it gets purged. Default is 7.
      retention_policy_enabled = true # (Optional) Boolean value that indicates whether the policy is enabled.
    }
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
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}

#EVENTHUB NAMESPACE
eventhub_namespace_variables = {
  "eventhub_namespace_1" = {
    eventhub_namespace_location                             = "Central India"        # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    eventhub_namespace_name                                 = "sd-plz-eventhub-ns"   # (Required) Specifies the name of the EventHub Namespace resource. Changing this forces a new resource to be created.
    eventhub_namespace_resource_group_name                  = "sd-plz-management-rg" # (Required) The name of the resource group in which to create the namespace. Changing this forces a new resource to be created.
    eventhub_namespace_sku                                  = "Standard"             # (Required) Defines which tier to use. Valid options are Basic, Standard, and Premium. Please note that setting this field to Premium will force the creation of a new resource.
    eventhub_namespace_capacity                             = "2"                    # (Optional) Specifies the Capacity / Throughput Units for a Standard SKU namespace. Default capacity has a maximum of 2, but can be increased in blocks of 2 on a committed purchase basis.
    eventhub_namespace_auto_inflate_enabled                 = true                   # (Optional) Is Auto Inflate enabled for the EventHub Namespace?
    eventhub_namespace_maximum_throughput_units             = 2                      # (Optional) Specifies the maximum number of throughput units when Auto Inflate is Enabled. Valid values range from 1 - 20.
    eventhub_namespace_zone_redundant                       = false                  # (Optional) Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). Changing this forces a new resource to be created. Defaults to false.
    eventhub_namespace_dedicated_eventhub_cluster_name      = null                   # (Optional) Specifies the name of the EventHub Cluster resource. Required, when the namespace needs a dedicated eventhub_cluster
    eventhub_namespace_eventhub_cluster_resource_group_name = null                   # (Optional) The name of the resource group in which the EventHub Cluster exists. Required, when the namespace needs a dedicated eventhub_cluster 
    eventhub_namespace_local_authentication_enabled         = false                  # (Optional) Is SAS authentication enabled for the EventHub Namespace?
    eventhub_namespace_public_network_access_enabled        = false                  # (Optional) Is public network access enabled for the EventHub Namespace? Defaults to true.
    eventhub_namespace_minimum_tls_version                  = null                   # (Optional) Specifies the maximum number of throughput units when Auto Inflate is Enabled. Valid values range from 1 - 20.
    eventhub_namespace_identity = {
      eventhub_namespace_identity_type = "SystemAssigned" # (Required) Specifies the type of Managed Service Identity that should be configured on this Eventhub Namespace. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).# Other values could be "UserAssigned", "SystemAssigned" 
      # If given as "SystemAssigned" , then give below parameter as null
      eventhub_namespace_user_assigned_identities = null # (Optional) Eventhub namespace user assigned identities
    }
    eventhub_namespace_network_rulesets = { # (Optional) A network_rulesets block as defined below.
      "eventhub_namespace_network_rulesets_1" = {
        network_rulesets_default_action                 = "Deny" # (Required) The default action to take when a rule is not matched. Possible values are Allow and Deny.
        network_rulesets_trusted_service_access_enabled = false  # (Optional) Whether Trusted Microsoft Services are allowed to bypass firewall.
        network_rulesets_public_network_access_enabled  = false  # (Optional) Is public network access enabled for the EventHub Namespace? Defaults to true.
        network_rulesets_virtual_network_rule           = null
        network_rulesets_ip_rule                        = null # (Optional) One or more ip_rule blocks can be defined with ip_mask & action
      }
    }
    eventhub_namespace_tags = { # (Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}

#EVENTHUB
eventhub_variables = {
  "eventhub_1" = {
    eventhub_capture_description                              = null /*{                                                                                                               #(Optional) A capture_description block supports the following
      capture_description_destination = {                                                                                                          #(Required) A destination block as defined below.
        capture_description_destination_archive_name_format = "{Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}" #(Required) The Blob naming convention for archiving. e.g. {Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}. Here all the parameters (Namespace,EventHub .. etc) are mandatory irrespective of order
        capture_description_destination_blob_container_name = "00001"                                                                #(Required) The name of the Container within the Blob Storage Account where messages should be archived.
        capture_description_destination_name                = "EventHubArchive.AzureBlockBlob"                                                     #(Required) The Name of the Destination where the capture should take place. At this time the only supported value is EventHubArchive.AzureBlockBlob.
      }
      capture_description_enabled             = true     #(Required) Specifies if the Capture Description is Enabled.
      capture_description_encoding            = "Avro"   #(Required) Specifies the Encoding used for the Capture Description. Possible values are Avro and AvroDeflate.
      capture_description_interval_in_seconds = 60       #(Optional) Specifies the time interval in seconds at which the capture will happen. Values can be between 60 and 900 seconds. Defaults to 300 seconds.
      capture_description_size_limit_in_bytes = 10485760 #(Optional) Specifies the amount of data built up in your EventHub before a Capture Operation occurs. Value should be between 10485760 and 524288000 bytes. Defaults to 314572800 bytes.
      capture_description_skip_empty_archives = false    #(Optional) Specifies if empty files should not be emitted if no events occur during the Capture time window. Defaults to false.
    }*/
    eventhub_message_retention                                = 1                      #(Required) Specifies the number of days to retain the events for this Event Hub.
    eventhub_name                                             = "sd-plz-eventhub"      #(Required) Specifies the name of the EventHub resource. Changing this forces a new resource to be created.
    eventhub_namespace_name                                   = "sd-plz-eventhub-ns"   #(Required) Specifies the name of the EventHub Namespace. Changing this forces a new resource to be created.
    eventhub_partition_count                                  = 1                      #(Required) Specifies the current number of shards on the Event Hub. Changing this will force-recreate the resource.
    eventhub_resource_group_name                              = "sd-plz-management-rg" #(Required) The name of the resource group in which the EventHub's parent Namespace exists. Changing this forces a new resource to be created.
    eventhub_status                                           = "Active"               #(Optional) Specifies the status of the Event Hub resource. Possible values are Active, Disabled and SendDisabled. Defaults to Active.
    eventhub_storage_blob_storage_account_name                = null                   #(Optional) To fetch The ID of the Blob Storage Account where messages should be archived.
    eventhub_storage_blob_storage_account_resource_group_name = null                   #(Required) Specifies the name of the resource group the Storage Account is located in. if capture description is enabled.
    eventhub_storage_blob_storage_container_name              = null                   #(Required) The name of the Container within the Blob Storage Account where messages should be archived. if capture description is enabled.
  }
}

#KUBERNETES CLUSTER
kubernetes_cluster_variables = {
  "aks_1" = {
    kubernetes_cluster_name                                                            = "sdplzmgmtaks01"       #(Required) The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created.
    kubernetes_cluster_location                                                        = "Central India"        #(Required) The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created.
    kubernetes_cluster_resource_group_name                                             = "sd-plz-management-rg" # (Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_key_vault_name                                                  = null                   #(Optional) Incase if any secret value is passed for linux_profile, windows_profile, azure_active_directory_role_based_access_control(azure_active_directory_role_based_access_control_server_app_secret) or service_principal(client_secret). Pass null if not required
    kubernetes_cluster_key_vault_resource_group_name                                   = null                   #(Optional) To be provided for the kubernetes_cluster_key_vault_name  resource group
    kubernetes_cluster_key_vault_certificate_name                                      = null                   #(Optional) Specifies the name of the Key Vault Certificate which contain the list of up to 10 base64 encoded CAs that will be added to the trust store on nodes with the custom_ca_trust_enabled feature enabled.
    kubernetes_cluster_default_node_pool_name                                          = "sdelkpool"
    kubernetes_cluster_default_node_pool_capacity_reservation_group_name               = null             #(Optional) provide the linux kubernetes_cluster capacity reservation group name
    kubernetes_cluster_default_node_pool_capacity_reservation_resource_group_name      = null             #(Optional) provide the capacity reservation group resource group name
    kubernetes_cluster_default_node_pool_vm_size                                       = "Standard_D8_v3" #(Required) The size of the Virtual Machine, such as Standard_DS2_v2. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_custom_ca_trust_enabled                       = false            #(Optional) Specifies whether to trust a Custom CA.
    kubernetes_cluster_default_node_pool_key_vault_certificate_name                    = null             #(Optional) Specifies the name of the Key Vault Certificate. If kubernetes_cluster_default_node_pool_custom_ca_trust_enabled = true, then this is Required.
    kubernetes_cluster_default_node_pool_enable_auto_scaling                           = false            #(Optional) Should the Kubernetes Auto Scaler be enabled for this Node Pool? Defaults to false. This requires that the type is set to VirtualMachineScaleSets
    kubernetes_cluster_default_node_pool_workload_runtime                              = null             #(Optional) Specifies the workload runtime used by the node pool. Possible values are OCIContainer and KataMshvVmIsolation.
    kubernetes_cluster_default_node_pool_enable_host_encryption                        = false            #(Optional) Should the nodes in the Default Node Pool have host encryption enabled? Defaults to false
    kubernetes_cluster_default_node_pool_enable_node_public_ip                         = false            #(Optional) Should nodes in this Node Pool have a Public IP Address? Defaults to false. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_kubelet_config                                = null
    kubernetes_cluster_default_node_pool_linux_os_config                               = null
    kubernetes_cluster_default_node_pool_fips_enabled                                  = false #(Optional) Should the nodes in this Node Pool have Federal Information Processing Standard enabled? Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_kubelet_disk_type                             = "OS"  #(Optional) The type of disk used by kubelet. Possible values are OS and Temporary.
    kubernetes_cluster_default_node_pool_max_pods                                      = 30    # (Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created.
    kubernetes_cluster_message_of_the_day                                              = null  # (Optional) A base64-encoded string which will be written to /etc/motd after decoding. This allows customization of the message of the day for Linux nodes. It cannot be specified for Windows nodes and must be a static string (i.e. will be printed raw and not executed as a script). Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_node_public_ip_prefix_name                    = null  #(Optional) Resource ID for the Public IP Addresses Prefix for the nodes in this Node Pool. enable_node_public_ip should be true. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_node_public_ip_prefix_resource_group_name     = null
    kubernetes_cluster_default_node_pool_is_host_group_id_required                     = false                             #(Required)Boolean value if host group id required
    kubernetes_cluster_default_node_pool_dedicated_host_group_name                     = null                              #(Optional) Specifies the Name of the Host Group within which this AKS Cluster should be created.
    kubernetes_cluster_default_node_pool_dedicated_host_group_resource_group_name      = null                              #(Optional) Specifies the Resource Group Name of the Host Group
    kubernetes_cluster_default_node_pool_node_labels                                   = null                              #(Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool.
    kubernetes_cluster_default_node_pool_only_critical_addons_enabled                  = false                             #(Optional) Enabling this option will taint default node pool with CriticalAddonsOnly=true:NoSchedule taint. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_orchestrator_version                          = "1.29.0"                          #(Optional) Version of Kubernetes used for the Agents. If not specified, the default node pool will be created with the version specified by kubernetes_version. If both are unspecified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). This version must be supported by the Kubernetes Cluster - as such the version of Kubernetes used on the Cluster/Control Plane may need to be upgraded first.
    kubernetes_cluster_default_node_pool_os_disk_size_gb                               = 128                               #(Optional) The size of the OS Disk which should be used for each agent in the Node Pool. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_os_disk_type                                  = "Managed"                         #(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_os_sku                                        = "Ubuntu"                          #(Optional) OsSKU to be used to specify Linux OSType. Not applicable to Windows OSType. Possible values include: Ubuntu, CBLMariner. Defaults to Ubuntu. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_is_proximity_placement_group_id_required      = false                             #(Required)Boolean value if proximity placement group id required
    kubernetes_cluster_default_node_pool_proximity_placement_group_name                = null                              #(Optional) Provide proximity placement group name if kubernetes_cluster_is_proximity_placement_group_id_required is set to true
    kubernetes_cluster_default_node_pool_proximity_placement_group_resource_group_name = null                              #(Optional) Provide proximity placement group resource group name if kubernetes_cluster_is_proximity_placement_group_id_required is set to true
    kubernetes_cluster_default_node_pool_pod_virtual_network_name                      = "sd-plz-management-vnet"          #(Optional) The name of the Subnet where the pods in the default Node Pool should exist.
    kubernetes_cluster_default_node_pool_pod_subnet_name                               = "sd-plz-management-vnet-snet-pod" #(Optional) The name of the Subnet where the pods in the default Node Pool should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_pod_scale_down_mode                           = "Delete"                          #(Optional) Specifies the autoscaling behaviour of the Kubernetes Cluster. Allowed values are Delete and Deallocate. Defaults to Delete.
    kubernetes_cluster_default_node_pool_is_snapshot_id_required                       = false                             #(Required)Boolean value if snapshot id required
    kubernetes_cluster_default_node_pool_snapshot_name                                 = null                              #(Optional) Provide snapshot name if kubernetes_cluster_default_node_pool_is_snapshot_id_required is set to true
    kubernetes_cluster_default_node_pool_snapshot_resource_group_name                  = null                              #(Optional) Provide snapshot resource group name if kubernetes_cluster_default_node_pool_is_snapshot_id_required is set to true
    kubernetes_cluster_default_node_pool_temporary_name_for_rotation                   = "aksmgmtrotation01"                              #(Optional) Specifies the name of the temporary node pool used to cycle the default node pool for VM resizing.
    kubernetes_cluster_default_node_pool_pod_virtual_network_resource_group_name       = "sd-plz-management-rg"            #(Optional) The name of the resource_group where the pods in the default Node Pool should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_type                                          = "VirtualMachineScaleSets"         #(Optional) The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets. Defaults to VirtualMachineScaleSets.
    kubernetes_cluster_default_node_pool_tags = {

      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
    kubernetes_cluster_default_node_pool_ultra_ssd_enabled                   = false #(Optional) Used to specify whether the UltraSSD is enabled in the Default Node Pool. Defaults to false
    kubernetes_cluster_node_network_profile                                  = null  #(Optional) Node Network Profile for Kubernetes Cluster
    kubernetes_cluster_default_node_pool_upgrade_settings                    = null
    kubernetes_cluster_default_node_pool_virtual_network_name                = "sd-plz-management-vnet" #(Optional) Name of VNet for assigning default node pool to a subnet
    kubernetes_cluster_default_node_pool_virtual_network_resource_group_name = "sd-plz-management-rg"
    kubernetes_cluster_default_node_pool_subnet_name                         = "sd-plz-management-vnet-elk-snet-01" #(Optional) Name of Subnet for assigning default node pool to a subnet . A Route Table must be configured on this Subnet.
    kubernetes_cluster_default_node_pool_max_count                           = null                                 #(Optional) The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000.
    kubernetes_cluster_default_node_pool_min_count                           = null                                 #(Optional) The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000
    kubernetes_cluster_default_node_pool_node_count                          = 3                                    #(Optional) The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 and between min_count and max_count.
    kubernetes_cluster_default_node_pool_availability_zones                  = null                                 #(Optional) Specifies a list of Availability Zones in which this Kubernetes Cluster should be located. Changing this forces a new Kubernetes Cluster to be created.
    kubernetes_cluster_dns_prefix                                            = "sdplzmgmtaks01"                     #(Optional) DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created. One of dns_prefix or dns_prefix_private_cluster must be specified. The dns_prefix must contain between 3 and 45 characters, and can contain only letters, numbers, and hyphens. It must start with a letter and must end with a letter or a number.
    kubernetes_cluster_dns_prefix_private_cluster                            = null                                 #(Optional) Specifies the DNS prefix to use with private clusters. Changing this forces a new resource to be created. One of dns_prefix or dns_prefix_private_cluster must be specified. The dns_prefix must contain between 3 and 45 characters, and can contain only letters, numbers, and hyphens. It must start with a letter and must end with a letter or a number.
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
    kubernetes_cluster_http_application_routing_enabled                      = true  #(Optional) Should HTTP Application Routing be enabled
    kubernetes_cluster_image_cleaner_enabled                                 = false #(Optional) Specifies whether Image Cleaner is enabled.
    kubernetes_cluster_image_cleaner_interval_hours                          = null  #(Optional) Specifies the interval in hours when images should be cleaned up. Defaults to 48.
    kubernetes_cluster_http_proxy_config                                     = null
    kubernetes_cluster_identity = {    #One of either identity or service_principal must be specified. Assign null if not required. Defines the kubernetes cluster identity to be used
      identity_type = "SystemAssigned" #(Required) Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      identity_ids  = null /*[{
        identity_name = "5bcd79c7-7094-44fc-b87a-f9c2f24f517c"
      identity_resource_group_name = "sd-plz-management-node-rg" }]*/
    }
    kubernetes_cluster_ingress_application_gateway = null
    kubernetes_cluster_key_management_service      = null
    kubernetes_cluster_key_vault_secrets_provider  = null
    kubernetes_cluster_kubelet_identity            = null
    kubernetes_cluster_kubernetes_version          = "1.29.0" #(Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). AKS does not require an exact patch version to be specified, minor version aliases such as 1.22 are also supported. - The minor version's latest GA patch is automatically chosen in that case.
    kubernetes_cluster_linux_profile               = null

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
      network_profile_network_plugin        = "azure"        #(Required) Network plugin to use for networking. Currently supported values are azure, kubenet and none. Changing this forces a new resource to be created.When network_plugin is set to azure - the vnet_subnet_id field in the default_node_pool block must be set and pod_cidr must not be set.
      network_profile_network_mode          = null           #(Optional) Network mode to be used with Azure CNI. Possible values are bridge and transparent. Changing this forces a new resource to be created. network_mode can only be set to bridge for existing Kubernetes Clusters and cannot be used to provision new Clusters - this will be removed by Azure in the future. This property can only be set when network_plugin is set to azure
      network_profile_network_policy        = null           #(Optional) Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created. When network_policy is set to azure, the network_plugin field can only be set to azure.
      network_profile_dns_service_ip        = "10.0.0.10"    #(Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created.
      network_profile_ebpf_data_plane       = null           #(Optional) Specifies the eBPF data plane used for building the Kubernetes network. Possible value is cilium. Disabling this forces a new resource to be created.
      network_profile_network_plugin_mode   = null           #(Optional) Specifies the network plugin mode used for building the Kubernetes network. Possible value is overlay.
      network_profile_outbound_type         = "loadBalancer" #(Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer, userDefinedRouting, managedNATGateway and userAssignedNATGateway. Defaults to loadBalancer.
      network_profile_pod_cidr              = null           #(Optional) The CIDR to use for pod IP addresses. This field can only be set when network_plugin is set to kubenet. Changing this forces a new resource to be created.
      network_profile_pod_cidrs             = null           # (Optional) A list of CIDRs to use for pod IP addresses. For single-stack networking a single IPv4 CIDR is expected. For dual-stack networking an IPv4 and IPv6 CIDR are expected. Changing this forces a new resource to be created.
      network_profile_service_cidr          = "10.0.0.0/16"  #(Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created. This range should not be used by any network element on or connected to this VNet. Service address CIDR must be smaller than /12. docker_bridge_cidr, dns_service_ip and service_cidr should all be empty or all should be set.
      network_profile_service_cidrs         = null           # (Optional) A list of CIDRs to use for Kubernetes services. For single-stack networking a single IPv4 CIDR is expected. For dual-stack networking an IPv4 and IPv6 CIDR are expected. Changing this forces a new resource to be created.
      network_profile_ip_versions           = ["IPv4"]       #(Optional) Specifies a list of IP versions the Kubernetes Cluster will use to assign IP addresses to its nodes and pods. Possible values are IPv4 and/or IPv6. IPv4 must always be specified. Changing this forces a new resource to be created. To configure dual-stack networking ip_versions should be set to ["IPv4", "IPv6"]
      network_profile_load_balancer_sku     = "standard"     #(Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard. Defaults to standard. (Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard. Defaults to standard. Changing this forces a new resource to be created.
      network_profile_load_balancer_profile = null
      network_profile_nat_gateway_profile   = null
    }
    kubernetes_cluster_node_os_channel_upgrade              = "None"                      #(Optional) The upgrade channel for this Kubernetes Cluster Nodes' OS Image. Possible values are Unmanaged, SecurityPatch, NodeImage and None.
    kubernetes_cluster_node_resource_group_name             = "sd-plz-management-node-rg" #(Optional) The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created. Azure requires that a new, non-existent Resource Group is used, as otherwise the provisioning of the Kubernetes Service will fail.
    kubernetes_cluster_oidc_issuer_enabled                  = false                       #(Required) Enable or Disable the OIDC issuer URL
    kubernetes_cluster_oms_agent                            = null
    kubernetes_cluster_service_mesh_profile                 = null
    kubernetes_cluster_open_service_mesh_enabled            = false #(Optional) Open Service Mesh needs to be enabled
    kubernetes_cluster_private_cluster_enabled              = true  #(Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created.
    kubernetes_cluster_private_dns_zone_name                = null  #"private.eastus2.azmk8s.io"  #(Optional)Use when kubernetes_cluster_private_cluster_enabled is set to true. Either the Name of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None. In case of None you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning. Changing this forces a new resource to be created.
    kubernetes_cluster_private_dns_zone_resource_group_name = null  #(Optional)Resource Group name for kubernetes_cluster_private_dns_zone_name.
    kubernetes_cluster_private_cluster_public_fqdn_enabled  = true  #(Optional) Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to false.
    kubernetes_cluster_workload_autoscaler_profile          = null
    # {                                        #(Optional) A workload_autoscaler_profile block defined below.
    #   workload_autoscaler_profile_keda_enabled = false                                        #(Optional) Specifies whether KEDA Autoscaler can be used for workloads.
    #   workload_autoscaler_profile_vertical_pod_autoscaler_enabled = bool #(Optional) Specifies whether Vertical Pod Autoscaler should be enabled.

    # }
    kubernetes_cluster_workload_identity_enabled         = false #(Optional) Specifies whether Azure AD Workload Identity should be enabled for the Cluster. Defaults to false
    kubernetes_cluster_public_network_access_enabled     = false #(Optional) Whether public network access is allowed for this Kubernetes Cluster. Defaults to true. Changing this forces a new resource to be created. When public_network_access_enabled is set to true, 0.0.0.0/32 must be added to api_server_authorized_ip_ranges
    kubernetes_cluster_role_based_access_control_enabled = true  #(Optional) - Whether Role Based Access Control for the Kubernetes Cluster should be enabled. Defaults to true. Changing this forces a new resource to be created.
    kubernetes_cluster_run_command_enabled               = true  #(Optional) Whether to enable run command for the cluster or not. Defaults to true
    kubernetes_cluster_service_principal                 = null
    kubernetes_cluster_storage_profile                   = null
    kubernetes_cluster_sku_tier                          = "Free" #Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free.
    kubernetes_cluster_tags = {
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
    kubernetes_cluster_web_app_routing = null #(Optional) A web_app_routing block as defined below
    #   web_app_routing_dns_zone_name = "dns000001"                      #(Required) Specifies the ID of the DNS Zone in which DNS entries are created for applications deployed to the cluster when Web App Routing is enabled.
    #   web_app_routing_dns_zone_resource_group = "rg000001"             #(Required) Specifies the ID of the DNS Zone in which DNS entries are created for applications deployed to the cluster when Web App Routing is enabled.
    # }
    kubernetes_cluster_windows_profile = null /*{                                          #(Optional) Pass as null if not required. Changing any parameter forces a new resource to be created.
      windows_profile_admin_username_key_vault_secret_name = "keyvaultsecret000001" #(Required) Pass the secret name where the adminuser name is stored. Pass null if not stored in key vault
      windows_profile_admin_username                       = "admin123"             #(Optional) The Admin Username for the Windows VMs if not present in key vault
      windows_profile_admin_password_secret_exist          = false                  #(Required) Set true if the password is present in key vault else new password will be generated
      windows_profile_admin_password_secret_name           = "akssecret111"         #(Required) If windows_profile_admin_password_secret_exist is true then the Admin Password is read from given secret else the new generated password is stored in the given secret. Length must be between 14 and 123 characters.
      windows_profile_admin_password_length                = 14                     #(Required) Password Length. Length must be between 14 and 123 characters. Password generated will contain minimum of 4 lower case, 4 upper case, 2 numeric and 2 special character
      windows_profile_license                              = "Windows_Server"       #(Optional) Specifies the type of on-premise license which should be used for Node Pool Windows Virtual Machine. At this time the only possible value is Windows_Server
      kubernetes_cluster_gmsa                              = null
      #     gmsa_dns_server       =   #(Required) Specifies the DNS server for Windows gMSA. Set this to an empty string if you have configured the DNS server in the VNet which was used to create the managed cluster.
      #     gmsa_root_domain      =   #(Required) Specifies the root domain name for Windows gMSA. Set this to an empty string if you have configured the DNS server in the VNet which was used to create the managed cluster.
      #   }
    }*/
  }
}

#NETWORK SECURITY GROUP
network_security_group_variables = {
  "network_security_group_1" = {
    network_security_group_name                = "sd-plz-management-nsg-01" # (Required) Specifies the name of the network security group
    network_security_group_resource_group_name = "sd-plz-management-rg"     # (Required) The name of the resource group in which to create the network security group
    network_security_group_location            = "Central India"            # (Required) Specifies the supported Azure location where the resource exists
    network_security_group_security_rule = {                                # (Optional) Map of objects representing security rules
      "nsg_rule_01" = {
        security_rule_name                                           = "nsgrule01"       # (Required) The name of the security rule
        security_rule_application_security_group_resource_group_name = null              # (Optional) The resource group name of the application security group
        security_rule_priority                                       = 100               # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
        security_rule_direction                                      = "Inbound"         # (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.
        security_rule_access                                         = "Deny"            # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.
        security_rule_protocol                                       = "Tcp"             # (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
        security_rule_source_port_range                              = "*"               # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified
        security_rule_source_port_ranges                             = null              # (Optional) List of source ports or port ranges. This is required if source_port_range is not specified
        security_rule_destination_port_range                         = "*"               # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
        security_rule_destination_port_ranges                        = null              # (Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified
        security_rule_source_address_prefix                          = "*"               # (Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified.
        security_rule_source_address_prefixes                        = null              # (Optional) List of source address prefixes. Tags may not be used. This is required if source_address_prefix is not specified.
        security_rule_destination_address_prefix                     = "*"               # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if destination_address_prefixes is not specified.
        security_rule_destination_address_prefixes                   = null              # (Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified.
        security_rule_description                                    = "InboundAllow100" # (Optional) A description for this rule. Restricted to 140 characters
        security_rule_source_application_security_group_names        = null              # (Optional) A List of source Application Security Group names
        security_rule_destination_application_security_group_names   = null              # (Optional) A List of destination Application Security Group names
    } }
    network_security_group_tags = { #(Optional) A mapping of tags which should be assigned to the Network Security Group.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  },
  "network_security_group_2" = {
    network_security_group_name                = "sd-plz-management-nsg-02" # (Required) Specifies the name of the network security group
    network_security_group_resource_group_name = "sd-plz-management-rg"     # (Required) The name of the resource group in which to create the network security group
    network_security_group_location            = "Central India"            # (Required) Specifies the supported Azure location where the resource exists
    network_security_group_security_rule = {                                # (Optional) Map of objects representing security rules
      "nsg_rule_01" = {
        security_rule_name                                           = "nsgrule01"       # (Required) The name of the security rule
        security_rule_application_security_group_resource_group_name = null              # (Optional) The resource group name of the application security group
        security_rule_priority                                       = 100               # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
        security_rule_direction                                      = "Inbound"         # (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.
        security_rule_access                                         = "Deny"            # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.
        security_rule_protocol                                       = "Tcp"             # (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
        security_rule_source_port_range                              = "*"               # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified
        security_rule_source_port_ranges                             = null              # (Optional) List of source ports or port ranges. This is required if source_port_range is not specified
        security_rule_destination_port_range                         = "*"               # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
        security_rule_destination_port_ranges                        = null              # (Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified
        security_rule_source_address_prefix                          = "*"               # (Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified.
        security_rule_source_address_prefixes                        = null              # (Optional) List of source address prefixes. Tags may not be used. This is required if source_address_prefix is not specified.
        security_rule_destination_address_prefix                     = "*"               # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if destination_address_prefixes is not specified.
        security_rule_destination_address_prefixes                   = null              # (Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified.
        security_rule_description                                    = "InboundAllow100" # (Optional) A description for this rule. Restricted to 140 characters
        security_rule_source_application_security_group_names        = null              # (Optional) A List of source Application Security Group names
        security_rule_destination_application_security_group_names   = null              # (Optional) A List of destination Application Security Group names
    } }
    network_security_group_tags = { #(Optional) A mapping of tags which should be assigned to the Network Security Group.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}

network_security_group_association_variables = {
  "network_security_group_association_1" = {
    network_interface_security_group_association = [ # (Optional) The block for security group association with network interface
      {
        network_security_group_association_network_interface_name                     = "pnic000001" # (Required) The name of the network interface
        network_security_group_association_network_security_group_name                = "pnsg000001" # (Required) The name of the network security group name to associate with network interface
        network_security_group_association_network_interface_resource_group_name      = "prg000001"  # (Required) The resource group name which contains network interface
        network_security_group_association_network_security_group_resource_group_name = "prg000001"  # (Required) The resource group name which contains security group
      }
    ]
    subnet_security_group_association = null # (Optional) The block for security group association with subnet
  },
  "network_security_group_association_2" = {
    network_interface_security_group_association = null # (Optional) The block for security group association with network interface
    subnet_security_group_association = [
      {
        network_security_group_association_network_security_group_name                = "g000001"     # (Required)  The name of network_security_group_name to assiciate with subnet
        network_security_group_association_network_security_group_resource_group_name = "rg000001"    # (Required) The resource group name of security group.
        network_security_group_association_subnet_name                                = "sn000001"    # (Required) The name subnet which needs to be associated with network security group
        network_security_group_association_virtual_network_name                       = "pvnet000001" # (Required) The name of the virtual network where subnets are created
        network_security_group_association_virtual_network_resource_group_name        = "prg000002"   # (Required) The resource group name of the virtual network
      }
    ]
  },
  "network_security_group_association_3" = {
    network_interface_security_group_association = [
      {
        network_security_group_association_network_interface_name                     = "pnic000002" # (Required) The name of the network interface
        network_security_group_association_network_security_group_name                = "pnsg000002" # (Required) The name of the network security group name to associate with network interface
        network_security_group_association_network_interface_resource_group_name      = "prg000001"  # (Required) The resource group name which contains network interface
        network_security_group_association_network_security_group_resource_group_name = "prg000001"  # (Required) The resource group name which contains security group
      }
    ],
    subnet_security_group_association = [
      {
        network_security_group_association_network_security_group_name                = "pnsg000002"  # (Required)  The name of network_security_group_name to assiciate with subnet
        network_security_group_association_network_security_group_resource_group_name = "prg000001"   # (Required) The resource group name of security group.
        network_security_group_association_subnet_name                                = "psn000002"   # (Required) The name subnet which needs to be associated with network security group
        network_security_group_association_virtual_network_name                       = "pvnet000001" # (Required) The name of the virtual network where subnets are created
        network_security_group_association_virtual_network_resource_group_name        = "prg000002"   # (Required) The resource group name of the virtual network
      }
    ]
  }
}

#LINUX VM
linux_virtual_machine_variables = {
  "linux_virtual_machine_1" = {
    linux_virtual_machine_admin_username = "palovman1"       #(Required) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created.
    linux_virtual_machine_location       = "Central India" #(Required) The Azure location where the Linux Virtual Machine should exist. Changing this forces a new resource to be created.
    linux_virtual_machine_license_type   = null            #(Optional) Specifies the BYOL Type for this Virtual Machine. Possible values are RHEL_BYOS and SLES_BYOS.
    linux_virtual_machine_name           = "SDLVMFWPAN01"    #(Required) The name of the Linux Virtual Machine. Changing this forces a new resource to be created.
    linux_virtual_machine_os_disk = {                      #(Required) A os_disk block as defined below.
      os_disk_caching              = null                  #(Required) The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite.
      os_disk_storage_account_type = "Standard_LRS"        #(Required) The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS. Changing this forces a new resource to be created.
      os_disk_diff_disk_settings = {                       #(Optional) A diff_disk_settings block as defined above. Changing this forces a new resource to be created.
        diff_disk_settings_option    = "Local"             # (Required) Specifies the Ephemeral Disk Settings for the OS Disk. At this time the only possible value is Local. Changing this forces a new resource to be created.
        diff_disk_settings_placement = null                #(Optional) Specifies where to store the Ephemeral Disk. Possible values are CacheDisk and ResourceDisk. Defaults to CacheDisk. Changing this forces a new resource to be created.
      }
      os_disk_disk_size_gb              = 120                  #(Optional) The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from.
      os_disk_name                      = "SDLVMFWPAN01-disk-01" #(Optional) The name which should be used for the Internal OS Disk. Changing this forces a new resource to be created.
      os_disk_security_encryption_type  = null                 #(Optional) Encryption Type when the Virtual Machine is a Confidential VM. Possible values are VMGuestStateOnly and DiskWithVMGuestState. Changing this forces a new resource to be created.
      os_disk_write_accelerator_enabled = false                #(Optional) Should Write Accelerator be Enabled for this OS Disk? Defaults to false.
    }
    linux_virtual_machine_resource_group_name = "sd-plz-management-rg" #(Required) The name of the Resource Group in which the Linux Virtual Machine should be exist. Changing this forces a new resource to be created.
    linux_virtual_machine_size                = "Standard_DS4_v2"            #(Required) The SKU which should be used for this Virtual Machine, such as Standard_F2.
    linux_virtual_machine_additional_capabilities = {                       #(Optional) A additional_capabilities block as defined below.
      additional_capabilities_ultra_ssd_enabled = false                     #(Optional) Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine? Defaults to false.
    }
    linux_virtual_machine_allow_extension_operations            = false        #(Optional) Should Extension Operations be allowed on this Virtual Machine?
    linux_virtual_machine_boot_diagnostics_storage_account_name = null         # Provide storage account name value if linux_virtual_machine_is_storage_blob_required or linux_virtual_machine_is_boot_diagnostics_required is set to true
    linux_virtual_machine_computer_name                         = "SDLVMFWPAN01" #(Optional) Specifies the Hostname which should be used for this Virtual Machine. If unspecified this defaults to the value for the name field. If the value of the name field is not a valid computer_name, then you must specify computer_name. Changing this forces a new resource to be created.
    linux_virtual_machine_custom_data                           = null         #(Optional) The Base64-Encoded Custom Data which should be used for this Virtual Machine. Changing this forces a new resource to be created.
    linux_virtual_machine_disable_password_authentication       = false        #(Optional) Should Password Authentication be disabled on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created.
    linux_virtual_machine_edge_zone                             = null         #(Optional) Specifies the Edge Zone within the Azure Region where this Linux Virtual Machine should exist. Changing this forces a new Linux Virtual Machine to be created.
    linux_virtual_machine_encryption_at_host_enabled            = false        #(Optional) Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?
    linux_virtual_machine_eviction_policy                       = null         #(Optional) Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance. Possible values are Deallocate and Delete. Changing this forces a new resource to be created.
    linux_virtual_machine_extensions_time_budget                = null         #(Optional) Specifies the duration allocated for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. Defaults to 90 minutes (PT1H30M).
    linux_virtual_machine_gallery_application                   = null         #(Optional) A gallery_application block as defined below.
    /* Sample Code {
      #gallery_application_configuration_blob_uri = string                               #(Optional) Specifies the URI to an Azure Blob that will replace the default configuration for the package if provided.
      gallery_application_order                  = 1                               #(Optional) Specifies the order in which the packages have to be installed. Possible values are between 0 and 2,147,483,647.
      gallery_application_tag                    = null                               #(Optional) Specifies a passthrough value for more generic context. This field can be any valid string value.
    }  */
    linux_virtual_machine_identity = {                                  #(Optional)
      identity_type                                  = "SystemAssigned" #(Required) The type of Managed Service Identity that is configured on this Disk Encryption Set. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      linux_virtual_machine_user_assigned_identities = null /* [{
        user_assigned_identities_name                = "puai000001" #(Required)Name of the user assigned identity
        user_assigned_identities_resource_group_name = "prg000001"  #(Required)Resource group name of the user assigned identity
      }]*/
    }
    linux_virtual_machine_patch_assessment_mode = null           #(Optional) Specifies the mode of VM Guest Patching for the Virtual Machine. Possible values are AutomaticByPlatform or ImageDefault. Defaults to ImageDefault.
    linux_virtual_machine_patch_mode            = "ImageDefault" # (Optional) Specifies the mode of in-guest patching to this Linux Virtual Machine. Possible values are AutomaticByPlatform and ImageDefault. Defaults to ImageDefault. For more information on patch modes please see the product documentation.
    linux_virtual_machine_max_bid_price         = "-1"           #(Optional) The maximum price you're willing to pay for this Virtual Machine, in US Dollars; which must be greater than the current spot price. If this bid price falls below the current spot price the Virtual Machine will be evicted using the eviction_policy. Defaults to -1, which means that the Virtual Machine should not be evicted for price reasons.
    linux_virtual_machine_plan = [{
      plan_name      = "byol"             #(Required) Specifies the Name of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
      plan_product   = "panorama"         #(Required) Specifies the Product of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
      plan_publisher = "paloaltonetworks" #(Optional) A plan block as defined below. Changing this forces a new resource to be created.
    }]
    linux_virtual_machine_platform_fault_domain = null      #(Optional) Specifies the Platform Fault Domain in which this Linux Virtual Machine should be created. Defaults to -1, which means this will be automatically assigned to a fault domain that best maintains balance across the available fault domains. Changing this forces a new Linux Virtual Machine to be created.
    linux_virtual_machine_priority              = "Regular" #(Optional) Specifies the priority of this Virtual Machine. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created.
    linux_virtual_machine_provision_vm_agent    = false     #(Optional) Should the Azure VM Agent be provisioned on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created.
    linux_virtual_machine_secure_boot_enabled   = false     #(Optional) Specifies whether secure boot should be enabled on the virtual machine. Changing this forces a new resource to be created.
    linux_virtual_machine_source_image_reference = {        #Optional) A source_image_reference block as defined below. Changing this forces a new resource to be created.
      source_image_reference_publisher = "paloaltonetworks" #(Optional) Specifies the publisher of the image used to create the virtual machines.
      source_image_reference_offer     = "panorama"         #(Optional) Specifies the offer of the image used to create the virtual machines.
      source_image_reference_sku       = "byol"             #(Optional) Specifies the SKU of the image used to create the virtual machines.
      source_image_reference_version   = "latest"           #(Optional) Specifies the version of the image used to create the virtual machines.
    }
    linux_virtual_machine_termination_notification = null /* [{ #(Optional) A termination_notification block as defined below.
      termination_notification_enabled = true           #(Required) Should the termination notification be enabled on this Virtual Machine? Defaults to false.
      termination_notification_timeout = "PT10M"        #(Optional) Length of time (in minutes, between 5 and 15) a notification to be sent to the VM on the instance metadata server till the VM gets deleted. The time duration should be specified in ISO 8601 format.
    }]*/
    linux_virtual_machine_user_data                = null  #(Optional) The Base64-Encoded User Data which should be used for this Virtual Machine.
    linux_virtual_machine_vtpm_enabled             = false #(Optional) Specifies whether vTPM should be enabled on the virtual machine. Changing this forces a new resource to be created.
    linux_virtual_machine_zone                     = null  #(Optional) Specifies the Availability Zones in which this Linux Virtual Machine should be located. Changing this forces a new Linux Virtual Machine to be created.
    linux_virtual_machine_tags = {
      BU             = "ELZ",
      Role           = "Palo Alto VM",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }

    linux_virtual_machine_use_existing_vm_username                   = false             #(Required)should be set true if existing user name is used
    linux_virtual_machine_generate_new_admin_password                = true              #(Required)admin_password should be generated if disable_password_authentication is false
    linux_virtual_machine_generate_new_ssh_key                       = true              #(Required)Should be true/false if linux_virtual_machine_disable_password_authentication is true
    linux_virtual_machine_admin_login_key_vault_name                 = "sdplzmgmtdckv01" #"existingkeyvaultscenario"
    linux_virtual_machine_tls_private_key_algorithm                  = "RSA"             #Provide Algorithm used for TLS private key if linux_virtual_machine_generate_new_ssh_key is true
    linux_virtual_machine_tls_private_key_rsa_bits                   = 2048              #Provide number if bits for TLS private key if linux_virtual_machine_generate_new_ssh_key is true
    linux_virtual_machine_admin_ssh_key_vault_secret_expiration_date = null
    linux_virtual_machine_admin_ssh_key_vault_secret_content_type    = null
    linux_virtual_machine_admin_ssh_key_vault_secret_name            = "SDLVMFWPAN01-sshkey" #Key vault secret name to store the ssh key if linux_virtual_machine_generate_new_ssh_key is true
    linux_virtual_machine_is_disk_encryption_set_required            = false               #(Required)Boolean value if disk encryption set is required or not
    linux_virtual_machine_is_storage_blob_required                   = false               #(Required)Boolean value if blob storage is required
    linux_virtual_machine_storage_blob_name                          = null                #Provide blob storage name value if linux_virtual_machine_is_storage_blob_required is set to true.
    linux_virtual_machine_storage_account_name                       = null                #Provide storage account name value if linux_virtual_machine_is_storage_blob_required or linux_virtual_machine_is_boot_diagnostics_required is set to true
    linux_virtual_machine_storage_container_name                     = null                #Provide storage container name value if linux_virtual_machine_is_storage_blob_required is set to true.
    linux_virtual_machine_is_gallery_application_id_required         = false               #(Required)Boolean value if gallery application id is required
    linux_virtual_machine_gallery_application_version_name           = null                #Provide version name if linux_virtual_machine_is_gallery_application_id_required is set to true
    linux_virtual_machine_shared_image_gallery_name                  = null                #Name of the shared image gallery. #Provide value if linux_virtual_machine_is_gallery_application_id_required is set to true
    linux_virtual_machine_gallery_application_name                   = null                #Name of gallery application. #Provide value if linux_virtual_machine_is_gallery_application_id_required is set to true
    linux_virtual_machine_is_capacity_reservation_group_id_required  = false               #(Required)Boolean value if capacity reservation group id is required
    linux_virtual_machine_capacity_reservation_group_name            = null                #Provide capacity reservation group name if linux_virtual_machine_is_capacity_reservation_group_id_required is set to true
    linux_virtual_machine_is_key_vault_certificate_url_required      = false               #(Required)Boolean value if key vault certificate url is required
    linux_virtual_machine_key_vault_certificate_name                 = null                #Provide key vault certificate name if linux_virtual_machine_is_key_vault_certificate_url_required is set to true
    linux_virtual_machine_is_vmss_id_required                        = false               #(Required)Boolean value if VMSS id is required
    linux_virtual_machine_network_interface = {                                            #(Required) Map of object for network interface
      "nic1" = {
        network_interface_name                = "sd-plz-sdlvmfwpan01-mgmt-nic" #(Required)Name of the network interface
        network_interface_resource_group_name = "sd-plz-management-rg"     #(Required)Resource group name of network interface
      }
    }
    linux_virtual_machine_is_secret_required                                     = false                 #(Required)Boolean value if secret is required or not
    linux_virtual_machine_disk_encryption_set_name                               = null                  #Name of the disk encryption set. Provide value if linux_virtual_machine_is_disk_encryption_set_required is set to true
    linux_virtual_machine_is_boot_diagnostics_required                           = false                 #(Required)Boolean value if boot diagnostics required
    linux_virtual_machine_bypass_platform_safety_checks_on_user_schedule_enabled = false                 #(Optional) Specifies whether to skip platform scheduled patching when a user schedule is associated with the VM. Defaults to false.Can only be set to true when patch_mode is set to AutomaticByPlatform.
    linux_virtual_machine_is_availability_set_id_required                        = false                 #(Required)Boolean value if availability set id required
    linux_virtual_machine_is_proximity_placement_group_id_required               = false                 #(Required)Boolean value if proximity placement group id required
    linux_virtual_machine_reboot_setting                                         = null                  # (Optional) Specifies the reboot setting for platform scheduled patching. Possible values are Always, IfRequired and Never. can only be set when patch_mode is set to AutomaticByPlatform.
    linux_virtual_machine_is_dedicated_host_group_id_required                    = false                 #(Required)Boolean value if dedicated host group id required
    linux_virtual_machine_is_dedicated_host_id_required                          = false                 #(Required)Boolean value if dedicated host id required
    linux_virtual_machine_deploy_vm_using_source_image_reference                 = true                  #(Required)Boolean value if VM should be deployed using source image reference
    linux_virtual_machine_availability_set_name                                  = null                  # Provide availability set name if linux_virtual_machine_is_availability_set_id_required is set true
    linux_virtual_machine_availability_set_resource_group_name                   = null                  # Provide availability set resource group name if linux_virtual_machine_is_availability_set_id_required is set true
    linux_virtual_machine_dedicated_host_group_name                              = null                  # Provide host group name if linux_virtual_machine_is_dedicated_host_group_id_required is set true
    linux_virtual_machine_dedicated_host_group_resource_group_name               = null                  # Provide host group resource group name if linux_virtual_machine_is_dedicated_host_group_id_required is set true
    linux_virtual_machine_dedicated_host_name                                    = null                  # Provide host name if linux_virtual_machine_is_dedicated_host_id_required is set true
    linux_virtual_machine_dedicated_host_resource_group_name                     = null                  # Provide host resource group name if linux_virtual_machine_is_dedicated_host_id_required is set true
    linux_virtual_machine_proximity_placement_group_name                         = null                  # Provide proximity palcement group name if linux_virtual_machine_is_proximity_placement_group_id_required is set true
    linux_virtual_machine_proximity_placement_group_resource_group_name          = null                  # Provide proximity palcement group resource group name if linux_virtual_machine_is_proximity_placement_group_id_required is set true
    linux_virtual_machine_generated_admin_password_secret_name                   = "SDLVMFWPAN01-password" #Provide Key vault secret name to store random password if linux_virtual_machine_generate_new_admin_password is true
    linux_virtual_machine_generated_admin_password_secret_expiration_date        = null
    linux_virtual_machine_generated_admin_password_secret_content_type           = null
    linux_virtual_machine_existing_admin_password_secret_name                    = null                   #Provide Key vault secret name where the existing password exists if linux_virtual_machine_generate_new_admin_password is false
    linux_virtual_machine_virtual_machine_scale_set_name                         = null                   #Provide Vm scale set name if linux_virtual_machine_is_vmss_id_required is true
    linux_virtual_machine_virtual_machine_scale_set_resource_group_name          = null                   #Provide VM scale set resource group name if linux_virtual_machine_is_vmss_id_required is true
    linux_virtual_machine_source_image_type                                      = "PlatformImage"        #Provide image type if linux_virtual_machine_deploy_vm_using_source_image_reference is set to false. If you are using existing vm image make image type as "VMImage" if you are using share image give as "SharedImage"
    linux_virtual_machine_shared_image_name                                      = null                   #Provide image name if linux_virtual_machine_source_image_type is "SharedImage"
    linux_virtual_machine_shared_image_resource_group_name                       = null                   #Provide image resource group name if linux_virtual_machine_source_image_type is "SharedImage"
    linux_virtual_machine_existing_image_name                                    = null                   #Provide image name if linux_virtual_machine_source_image_type is "VMImage"
    linux_virtual_machine_existing_image_resource_group_name                     = null                   #Provide existing image resource group name if image type is "VMImage"
    linux_virtual_machine_admin_key_vault_resource_group_name                    = "sd-plz-management-rg" #Provide key vault resource group name to store credentials
    linux_virtual_machine_storage_account_resource_group_name                    = null                   #Provide value if linux_virtual_machine_is_boot_diagnostics_required is set to true
    linux_virtual_machine_disk_encryption_set_resource_group_name                = null                   #Resource group name of the disk encryption set. Provide value if linux_virtual_machine_is_disk_encryption_set_required is set to true
    linux_virtual_machine_existing_admin_username_secret_name                    = null                   #Provide Key vault secret name to store admin username. Provide value if linux_virtual_machine_use_existing_vm_username is set to true.
  }

}
#NETWORK INTERFACE
network_interface_variables = {
  "network_interface_1" = {
    network_interface_name                          = "sd-plz-sdlvmfwpan01-mgmt-nic" #The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_location                      = "Central India"                 #The location where the Network Interface should exist. Changing this forces a new resource to be created.
    network_interface_resource_group_name           = "sd-plz-management-rg"     #The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.
    network_interface_auxiliary_mode                = null                            # (Optional) Specifies the auxiliary mode used to enable network high-performance feature on Network Virtual Appliances (NVAs). Possible values are AcceleratedConnections and Floating.
    network_interface_auxiliary_sku                 = null                            # (Optional) Specifies the SKU used for the network high-performance feature on Network Virtual Appliances (NVAs). Possible values are A1, A2, A4 and A8.
    network_interface_dns_servers                   = []                              #if provided, it will override the DNS server value defined in vnet module
    network_interface_edge_zone                     = null                            #Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created
    network_interface_enable_ip_forwarding          = false                           #Enable only if IP Forwarding is required
    network_interface_enable_accelerated_networking = false                           #Enable only if accelerated networking is required
    network_interface_internal_dns_label            = null                            #The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.
    network_interface_ip_configuration = {
      "ip_configuration_1" = {
        ip_configuration_name                          = "privateconfig1" #A name used for this IP Configuration. Changing this forces a new resource to be created
        ip_configuration_private_ip_address_allocation = "Dynamic"        #Possible values are Dynamic and Static
        #ip_configuration_private_ip_address            = "10.0.3.11"                #When private_ip_address_allocation is set to Static, The Static IP Address which should be used
        ip_configuration_private_ip_address         = null
        ip_configuration_private_ip_address_version = "IPv4" #The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.
        ip_configuration_subnet = ({
          subnet_virtual_network_name                = "sd-plz-management-vnet"                    #When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID
          subnet_name                                = "sd-plz-management-vnet-shared-snet-01" #When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID
          subnet_virtual_network_resource_group_name = "sd-plz-management-rg"                       #When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID
        })
        ip_configuration_public_ip     = null
        ip_configuration_primary       = true #Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false.Must be true for the first ip_configuration when multiple are specified
        ip_configuration_load_balancer = null
      }
    }
    network_interface_tags = { #(Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}

