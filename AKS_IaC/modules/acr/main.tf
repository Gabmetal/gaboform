## Modulo que permite la creacion de un recurso Azure COntainer Registry ##

resource "azurerm_container_registry" "acr" {
  count                    = var.resource_count
  name                     = var.acrname
  resource_group_name      = var.rg_name
  location                 = var.location
  sku                      = "Standard"
  admin_enabled            = true
  #georeplication_locations = ["East US", "West Europe"]
  tags                     = var.tags
}