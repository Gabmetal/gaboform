## Modulo que permite la creacion de un recurso Azure Storage Account ##

resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "Production"
  }
}