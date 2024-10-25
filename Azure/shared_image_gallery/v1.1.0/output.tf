#shared_image_gallery
output "shared_image_gallery_ids" {
  value = { for k, v in azurerm_shared_image_gallery.shared_image_gallery : k => v.id }
}


