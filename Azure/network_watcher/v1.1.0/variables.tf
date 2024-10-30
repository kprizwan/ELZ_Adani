#NETWORK WATCHER VARIABLES
variable "network_watcher_variables" {
  description = "Map of network watcher variables"
  type = map(object({
    name                 = string
    location             = string
    resource_group_name  = string
    network_watcher_tags = map(string)
  }))
}