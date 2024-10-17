locals {
  additional_location_subnet_name    = flatten([for k, v in var.api_management_variables : [for i, j in v.api_management_additional_location : [{ main_key = k, subnet_name = j.additional_location_virtual_network_configuration.virtual_network_configuration_subnet_name, vnet_name = j.additional_location_virtual_network_configuration.virtual_network_configuration_virtual_network_name, rg_name = j.additional_location_virtual_network_configuration.virtual_network_configuration_subnet_resource_group_name }] if j.additional_location_virtual_network_configuration != null] if lookup(v, "api_management_additional_location", null) != null])
  additional_location_public_ip_name = flatten([for k, v in var.api_management_variables : [for i, j in v.api_management_additional_location : [{ main_key = k, public_ip_name = j.additional_location_public_ip_address_name, rg_name = j.additional_location_public_ip_address_resource_group_name }] if j.additional_location_public_ip_address_name != null] if lookup(v, "api_management_additional_location", null) != null])
  identities                         = { for k, v in var.api_management_variables : k => lookup(v, "api_management_identity", null) != null ? v.api_management_identity.identity_type != "SystemAssigned" ? v.api_management_identity.identity_user_assigned_identities : null : null }
  identities_list = flatten([
    for k, v in local.identities : [for i in v : [
      {
        main_key                     = k
        identity_name                = i.identity_name
        identity_resource_group_name = i.identity_resource_group_name
    }]] if v != null
  ])

  hostname_configuration_vals       = { for k, v in var.api_management_variables : k => v.api_management_hostname_configuration if lookup(v, "api_management_hostname_configuration", null) != null }
  management_key_vault_secret       = flatten([for k, v in local.hostname_configuration_vals : [for i, j in v.hostname_configuration_management : { main_key = k, key_vault_secret_name = j.management_key_vault_secret_name, secondary_key = j.management_host_name } if lookup(j, "management_key_vault_secret_name", null) != null] if(lookup(v, "hostname_configuration_management", null) != null && lookup(v, "hostname_configuration_key_vault_name", null) != null)])
  portal_key_vault_secret           = flatten([for k, v in local.hostname_configuration_vals : [for i, j in v.hostname_configuration_portal : { main_key = k, key_vault_secret_name = j.portal_key_vault_secret_name, secondary_key = j.portal_host_name } if lookup(j, "portal_key_vault_secret_name", null) != null] if(lookup(v, "hostname_configuration_portal", null) != null && lookup(v, "hostname_configuration_key_vault_name", null) != null)])
  developer_portal_key_vault_secret = flatten([for k, v in local.hostname_configuration_vals : [for i, j in v.hostname_configuration_developer_portal : { main_key = k, key_vault_secret_name = j.developer_portal_key_vault_secret_name, secondary_key = j.developer_portal_host_name } if lookup(j, "developer_portal_key_vault_secret_name", null) != null] if(lookup(v, "hostname_configuration_developer_portal", null) != null && lookup(v, "hostname_configuration_key_vault_name", null) != null)])
  proxy_key_vault_secret            = flatten([for k, v in local.hostname_configuration_vals : [for i, j in v.hostname_configuration_proxy : { main_key = k, key_vault_secret_name = j.proxy_key_vault_secret_name, secondary_key = j.proxy_host_name } if lookup(j, "proxy_key_vault_secret_name", null) != null] if(lookup(v, "hostname_configuration_proxy", null) != null && lookup(v, "hostname_configuration_key_vault_name", null) != null)])
  scm_key_vault_secret              = flatten([for k, v in local.hostname_configuration_vals : [for i, j in v.hostname_configuration_scm : { main_key = k, key_vault_secret_name = j.scm_key_vault_secret_name, secondary_key = j.scm_host_name } if lookup(j, "scm_key_vault_secret_name", null) != null] if(lookup(v, "hostname_configuration_scm", null) != null && lookup(v, "hostname_configuration_key_vault_name", null) != null)])
  certificate_encoded_certificate = flatten([for k, v in var.api_management_variables : [
    for i, j in v.api_management_certificate :
    merge({ main_key = k, api_mangement_certificate_key = i, key_vault_certificate_name = j.certificate_encoded_certificate_name }, j)
  ] if v.api_management_certificate != null])

  certificate_password = flatten([for k, v in var.api_management_variables : [
    for i, j in v.api_management_certificate :
    merge({ main_key = k, api_mangement_certificate_key = i, key_vault_secret_name = j.certificate_certificate_password_secret_name }, j)
    if j.certificate_certificate_password_secret_name != null]
  if v.api_management_certificate != null])
}

