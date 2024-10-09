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

#VNET
vnets_variables = {
  "vnet_1" = {
    name                        = "ploceusvnet000001"
    location                    = "westus2"
    resource_group_name         = "ploceusrg000001"
    address_space               = ["10.0.0.0/16"]
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

#DDOS plan creation is optional and costly. Uncommenting the below module (line 24 to 34) will create a new DDOS protection plan. Use only if required. 
#If DDOS protection plan is required for vnet also uncomment lines 40 to 47 from variable.tf inside example folder and
#Also uncomment lines 9 to 12 from main.tf inside example folder

#DDOS protection plan (Optional module for VNET)
# ddos_protection_plan_variables = {
#   "ddos_plan_1" = {
#     name                            = "ploceusddosplan000002"
#     location                        = "westus2"
#     resource_group_name             = "ploceus"
#     ddos_protection_plan_tags = {
#       Created_By = "Ploceus",
#       Department = "CIS"
#     }
#   }
# }

#SUBNET

subnet_variables = {
  "subnet_1" = {
    name                                           = "ploceussubnet000001"
    resource_group_name                            = "ploceusrg000001"
    address_prefixes                               = ["10.0.1.0/24"]
    virtual_network_name                           = "ploceusvnet000001a"
    enforce_private_link_service_network_policies  = true
    enforce_private_link_endpoint_network_policies = true
    is_delegetion_required                         = false #update to true if delegation required and update delegation name,service_name,Service_actions
    service_endpoints                              = ["Microsoft.AzureActiveDirectory"]
    delegation_name                                = "delegation000001"
    service_name                                   = "Microsoft.Sql/managedInstances"
    service_actions                                = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
  }

  "subnet_2" = {
    name                                           = "ploceussubnet000002"
    resource_group_name                            = "ploceusrg000001"
    address_prefixes                               = ["10.0.2.0/24"]
    virtual_network_name                           = "ploceusvnet000001a"
    enforce_private_link_service_network_policies  = false                                                                                                                                                    #Setting this to true will Disable the policy
    enforce_private_link_endpoint_network_policies = false                                                                                                                                                    #Setting this to true will Disable the policy
    service_endpoints                              = ["Microsoft.AzureActiveDirectory"]                                                                                                                       #update this field if service endpoint is required
    is_delegetion_required                         = false                                                                                                                                                    #update to true if delegation required and update delegation name,service_name,Service_actions
    delegation_name                                = "delegation000002"                                                                                                                                       #Update this field if delgation required
    service_name                                   = "Microsoft.Databricks/workspaces"                                                                                                                        #Update this field if delgation required
    service_actions                                = ["Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"] #Update this field if delgation required
  }
}



#KEY VAULT
# key_vault_variables = {
#   "key_vault_1" = {
#     name                            = "ploceuskeyvault000001"
#     location                        = "westus2"
#     resource_group_name             = "ploceus"
#     enabled_for_disk_encryption     = true
#     enabled_for_deployment          = false
#     enabled_for_template_deployment = false
#     #soft_delete_retention_days      = "7"
#     purge_protection_enabled = false
#     sku_name                 = "standard"
#     key_permissions          = []
#     secret_permissions       = []
#     storage_permissions      = []
#     key_vault_tags = {
#       Created_By = "Ploceus",
#       Department  = "CIS"
#     }
#   }
# }


#DISK ENCRYPTION SET


#PUBLIC IP
public_ip_variables = {
  "public_ip_1" = {
    name                    = "ploceuspublicip000001"
    resource_group_name     = "ploceusrg000001"
    location                = "westus2"
    ip_version              = "IPv4"
    allocation_method       = "Static"
    sku                     = "Standard"
    sku_tier                = "Regional"
    public_ip_dns           = "ploceuspublicip000001"
    public_ip_prefix_id     = null
    idle_timeout_in_minutes = "30"
    zones                   = ["1", "3"]
    edge_zone               = null
    availability_zone       = "1"
    reverse_fqdn            = null
    ip_tags                 = null
    public_ip_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#APPLICATION GATEWAY 
application_gateway_variables = {
  "application_gateway_1" = {
    application_gateway_name                            = "ploceusapgw000002"
    application_gateway_resource_group_name             = "ploceusrg000001"
    application_gateway_location                        = "westus2"
    application_gateway_sku_name                        = "Standard_v2"
    application_gateway_sku_tier                        = "Standard_v2"
    application_gateway_sku_capacity                    = 1
    application_gateway_vnet_name                       = "ploceusvnet000001a"
    application_gateway_subnet_name                     = "ploceussubnet000001a"
    application_gateway_frontend_port_name              = "apgw000002-feip"
    application_gateway_frontend_port                   = 80
    application_gateway_is_private_frontend_ip_required = false
    application_gateway_is_public_frontend_ip_required  = true
    application_gateway_is_waf_policy_required          = false
    application_gateway_waf_policy_name                 = null
    application_gateway_waf_policy_resource_group_name  = null
    application_gateway_public_ip_name                  = "ploceuspublicip000002a"
    application_gateway_fips_enabled                    = false
    application_gateway_identity = [{
      identity_type                         = "UserAssigned"
      identity_identity_name                = "ploceusuai000001"
      identity_identity_resource_group_name = "ploceusrg000001"
    }]
    application_gateway_zones                      = ["1", "2", "3"]
    application_gateway_trusted_client_certificate = null
    application_gateway_authentication_certificate = null
    application_gateway_trusted_root_certificate   = null
    application_gateway_keyvault_cert_configuration = {
      keyvault_cert_configuration_certificate_keyvault_name       = "ploceuskeyvault000001"
      keyvault_cert_configuration_certificate_resource_group_name = "ploceusrg000002"
    }
    application_gateway_custom_error_configuration        = null
    application_gateway_force_firewall_policy_association = false # Is the Firewall Policy associated with the Application Gateway?
    application_gateway_enable_http2                      = false # defaults to false

    application_gateway_sku = {
      sku_name     = "WAF_v2"
      sku_tier     = "WAF_v2"
      sku_capacity = null
    }

    application_gateway_gateway_ip_configuration = [
      {
        gateway_ip_configuration_name        = "apgw000002-gicconfig2"
        gateway_ip_configuration_subnet_name = "ploceussubnet000001a" #"ploceussubnet000001a"
    }]

    application_gateway_waf_configuration = {
      waf_configuration_firewall_mode            = "Prevention"
      waf_configuration_rule_set_type            = "OWASP"
      waf_configuration_rule_set_version         = "3.2"
      waf_configuration_file_upload_limit_mb     = "100"
      waf_configuration_max_request_body_size_kb = "127"
      waf_configuration_request_body_check       = true
      waf_configuration_enabled                  = true
      waf_configuration_disabled_rule_group = {
        disabled_rule_group_rule_group_name = "General"
      }
      waf_configuration_exclusion = {
        exclusion_match_variable          = "RequestHeaderNames"
        exclusion_selector_match_operator = "StartsWith"
        exclusion_selector                = "RequestHeaderNames"
      }
    }
    application_gateway_frontend_ports = [
      {
        frontend_ports_name = "appgatewayfeporthttp80"
        frontend_ports_port = 80
      },
      {
        frontend_ports_name = "appgwfeporthttp8080"
        frontend_ports_port = 8080
      }
    ]

    application_gateway_backend_address_pools = [
      {
        backend_address_pools_name         = "appgateway-beap"
        backend_address_pools_fqdns        = null
        backend_address_pools_ip_addresses = null
      }
    ]

    application_gateway_autoscale_configuration = {
      autoscale_configuration_min_capacity = 1
      autoscale_configuration_max_capacity = 2
    }
    application_gateway_backend_http_settings = [
      {
        backend_http_settings_name                                = "http-be-htst"
        backend_http_settings_path                                = "/"
        backend_http_settings_port                                = 80
        backend_http_settings_protocol                            = "Http"
        backend_http_settings_cookie_based_affinity               = "Enabled"
        backend_http_settings_affinity_cookie_name                = "ploceuscookie000001"
        backend_http_settings_request_timeout                     = 20
        backend_http_settings_probe_name                          = "http-bc-prob"
        backend_http_settings_host_name                           = "hostname.com"
        backend_http_settings_pick_host_name_from_backend_address = false
        backend_http_settings_trusted_root_certificate_names      = null //["ploceusappcert"]
        backend_http_settings_authentication_certificate          = null
        backend_http_settings_connection_draining = [{
          connection_draining_enabled           = true
          connection_draining_drain_timeout_sec = "100"
        }]
      }
    ]
    application_gateway_frontend_ip_configuration = [{
      frontend_ip_configuration_name                            = "apgwfeipconfig000002"
      frontend_ip_configuration_private_ip_address              = null
      frontend_ip_configuration_private_ip_address_allocation   = null
      frontend_ip_configuration_private_link_configuration_name = null
      frontend_ip_configuration_is_private_frontend_ip_required = false
      frontend_ip_configuration_is_public_frontend_ip_required  = true
    }]
    application_gateway_http_listener = [
      {
        http_listener_name                           = "http-bc-lstn"
        http_listener_frontend_ip_configuration_name = "apgwfeipconfig000002"
        http_listener_frontend_port_name             = "appgatewayfeporthttp80"
        http_listener_protocol                       = "Http"
        http_listener_ssl_certificate_name           = null //"ploceusappcert"
        http_listener_sni_required                   = false
        http_listener_listener_type                  = "MultiSite"
        http_listener_host_name                      = "hostname.com"
        http_listener_host_names                     = null
        http_listener_ssl_profile_name               = null
        http_listener_custom_error_configuration = [{
          custom_error_configuration_status_code           = "HttpStatus403"
          custom_error_configuration_custom_error_page_url = "https://hostname.blob.core.windows.net/httpstatuscode403/403.html"
        }]
      },
      {
        http_listener_name                           = "http-bc-lstn2"
        http_listener_frontend_ip_configuration_name = "apgwfeipconfig000002"
        http_listener_frontend_port_name             = "appgwfeporthttp8080"
        http_listener_protocol                       = "Http"
        http_listener_ssl_certificate_name           = null
        http_listener_sni_required                   = false
        http_listener_listener_type                  = "MultiSite"
        http_listener_host_name                      = "hostname2.com"
        http_listener_host_names                     = null
        http_listener_ssl_profile_name               = null
        http_listener_custom_error_configuration = [{
          custom_error_configuration_status_code           = "HttpStatus502"
          custom_error_configuration_custom_error_page_url = "https://hostname.blob.core.windows.net/httpstatuscode502/502.html"
        }]
      }
    ]
    application_gateway_request_routing_rules = [
      {
        request_routing_rules_name                        = "http-bc-rqrt"
        request_routing_rules_rule_type                   = "PathBasedRouting"
        request_routing_rules_listener_name               = "http-bc-lstn"
        request_routing_rules_backend_address_pool_name   = null
        request_routing_rules_backend_http_settings_name  = null
        request_routing_rules_rewrite_rule_set_name       = null
        request_routing_rules_redirect_configuration_name = null
        request_routing_rules_priority                    = "10"
        request_routing_rules_url_path_map_name           = "urlpathbasedmaps"

      }
    ]
    application_gateway_url_path_maps = [{
      url_path_maps_name                                = "urlpathbasedmaps"
      url_path_maps_default_backend_http_settings_name  = null
      url_path_maps_default_backend_address_pool_name   = null
      url_path_maps_default_redirect_configuration_name = "bc-rconfig"
      url_path_maps_default_rewrite_rule_set_name       = null
      url_path_maps_path_rules = [{
        path_rules_name                        = "mytheartrule"
        path_rules_paths                       = ["/*"]
        path_rules_backend_http_settings_name  = null
        path_rules_backend_address_pool_name   = null
        path_rules_redirect_configuration_name = "bc-rconfig"
        path_rules_rewrite_rule_set_name       = null
      }]
    }]
    application_gateway_private_link_configuration = null
    application_gateway_probe = [
      {
        probe_name                                      = "http-bc-prob"
        probe_path                                      = "/"
        probe_protocol                                  = "Http"
        probe_host                                      = "hostname.com"
        probe_port                                      = "80"
        probe_minimum_servers                           = "4"
        probe_interval                                  = null
        probe_timeout                                   = null
        probe_unhealthy_threshold                       = null
        probe_pick_host_name_from_backend_http_settings = false
        probe_match = [{
          match_body        = "Error occured due to autherization failure"
          match_status_code = ["403"]
        }]
      }
    ]
    application_gateway_redirect_configurations = [
      {
        redirect_configurations_name                 = "bc-rconfig"
        redirect_configurations_redirect_type        = "Permanent"
        redirect_configurations_target_listener_name = "http-bc-lstn2"
        redirect_configurations_target_url           = null
        redirect_configurations_include_path         = true
        redirect_configurations_include_query_string = true
      }
    ]
    application_gateway_disabled_ssl_protocols                  = null
    application_gateway_key_vault_with_private_endpoint_enabled = true
    application_gateway_ssl_profile                             = null
    application_gateway_ssl_policy                              = null
    application_gateway_ssl_certificate = [{
      ssl_certificate_name                  = "ploceuscertificate"
      ssl_certificate_key_vault_secret_name = null
    }]
    application_gateway_rewrite_rule_set = null

    application_gateway_application_gateway_tags = {
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
    log_analytics_workspace_resource_group_name                = "ploceusrg000002"  #Required
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

#AKS CLUSTER
aks_cluster_variables = {
  "aks_1" = {
    vnet_name                                                = "ploceusvnet000001" #Optional parameter - Use only if specific subnet needs to be defined for Kubernetes cluster, if not keep it as null
    resource_group_name                                      = "ploceusrg000001"
    subnet_name                                              = "ploceussubnet000002" #Optional parameter - Use only if specific subnet needs to be defined for Kubernetes cluster, If not keep it as null
    disk_encryption_set_name                                 = null
    is_subnet_required                                       = true #Optional parameter - Keep it true only if specific subnet needs to be defined, If not keep it false  
    is_disk_encryption_set_required                          = false
    aks_name                                                 = "ploceusaks000001"
    location                                                 = "westus2"
    dns_prefix                                               = "ploceusaks000001dns"
    node_resource_group_name                                 = "ploceus_noderg000001"
    sku_tier                                                 = "Free"
    dns_prefix_private_cluster                               = null
    private_cluster_enabled                                  = false
    private_dns_zone_id                                      = null
    api_server_authorized_ip_ranges                          = null
    kubernetes_version                                       = "1.23.8"
    automatic_channel_upgrade                                = null #"stable" This is in preview stage. Provide the value once this feature is in production
    default_node_pool_name                                   = "plakspool01"
    default_node_pool_node_count                             = 2
    default_node_pool_vm_size                                = "Standard_D2_v3"
    default_node_pool_type                                   = "VirtualMachineScaleSets"
    default_node_pool_availability_zones                     = ["1", "2", "3"]
    default_node_pool_enable_auto_scaling                    = true
    default_node_pool_max_count                              = 3
    default_node_pool_min_count                              = 2
    default_node_pool_enable_host_encryption                 = false
    default_node_pool_enable_node_public_ip                  = false
    default_node_pool_max_pods                               = 110
    default_node_pool_node_labels                            = null
    default_node_pool_os_disk_size_gb                        = 30
    azure_active_directory_role_based_access_control_enabled = false
    aad_managed                                              = true
    aad_tenant_id                                            = null                                     #Optional parameter - Use this parameter if you want to use the specific Azure AD application tenant ID, if not keep it null and it will use tenant ID of the current Subscription 
    aad_admin_group_object_ids                               = ["2d644380-095a-4e9c-9c92-a9286ad6ac0a"] #Optional parameter - Use this parameter only if aad_managed is true. Keep it as null if no Admin groups is used for Admin Role on the cluster. 
    aad_azure_rbac_enabled                                   = true                                     #Optional parameter - Use this parameter only if aad_managed is true . Also Microsoft.ContainerService/EnableAzureRBACPreview feature flag should be enabled. Keep it as null if no azure_rabac is not required.
    aad_client_app_id                                        = null                                     #Optional parameter - If aad_managed is false, this fields should be provided
    aad_server_app_id                                        = null                                     #Optional parameter - If aad_managed is false, this fields should be provided
    aad_server_app_secret                                    = null                                     #Optional parameter - If aad_managed is false, this fields should be provided
    balance_similar_node_groups                              = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Possible values - true/false . Defaults to false. 
    expander                                                 = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Possible values - least-waste/priority/most-pods/random . Defaults to random
    max_graceful_termination_sec                             = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 600
    max_node_provisioning_time                               = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 15m
    max_unready_nodes                                        = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 3
    max_unready_percentage                                   = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 45
    new_pod_scale_up_delay                                   = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 10s
    scale_down_delay_after_add                               = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to scan_interval
    scale_down_delay_after_delete                            = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 3m
    scale_down_delay_after_failure                           = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 10s
    scan_interval                                            = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 10m
    scale_down_unneeded                                      = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 10m
    scale_down_unready                                       = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 20m
    scale_down_utilization_threshold                         = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 0.5
    empty_bulk_delete_max                                    = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Defaults to 10
    skip_nodes_with_local_storage                            = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Possible values - true/false . Defaults to true
    skip_nodes_with_system_pods                              = null                                     #Optional parameter - Use this parameter only if autoscaling is used, if not keep it as null. Possible values - true/false . Defaults to true
    network_plugin                                           = "azure"
    network_policy                                           = "azure"
    dns_service_ip                                           = "12.0.3.10"
    docker_bridge_cidr                                       = "172.17.0.1/16"
    outbound_type                                            = null
    pod_cidr                                                 = null
    service_cidr                                             = "12.0.3.0/24"
    # load_balancer_sku                        = "Standard" #Defaults to "Standard", Provides LB profile if we are exclusively providing the load_balancer_sku. If not keep it to null
    # lb_outbound_ports_allocated              = null
    # lb_idle_timeout_in_minutes               = null
    # lb_managed_outbound_ip_count             = null
    # lb_outbound_ip_prefix_ids                = []
    # lb_outbound_ip_address_ids               = null
    identity_type                              = "SystemAssigned" #Best practise is to keep SystemAssigned since AKS creates a UserAssigned identity automatically to provide access to other resources & services. We need to provide access to that UserAssigned identity with necessary roles
    azure_policy_enabled                       = false
    ingress_application_gateway                = false
    application_gateway_name                   = "ploceusrg000001"
    http_application_routing_enabled           = true
    oms_agent_enabled                          = true               #If marked as true, then the OMS agent will be deployed along with a log analytics workspace ID.
    log_analytics_workspace_name               = "ploceuslog000001" #Provide log analytics worksapce name if oms_agent_enabled is true. If not, keep it as null
    user_identity_name                         = null               #"ploceusaksuseridentity"
    http_proxy                                 = null               #Optional parameter - Use this parameter only if http proxy is used, if not keep it as null.
    https_proxy                                = null               #Optional parameter - Use this parameter only if https proxt is used, if not keep it as null.
    no_proxy                                   = []                 #Optional parameter - Use this parameter only if no proxy is used, if not keep it as null.
    trusted_ca                                 = null               #Optional parameter - Use this parameter only if a CA certificate is used, if not keep it as null.
    open_service_mesh_enabled                  = false              #Optional parameter - Use this parameter to enable Service Mesh
    local_account_disabled                     = false              #Optional parameter - Use this parameter to disable local accounts
    maintenance_window_enabled                 = false              # Optional parameter - Use this to enable the maintenance window
    maintenance_window_allow_time_enabled      = false              #  Optional parameter - Use this parameter to enable the allowed time for maintenance
    maintenance_window_allow_time_day          = "Monday"
    maintenance_window_allow_time_hours        = [1, 2, 3, 4]
    maintenance_window_block_time_enabled      = false                  #  Optional parameter - Use this parameter to enable feature for blocking maintenance
    maintenance_window_block_starttime         = "2006-01-02T15:04:05Z" #Put only as  RFC3339 format
    maintenance_window_block_endtime           = "2006-01-02T15:06:05Z" #Put only as  RFC3339 format
    windows_profile_enabled                    = false                  # Make it true to enable Windows profile
    windows_profile_admin_password             = "admin@123456"         # Required if windows profile is enabled
    windows_profile_admin_username             = "adminkubeconfig"      # Required if windows profile is enabled
    windows_profile_license                    = "Windows_Server"       # Only allowed value is Windows_Server
    kubelet_identity_enabled                   = false
    kubelet_identity_client_id                 = "string"
    kubelet_identity_object_id                 = "string"
    kubelet_identity_user_assigned_identity_id = "string"
    linux_profile_enabled                      = false
    linux_profile_admin_username               = "adminuser123"
    linux_profile_ssh_key                      = "string"
    aks_cluster_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
