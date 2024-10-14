### Attributes: ###
- resource_group_name     = string      #(Required) Name of the Resouce Group with which it should be created.
- resource_group_location = string      #(Required) The Azure Region where the Resource Group should exist
- resource_group_managed_by = string    #(optional)  The ID of the resource or application that manages this Resource Group.
- resource_group_tags     = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.

>### Notes: ###
> - Azure automatically deletes any Resources nested within the Resource Group when a Resource Group is deleted.
Version 2.72 and later of the Azure Provider include a Feature Toggle which can error if there are any Resources left within the Resource Group at deletion time. This Feature Toggle is disabled in 2.x but enabled by default from 3.0 onwards, and is intended to avoid the unintentional destruction of resources managed outside of Terraform (for example, provisioned by an ARM Template). See the Features block documentation for more information on Feature Toggles within Terraform.