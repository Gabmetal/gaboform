resource "azurerm_subnet" "main" {
  count                     = var.subnet_id_aks == "" ? 1 : 0
  name                      = var.subnet_name
  resource_group_name       = var.rg_name
  virtual_network_name      = var.vnet_name
  address_prefixes          = var.address_prefixes

}