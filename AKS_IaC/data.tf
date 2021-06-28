data "azurerm_kubernetes_cluster" "existing_cluster" {
  count               = var.UPDATING_EXISTING_CLUSTER ? 1 : 0
  name                = var.AKS_NAME
  resource_group_name = var.RG_NAME
}

data "azuread_service_principal" "existing_sp" {
  count          = var.EXISTING_SP_ID       == "" ? 0 : 1
  application_id = var.EXISTING_SP_ID
}

data "azurerm_container_registry" "existing_acr" {
  count               = var.CREATE_NEW_ACR ? 0 : 1
  name                = var.ACRNAME
  resource_group_name = var.RG_NAME
}
