#NETWORK WATCHER VARIABLES
variable "network_watcher_variables" {
  description = "Map of network watcher variables"
  type = map(object({
    network_watcher_name                = string      #(Required) The name of the Network Watcher. Changing this forces a new resource to be created.
    network_watcher_location            = string      #(Required) The name of the resource group in which to create the Network Watcher. Changing this forces a new resource to be created.
    network_watcher_resource_group_name = string      #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    network_watcher_tags                = map(string) #(Optional) A mapping of tags to assign to the resource.
  }))
  default = {}
}