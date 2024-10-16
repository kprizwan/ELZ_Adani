#LOCALS BLOCK
locals {
  is_public_ip_exists  = { for k, v in var.application_gateway_variables : k => v if lookup(v, "application_gateway_is_public_frontend_ip_required", false) == true }
  is_waf_policy_exists = { for k, v in var.application_gateway_variables : k => v if lookup(v, "application_gateway_is_waf_policy_required", false) == true }
  gateway_ip_config_subnet_map = flatten([
    for k, v in var.application_gateway_variables : [
      for i, j in v.application_gateway_gateway_ip_configuration :
      merge({
        app_gateway_name = k, subnet_name = j.gateway_ip_configuration_subnet_name, vnet_name = v.application_gateway_vnet_name, resource_group_name = v.application_gateway_vnet_resource_group_name
      }, j) if j.gateway_ip_configuration_subnet_name != null
    ]
  ])

  gateway_listener_ssl_cert_map = flatten([
    for k, v in var.application_gateway_variables : [
      for i, j in v.application_gateway_ssl_certificate :
      merge({
        app_gateway_name = k, keyvault_name = v.application_gateway_keyvault_cert_configuration.keyvault_cert_configuration_certificate_keyvault_name, certificate_name = j.ssl_certificate_key_vault_secret_name, pfx_pass_secret_name = j.ssl_certificate_pfx_password_key_vault_secret_name
      }, j)
    ] if v.application_gateway_ssl_certificate != null
  ])

  gateway_user_managed_identity_map = flatten([
    for k, v in var.application_gateway_variables : [
      for i, j in v.application_gateway_identity :
      merge({
        app_gateway_name = k, identity_name = j.identity_identity_name, identity_resource_group_name = j.identity_identity_resource_group_name
      }, j)
    ] if v.application_gateway_identity != null
  ])

  gateway_trusted_client_certificate_map = flatten([
    for k, v in var.application_gateway_variables : [
      for i, j in v.application_gateway_trusted_client_certificate :
      merge({
        app_gateway_name = k, client_certificate_name = j.trusted_client_certificate_name, client_cert_resource_group_name = j.trusted_client_certificate_trusted_client_certificate_resource_group_name
      }, j)
    ] if v.application_gateway_trusted_client_certificate != null
  ])

  gateway_trusted_root_certificate_map = flatten([
    for k, v in var.application_gateway_variables : [
      for i, j in v.application_gateway_trusted_root_certificate :
      merge({
        app_gateway_name = k, root_certificate_name = j.trusted_root_certificate_name, keyvault_root_cert_secret_name = j.trusted_root_certificate_key_vault_secret_name
      }, j)
    ] if v.application_gateway_trusted_root_certificate != null
  ])

  gateway_authentication_certificate_map = flatten([
    for k, v in var.application_gateway_variables : [
      for i, j in v.application_gateway_authentication_certificate :
      merge({
        app_gateway_name = k, authentication_certificate_name = j.authentication_certificate_name, keyvault_auth_cert_secret_name = j.authentication_certificate_name_key_vault_secret_name
      }, j)
    ] if v.application_gateway_authentication_certificate != null
  ])

  gateway_keyvault_map = { for k, v in var.application_gateway_variables : k => v if v.application_gateway_keyvault_cert_configuration != null }
}

#DATA BLOCK TO FETCH VNET ID
data "azurerm_virtual_network" "vnet_id" {
  for_each            = var.application_gateway_variables
  name                = each.value.application_gateway_vnet_name
  resource_group_name = each.value.application_gateway_vnet_resource_group_name
}

#DATA BLOCK TO FETCH SUBNET ID
data "azurerm_subnet" "subnet_id" {
  for_each             = var.application_gateway_variables
  name                 = each.value.application_gateway_subnet_name
  virtual_network_name = each.value.application_gateway_vnet_name
  resource_group_name  = each.value.application_gateway_vnet_resource_group_name
}

