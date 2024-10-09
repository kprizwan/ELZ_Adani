# LOAD BALANCER PROBE
variable "load_balancer_probe_variables" {
  type = map(object({
    load_balancer_probe_load_balancer_name                = string #(Required) Loadbalancer name for fetching the ID of the LoadBalancer in which to create the NAT Rule.
    load_balancer_probe_load_balancer_resource_group_name = string #(Required)Loadbalancer resource group name for fetching the ID of the LoadBalancer in which to create the NAT Rule.
    load_balancer_probe_name                              = string #(Required) Specifies the name of the Probe.
    load_balancer_probe_port                              = number #(Required) Port on which the Probe queries the backend endpoint. Possible values range from 1 to 65535, inclusive.
    load_balancer_probe_protocol                          = string #(Optional) Specifies the protocol of the end point. Possible values are Http, Https or Tcp. If TCP is specified, a received ACK is required for the probe to be successful. If HTTP is specified, a 200 OK response from the specified URI is required for the probe to be successful.
    load_balancer_probe_request_path                      = string #(Optional) The URI used for requesting health status from the backend endpoint. Required if protocol is set to Http or Https. Otherwise, it is not allowed.
    load_balancer_probe_interval_in_seconds               = number #(Optional) The interval, in seconds between probes to the backend endpoint for health status. The default value is 15, the minimum value is 5.
    load_balancer_probe_number_of_probes                  = number #(Optional) The number of failed probe attempts after which the backend endpoint is removed from rotation. The default value is 2. NumberOfProbes multiplied by intervalInSeconds value must be greater or equal to 10.Endpoints are returned to rotation when at least one probe is successful.
  }))
  description = "Map of load_balancer_probe"
  default     = {}
}
