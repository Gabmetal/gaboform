## Modulo que permite la creacion de un recurso Azure Resource Group ##
resource "azurerm_resource_group" "main" {
  name     = var.rg_name
  location = var.location
  tags     = var.tags
}