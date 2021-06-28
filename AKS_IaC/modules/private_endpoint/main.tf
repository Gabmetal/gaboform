
resource "azurerm_private_endpoint" "endpointtomysql" {
  count                                   = var.resource_count
  name                                    = "privatelink-mysql-database-azure-com"
  location                                = var.location
  resource_group_name                     = var.rg_name
  subnet_id                               = var.subnet_id

  private_service_connection {
    name                                  = "privatelink-mysql-database-com"
    private_connection_resource_id        = var.resource_id_to_connect
    is_manual_connection                  = false
    subresource_names                     = ["mysqlServer"]
  }

  tags = var.tags
}