data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}


resource "azurerm_shared_image_gallery" "workshop" {
  name                = var.gallery_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  description         = "shared images for workshop"

}

#need to pre-stage image definition
resource "azurerm_shared_image" "workshop" {
  name                = var.image_name
  gallery_name        = azurerm_shared_image_gallery.workshop.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  os_type             = "Linux"
  hyper_v_generation  = var.hyper_v_generation

  identifier {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
  }
}