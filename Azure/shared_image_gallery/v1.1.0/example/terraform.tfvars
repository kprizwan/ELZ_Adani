#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000001"
    location = "westus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#shared_image_gallery
shared_image_gallery_variables = {
  shared_image_gallery_1 = {
    shared_image_gallery_name                = "ploceussimg000001"
    shared_image_gallery_resource_group_name = "ploceusrg000001"
    shared_image_gallery_location            = "westus2"
    shared_image_gallery_description         = "ploceusdes00001"
    shared_image_gallery_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