#Key Vault for Certificate secret
data "azurerm_key_vault" "host_configuration_key_vault_id" {
  provider            = azurerm.key_vault_sub
  for_each            = { for k, v in local.hostname_configuration_vals : k => v if lookup(v, "hostname_configuration_key_vault_name", null) != null }
  name                = each.value.hostname_configuration_key_vault_name
  resource_group_name = each.value.hostname_configuration_key_vault_resource_group_name
}

#Key Vault Secret for management certificate secret
data "azurerm_key_vault_secret" "management_key_vault_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = { for k, v in local.management_key_vault_secret : "${v.main_key}#${v.secondary_key}" => v }
  name         = each.value.key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.host_configuration_key_vault_id[each.value.main_key].id
}

#Key Vault Secret for portal certificate secret
data "azurerm_key_vault_secret" "portal_key_vault_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = { for k, v in local.portal_key_vault_secret : "${v.main_key}#${v.secondary_key}" => v }
  name         = each.value.key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.host_configuration_key_vault_id[each.value.main_key].id
}

#Key Vault Secret for developer_portal certificate secret
data "azurerm_key_vault_secret" "developer_portal_key_vault_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = { for k, v in local.developer_portal_key_vault_secret : "${v.main_key}#${v.secondary_key}" => v }
  name         = each.value.key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.host_configuration_key_vault_id[each.value.main_key].id
}

#Key Vault Secret for proxy certificate secret
data "azurerm_key_vault_secret" "proxy_key_vault_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = { for k, v in local.proxy_key_vault_secret : "${v.main_key}#${v.secondary_key}" => v }
  name         = each.value.key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.host_configuration_key_vault_id[each.value.main_key].id
}

#Key Vault Secret for scm certificate secret
data "azurerm_key_vault_secret" "scm_key_vault_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = { for k, v in local.scm_key_vault_secret : "${v.main_key}#${v.secondary_key}" => v }
  name         = each.value.key_vault_secret_name
  key_vault_id = data.azurerm_key_vault.host_configuration_key_vault_id[each.value.main_key].id
}

#User Assigned Identity with Key Vault access
data "azurerm_user_assigned_identity" "host_configuration_user_identity" {
  provider            = azurerm.api_management_sub
  for_each            = { for k, v in local.hostname_configuration_vals : k => v if lookup(v, "hostname_configuration_ssl_keyvault_identity_client_type", null) == "UserAssigned" }
  name                = each.value.hostname_configuration_ssl_keyvault_identity_client_name
  resource_group_name = each.value.hostname_configuration_ssl_keyvault_identity_client_resource_group
}

#Public IP of additional location
data "azurerm_public_ip" "additional_location_public_ip" {
  provider            = azurerm.api_management_sub
  for_each            = { for k, v in local.additional_location_public_ip_name : "${v.main_key}#${v.public_ip_name}" => v }
  name                = each.value.public_ip_name
  resource_group_name = each.value.rg_name
}

#Subnet of additional locations
data "azurerm_subnet" "additional_location_subnet" {
  provider             = azurerm.api_management_sub
  for_each             = { for k, v in local.additional_location_subnet_name : "${v.main_key}#${v.subnet_name}" => v }
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}

#User Assigned identity
data "azurerm_user_assigned_identity" "api_management_user_identity" {
  provider            = azurerm.api_management_sub
  for_each            = { for v in local.identities_list : "${v.main_key},${v.identity_name}" => v }
  name                = each.value.identity_name
  resource_group_name = each.value.identity_resource_group_name
}

#Key Vault storing Certificate
data "azurerm_key_vault" "certificate_key_vault_id" {
  provider            = azurerm.key_vault_sub
  for_each            = { for k, v in var.api_management_variables : k => v if lookup(v, "api_management_certificate_key_vault_name", null) != null }
  name                = each.value.api_management_certificate_key_vault_name
  resource_group_name = each.value.api_management_certificate_key_vault_resource_group_name
}

#Key vault certificate for certificate encoded certificate
data "azurerm_key_vault_certificate" "encoded_certificate" {
  provider     = azurerm.key_vault_sub
  for_each     = { for x in local.certificate_encoded_certificate : "${x.main_key},${x.api_mangement_certificate_key}" => x }
  name         = each.value.certificate_encoded_certificate_name
  key_vault_id = data.azurerm_key_vault.certificate_key_vault_id[each.value.main_key].id
}

