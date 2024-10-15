#NAT GATEWAY PUBLIC IP ASSOCIATION VARIABLES
variable "nat_gateway_public_ip_association_variables" {
  description = "Map of object of nat gateway public ip associations"
  type = map(object({
    public_ip_name                  = string #(Required) Specifies the name of the Public IP.
    public_ip_resource_group_name   = string #(Required) The name of the Resource Group where this Public IP should exist.
    nat_gateway_name                = string #(Required) Specifies the name of the NAT Gateway. Changing this forces a new resource to be created.
    nat_gateway_resource_group_name = string #(Required) Specifies the name of the Resource Group in which the NAT Gateway should exist.
  }))
  default = {}
}
