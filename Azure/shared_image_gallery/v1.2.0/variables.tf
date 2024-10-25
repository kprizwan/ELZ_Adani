#shared image gallery
variable "shared_image_gallery_variables" {
  type = map(object({
    shared_image_gallery_name                = string      #(Required) Specifies the name of the Shared Image Gallery.
    shared_image_gallery_resource_group_name = string      #(Required) The name of the resource group in which to create the Shared Image Gallery.
    shared_image_gallery_location            = string      #(Required) Specifies the supported Azure location where the resource exists.
    shared_image_gallery_description         = string      #(Optional) A description for this Shared Image Gallery.
    shared_image_gallery_tags                = map(string) #(Optional) A mapping of tags to assign to the Shared Image Gallery.
  }))
  description = "Map of Shared Image Gallery"
  default = {
  }
}
