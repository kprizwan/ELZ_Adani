#Variables for public IP
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
