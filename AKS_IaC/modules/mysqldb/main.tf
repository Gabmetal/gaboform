## Bloque para la generacion del motor de la BD MYsql

resource "azurerm_mysql_server" "mysqltest" {
  name                                                        = var.name
  location                                                    = var.location
  resource_group_name                                         = var.rg_name

  administrator_login                                         = var.administrator_login #"mysqladminun"
  administrator_login_password                                = var.administrator_login_password #"IngresarDb2021!"

  sku_name                                                    = "GP_Gen5_4"
  storage_mb                                                  = 5120
  version                                                     = "5.7"

  auto_grow_enabled                                           = true
  backup_retention_days                                       = 7
  # geo redundat no acepta
  geo_redundant_backup_enabled                                = false
  # no acepta encryption enabled
  infrastructure_encryption_enabled                           = false
  # con false no
  public_network_access_enabled                               = false
  ssl_enforcement_enabled                                     = true
  ssl_minimal_tls_version_enforced                            = "TLS1_2"

  tags = {
      Enviroment = "Produccion"
      AppName = "-"
  }
}

