## Attributes:

- bastion_host_name = string #(Required) Specifies the name of the Bastion Host. Changing this forces a new resource to be created.
- bastion_host_resource_group_name  = string #(Required) The name of the resource group in which to create the Bastion Host.
- bastion_host_location = string #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. Review https://learn.microsoft.com/en-us/azure/bastion/bastion-faq for supported locations.
- bastion_host_is_copy_paste_enabled = bool #(Optional) Is Copy/Paste feature enabled for the Bastion Host. Defaults to true.
- bastion_host_is_file_copy_enabled = bool #(Optional) Is File Copy feature enabled for the Bastion Host. Defaults to false.
- bastion_host_sku = string #(Optional) The S#(Optional) Is IP Connect feature enabled for the Bastion Host. Defaults to false.
- bastion_host_scale_units = number #(Optional) The number of scale units with which to provision the Bastion Host. Possible values are between 2 and 50. Defaults to 2.
- bastion_host_is_shareable_link_enabled = bool #(Optional) Is Shareable Link feature enabled for the Bastion Host. Defaults to false.
- bastion_host_is_tunneling_enabled = bool #(Optional) Is Tunneling feature enabled for the Bastion Host. Defaults to false.
- bastion_host_tags = map(string) #(Optional) A mapping of tags to assign to the resource.
- bastion_host_virtual_network_name = string #(Required) The Virtual network name for subnet ID
- bastion_host_virtual_network_resource_group_name = string  #(Required) The Virtual network resource group name for subnet ID
- bastion_host_subnet_name  = string #(Required) The Subnet name for Subnet ID
- bastion_host_public_ip_name = string #(Required) The Public IP name for public IP address ID
- bastion_host_public_ip_resource_group_name = string #(Required) The Public IP resource group name for public IP address ID
- bastion_host_ip_configuration = #(Required) A ip_configuration block as defined below.
  - ip_configuration_name = string  #(Required) The name of the IP configuration.

>## Notes:
>1. file_copy_enabled is only supported when sku is Standard.
>2. ip_connect_enabled is only supported when sku is Standard.
>3. scale_units only can be changed when sku is Standard. scale_units is always 2 when sku is Basic.
>4. shareable_link_enabled is only supported when sku is Standard.
>5. tunneling_enabled is only supported when sku is Standard.
>6. The Subnet used for the Bastion Host must have the name AzureBastionSubnet and the subnet mask must be at least a /26.  