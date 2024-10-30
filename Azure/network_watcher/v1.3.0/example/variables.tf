#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  type = map(object({
    resource_group_name       = string      #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = string      #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags       = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups"
  default     = {}
}

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