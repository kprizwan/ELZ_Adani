#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000001" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location = "westus2"         #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_managed_by = "ploceus" #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#SHARED IMAGE GALLERY
shared_image_gallery_variables = {
  shared_image_gallery_1 = {
    shared_image_gallery_name                = "ploceussimg000001" #(Required) Specifies the name of the Shared Image Gallery.
    shared_image_gallery_resource_group_name = "ploceusrg000001"   #(Required) The name of the resource group in which to create the Shared Image Gallery.
    shared_image_gallery_location            = "westus2"           #(Required) Specifies the supported Azure location where the resource exists.
    shared_image_gallery_description         = "ploceusdes00001"   #(Optional) A description for this Shared Image Gallery.
    shared_image_gallery_sharing             = null
    shared_image_gallery_tags = { #(Optional) A mapping of tags to assign to the Shared Image Gallery.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}