#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
  default = {}
}

#VNET VARIABLES
variable "vnets_variables" {
  description = "Map of vnet objects. name, vnet_address_space, and dns_server supported"
  type = map(object({
    name                        = string
    location                    = string
    resource_group_name         = string
    address_space               = list(string)
    dns_servers                 = list(string)
    is_ddos_protection_required = bool
    ddos_protection_plan_name   = string
    vnet_tags                   = map(string)
  }))
  default = {}
}

# #DDOS protection plan VARIABLES
# variable "ddos_protection_plan_variables" {
#   type = map(object({
#     name                            = string
#     resource_group_name             = string
#     location                        = string
#     ddos_protection_plan_tags       = map(string)
#   }))
# }

#Subnet VARIABLES


variable "subnet_variables" {
  type = map(object({
    name                                           = string
    resource_group_name                            = string
    virtual_network_name                           = string
    address_prefixes                               = list(string)
    enforce_private_link_service_network_policies  = bool
    enforce_private_link_endpoint_network_policies = bool
    service_endpoints                              = list(string)
    is_delegetion_required                         = bool
    delegation_name                                = string
    service_name                                   = string
    service_actions                                = list(string)
  }))
  default = {}
}


# #KEY VAULT VARIABLES
# variable "key_vault_variables" {
#   type = map(object({
#     name                            = string
#     resource_group_name             = string
#     location                        = string
#     enabled_for_disk_encryption     = bool
#     enabled_for_deployment          = bool
#     enabled_for_template_deployment = bool
#     #soft_delete_retention_days      = string
#     purge_protection_enabled = bool
#     sku_name                 = string
#     key_permissions          = list(string)
#     secret_permissions       = list(string)
#     storage_permissions      = list(string)
#     key_vault_tags           = map(string)
#   }))
# }

# #DISK ENCRYPTION SET VARIABLE


#Public IP VARIABLES
variable "public_ip_variable" {
  type = map(object({
    name                    = string
    resource_group_name     = string
    location                = string
    ip_version              = string
    allocation_method       = string
    sku                     = string
    sku_tier                = string
    public_ip_dns           = string
    idle_timeout_in_minutes = string
    availability_zone       = string
    reverse_fqdn            = string
    ip_tags                 = map(string)
    public_ip_tags          = map(string)
  }))
}

#APPLICATION GATEWAY VARIABLE
variable "application_gateway_variables" {
  type = map(object({
    name                           = string
    resource_group_name            = string
    location                       = string
    sku_name                       = string
    sku_tier                       = string
    sku_capacity                   = number
    gateway_ip_configuration_name  = string
    vnet_name                      = string
    subnet_name                    = string
    frontend_port_name             = string
    frontend_port                  = number
    frontend_ip_configuration_name = string
    is_private_fronted_ip_required = bool
    private_ip_address             = string
    is_public_fronted_ip_required  = bool
    public_ip_name                 = string
    private_ip_address_allocation  = string
    application_gateway_tags       = map(string)


    sku = object({
      name     = string
      tier     = string
      capacity = number
    })

    autoscale_configuration = object({
      min_capacity = number
      max_capacity = number
    })

    frontend_ports = list(object({
      name = string
      port = number
    }))

    backend_address_pools = list(object({
      name         = string
      fqdns        = list(string)
      ip_addresses = list(string)
    }))

    backend_http_settings = list(object({
      name                                = string
      cookie_based_affinity               = string
      path                                = string
      port                                = number
      request_timeout                     = number
      probe_name                          = string
      protocol                            = string
      host_name                           = string
      pick_host_name_from_backend_address = bool
    }))

    http_listeners = list(object({
      name                           = string
      frontend_ip_configuration_name = string
      frontend_port_name             = string
      ssl_certificate_name           = string
      protocol                       = string
      sni_required                   = bool
      listener_type                  = string       # MultiSite or Basic
      host_name                      = string       # Required if listener_type = MultiSite and host_names = null
      host_names                     = list(string) # Required if listener_type = MultiSite and host_name = null
      firewall_policy_id             = string
    }))

    request_routing_rules = list(object({
      name                        = string
      rule_type                   = string
      listener_name               = string
      backend_address_pool_name   = string
      backend_http_settings_name  = string
      redirect_configuration_name = string
      url_path_map_name           = string
      rewrite_rule_set_name       = string
    }))

    url_path_maps = list(object({
      name                                = string
      default_backend_http_settings_name  = string
      default_backend_address_pool_name   = string
      default_redirect_configuration_name = string
      default_rewrite_rule_set_name       = string
      path_rules = list(object({
        name                        = string
        paths                       = list(string)
        backend_http_settings_name  = string
        backend_address_pool_name   = string
        redirect_configuration_name = string
        rewrite_rule_set_name       = string
      }))
    }))
    waf_configuration = object({
      firewall_mode    = string
      rule_set_type    = string
      rule_set_version = number
      enabled          = bool
    })

    probes = list(object({
      name                                      = string
      path                                      = string
      interval                                  = number
      protocol                                  = string
      timeout                                   = number
      unhealthy_threshold                       = number
      host                                      = string
      pick_host_name_from_backend_http_settings = bool
    }))
    redirect_configurations = list(object({
      name                 = string
      redirect_type        = string
      target_listener_name = string
      target_url           = string
      include_path         = bool
      include_query_string = bool
    }))

  }))
}



