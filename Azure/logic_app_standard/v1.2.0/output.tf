#logic_app_standard_outputs
output "logic_app_standard_outputs" {
  value = { for k, v in azurerm_logic_app_standard.logic_app_standard : k => {
    id                             = v.id
    custom_domain_verification_id  = v.custom_domain_verification_id
    default_hostname               = v.default_hostname
    outbound_ip_addresses          = v.outbound_ip_addresses
    possible_outbound_ip_addresses = v.possible_outbound_ip_addresses
    identity                       = v.identity
    site_credential                = v.site_credential
    kind                           = v.kind
    }
  }
  sensitive   = true
  description = "logic app standard outputs values"
}