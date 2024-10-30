#RESOURCE GROUP
module "resource_group" {
  source                   = "../../../resource_group/v1.2.0"
  resource_group_variables = var.resource_group_variables
}

#shared image gallery 
module "shared_image_gallery" {
  source                         = "../"
  shared_image_gallery_variables = var.shared_image_gallery_variables
  depends_on                     = [module.resource_group]
}
