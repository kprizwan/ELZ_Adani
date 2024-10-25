#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  type = map(object({
    resource_group_name     = string      #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_tags     = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups"
  default     = {}
}

#NETWORK WATCHER VARIABLES
variable "network_watcher_variables" {
  type = map(object({
    name                 = string      #(Required) The name of the Network Watcher. Changing this forces a new resource to be created.
    location             = string      #(Required) The name of the resource group in which to create the Network Watcher. Changing this forces a new resource to be created.
    resource_group_name  = string      #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    network_watcher_tags = map(string) #(Optional) A mapping of tags to assign to the resource.
  }))
  description = "Map of network watcher variables"
  default     = {}
}