#DATA BLOCK TO FETCH GATEWAY IP CONFIG SUNET ID
data "azurerm_subnet" "gateway_ip_config_subnet_id" {
  for_each             = { for i in local.gateway_ip_config_subnet_map : "${i.app_gateway_name}:${i.subnet_name}" => i }
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}

#DATA BLOCK TO FETCH PUBLIC IP ID
data "azurerm_public_ip" "public_ip" {
  for_each            = local.is_public_ip_exists
  name                = each.value.application_gateway_public_ip_name
  resource_group_name = each.value.application_gateway_resource_group_name
}

#DATA BLOCK TO FETCH KEYVAULT ID
data "azurerm_key_vault" "ssl_cert_keyvault_id" {
  for_each            = local.gateway_keyvault_map
  name                = each.value.application_gateway_keyvault_cert_configuration.keyvault_cert_configuration_certificate_keyvault_name
  resource_group_name = each.value.application_gateway_keyvault_cert_configuration.keyvault_cert_configuration_certificate_resource_group_name
}

#DATA BLOCK TO FETCH SSL CERT KEYVAULT SECRET ID
data "azurerm_key_vault_secret" "ssl_cert_ids" {
  for_each     = { for x in local.gateway_listener_ssl_cert_map : "${x.app_gateway_name}:${x.keyvault_name}:${x.certificate_name}" => x }
  name         = each.value.certificate_name
  key_vault_id = data.azurerm_key_vault.ssl_cert_keyvault_id[each.value.app_gateway_name].id
}

#DATA BLOCK TO FETCH PFX PASSWORD KEYVAULT SECRET ID
data "azurerm_key_vault_secret" "ssl_cert_pfx_pass_ids" {
  for_each     = { for x in local.gateway_listener_ssl_cert_map : "${x.app_gateway_name}:${x.keyvault_name}:${x.pfx_pass_secret_name}" => x if x.pfx_pass_secret_name != null }
  name         = each.value.pfx_pass_secret_name
  key_vault_id = data.azurerm_key_vault.ssl_cert_keyvault_id[each.value.app_gateway_name].id
}

#DATA BLOCK TO FETCH TRUSTED ROOT CERT KEYVAULT SECRET ID
data "azurerm_key_vault_secret" "trusted_root_cert_ids" {
  for_each     = { for x in local.gateway_trusted_root_certificate_map : "${x.app_gateway_name}:${x.name}:${x.keyvault_root_cert_secret_name}" => x }
  name         = each.value.certificate_name
  key_vault_id = data.azurerm_key_vault.ssl_cert_keyvault_id[each.value.app_gateway_name].id
}

#DATA BLOCK TO FETCH CLIENT CERT KEYVAULT SECRET ID
data "azurerm_key_vault_certificate" "client_cert_ids" {
  for_each     = { for x in local.gateway_trusted_client_certificate_map : "${x.app_gateway_name}:${x.client_certificate_name}" => x }
  name         = each.value.client_certificate_name
  key_vault_id = data.azurerm_key_vault.ssl_cert_keyvault_id[each.value.app_gateway_name].id
}

#DATA BLOCK TO FETCH AUTHENTICATION CERT KEYVAULT SECRET ID
data "azurerm_key_vault_certificate" "authentication_cert_ids" {
  for_each     = { for x in local.gateway_authentication_certificate_map : "${x.app_gateway_name}:${x.authentication_certificate_name}:${x.keyvault_auth_cert_secret_name}" => x }
  name         = each.value.keyvault_auth_cert_secret_name
  key_vault_id = data.azurerm_key_vault.ssl_cert_keyvault_id[each.value.app_gateway_name].id
}

#DATA BLOCK TO FETCH WAF POLICY ID
data "azurerm_web_application_firewall_policy" "waf_policy_id" {
  for_each            = local.is_waf_policy_exists
  name                = each.value.application_gateway_waf_policy_name
  resource_group_name = each.value.application_gateway_waf_policy_resource_group_name
}

