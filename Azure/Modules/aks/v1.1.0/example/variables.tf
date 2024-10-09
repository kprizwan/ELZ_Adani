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

#VNET variable
variable "vnets_variables" {
  description = "Map of vnet objects. name, vnet_address_space, and dns_server supported"
  type = map(object({
    name                        = string
    location                    = string
    resource_group_name         = string
    address_space               = list(string)
    dns_servers                 = list(string)
    flow_timeout_in_minutes     = number
    bgp_community               = string
    is_ddos_protection_required = bool
    ddos_protection_plan_name   = string
    edge_zone                   = string
    vnet_tags                   = map(string)
  }))
  default = {}
}


#Subnet Variables
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

#Variables for public IP
variable "public_ip_variables" {
  type = map(object({
    name                    = string
    resource_group_name     = string
    location                = string
    ip_version              = string
    allocation_method       = string
    sku                     = string
    sku_tier                = string
    zones                   = list(string)
    edge_zone               = string
    public_ip_dns           = string
    idle_timeout_in_minutes = string
    reverse_fqdn            = string
    public_ip_prefix_id     = string
    ip_tags                 = map(string)
    public_ip_tags          = map(string)
  }))
}


#USER ASSIGNED IDENTITY VARIABLES
variable "user_assigned_identity_variables" {
  description = "Map of user assigned identity"
  type = map(object({
    user_assigned_identity_name                = string
    user_assigned_identity_location            = string
    user_assigned_identity_resource_group_name = string
    user_assigned_identity_tags                = map(string)
  }))
  default = {}
}

