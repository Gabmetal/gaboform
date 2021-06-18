resource "azurerm_virtual_network" "aks-vnet" {
  count                     = var.subnet_id_aks == "" ? 1 : 0

  name                      = var.vnet_name
  resource_group_name       = var.rg_name
  location                  = var.location
  address_space             = var.address_space

  tags = var.tags
}