#LOG ANALYTICS WORKSPACE VARIABLE
variable "log_analytics_workspace_variables" {
  type = map(object({
    name                               = string
    location                           = string
    resource_group_name                = string
    sku                                = string
    retention_in_days                  = number
    daily_quota_gb                     = number
    internet_ingestion_enabled         = bool
    internet_query_enabled             = bool
    reservation_capacity_in_gb_per_day = number
    log_analytics_workspace_tags       = map(string)
  }))
}


#AKS CLUSTER VARIABLE
variable "aks_cluster_variables" {
  type = map(object({
    vnet_name                                = string
    resource_group_name                      = string
    subnet_name                              = string
    disk_encryption_set_name                 = string
    is_subnet_required                       = bool
    is_disk_encryption_set_required          = bool
    name                                     = string
    location                                 = string
    dns_prefix                               = string
    node_resource_group_name                 = string
    sku_tier                                 = string
    dns_prefix_private_cluster               = string
    private_cluster_enabled                  = bool
    private_dns_zone_id                      = string
    api_server_authorized_ip_ranges          = list(string)
    kubernetes_version                       = string
    automatic_channel_upgrade                = string
    default_node_pool_name                   = string
    default_node_pool_node_count             = number
    default_node_pool_vm_size                = string
    default_node_pool_type                   = string
    default_node_pool_availability_zones     = list(string)
    default_node_pool_enable_auto_scaling    = bool
    default_node_pool_max_count              = number
    default_node_pool_min_count              = number
    default_node_pool_enable_host_encryption = bool
    default_node_pool_enable_node_public_ip  = bool
    default_node_pool_max_pods               = number
    default_node_pool_node_labels            = map(string)
    default_node_pool_os_disk_size_gb        = number
    role_based_access_control_enabled        = bool
    aad_managed                              = bool
    aad_tenant_id                            = string
    aad_admin_group_object_ids               = list(string)
    aad_azure_rbac_enabled                   = bool
    aad_client_app_id                        = string
    aad_server_app_id                        = string
    aad_server_app_secret                    = string
    balance_similar_node_groups              = bool
    expander                                 = string
    max_graceful_termination_sec             = number
    max_node_provisioning_time               = string
    max_unready_nodes                        = number
    max_unready_percentage                   = number
    new_pod_scale_up_delay                   = string
    scale_down_delay_after_add               = string
    scale_down_delay_after_delete            = string
    scale_down_delay_after_failure           = string
    scan_interval                            = string
    scale_down_unneeded                      = string
    scale_down_unready                       = string
    scale_down_utilization_threshold         = number
    empty_bulk_delete_max                    = number
    skip_nodes_with_local_storage            = bool
    skip_nodes_with_system_pods              = bool
    network_plugin                           = string
    network_policy                           = string
    dns_service_ip                           = string
    docker_bridge_cidr                       = string
    outbound_type                            = string
    pod_cidr                                 = string
    service_cidr                             = string
    # load_balancer_sku                        = string
    # lb_outbound_ports_allocated              = string
    # lb_idle_timeout_in_minutes               = string
    # lb_managed_outbound_ip_count             = string
    # lb_outbound_ip_prefix_ids                = list(string)
    # lb_outbound_ip_address_ids               = list(string)
    identity_type                              = string
    azure_policy_enabled                       = bool
    ingress_application_gateway_enabled        = bool
    application_gateway_name                   = string
    http_application_routing_enabled           = bool
    kube_dashboard_enabled                     = bool
    oms_agent_enabled                          = bool
    log_analytics_workspace_name               = string
    user_identity_name                         = string
    http_proxy                                 = string
    https_proxy                                = string
    no_proxy                                   = list(string)
    trusted_ca                                 = string
    open_service_mesh_enabled                  = bool
    local_account_disabled                     = bool
    maintenance_window_enabled                 = bool
    maintenance_window_allow_time_enabled      = bool
    maintenance_window_allow_time_day          = string
    maintenance_window_allow_time_hours        = list(number)
    maintenance_window_block_time_enabled      = bool
    maintenance_window_block_starttime         = string
    maintenance_window_block_endtime           = string
    windows_profile_enabled                    = bool
    windows_profile_admin_password             = string
    windows_profile_admin_username             = string
    windows_profile_license                    = string
    kubelet_identity_enabled                   = bool
    kubelet_identity_client_id                 = string
    kubelet_identity_object_id                 = string
    kubelet_identity_user_assigned_identity_id = string
    linux_profile_enabled                      = bool
    linux_profile_admin_username               = string
    linux_profile_ssh_key                      = string
    aks_cluster_tags                           = map(string)
  }))
}