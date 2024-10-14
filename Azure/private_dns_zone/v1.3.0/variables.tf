#PRIVATE DNS ZONE VARIABLES
variable "private_dns_zone_variables" {
  type = map(object({
    private_dns_zone_name                = string #(Required) The name of the Private DNS Zone. Must be a valid domain name.
    private_dns_zone_resource_group_name = string #(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.
    private_dns_zone_soa_record = list(object({   #(Optional) An soa_record block as defined below. Changing this forces a new resource to be created.
      soa_record_email         = string           #(Required) The email contact for the SOA record.
      soa_record_expire_time   = number           #(Optional) The expire time for the SOA record. Defaults to 2419200.
      soa_record_minimum_ttl   = number           #(Optional) The minimum Time To Live for the SOA record. By convention, it is used to determine the negative caching duration. Defaults to 10.
      soa_record_refresh_time  = number           #(Optional) The refresh time for the SOA record. Defaults to 3600.
      soa_record_retry_time    = number           #(Optional) The retry time for the SOA record. Defaults to 300.
      soa_record_serial_number = number           #(optional) The serial number for the SOA record.
      soa_record_ttl           = number           #(Optional) The Time To Live of the SOA Record in seconds. Defaults to 3600.
      soa_record_tags          = map(string)      #(Optional) A mapping of tags to assign to the Record Set.
    }))
    private_dns_zone_tags = map(string)
  }))
  description = "Map of private dns zone"
  default     = {}
}