#Key Vault Secret for Certificate Password  # This is commented because there is a glitch in terraform where it is expecting "certificate_password" to be bool instead of a string in dynamic certificate block.
/* data "azurerm_key_vault_secret" "certificate_password_secret" {
  provider     = azurerm.key_vault_sub
  for_each     = { for x in local.certificate_password : "${x.main_key},${x.api_mangement_certificate_key}" => x }
  name         = each.value.certificate_certificate_password_secret_name
  key_vault_id = data.azurerm_key_vault.certificate_key_vault_id[each.value.main_key].id
} */

#Subnet of virtual network configuration
data "azurerm_subnet" "virtual_network_configuration_subnet" {
  provider             = azurerm.api_management_sub
  for_each             = { for k, v in var.api_management_variables : k => v if(lookup(v, "api_management_virtual_network_type", "None") != "None" || lookup(v, "api_management_virtual_network_type", null) != null) && (lookup(v, "api_management_virtual_network_configuration", null) != null) }
  name                 = each.value.api_management_virtual_network_configuration.virtual_network_configuration_subnet_name
  virtual_network_name = each.value.api_management_virtual_network_configuration.virtual_network_configuration_virtual_network_name
  resource_group_name  = each.value.api_management_virtual_network_configuration.virtual_network_configuration_subnet_resource_group_name
}

#Public IP of virtual network configuration
data "azurerm_public_ip" "virtual_network_configuration_public_ip" {
  provider            = azurerm.api_management_sub
  for_each            = { for k, v in var.api_management_variables : k => v if lookup(v, "api_management_public_ip_address_name", null) != null }
  name                = each.value.api_management_public_ip_address_name
  resource_group_name = each.value.api_management_public_ip_address_resource_group_name
}

