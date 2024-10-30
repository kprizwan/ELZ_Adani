
resource "azurerm_shared_image_gallery" "shared_image_gallery" {
  for_each            = var.shared_image_gallery_variables
  name                = each.value.shared_image_gallery_name
  resource_group_name = each.value.shared_image_gallery_resource_group_name
  location            = each.value.shared_image_gallery_location
  description         = each.value.shared_image_gallery_description
  tags                = merge(each.value.shared_image_gallery_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}