#APPLICATION GATEWAY VARIABLE
variable "application_gateway_variables" {
  type = map(object({
    application_gateway_name                              = string
    application_gateway_resource_group_name               = string
    application_gateway_location                          = string
    application_gateway_sku_name                          = string
    application_gateway_sku_tier                          = string
    application_gateway_sku_capacity                      = number
    application_gateway_vnet_name                         = string
    application_gateway_subnet_name                       = string
    application_gateway_frontend_port_name                = string
    application_gateway_frontend_port                     = number
    application_gateway_is_private_frontend_ip_required   = bool
    application_gateway_is_public_frontend_ip_required    = bool
    application_gateway_is_waf_policy_required            = bool
    application_gateway_waf_policy_name                   = string
    application_gateway_waf_policy_resource_group_name    = string
    application_gateway_public_ip_name                    = string
    application_gateway_fips_enabled                      = bool
    application_gateway_force_firewall_policy_association = bool
    application_gateway_zones                             = list(string)
    application_gateway_keyvault_cert_configuration = object({
      keyvault_cert_configuration_certificate_keyvault_name       = string
      keyvault_cert_configuration_certificate_resource_group_name = string
    })
    application_gateway_application_gateway_tags = map(string)
    application_gateway_enable_http2             = bool


    application_gateway_sku = object({
      sku_name     = string
      sku_tier     = string
      sku_capacity = number
    })


    application_gateway_trusted_client_certificate = list(object({
      trusted_client_certificate_name                                           = string
      trusted_client_certificate_trusted_client_certificate_resource_group_name = string
    }))
    application_gateway_ssl_certificate = list(object({
      ssl_certificate_name                  = string
      ssl_certificate_key_vault_secret_name = string
    }))

    application_gateway_authentication_certificate = list(object({
      authentication_certificate_name                  = string
      authentication_certificate_key_vault_secret_name = string
    }))

    application_gateway_trusted_root_certificate = list(object({
      trusted_root_certificate_name                  = string
      trusted_root_certificate_key_vault_secret_name = string
    }))

    application_gateway_identity = list(object({
      identity_type                         = string
      identity_identity_name                = string
      identity_identity_resource_group_name = string
    }))

    application_gateway_private_link_configuration = list(object({
      private_link_configuration_name = string
      private_link_configuration_ip_configuration = list(object({
        ip_configuration_subnet_id                     = string
        ip_configuration_private_ip_address_allocation = string
        ip_configuration_name                          = bool
        ip_configuration_private_ip_address            = string
        ip_configuration_primary                       = bool
        ip_configuration_private_ip_address            = string
      }))
    }))

    application_gateway_ssl_profile = list(object({
      ssl_profile_name                             = string
      ssl_profile_trusted_client_certificate_names = string
      ssl_profile_verify_client_cert_issuer_dn     = string
    }))
    application_gateway_ssl_policy = list(object({
      ssl_policy_name                 = string
      ssl_policy_policy_type          = string
      ssl_policy_cipher_suites        = list(string)
      ssl_policy_min_protocol_version = string
    }))

    application_gateway_autoscale_configuration = object({
      autoscale_configuration_min_capacity = number
      autoscale_configuration_max_capacity = number
    })

    application_gateway_frontend_ports = list(object({
      frontend_ports_name = string
      frontend_ports_port = number
    }))

    application_gateway_backend_address_pools = list(object({
      backend_address_pools_name         = string
      backend_address_pools_fqdns        = list(string)
      backend_address_pools_ip_addresses = list(string)
    }))

    application_gateway_backend_http_settings = list(object({
      backend_http_settings_name                                = string
      backend_http_settings_cookie_based_affinity               = string
      backend_http_settings_path                                = string
      backend_http_settings_port                                = number
      backend_http_settings_request_timeout                     = number
      backend_http_settings_probe_name                          = string
      backend_http_settings_protocol                            = string
      backend_http_settings_host_name                           = string
      backend_http_settings_pick_host_name_from_backend_address = bool
      backend_http_settings_affinity_cookie_name                = string
      backend_http_settings_trusted_root_certificate_names      = list(string)
      backend_http_settings_authentication_certificate = list(object({
        authentication_certificate_name = string
      }))
      backend_http_settings_connection_draining = list(object({
        connection_draining_enabled           = bool
        connection_draining_drain_timeout_sec = string
      }))
    }))
    application_gateway_gateway_ip_configuration = list(object({
      gateway_ip_configuration_name        = string
      gateway_ip_configuration_subnet_name = string
    }))

    application_gateway_frontend_ip_configuration = list(object({
      frontend_ip_configuration_name                            = string
      frontend_ip_configuration_private_ip_address              = string
      frontend_ip_configuration_private_ip_address_allocation   = string
      frontend_ip_configuration_private_link_configuration_name = string
      frontend_ip_configuration_is_private_frontend_ip_required = bool
      frontend_ip_configuration_is_public_frontend_ip_required  = bool
    }))

    application_gateway_http_listener = list(object({
      http_listener_name                           = string
      http_listener_frontend_ip_configuration_name = string
      http_listener_frontend_port_name             = string
      http_listener_ssl_certificate_name           = string
      http_listener_protocol                       = string
      http_listener_sni_required                   = bool
      http_listener_listener_type                  = string       # MultiSite or Basic
      http_listener_host_name                      = string       # Required if listener_type = MultiSite and host_names = null
      http_listener_host_names                     = list(string) # Required if listener_type = MultiSite and host_name = null
      http_listener_ssl_profile_name               = string
      http_listener_custom_error_configuration = list(object({
        custom_error_configuration_status_code           = string
        custom_error_configuration_custom_error_page_url = string
      }))
    }))

    application_gateway_request_routing_rules = list(object({
      request_routing_rules_name                        = string
      request_routing_rules_rule_type                   = string
      request_routing_rules_listener_name               = string
      request_routing_rules_backend_address_pool_name   = string
      request_routing_rules_backend_http_settings_name  = string
      request_routing_rules_redirect_configuration_name = string
      request_routing_rules_url_path_map_name           = string
      request_routing_rules_priority                    = string
      request_routing_rules_rewrite_rule_set_name       = string
    }))

    application_gateway_url_path_maps = list(object({
      url_path_maps_name                                = string
      url_path_maps_default_backend_http_settings_name  = string
      url_path_maps_default_backend_address_pool_name   = string
      url_path_maps_default_redirect_configuration_name = string
      url_path_maps_default_rewrite_rule_set_name       = string
      url_path_maps_path_rules = list(object({
        path_rules_name                        = string
        path_rules_paths                       = list(string)
        path_rules_backend_http_settings_name  = string
        path_rules_backend_address_pool_name   = string
        path_rules_redirect_configuration_name = string
        path_rules_rewrite_rule_set_name       = string
      }))
    }))
    application_gateway_waf_configuration = object({
      waf_configuration_firewall_mode            = string
      waf_configuration_rule_set_type            = string
      waf_configuration_rule_set_version         = number
      waf_configuration_enabled                  = bool
      waf_configuration_file_upload_limit_mb     = string
      waf_configuration_request_body_check       = bool
      waf_configuration_max_request_body_size_kb = string

      waf_configuration_disabled_rule_group = object({
        disabled_rule_group_rule_group_name = string
      })

      waf_configuration_exclusion = object({
        exclusion_match_variable          = string
        exclusion_selector_match_operator = string
        exclusion_selector                = string
      })
    })

    application_gateway_probe = list(object({
      probe_name                                      = string
      probe_path                                      = string
      probe_interval                                  = number
      probe_protocol                                  = string
      probe_timeout                                   = number
      probe_unhealthy_threshold                       = number
      probe_host                                      = string
      probe_port                                      = string
      probe_minimum_servers                           = string
      probe_pick_host_name_from_backend_http_settings = bool
      probe_match = list(object({
        match_body        = string
        match_status_code = list(string)
      }))
    }))
    application_gateway_redirect_configurations = list(object({
      redirect_configurations_name                 = string
      redirect_configurations_redirect_type        = string
      redirect_configurations_target_listener_name = string
      redirect_configurations_target_url           = string
      redirect_configurations_include_path         = bool
      redirect_configurations_include_query_string = bool
    }))
    application_gateway_rewrite_rule_set = list(object({
      rewrite_rule_set_name = string
      rewrite_rule_set_rewrite_rule = list(object({
        rewrite_rule_name          = string
        rewrite_rule_rule_sequence = string
        rule_sequence_condition = list(object({
          condition_variable    = string
          condition_pattern     = string
          condition_ignore_case = string
          condition_negate      = string
        }))
        rewrite_rule_set_response_header_configuration = list(object({
          response_header_configuration_header_name  = string
          response_header_configuration_header_value = string
        }))
        rewrite_rule_set_request_header_configuration = list(object({
          request_header_configuration_header_name  = string
          request_header_configuration_header_value = string
        }))
        rewrite_rule_set_url = list(object({
          url_path         = string
          url_query_string = string
          url_reroute      = string
        }))
      }))
    }))

  }))
}