#API Management Resource
resource "azurerm_api_management" "api_management" {
  provider                      = azurerm.api_management_sub
  for_each                      = var.api_management_variables
  name                          = each.value.api_management_name
  location                      = each.value.api_management_location
  resource_group_name           = each.value.api_management_resource_group_name
  publisher_name                = each.value.api_management_publisher_name
  publisher_email               = each.value.api_management_publisher_email
  sku_name                      = each.value.api_management_sku_name
  client_certificate_enabled    = each.value.api_management_client_certificate_enabled
  gateway_disabled              = each.value.api_management_gateway_disabled
  min_api_version               = each.value.api_management_min_api_version
  zones                         = each.value.api_management_zones
  notification_sender_email     = each.value.api_management_notification_sender_email
  public_ip_address_id          = each.value.api_management_public_ip_address_name != null ? data.azurerm_public_ip.virtual_network_configuration_public_ip[each.key].id : null
  public_network_access_enabled = each.value.api_management_public_network_access_enabled
  virtual_network_type          = each.value.api_management_virtual_network_type

  dynamic "additional_location" {
    for_each = each.value.api_management_additional_location != null ? each.value.api_management_additional_location : []
    content {
      location             = additional_location.value.additional_location_location
      capacity             = additional_location.value.additional_location_capacity
      zones                = additional_location.value.additional_location_zones
      public_ip_address_id = additional_location.value.additional_location_public_ip_address_name != null ? data.azurerm_public_ip.additional_location_public_ip["${each.key}#${virtual_network_configuration.value.additional_location_public_ip_address_name}"].id : null
      gateway_disabled     = additional_location.additional_location_gateway_disabled
      dynamic "virtual_network_configuration" {
        for_each = additional_location.value.additional_location_virtual_network_configuration != null ? [additional_location.value.additional_location_virtual_network_configuration] : []
        content {
          subnet_id = data.azurerm_subnet.additional_location_subnet["${each.key}#${virtual_network_configuration.value.virtual_network_configuration_subnet_name}"].id
        }
      }
    }
  }

  dynamic "certificate" {
    for_each = each.value.api_management_certificate != null ? each.value.api_management_certificate : {}
    content {
      encoded_certificate = data.azurerm_key_vault_certificate.encoded_certificate["${each.key},${certificate.key}"].certificate_data_base64
      store_name          = certificate.value.certificate_store_name
      # certificate_password = data.azurerm_key_vault_secret.certificate_password_secret["${each.key},${certificate.key}"].value
      # This is commented because this is optional and there is a glitch in terraform v3.75.0 where the value expected for certificate_password is bool instead of a string.
    }
  }

  dynamic "delegation" {
    for_each = each.value.api_management_delegation != null ? each.value.api_management_delegation : {}
    content {
      subscriptions_enabled     = delegation.value.delegation_subscriptions_enabled
      user_registration_enabled = delegation.value.delegation_user_registration_enabled
      url                       = delegation.value.delegation_url
      validation_key            = delegation.value.delegation_validation_key
    }
  }

  dynamic "identity" { #Required, if boot diagnostics is required
    for_each = each.value.api_management_identity != null ? [1] : []
    content {
      type         = each.value.api_management_identity.identity_type
      identity_ids = each.value.api_management_identity.identity_user_assigned_identities == null ? [] : [for k, v in each.value.api_management_identity.identity_user_assigned_identities : data.azurerm_user_assigned_identity.api_management_user_identity["${each.key},${v.identity_name}"].id]
    }
  }

  dynamic "hostname_configuration" {
    for_each = each.value.api_management_hostname_configuration != null ? [each.value.api_management_hostname_configuration] : []
    content {
      dynamic "management" {
        for_each = hostname_configuration.value.hostname_configuration_management != null ? hostname_configuration.value.hostname_configuration_management : []
        content {
          host_name                       = management.value.management_host_name
          key_vault_id                    = management.value.management_key_vault_secret_name != null ? data.azurerm_key_vault_secret.management_key_vault_secret["${each.key}#${management.value.management_host_name}"].id : null
          certificate                     = null
          certificate_password            = null
          negotiate_client_certificate    = management.value.management_negotiate_client_certificate
          ssl_keyvault_identity_client_id = hostname_configuration.value.hostname_configuration_ssl_keyvault_identity_client_type == "UserAssigned" ? data.azurerm_user_assigned_identity.host_configuration_user_identity[each.key].id : hostname_configuration.value.hostname_configuration_ssl_keyvault_identity_client_type == "SystemAssigned" && hostname_configuration.value.hostname_configuration_ssl_keyvault_identity_client_id != null ? hostname_configuration.value.hostname_configuration_ssl_keyvault_identity_client_id : null
        }
      }
      dynamic "portal" {
        for_each = hostname_configuration.value.hostname_configuration_portal != null ? hostname_configuration.value.hostname_configuration_portal : []
        content {
          host_name                       = portal.value.portal_host_name
          key_vault_id                    = portal.value.portal_key_vault_secret_name != null ? data.azurerm_key_vault_secret.portal_key_vault_secret["${each.key}#${portal.value.portal_host_name}"].id : null
          certificate                     = null
          certificate_password            = null
          negotiate_client_certificate    = portal.value.portal_negotiate_client_certificate
          ssl_keyvault_identity_client_id = hostname_configuration.value.hostname_configuration_ssl_keyvault_identity_client_type == "UserAssigned" ? data.azurerm_user_assigned_identity.host_configuration_user_identity[each.key].id : hostname_configuration.value.hostname_configuration_ssl_keyvault_identity_client_type == "SystemAssigned" && hostname_configuration.value.hostname_configuration_ssl_keyvault_identity_client_id != null ? hostname_configuration.value.hostname_configuration_ssl_keyvault_identity_client_id : null
        }
      }
      dynamic "developer_portal" {
        for_each = hostname_configuration.value.hostname_configuration_developer_portal != null ? hostname_configuration.value.hostname_configuration_developer_portal : []
        content {
          host_name                       = developer_portal.value.developer_portal_host_name
          key_vault_id                    = developer_portal.value.developer_portal_key_vault_secret_name != null ? data.azurerm_key_vault_secret.developer_portal_key_vault_secret["${each.key}#${developer_portal.value.developer_portal_host_name}"].id : null
          certificate                     = null
          certificate_password            = null
          negotiate_client_certificate    = developer_portal.value.developer_portal_negotiate_client_certificate
          ssl_keyvault_identity_client_id = hostname_configuration.value.hostname_configuration_ssl_keyvault_identity_client_type == "UserAssigned" ? data.azurerm_user_assigned_identity.host_configuration_user_identity[each.key].id : hostname_configuration.value.hostname_configuration_ssl_keyvault_identity_client_type == "SystemAssigned" && hostname_configuration.value.hostname_configuration_ssl_keyvault_identity_client_id != null ? hostname_configuration.value.hostname_configuration_ssl_keyvault_identity_client_id : null
        }
      }
      dynamic "proxy" {
        for_each = hostname_configuration.value.hostname_configuration_proxy != null ? hostname_configuration.value.hostname_configuration_proxy : []
        content {
          default_ssl_binding             = proxy.value.proxy_default_ssl_binding
          host_name                       = proxy.value.proxy_host_name
          key_vault_id                    = proxy.value.proxy_key_vault_secret_name != null ? data.azurerm_key_vault_secret.proxy_key_vault_secret["${each.key}#${proxy.value.proxy_host_name}"].id : null
          certificate                     = null
          certificate_password            = null
          negotiate_client_certificate    = proxy.value.proxy_negotiate_client_certificate
          ssl_keyvault_identity_client_id = hostname_configuration.value.hostname_configuration_ssl_keyvault_identity_client_type == "UserAssigned" ? data.azurerm_user_assigned_identity.host_configuration_user_identity[each.key].id : hostname_configuration.value.hostname_configuration_ssl_keyvault_identity_client_type == "SystemAssigned" && hostname_configuration.value.hostname_configuration_ssl_keyvault_identity_client_id != null ? hostname_configuration.value.hostname_configuration_ssl_keyvault_identity_client_id : null
        }
      }
      dynamic "scm" {
        for_each = hostname_configuration.value.hostname_configuration_scm != null ? hostname_configuration.value.hostname_configuration_scm : []
        content {
          host_name                       = scm.value.scm_host_name
          key_vault_id                    = scm.value.scm_key_vault_secret_name != null ? data.azurerm_key_vault_secret.scm_key_vault_secret["${each.key}#${scm.value.scm_host_name}"].id : null
          certificate                     = null
          certificate_password            = null
          negotiate_client_certificate    = scm.value.scm_negotiate_client_certificate
          ssl_keyvault_identity_client_id = hostname_configuration.value.hostname_configuration_ssl_keyvault_identity_client_type == "UserAssigned" ? data.azurerm_user_assigned_identity.host_configuration_user_identity[each.key].id : hostname_configuration.value.hostname_configuration_ssl_keyvault_identity_client_type == "SystemAssigned" && hostname_configuration.value.hostname_configuration_ssl_keyvault_identity_client_id != null ? hostname_configuration.value.hostname_configuration_ssl_keyvault_identity_client_id : null
        }
      }
    }
  }

  dynamic "policy" {
    for_each = each.value.api_management_policy != null ? [each.value.api_management_policy] : []
    content {
      xml_content = policy.value.policy_xml_content
      xml_link    = policy.value.policy_xml_link
    }
  }
  dynamic "protocols" {
    for_each = each.value.api_management_protocols != null ? [each.value.api_management_protocols] : []
    content {
      enable_http2 = protocols.value.protocols_enable_http2
    }
  }
  dynamic "security" {
    for_each = each.value.api_management_security != null ? [each.value.api_management_security] : []
    content {
      enable_backend_ssl30                                = security.value.security_enable_backend_ssl30
      enable_backend_tls10                                = security.value.security_enable_backend_tls10
      enable_backend_tls11                                = security.value.security_enable_backend_tls11
      enable_frontend_ssl30                               = security.value.security_enable_frontend_ssl30
      enable_frontend_tls10                               = security.value.security_enable_frontend_tls10
      enable_frontend_tls11                               = security.value.security_enable_frontend_tls11
      tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = security.value.security_tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled
      tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = security.value.security_tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled
      tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = security.value.security_tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled
      tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = security.value.security_tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled
      tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = security.value.security_tls_rsa_with_aes128_cbc_sha256_ciphers_enabled
      tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = security.value.security_tls_rsa_with_aes128_cbc_sha_ciphers_enabled
      tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = security.value.security_tls_rsa_with_aes128_gcm_sha256_ciphers_enabled
      tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = security.value.security_tls_rsa_with_aes256_cbc_sha256_ciphers_enabled
      tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = security.value.security_tls_rsa_with_aes256_cbc_sha_ciphers_enabled
      triple_des_ciphers_enabled                          = security.value.security_triple_des_ciphers_enabled
    }
  }
  dynamic "sign_in" {
    for_each = each.value.api_management_sign_in != null ? [each.value.api_management_sign_in] : []
    content {
      enabled = sign_in.value.sign_in_enabled
    }
  }
  dynamic "sign_up" {
    for_each = each.value.api_management_sign_up != null ? [each.value.api_management_sign_up] : []
    content {
      enabled = sign_up.value.sign_up_enabled
      terms_of_service {
        consent_required = sign_up.value.sign_up_terms_of_service.terms_of_service_consent_required
        enabled          = sign_up.value.sign_up_terms_of_service.terms_of_service_enabled
        text             = sign_up.value.sign_up_terms_of_service.terms_of_service_text
      }
    }
  }
  dynamic "tenant_access" {
    for_each = each.value.api_management_tenant_access != null ? [each.value.api_management_tenant_access] : []
    content {
      enabled = tenant_access.value.tenant_access_enabled
    }
  }

  dynamic "virtual_network_configuration" {
    for_each = (each.value.api_management_virtual_network_configuration != null && each.value.api_management_virtual_network_type != "None") ? [each.value.api_management_virtual_network_configuration] : []
    content {
      subnet_id = data.azurerm_subnet.virtual_network_configuration_subnet[each.key].id
    }
  }

  tags = merge(each.value.api_management_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}