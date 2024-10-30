#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.3.0"
  resource_group_variables = var.resource_group_variables
}

#SHARED IMAGE GALLERY
module "shared_image_gallery" {
  source                         = "../"
  shared_image_gallery_variables = var.shared_image_gallery_variables
  depends_on                     = [module.resource_group]
}