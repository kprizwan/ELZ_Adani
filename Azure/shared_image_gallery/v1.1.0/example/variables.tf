
#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
  default = {}
}

#shared image gallery 
variable "shared_image_gallery_variables" {
  type = map(object({
    shared_image_gallery_name                = string
    shared_image_gallery_resource_group_name = string
    shared_image_gallery_location            = string
    shared_image_gallery_description         = string
    shared_image_gallery_tags                = map(string)
  }))
}
