#PRIVATE DNS ZONE
resource "azurerm_private_dns_zone" "private_dns_zone" {
  for_each            = var.private_dns_zone_variables
  name                = each.value.private_dns_zone_name
  resource_group_name = each.value.private_dns_zone_resource_group_name
  dynamic "soa_record" {
    for_each = each.value.private_dns_zone_soa_record == null ? [] : each.value.private_dns_zone_soa_record
    content {
      email        = soa_record.value.soa_record_email
      expire_time  = soa_record.value.soa_record_expire_time
      minimum_ttl  = soa_record.value.soa_record_minimum_ttl
      refresh_time = soa_record.value.soa_record_refresh_time
      retry_time   = soa_record.value.soa_record_retry_time
      ttl          = soa_record.value.soa_record_ttl
      tags         = soa_record.value.soa_record_tags
    }
  }
  tags = merge(each.value.private_dns_zone_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}