#DATA BLOCK TO FETCH USER MANAGED IDENTITY ID
data "azurerm_user_assigned_identity" "user_managed_identity_ids" {
  for_each            = { for x in local.gateway_user_managed_identity_map : "${x.app_gateway_name}:${x.identity_name}:${x.identity_resource_group_name}" => x }
  name                = each.value.identity_name
  resource_group_name = each.value.identity_resource_group_name
}

#APPLICATION GATEWAY
resource "azurerm_application_gateway" "application_gateway" {
  for_each                          = var.application_gateway_variables
  name                              = each.value.application_gateway_name
  resource_group_name               = each.value.application_gateway_resource_group_name
  location                          = each.value.application_gateway_location
  fips_enabled                      = each.value.application_gateway_fips_enabled
  zones                             = each.value.application_gateway_zones
  enable_http2                      = each.value.application_gateway_enable_http2
  force_firewall_policy_association = each.value.application_gateway_force_firewall_policy_association
  firewall_policy_id                = each.value.application_gateway_is_waf_policy_required == false ? null : data.azurerm_web_application_firewall_policy.waf_policy_id[each.key].id

  dynamic "sku" {
    for_each = lookup(each.value, "application_gateway_sku", null) == null ? [] : [each.value.application_gateway_sku]
    content {
      name     = sku.value.sku_name
      tier     = sku.value.sku_tier
      capacity = sku.value.sku_capacity
    }
  }

  dynamic "identity" {
    for_each = each.value.application_gateway_identity != null ? each.value.application_gateway_identity : []
    content {
      type         = identity.value.identity_type
      identity_ids = [for k, v in each.value.application_gateway_identity : data.azurerm_user_assigned_identity.user_managed_identity_ids["${each.key}:${v.identity_identity_name}:${v.identity_identity_resource_group_name}"].id]
    }
  }

  dynamic "trusted_client_certificate" {
    for_each = each.value.application_gateway_trusted_client_certificate != null ? [each.value.application_gateway_trusted_client_certificate] : []
    content {
      name = trusted_client_certificate.value.trusted_client_certificate_name
      data = data.azurerm_key_vault_certificate.client_cert_ids["${each.key}:${trusted_client_certificate.value.trusted_client_certificate_name}"].certificate_data
    }
  }

  dynamic "authentication_certificate" {
    for_each = each.value.application_gateway_authentication_certificate != null ? [each.value.application_gateway_authentication_certificate] : []
    content {
      name = authentication_certificate.value.authentication_certificate_name
      data = data.azurerm_key_vault_certificate.azurerm_key_vault_certificate.authentication_cert_ids["${each.key}:${authentication_certificate.value.authentication_certificate_name}:${authentication_certificate.authentication_certificate_key_vault_secret_name}"].certificate_data
    }
  }

  dynamic "autoscale_configuration" {
    for_each = each.value["application_gateway_autoscale_configuration"] != null ? [each.value["application_gateway_autoscale_configuration"]] : []
    content {
      min_capacity = autoscale_configuration.value.autoscale_configuration_min_capacity
      max_capacity = autoscale_configuration.value.autoscale_configuration_max_capacity
    }
  }

  dynamic "gateway_ip_configuration" {
    for_each = each.value.application_gateway_gateway_ip_configuration != null ? toset(each.value.application_gateway_gateway_ip_configuration) : []
    content {
      name      = gateway_ip_configuration.value.gateway_ip_configuration_name
      subnet_id = gateway_ip_configuration.value.gateway_ip_configuration_subnet_name != null ? data.azurerm_subnet.gateway_ip_config_subnet_id["${each.key}:${gateway_ip_configuration.value.gateway_ip_configuration_subnet_name}"].id : data.azurerm_subnet.subnet_id[each.key].id
    }
  }

  dynamic "trusted_root_certificate" {
    for_each = each.value.application_gateway_trusted_root_certificate != null ? [each.value.application_gateway_trusted_root_certificate] : []
    content {
      name                = trusted_root_certificate.value.trusted_root_certificate_name
      data                = trusted_root_certificate.value.trusted_root_certificate_key_vault_secret_name == null ? trusted_root_certificate.value.trusted_root_certificate_data : null
      key_vault_secret_id = trusted_root_certificate.value.trusted_root_certificate_key_vault_secret_name == null ? null : data.azurerm_key_vault_secret.trusted_root_cert_ids["${each.key}:${trusted_root_certificate.value.trusted_root_certificate_name}"].id
    }
  }

  dynamic "frontend_port" {
    for_each = coalesce(lookup(each.value, "application_gateway_frontend_ports"), [])
    content {
      name = frontend_port.value.frontend_ports_name
      port = coalesce(frontend_port.value.frontend_ports_port, 0)
    }
  }


  dynamic "frontend_ip_configuration" {
    for_each = each.value.application_gateway_frontend_ip_configuration != null ? toset(each.value.application_gateway_frontend_ip_configuration) : []
    content {
      name                            = frontend_ip_configuration.value.frontend_ip_configuration_name
      subnet_id                       = frontend_ip_configuration.value.frontend_ip_configuration_is_private_frontend_ip_required == false ? null : data.azurerm_subnet.subnet_id[each.key].id
      private_ip_address              = frontend_ip_configuration.value.frontend_ip_configuration_private_ip_address
      public_ip_address_id            = frontend_ip_configuration.value.frontend_ip_configuration_is_public_frontend_ip_required == false ? null : data.azurerm_public_ip.public_ip[each.key].id
      private_ip_address_allocation   = frontend_ip_configuration.value.frontend_ip_configuration_private_ip_address_allocation
      private_link_configuration_name = frontend_ip_configuration.value.frontend_ip_configuration_private_link_configuration_name
    }
  }

  dynamic "backend_address_pool" {
    for_each = coalesce(lookup(each.value, "application_gateway_backend_address_pools"), [])
    content {
      name         = backend_address_pool.value.backend_address_pools_name
      fqdns        = lookup(backend_address_pool.value, "backend_address_pools_fqdns", null)
      ip_addresses = lookup(backend_address_pool.value, "backend_address_pools_ip_addresses", null)
    }
  }

  dynamic "backend_http_settings" {
    for_each = coalesce(lookup(each.value, "application_gateway_backend_http_settings"), [])
    content {
      name                                = backend_http_settings.value.backend_http_settings_name
      cookie_based_affinity               = coalesce(backend_http_settings.value.backend_http_settings_cookie_based_affinity, "Disabled")
      path                                = backend_http_settings.value.backend_http_settings_path
      port                                = coalesce(backend_http_settings.value.backend_http_settings_port, 0)
      protocol                            = coalesce(backend_http_settings.value.backend_http_settings_protocol, "Https")
      request_timeout                     = coalesce(backend_http_settings.value.backend_http_settings_request_timeout, 20)
      probe_name                          = lookup(backend_http_settings.value, "backend_http_settings_probe_name", null)
      host_name                           = coalesce(backend_http_settings.value.backend_http_settings_pick_host_name_from_backend_address, false) == false ? lookup(backend_http_settings.value, "host_name", null) : null
      pick_host_name_from_backend_address = coalesce(backend_http_settings.value.backend_http_settings_pick_host_name_from_backend_address, false)
      trusted_root_certificate_names      = coalesce(backend_http_settings.value.backend_http_settings_protocol, "Https") == "Https" ? lookup(each.value, "backend_http_settings_trusted_root_certificate_names", null) : null
      affinity_cookie_name                = backend_http_settings.value.backend_http_settings_affinity_cookie_name
      dynamic "authentication_certificate" {
        for_each = backend_http_settings.value.backend_http_settings_authentication_certificate != null ? [backend_http_settings.value.backend_http_settings_authentication_certificate] : []
        content {
          name = authentication_certificate.value.authentication_certificate_name
        }
      }
      dynamic "connection_draining" {
        for_each = coalesce(lookup(backend_http_settings.value, "backend_http_settings_connection_draining"), [])
        content {
          enabled           = connection_draining.value.connection_draining_enabled
          drain_timeout_sec = connection_draining.value.connection_draining_drain_timeout_sec
        }
      }
    }
  }


  dynamic "http_listener" {
    for_each = coalesce(lookup(each.value, "application_gateway_http_listener"), [])
    content {
      name                           = http_listener.value.http_listener_name
      frontend_ip_configuration_name = http_listener.value.http_listener_frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.http_listener_frontend_port_name
      ssl_profile_name               = http_listener.value.http_listener_ssl_profile_name
      protocol                       = coalesce(http_listener.value.http_listener_protocol, "Https")
      ssl_certificate_name           = lookup(http_listener.value, "http_listener_ssl_certificate_name", null)
      require_sni                    = coalesce(http_listener.value.http_listener_sni_required, false)
      host_name                      = (coalesce(http_listener.value.http_listener_listener_type, "Basic") == "MultiSite" && http_listener.value.http_listener_host_names == null) ? http_listener.value.http_listener_host_name : null
      host_names                     = (coalesce(http_listener.value.http_listener_listener_type, "Basic") == "MultiSite" && http_listener.value.http_listener_host_name == null) ? http_listener.value.http_listener_host_names : null
      firewall_policy_id             = each.value.application_gateway_is_waf_policy_required == false ? null : data.azurerm_web_application_firewall_policy.waf_policy_id[each.key].id
      dynamic "custom_error_configuration" {
        for_each = coalesce(lookup(http_listener.value, "http_listener_custom_error_configuration"), [])
        content {
          status_code           = custom_error_configuration.value.custom_error_configuration_status_code
          custom_error_page_url = custom_error_configuration.value.custom_error_configuration_custom_error_page_url
        }
      }
    }
  }

  dynamic "ssl_certificate" {
    for_each = each.value.application_gateway_ssl_certificate != null ? each.value.application_gateway_ssl_certificate : []
    content {
      name                = ssl_certificate.value.ssl_certificate_name
      data                = ssl_certificate.value.ssl_certificate_key_vault_secret_name != null ? ssl_certificate.value.ssl_certificate_data : null
      password            = ssl_certificate.value.ssl_certificate_data == null ? null : data.azurerm_key_vault_secret.ssl_cert_pfx_pass_ids["${each.key}:${each.value.application_gateway_keyvault_cert_configuration.keyvault_cert_configuration_certificate_keyvault_name}:${ssl_certificate.value.ssl_certificate_name}"].id
      key_vault_secret_id = ssl_certificate.value.ssl_certificate_key_vault_secret_name != null ? data.azurerm_key_vault_secret.ssl_cert_ids["${each.key}:${each.value.application_gateway_keyvault_cert_configuration.keyvault_cert_configuration_certificate_keyvault_name}:${ssl_certificate.value.ssl_certificate_key_vault_secret_name}"].id : null
    }
  }

  dynamic "request_routing_rule" {
    for_each = coalesce(lookup(each.value, "application_gateway_request_routing_rules"), [])
    content {
      name                        = request_routing_rule.value.request_routing_rules_name
      rule_type                   = coalesce(request_routing_rule.value.request_routing_rules_rule_type, "Basic")
      http_listener_name          = request_routing_rule.value.request_routing_rules_listener_name
      priority                    = request_routing_rule.value.request_routing_rules_priority
      backend_address_pool_name   = request_routing_rule.value.request_routing_rules_redirect_configuration_name == null ? lookup(request_routing_rule.value, "request_routing_rules_backend_address_pool_name", null) : null
      backend_http_settings_name  = request_routing_rule.value.request_routing_rules_redirect_configuration_name == null ? lookup(request_routing_rule.value, "request_routing_rules_backend_http_settings_name", null) : null
      redirect_configuration_name = (request_routing_rule.value.request_routing_rules_backend_http_settings_name == null && request_routing_rule.value.request_routing_rules_backend_address_pool_name == null) ? lookup(request_routing_rule.value, "request_routing_rules_redirect_configuration_name", null) : null
      url_path_map_name           = coalesce(request_routing_rule.value.request_routing_rules_rule_type, "Basic") == "PathBasedRouting" ? request_routing_rule.value.request_routing_rules_url_path_map_name : null
      rewrite_rule_set_name       = lookup(request_routing_rule.value, "request_routing_rules_rewrite_rule_set_name", null)
    }
  }

  dynamic "global" {
    for_each = each.value.application_gateway_global != null ? [each.value.application_gateway_global] : []
    content {
      request_buffering_enabled  = global.value.global_request_buffering_enabled
      response_buffering_enabled = global.value.global_response_buffering_enabled
    }
  }

  dynamic "url_path_map" {
    for_each = coalesce(lookup(each.value, "application_gateway_url_path_maps"), [])
    content {
      name                                = url_path_map.value.url_path_maps_name
      default_backend_http_settings_name  = url_path_map.value.url_path_maps_default_redirect_configuration_name == null ? lookup(url_path_map.value, "url_path_maps_default_backend_http_settings_name", null) : null
      default_backend_address_pool_name   = url_path_map.value.url_path_maps_default_redirect_configuration_name == null ? lookup(url_path_map.value, "url_path_maps_default_backend_address_pool_name", null) : null
      default_redirect_configuration_name = (url_path_map.value.url_path_maps_default_backend_http_settings_name == null && url_path_map.value.url_path_maps_default_backend_address_pool_name == null) ? lookup(url_path_map.value, "url_path_maps_default_redirect_configuration_name", null) : null
      default_rewrite_rule_set_name       = lookup(url_path_map.value, "url_path_maps_default_rewrite_rule_set_name", null)
      dynamic "path_rule" {
        for_each = coalesce(lookup(url_path_map.value, "url_path_maps_path_rules"), [])
        content {
          name                        = path_rule.value.path_rules_name
          paths                       = path_rule.value.path_rules_paths
          backend_address_pool_name   = path_rule.value.path_rules_redirect_configuration_name == null ? lookup(path_rule.value, "path_rules_backend_address_pool_name", null) : null
          backend_http_settings_name  = path_rule.value.path_rules_redirect_configuration_name == null ? lookup(path_rule.value, "path_rules_backend_http_settings_name", null) : null
          redirect_configuration_name = (path_rule.value.path_rules_backend_http_settings_name == null && path_rule.value.path_rules_backend_address_pool_name == null) ? lookup(path_rule.value, "path_rules_redirect_configuration_name", null) : null
          rewrite_rule_set_name       = lookup(path_rule.value, "path_rules_rewrite_rule_set_name", null)
          firewall_policy_id          = each.value.application_gateway_is_waf_policy_required == false ? null : data.azurerm_web_application_firewall_policy.waf_policy_id[each.key].id
        }
      }
    }
  }

  dynamic "private_link_configuration" {
    for_each = each.value.application_gateway_private_link_configuration != null ? [each.value.application_gateway_private_link_configuration] : []
    content {
      name = private_link_configuration.value.private_link_configuration_name
      dynamic "ip_configuration" {
        for_each = each.value.private_link_configuration_ip_configuration != null ? [each.value.private_link_configuration_ip_configuration] : []
        content {
          name                          = ip_configuration.value.ip_configuration_name
          subnet_id                     = each.value.application_gateway_is_private_frontend_ip_required == false ? null : data.azurerm_subnet.subnet_id[each.key].id
          private_ip_address_allocation = ip_configuration.value.ip_configuration_private_ip_address_allocation
          primary                       = ip_configuration.value.ip_configuration_primary
          private_ip_address            = ip_configuration.value.ip_configuration_private_ip_address
        }
      }
    }
  }

  dynamic "redirect_configuration" {
    for_each = coalesce(lookup(each.value, "application_gateway_redirect_configurations"), [])
    content {
      name                 = redirect_configuration.value.redirect_configurations_name
      redirect_type        = coalesce(redirect_configuration.value.redirect_configurations_redirect_type, "Permanent")
      target_listener_name = redirect_configuration.value.redirect_configurations_target_url == null ? lookup(redirect_configuration.value, "redirect_configurations_target_listener_name", null) : null
      target_url           = redirect_configuration.value.redirect_configurations_target_listener_name == null ? lookup(redirect_configuration.value, "redirect_configurations_target_url", null) : null
      include_path         = coalesce(redirect_configuration.value.redirect_configurations_include_path, false)
      include_query_string = coalesce(redirect_configuration.value.redirect_configurations_include_query_string, false)
    }
  }

  dynamic "waf_configuration" {
    for_each = each.value.application_gateway_waf_configuration == null ? [] : [each.value.application_gateway_waf_configuration]
    content {
      firewall_mode            = waf_configuration.value.waf_configuration_firewall_mode
      rule_set_type            = waf_configuration.value.waf_configuration_rule_set_type
      rule_set_version         = waf_configuration.value.waf_configuration_rule_set_version
      enabled                  = waf_configuration.value.waf_configuration_enabled
      file_upload_limit_mb     = waf_configuration.value.waf_configuration_file_upload_limit_mb
      request_body_check       = waf_configuration.value.waf_configuration_request_body_check
      max_request_body_size_kb = waf_configuration.value.waf_configuration_max_request_body_size_kb

      dynamic "disabled_rule_group" {
        for_each = waf_configuration.value.waf_configuration_disabled_rule_group != null ? [waf_configuration.value.waf_configuration_disabled_rule_group] : []
        content {
          rule_group_name = disabled_rule_group.value.disabled_rule_group_rule_group_name
          rules           = disabled_rule_group.value.disabled_rule_group_rules
        }
      }
      dynamic "exclusion" {
        for_each = waf_configuration.value.waf_configuration_exclusion != null ? [waf_configuration.value.waf_configuration_exclusion] : []
        content {
          match_variable          = exclusion.value.exclusion_match_variable
          selector_match_operator = exclusion.value.exclusion_selector_match_operator
          selector                = exclusion.value.exclusion_selector
        }
      }
    }
  }

  dynamic "probe" {
    for_each = each.value.application_gateway_probe != null ? toset(each.value.application_gateway_probe) : []
    content {
      name                                      = probe.value.probe_name
      path                                      = probe.value.probe_path
      port                                      = probe.value.probe_port
      minimum_servers                           = probe.value.probe_minimum_servers
      protocol                                  = coalesce(probe.value.probe_protocol, "Https")
      interval                                  = coalesce(probe.value.probe_interval, 30)
      timeout                                   = coalesce(probe.value.probe_timeout, 30)
      unhealthy_threshold                       = coalesce(probe.value.probe_unhealthy_threshold, 3)
      host                                      = coalesce(probe.value.probe_pick_host_name_from_backend_http_settings, false) == false ? probe.value.probe_host : null
      pick_host_name_from_backend_http_settings = coalesce(probe.value.probe_pick_host_name_from_backend_http_settings, false)
      dynamic "match" {
        for_each = coalesce(lookup(probe.value, "probe_match"), [])
        content {
          body        = match.value.match_body
          status_code = match.value.match_status_code
        }
      }
    }
  }

  dynamic "ssl_profile" {
    for_each = each.value.application_gateway_ssl_profile != null ? each.value.application_gateway_ssl_profile : []
    content {
      name                                 = ssl_profile.value.ssl_profile_name
      trusted_client_certificate_names     = ssl_profile.value.ssl_profile_trusted_client_certificate_names
      verify_client_cert_issuer_dn         = ssl_profile.value.ssl_profile_verify_client_cert_issuer_dn
      verify_client_certificate_revocation = ssl_profile.value.ssl_profile_verify_client_certificate_revocation
    }
  }

  dynamic "ssl_policy" {
    for_each = each.value.application_gateway_ssl_policy != null ? each.value.application_gateway_ssl_policy : []
    content {
      policy_name          = ssl_policy.value.ssl_policy_name
      policy_type          = ssl_policy.value.ssl_policy_policy_type
      cipher_suites        = ssl_policy.value.ssl_policy_cipher_suites
      min_protocol_version = ssl_policy.value.ssl_policy_min_protocol_version
      disabled_protocols   = ssl_policy.value.ssl_policy_disabled_protocols
    }
  }

  dynamic "redirect_configuration" {
    for_each = coalesce(lookup(each.value, "application_gateway_redirect_configurations"), [])
    content {
      name                 = redirect_configuration.value.redirect_configurations_name
      redirect_type        = coalesce(redirect_configuration.value.redirect_configurations_redirect_type, "Permanent")
      target_listener_name = redirect_configuration.value.redirect_configurations_target_url == null ? lookup(redirect_configuration.value, "redirect_configurations_target_listener_name", null) : null
      target_url           = redirect_configuration.value.redirect_configurations_target_listener_name == null ? lookup(redirect_configuration.value, "redirect_configurations_target_url", null) : null
      include_path         = coalesce(redirect_configuration.value.redirect_configurations_include_path, false)
      include_query_string = coalesce(redirect_configuration.value.redirect_configurations_include_query_string, false)
    }
  }
  dynamic "rewrite_rule_set" {
    for_each = each.value.application_gateway_rewrite_rule_set != null ? each.value.application_gateway_rewrite_rule_set : []
    content {
      name = rewrite_rule_set.value.rewrite_rule_set_name
      dynamic "rewrite_rule" {
        for_each = rewrite_rule_set.value.rewrite_rule_set_rewrite_rule != null ? rewrite_rule_set.value.rewrite_rule_set_rewrite_rule : []
        content {
          name          = rewrite_rule.value.rewrite_rule_name
          rule_sequence = rewrite_rule.value.rewrite_rule_rule_sequence
          dynamic "condition" {
            for_each = rewrite_rule.value.rule_sequence_condition != null ? rewrite_rule.value.rule_sequence_condition : []
            content {
              variable    = condition.value.condition_variable
              pattern     = condition.value.condition_pattern
              ignore_case = condition.value.condition_ignore_case
              negate      = condition.value.condition_negate
            }
          }
          dynamic "response_header_configuration" {
            for_each = rewrite_rule.value.rewrite_rule_set_response_header_configuration != null ? rewrite_rule.value.rewrite_rule_set_response_header_configuration : []
            content {
              header_name  = response_header_configuration.value.response_header_configuration_header_name
              header_value = response_header_configuration.value.response_header_configuration_header_value
            }
          }
          dynamic "request_header_configuration" {
            for_each = rewrite_rule.value.rewrite_rule_set_request_header_configuration != null ? rewrite_rule.value.rewrite_rule_set_request_header_configuration : []
            content {
              header_name  = request_header_configuration.value.request_header_configuration_header_name
              header_value = request_header_configuration.value.header.request_header_configuration_header_value
            }
          }
          dynamic "url" {
            for_each = rewrite_rule.value.rewrite_rule_set_url != null ? rewrite_rule.value.rewrite_rule_set_url : []
            content {
              path         = url.value.url_path
              query_string = url.value.url_query_string
              reroute      = url.value.url_reroute
              components   = url.value.url_components
            }
          }
        }
      }
    }
  }

  tags = merge(each.value.application_gateway_application_gateway_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}
