## Attributes

- name                 = string      #(Required) The name of the Network Watcher. Changing this forces a new resource to be created.
- location             = string      #(Required) The name of the resource group in which to create the Network Watcher. Changing this forces a new resource to be created.
- resource_group_name  = string      #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
- network_watcher_tags = map(string) #(Optional) A mapping of tags to assign to the resource.