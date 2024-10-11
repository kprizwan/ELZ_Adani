
#RESOURCE GROUP For LOG ANALYTICS WORKSPACE
resource_group_log_analytics_workspace_oms_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000004"
    location = "westus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#private_dns_zone
private_dns_zone_variable = {
  "dnszone1" = {
    private_dns_zone_name                = "private.westus2.azmk8s.io"
    private_dns_zone_resource_group_name = "ploceusrg000001"
    private_dns_zone_soa_record          = null
    private_dns_zone_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#LOG ANALYTICS WORKSPACE
log_analytics_workspace_variables = {
  "log_analytics_workspace_1" = {
    log_analytics_workspace_name                               = "ploceuslaw000001" #Required
    log_analytics_workspace_location                           = "westus2"          #Required
    log_analytics_workspace_resource_group_name                = "ploceusrg000004"  #Required
    log_analytics_workspace_sku                                = "PerGB2018"        #Optional
    log_analytics_workspace_retention_in_days                  = null               #Optional
    log_analytics_workspace_daily_quota_gb                     = null               #Optional
    log_analytics_workspace_internet_ingestion_enabled         = null               #Optional
    log_analytics_workspace_internet_query_enabled             = null               #Optional
    log_analytics_workspace_reservation_capacity_in_gb_per_day = null               #Optional
    log_analytics_workspace_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#RESOURCE GROUP For KEY VAULT
resource_group_key_vault_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000003"
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
    key_vault_name                                  = "ploceuskv000015l"
    key_vault_location                              = "westus2"
    key_vault_resource_group_name                   = "ploceusrg000003"
    key_vault_enabled_for_disk_encryption           = true
    key_vault_enabled_for_deployment                = true
    key_vault_enabled_for_template_deployment       = true
    key_vault_enable_rbac_authorization             = false
    key_vault_soft_delete_retention_days            = "7"
    key_vault_purge_protection_enabled              = false
    key_vault_sku_name                              = "standard"
    key_vault_access_container_agent_name           = null
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore", "Purge"]
    key_vault_access_policy_secret_permissions      = ["Get", "Set", "List", "Delete", "Recover", "Backup", "Restore", "Purge"]
    key_vault_access_policy_storage_permissions     = []
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]
    key_vault_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_network_acls_enabled          = false
    key_vault_network_acls_virtual_networks = null
    key_vault_network_acls_bypass           = "AzureServices"
    key_vault_network_acls_default_action   = "Deny"
    key_vault_network_acls_ip_rules         = ["0.0.0.0/16"]
    key_vault_contact_information_enabled   = false
    key_vault_contact_email                 = "xxxxxxxxxx@ploceus.com"
    key_vault_contact_name                  = "xxxxxxxxxx"
    key_vault_contact_phone                 = "99999999999"

  }
}

#RESOURCE GROUP For AKS CLUSTER
resource_group_aks_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000001"
    location = "westus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#VNET 
vnets_variables = {
  "vnet_1" = {
    name                        = "ploceusvnet000001a"
    location                    = "westus2"
    resource_group_name         = "ploceusrg000001"
    address_space               = ["10.1.0.0/16"]
    dns_servers                 = []
    flow_timeout_in_minutes     = null #possible values are between 4 and 30 minutes.
    bgp_community               = null
    edge_zone                   = null
    is_ddos_protection_required = false #Provide the value as true only if ddos_protection_plan is required
    ddos_protection_plan_name   = null  #Provide the name of the ddos protection plan if above value is true or else keep it as null. If new DDOS protection plan needs to be created uncomment from line 24 to 34
    vnet_tags = {
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
#Subnets
subnet_variables = {
  "subnet_1" = {
    name                                           = "ploceussubnet000001a"
    resource_group_name                            = "ploceusrg000001"
    address_prefixes                               = ["10.1.0.0/24"]
    virtual_network_name                           = "ploceusvnet000001a"
    enforce_private_link_service_network_policies  = true
    enforce_private_link_endpoint_network_policies = true
    is_delegetion_required                         = false #update to true if delegation required and update delegation name,service_name,Service_actions
    service_endpoints                              = null
    delegation_name                                = null
    service_name                                   = null
    service_actions                                = null
  }
}

#AKS CLUSTER
kubernetes_cluster_variables = {
  "aks_1" = {
    kubernetes_cluster_name                                                        = "ploceusaks000001"  #(Required) The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created.
    kubernetes_cluster_location                                                    = "westus2"           #(Required) The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created.
    kubernetes_cluster_resource_group_name                                         = "ploceusrg000001"   #(Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_key_vault_name                                              = "ploceuskv000015l"  #(Optional) Incase if any secret value is passed for linux_profile, windows_profile, azure_active_directory_role_based_access_control(azure_active_directory_role_based_access_control_server_app_secret) or service_principal(client_secret). Pass null if not required
    kubernetes_cluster_key_vault_resource_group_name                               = "ploceusrg000003"   #(Optional) To be provided for the kubernetes_cluster_key_vault_name  resource group
    kubernetes_cluster_default_node_pool_name                                      = "pool000001"        #(Required) The name which should be used for the default Kubernetes Node Pool. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_vm_size                                   = "standard_d2pds_v5" #(Required) The size of the Virtual Machine, such as Standard_DS2_v2. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_enable_auto_scaling                       = false               #(Optional) Should the Kubernetes Auto Scaler be enabled for this Node Pool? Defaults to false. This requires that the type is set to VirtualMachineScaleSets
    kubernetes_cluster_default_node_pool_enable_host_encryption                    = false               #(Optional) Should the nodes in the Default Node Pool have host encryption enabled? Defaults to false
    kubernetes_cluster_default_node_pool_enable_node_public_ip                     = false               #(Optional) Should nodes in this Node Pool have a Public IP Address? Defaults to false. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_kubelet_config                            = null
    kubernetes_cluster_default_node_pool_linux_os_config                           = null
    kubernetes_cluster_default_node_pool_fips_enabled                              = false #(Optional) Should the nodes in this Node Pool have Federal Information Processing Standard enabled? Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_kubelet_disk_type                         = null  #(Optional) The type of disk used by kubelet. Possible values are OS and Temporary.
    kubernetes_cluster_default_node_pool_max_pods                                  = 30    # (Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_node_public_ip_prefix_name                = null  #(Optional) Resource ID for the Public IP Addresses Prefix for the nodes in this Node Pool. enable_node_public_ip should be true. Changing this forces a new resource to be created. 
    kubernetes_cluster_default_node_pool_node_public_ip_prefix_resource_group_name = null
    kubernetes_cluster_default_node_pool_node_labels                               = null  #(Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool.
    kubernetes_cluster_default_node_pool_only_critical_addons_enabled              = false #(Optional) Enabling this option will taint default node pool with CriticalAddonsOnly=true:NoSchedule taint. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_orchestrator_version                      = null  #(Optional) Version of Kubernetes used for the Agents. If not specified, the default node pool will be created with the version specified by kubernetes_version. If both are unspecified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). This version must be supported by the Kubernetes Cluster - as such the version of Kubernetes used on the Cluster/Control Plane may need to be upgraded first.
    kubernetes_cluster_default_node_pool_os_disk_size_gb                           = null  #(Optional) The size of the OS Disk which should be used for each agent in the Node Pool. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_os_disk_type                              = null  #(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_os_sku                                    = null  #(Optional) OsSKU to be used to specify Linux OSType. Not applicable to Windows OSType. Possible values include: Ubuntu, CBLMariner. Defaults to Ubuntu. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_pod_virtual_network_name                  = null  #(Optional) The name of the Subnet where the pods in the default Node Pool should exist.
    kubernetes_cluster_default_node_pool_pod_subnet_name                           = null  #(Optional) The name of the Subnet where the pods in the default Node Pool should exist. Changing this forces a new resource to be created.
    kubernetes_cluster_default_node_pool_pod_virtual_network_resource_group_name   = null
    kubernetes_cluster_default_node_pool_type                                      = null #(Optional) The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets. Defaults to VirtualMachineScaleSets.
    kubernetes_cluster_default_node_pool_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
    kubernetes_cluster_default_node_pool_ultra_ssd_enabled                   = false #(Optional) Used to specify whether the UltraSSD is enabled in the Default Node Pool. Defaults to false
    kubernetes_cluster_default_node_pool_upgrade_settings                    = null
    kubernetes_cluster_default_node_pool_virtual_network_name                = "ploceusvnet000001a" #(Optional) Name of VNet for assigning default node pool to a subnet
    kubernetes_cluster_default_node_pool_virtual_network_resource_group_name = "ploceusrg000001"
    kubernetes_cluster_default_node_pool_subnet_name                         = "ploceussubnet000001a" #(Optional) Name of Subnet for assigning default node pool to a subnet . A Route Table must be configured on this Subnet.
    kubernetes_cluster_default_node_pool_max_count                           = null                   #(Optional) The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000.
    kubernetes_cluster_default_node_pool_min_count                           = null                   #(Optional) The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000
    kubernetes_cluster_default_node_pool_node_count                          = 2                      #(Optional) The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 and between min_count and max_count.
    kubernetes_cluster_default_node_pool_availability_zones                  = null                   #(Optional) Specifies a list of Availability Zones in which this Kubernetes Cluster should be located. Changing this forces a new Kubernetes Cluster to be created.  
    kubernetes_cluster_dns_prefix                                            = "ploceusdnsprefix"     #(Optional) DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created. One of dns_prefix or dns_prefix_private_cluster must be specified. The dns_prefix must contain between 3 and 45 characters, and can contain only letters, numbers, and hyphens. It must start with a letter and must end with a letter or a number.
    kubernetes_cluster_dns_prefix_private_cluster                            = null                   #"ploceus"      #(Optional) Specifies the DNS prefix to use with private clusters. Changing this forces a new resource to be created. One of dns_prefix or dns_prefix_private_cluster must be specified. The dns_prefix must contain between 3 and 45 characters, and can contain only letters, numbers, and hyphens. It must start with a letter and must end with a letter or a number.
    kubernetes_cluster_aci_connector_linux                                   = null
    kubernetes_cluster_automatic_channel_upgrade                             = null #(Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, node-image and stable. Omitting this field sets this value to none. Cluster Auto-Upgrade will update the Kubernetes Cluster (and its Node Pools) to the latest GA version of Kubernetes automatically and will not update to Preview versions.
    kubernetes_cluster_api_server_authorized_ip_ranges                       = null # (Optional) The IP ranges to allow for incoming traffic to the server nodes.
    kubernetes_cluster_auto_scaler_profile                                   = null
    kubernetes_cluster_azure_active_directory_role_based_access_control      = null
    kubernetes_cluster_azure_policy_enabled                                  = false #(Optional) Should the Azure Policy Add-On be enabled
    kubernetes_cluster_disk_encryption_set_name                              = null  #(Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes. Set to null if not required.
    kubernetes_cluster_disk_encryption_set_resource_group_name               = null
    kubernetes_cluster_http_application_routing_enabled                      = false #(Optional) Should HTTP Application Routing be enabled
    kubernetes_cluster_http_proxy_config                                     = null
    kubernetes_cluster_identity = {  #One of either identity or service_principal must be specified. Assign null if not required. Defines the kubernetes cluster identity to be used
      identity_type = "UserAssigned" #(Required) Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      identity_ids = [{
        identity_name = "ploceusuai000001"
      identity_resource_group_name = "ploceusrg000001" }]
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
    kubernetes_cluster_key_vault_secrets_provider = null
    kubernetes_cluster_kubelet_identity           = null
    kubernetes_cluster_kubernetes_version         = "1.24.6" #(Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade).
    kubernetes_cluster_linux_profile              = null

    // {                                  #(Optional) Pass as null if not required. Changing any parameter forces a new resource to be created.
    //   linux_profile_admin_username_key_vault_secret_name = null           #(Required) Pass the secret name where the adminuser name is stored. Pass null if not stored in key vault
    //   linux_profile_admin_username                       = "adminuser"    #(Optional) The Admin Username for the Cluster if it is not present in key vault 
    //   linux_profile_ssh_key_secret_exist                 = false          #(Required) Set true if the public key is present in key vault. Set false where a new public and private key is generated. Public key will be stored in name provided in linux_profile_ssh_key_secret_name, private key will be stored in the same secret name appended with private. Keys generated using RSA algo with 4096 rsa bits
    //   linux_profile_ssh_key_secret_name                  = "secretsshkey" #(Required) If linux_profile_ssh_key_secret_exist is true then the secret is fetched from the given secret name else the new public key generated is stored in given secret name
    // }
    kubernetes_cluster_local_account_disabled = false #(Optional) If true local accounts will be disabled. Defaults to false. If local_account_disabled is set to true, it is required to enable Kubernetes RBAC and AKS-managed Azure AD integration. 

    kubernetes_cluster_maintenance_window = null
    kubernetes_cluster_microsoft_defender = null
    kubernetes_cluster_network_profile = {
      network_profile_network_plugin        = "azure" #(Required) Network plugin to use for networking. Currently supported values are azure, kubenet and none. Changing this forces a new resource to be created.When network_plugin is set to azure - the vnet_subnet_id field in the default_node_pool block must be set and pod_cidr must not be set.
      network_profile_network_mode          = null    #(Optional) Network mode to be used with Azure CNI. Possible values are bridge and transparent. Changing this forces a new resource to be created. network_mode can only be set to bridge for existing Kubernetes Clusters and cannot be used to provision new Clusters - this will be removed by Azure in the future. This property can only be set when network_plugin is set to azure 
      network_profile_network_policy        = "azure" #(Optional) Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created. When network_policy is set to azure, the network_plugin field can only be set to azure.
      network_profile_dns_service_ip        = null    #(Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created.
      network_profile_docker_bridge_cidr    = null    #(Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created.
      network_profile_outbound_type         = null    #(Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer, userDefinedRouting, managedNATGateway and userAssignedNATGateway. Defaults to loadBalancer.
      network_profile_pod_cidr              = null    #(Optional) The CIDR to use for pod IP addresses. This field can only be set when network_plugin is set to kubenet. Changing this forces a new resource to be created.
      network_profile_service_cidr          = null    #(Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created. This range should not be used by any network element on or connected to this VNet. Service address CIDR must be smaller than /12. docker_bridge_cidr, dns_service_ip and service_cidr should all be empty or all should be set.
      network_profile_ip_versions           = null    #(Optional) Specifies a list of IP versions the Kubernetes Cluster will use to assign IP addresses to its nodes and pods. Possible values are IPv4 and/or IPv6. IPv4 must always be specified. Changing this forces a new resource to be created. To configure dual-stack networking ip_versions should be set to ["IPv4", "IPv6"]
      network_profile_load_balancer_sku     = null    #(Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard. Defaults to standard.
      network_profile_load_balancer_profile = null
      network_profile_nat_gateway_profile   = null
    }
    kubernetes_cluster_node_resource_group_name             = null  #(Optional) The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created. Azure requires that a new, non-existent Resource Group is used, as otherwise the provisioning of the Kubernetes Service will fail.
    kubernetes_cluster_oidc_issuer_enabled                  = false #Required) Enable or Disable the OIDC issuer URL
    kubernetes_cluster_oms_agent                            = null
    kubernetes_cluster_open_service_mesh_enabled            = false                       #(Optional) Open Service Mesh needs to be enabled
    kubernetes_cluster_private_cluster_enabled              = true                        #(Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created.
    kubernetes_cluster_private_dns_zone_name                = "private.westus2.azmk8s.io" #"private.eastus2.azmk8s.io"  #(Optional)Use when kubernetes_cluster_private_cluster_enabled is set to true. Either the Name of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None. In case of None you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning. Changing this forces a new resource to be created.
    kubernetes_cluster_private_dns_zone_resource_group_name = "ploceusrg000001"           #(Optional)Resource Group name for kubernetes_cluster_private_dns_zone_name. 
    kubernetes_cluster_private_cluster_public_fqdn_enabled  = false                       #(Optional) Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to false.
    kubernetes_cluster_public_network_access_enabled        = false                       #(Optional) Whether public network access is allowed for this Kubernetes Cluster. Defaults to true. Changing this forces a new resource to be created. When public_network_access_enabled is set to true, 0.0.0.0/32 must be added to api_server_authorized_ip_ranges
    kubernetes_cluster_role_based_access_control_enabled    = true                        #(Optional) - Whether Role Based Access Control for the Kubernetes Cluster should be enabled. Defaults to true. Changing this forces a new resource to be created.
    kubernetes_cluster_run_command_enabled                  = false                       #(Optional) Whether to enable run command for the cluster or not. Defaults to true
    kubernetes_cluster_service_principal                    = null
    kubernetes_cluster_sku_tier                             = "Free" # Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free.
    kubernetes_cluster_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
    kubernetes_cluster_windows_profile = {                                    #(Optional) Pass as null if not required. Changing any parameter forces a new resource to be created.
      windows_profile_admin_username_key_vault_secret_name = null             #(Required) Pass the secret name where the adminuser name is stored. Pass null if not stored in key vault
      windows_profile_admin_username                       = "admin123"       #(Optional) The Admin Username for the Windows VMs if not present in key vault
      windows_profile_admin_password_secret_exist          = false            #(Required) Set true if the password is present in key vault else new password will be generated 
      windows_profile_admin_password_secret_name           = "akssecret11"    #(Required) If windows_profile_admin_password_secret_exist is true then the Admin Password is read from given secret else the new generated password is stored in the given secret. Length must be between 14 and 123 characters.
      windows_profile_admin_password_length                = 14               #(Required) Password Length. Length must be between 14 and 123 characters. Password generated will contain minimum of 4 lower case, 4 upper case, 2 numeric and 2 special character
      windows_profile_license                              = "Windows_Server" #(Optional) Specifies the type of on-premise license which should be used for Node Pool Windows Virtual Machine. At this time the only possible value is Windows_Server
    }
  }
}



key_vault_subscription_id              = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
key_vault_tenant_id                    = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
kubernetes_cluster_subscription_id     = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
kubernetes_cluster_tenant_id           = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
log_analytics_oms_subscription_id      = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
log_analytics_oms_tenant_id            = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
log_analytics_defender_subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
log_analytics_defender_tenant_id       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
private_dns_zone_subscription_id       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
private_dns_zone_tenant_id             = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
