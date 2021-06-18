# Create a Private DNS Zone
resource "azurerm_private_dns_zone" "private-dns01" {
  name                                                        = var.name
  resource_group_name                                         = var.rg_name

  tags = {
      Enviroment = "Produccion"
      AppName = "-"
  }
}
