#PUBLIC IP is currently used in Application Gateway, Linux machines and Windows machines.
#Any changes to the module will result in other modules to stop working.
#Please change the main.tf, variables.tf and terraform.tfvars in example folder of any dependent modules mentioned above once any changes in made on this module.

resource "azurerm_public_ip" "public_ip" {
  for_each                = var.public_ip_variable
  name                    = each.value.name
  ip_version              = each.value.ip_version == null ? "IPv4" : each.value.ip_version
  resource_group_name     = each.value.resource_group_name
  location                = each.value.location
  allocation_method       = each.value.allocation_method
  sku                     = each.value.sku
  sku_tier                = each.value.sku_tier == null ? "Regional" : each.value.sku_tier
  domain_name_label       = each.value.public_ip_dns
  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes
  availability_zone       = each.value.availability_zone
  reverse_fqdn            = each.value.reverse_fqdn
  ip_tags                 = each.value.ip_tags
  tags                    = merge(each.value.public_ip_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}


