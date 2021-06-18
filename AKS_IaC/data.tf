data "azurerm_kubernetes_cluster" "existing_cluster" {
  count               = var.updating_existing_cluster ? 1 : 0
  name                = var.aks_name
  resource_group_name = var.rg_name
}