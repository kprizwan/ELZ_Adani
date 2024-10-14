#PRIVATE DNS ZONE OUTPUT
output "private_dns_zone_output" {
  description = "Private DNS Zone output values"
  value = { for k, v in azurerm_private_dns_zone.private_dns_zone : k => {
    id                                                    = v.id
    max_number_of_record_sets                             = v.max_number_of_record_sets
    max_number_of_virtual_network_links                   = v.max_number_of_virtual_network_links
    max_number_of_virtual_network_links_with_registration = v.max_number_of_virtual_network_links_with_registration
    number_of_record_sets                                 = v.number_of_record_sets
    tags                                                  = v.tags
    }
  }
}