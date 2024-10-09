#LOAD BALANCER RULES
variable "load_balancer_rule_variables" {
  type = map(object({
    load_balancer_rule_load_balancer_name                = string       #(Required) To fetch the ID of the Load Balancer in which to create the Rule.
    load_balancer_rule_load_balancer_resource_group_name = string       #(Required) To fecth the ID of the Load Balancer in which to create the Rule.
    load_balancer_rule_load_balancer_subscription_id     = string       #Mark as null if load_balancer_rule_probe_name is null
    load_balancer_rule_name                              = string       #(Required) Specifies the name of the LB Rule.
    load_balancer_rule_protocol                          = string       #(Required) The transport protocol for the external endpoint. Possible values are Tcp, Udp or All.
    load_balancer_rule_frontend_port                     = string       #(Required) The port for the external endpoint. Port numbers for each Rule must be unique within the Load Balancer. Possible values range between 0 and 65534, inclusive.
    load_balancer_rule_backend_port                      = string       #(Required) The port used for internal connections on the endpoint. Possible values range between 0 and 65535, inclusive.
    load_balancer_rule_frontend_ip_configuration_name    = string       #(Required) The name of the frontend IP configuration to which the rule is associated.
    load_balancer_rule_backend_pool_names                = list(string) #(Optional) Needed for fetching backend pool ids- A list of reference to a Backend Address Pool over which this Load Balancing Rule operates.
    load_balancer_rule_probe_name                        = string       #Optional, mark as null if not needed
    load_balancer_rule_load_distribution                 = string       #(Optional) Specifies the load balancing distribution type to be used by the Load Balancer. Possible values are: Default – The load balancer is configured to use a 5 tuple hash to map traffic to available servers. SourceIP – The load balancer is configured to use a 2 tuple hash to map traffic to available servers. SourceIPProtocol – The load balancer is configured to use a 3 tuple hash to map traffic to available servers. Also known as Session Persistence, where the options are called None, Client IP and Client IP and Protocol respectively.
    load_balancer_rule_idle_timeout_in_minutes           = number       #(Optional) Specifies the idle timeout in minutes for TCP connections. Valid values are between 4 and 30 minutes. Defaults to 4 minutes.
    load_balancer_rule_enable_floating_ip                = bool         #(Optional) Are the Floating IPs enabled for this Load Balncer Rule? A "floating” IP is reassigned to a secondary server in case the primary server fails. Required to configure a SQL AlwaysOn Availability Group. Defaults to false.
    load_balancer_rule_disable_outbound_snat             = bool         #(Optional) Is snat enabled for this Load Balancer Rule? Default false.
    load_balancer_rule_enable_tcp_reset                  = bool         #(Optional) Is TCP Reset enabled for this Load Balancer Rule? Defaults to false.
  }))
  description = "Map containing load balancer rule and probe parameters"
  default     = {}
}

