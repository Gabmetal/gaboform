
resource "azurerm_private_endpoint" "endpointtomysql" {
  name                                                              = "privatelink-mysql-database-azure-com"
  location                                                          = var.location
  resource_group_name                                               = var.rg_name
  subnet_id                                                         = var.subnet_id

  private_service_connection {
    name                                                            = "privatelink-mysql-database-com"
    private_connection_resource_id                                  = var.resource_id_to_connect
    is_manual_connection                                            = false
    subresource_names                                               = ["mysqlServer"]
  }

#  private_dns_zone_group {
#    name                                                           = "mysql-paas-privDnsZoneGroup"
#    private_dns_zone_ids                                           = var.ids_of_dns_zone
                                                                     #[azurerm_private_dns_zone.ple_dns_zone.id]
#  }

  tags = {
    Enviroment = "Produccion"
    AppName = "-"
  }
}