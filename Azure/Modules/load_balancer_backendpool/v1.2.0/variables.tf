# Load balancer backendpool variables
variable "load_balancer_backendpool_variables" {
  type = map(object({
    load_balancer_backendpool_name                      = string #(Required) Specifies the name of the Backend Address Pool.
    load_balancer_name                                  = string #(Required) Load balancer name
    load_balancer_resource_group_name                   = string # Name of the load balancer resource group
    load_balancer_backendpool_tunnel_interface_required = bool   #(Optional) One or more tunnel_interface blocks as defined below.
    load_balancer_backendpool_tunnel_interface_variables = map(object({
      load_balancer_backendpool_tunnel_interface_identifier = string #(Required) The unique identifier of this Gateway Lodbalancer Tunnel Interface.
      load_balancer_backendpool_tunnel_interface_type       = string #(Required) The traffic type of this Gateway Lodbalancer Tunnel Interface. Possible values are Internal and External.
      load_balancer_backendpool_tunnel_interface_protocol   = string #(Required) The protocol used for this Gateway Lodbalancer Tunnel Interface. Possible values are Native and VXLAN.
      load_balancer_backendpool_tunnel_interface_port       = string #(Required) The port number that this Gateway Lodbalancer Tunnel Interface listens to.
    }))
  }))
  description = "Map containing load balancer backend address pools"
  default     = {}
}