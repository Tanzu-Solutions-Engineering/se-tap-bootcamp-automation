output "gallery_name" {
  value = azurerm_shared_image_gallery.workshop.name
}

output "image_name" {
  value = azurerm_shared_image.workshop.name
}

output "image_publisher" {
  value = azurerm_shared_image.workshop.identifier[0].publisher
}

output "image_offer" {
  value = azurerm_shared_image.workshop.identifier[0].offer
}

output "image_sku" {
  value = azurerm_shared_image.workshop.identifier[0].sku
}