#LOG ANALYTICS WORKSPACE VARIABLE
variable "log_analytics_workspace_variables" {
  type = map(object({
    log_analytics_workspace_name                               = string
    log_analytics_workspace_location                           = string
    log_analytics_workspace_resource_group_name                = string
    log_analytics_workspace_sku                                = string
    log_analytics_workspace_retention_in_days                  = number
    log_analytics_workspace_daily_quota_gb                     = number
    log_analytics_workspace_internet_ingestion_enabled         = bool
    log_analytics_workspace_internet_query_enabled             = bool
    log_analytics_workspace_reservation_capacity_in_gb_per_day = number
    log_analytics_workspace_tags                               = map(string)
  }))
}


#AKS CLUSTER VARIABLE
variable "aks_cluster_variables" {
  type = map(object({
    vnet_name                                                = string
    resource_group_name                                      = string
    subnet_name                                              = string
    disk_encryption_set_name                                 = string
    is_subnet_required                                       = bool
    is_disk_encryption_set_required                          = bool
    aks_name                                                 = string
    location                                                 = string
    dns_prefix                                               = string
    node_resource_group_name                                 = string
    sku_tier                                                 = string
    dns_prefix_private_cluster                               = string
    private_cluster_enabled                                  = bool
    private_dns_zone_id                                      = string
    api_server_authorized_ip_ranges                          = list(string)
    kubernetes_version                                       = string
    automatic_channel_upgrade                                = string
    default_node_pool_name                                   = string
    default_node_pool_node_count                             = number
    default_node_pool_vm_size                                = string
    default_node_pool_type                                   = string
    default_node_pool_availability_zones                     = list(string)
    default_node_pool_enable_auto_scaling                    = bool
    default_node_pool_max_count                              = number
    default_node_pool_min_count                              = number
    default_node_pool_enable_host_encryption                 = bool
    default_node_pool_enable_node_public_ip                  = bool
    default_node_pool_max_pods                               = number
    default_node_pool_node_labels                            = map(string)
    default_node_pool_os_disk_size_gb                        = number
    azure_active_directory_role_based_access_control_enabled = bool
    aad_managed                                              = bool
    aad_tenant_id                                            = string
    aad_admin_group_object_ids                               = list(string)
    aad_azure_rbac_enabled                                   = bool
    aad_client_app_id                                        = string
    aad_server_app_id                                        = string
    aad_server_app_secret                                    = string
    balance_similar_node_groups                              = bool
    expander                                                 = string
    max_graceful_termination_sec                             = number
    max_node_provisioning_time                               = string
    max_unready_nodes                                        = number
    max_unready_percentage                                   = number
    new_pod_scale_up_delay                                   = string
    scale_down_delay_after_add                               = string
    scale_down_delay_after_delete                            = string
    scale_down_delay_after_failure                           = string
    scan_interval                                            = string
    scale_down_unneeded                                      = string
    scale_down_unready                                       = string
    scale_down_utilization_threshold                         = number
    empty_bulk_delete_max                                    = number
    skip_nodes_with_local_storage                            = bool
    skip_nodes_with_system_pods                              = bool
    network_plugin                                           = string
    network_policy                                           = string
    dns_service_ip                                           = string
    docker_bridge_cidr                                       = string
    outbound_type                                            = string
    pod_cidr                                                 = string
    service_cidr                                             = string
    # load_balancer_sku                        = string
    # lb_outbound_ports_allocated              = string
    # lb_idle_timeout_in_minutes               = string
    # lb_managed_outbound_ip_count             = string
    # lb_outbound_ip_prefix_ids                = list(string)
    # lb_outbound_ip_address_ids               = list(string)
    identity_type                              = string
    azure_policy_enabled                       = bool
    ingress_application_gateway                = bool
    application_gateway_name                   = string
    http_application_routing_enabled           = bool
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