#shared_image_gallery output
output "shared_image_gallery_output" {
  description = "Shared image gallery output values"
  value = { for k, v in azurerm_shared_image_gallery.shared_image_gallery : k => {
    id = v.id
    }
  }
}