#SHARED IMAGE GALLERY VARIABLES
variable "shared_image_gallery_variables" {
  type = map(object({
    shared_image_gallery_name                = string #(Required) Specifies the name of the Shared Image Gallery.
    shared_image_gallery_resource_group_name = string #(Required) The name of the resource group in which to create the Shared Image Gallery.
    shared_image_gallery_location            = string #(Required) Specifies the supported Azure location where the resource exists.
    shared_image_gallery_description         = string #(Optional) A description for this Shared Image Gallery.
    shared_image_gallery_sharing = object({
      sharing_permission = string #(Required) The permission of the Shared Image Gallery when sharing. The only possible value now is Community. Changing this forces a new resource to be created.
      sharing_community_gallery = object({
        community_gallery_eula            = string #(Required) The End User Licence Agreement for the Shared Image Gallery. Changing this forces a new resource to be created.
        community_gallery_prefix          = string #(Required) Prefix of the community public name for the Shared Image Gallery. Changing this forces a new resource to be created.
        community_gallery_publisher_email = string #(Required) Email of the publisher for the Shared Image Gallery. Changing this forces a new resource to be created.
        community_gallery_publisher_uri   = string #(Required) URI of the publisher for the Shared Image Gallery. Changing this forces a new resource to be created.
      })
    })

    shared_image_gallery_tags = map(string) #(Optional) A mapping of tags to assign to the Shared Image Gallery.
  }))
  description = "Map of Shared Image Gallery"
  default     = {}
}