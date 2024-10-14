#SUBNET OUTPUT VALUES
output "subnet_output" {
  value = { for k, v in azurerm_subnet.subnet : k => {
    id                   = v.id
    name                 = v.name
    resource_group_name  = v.resource_group_name
    virtual_network_name = v.virtual_network_name
    address_prefixes     = v.address_prefixes
    }
  }
  description = "subnet output values"
}
