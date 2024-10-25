#SHARED IMAGE GALLERY
resource "azurerm_shared_image_gallery" "shared_image_gallery" {
  for_each            = var.shared_image_gallery_variables
  name                = each.value.shared_image_gallery_name
  resource_group_name = each.value.shared_image_gallery_resource_group_name
  location            = each.value.shared_image_gallery_location
  description         = each.value.shared_image_gallery_description
  dynamic "sharing" {
    for_each = each.value.shared_image_gallery_sharing != null ? [each.value.shared_image_gallery_sharing] : []
    content {
      permission = sharing.value.sharing_permission
      dynamic "community_gallery" {
        for_each = sharing.value.sharing_community_gallery != null && sharing.value.sharing_permission == "Community" ? [sharing.value.sharing_community_gallery] : []
        content {
          eula            = community_gallery.value.community_gallery_eula
          prefix          = community_gallery.value.community_gallery_prefix
          publisher_email = community_gallery.value.community_gallery_publisher_email
          publisher_uri   = community_gallery.value.community_gallery_publisher_uri
        }
      }
    }
  }
  tags = merge(each.value.shared_image_gallery_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}