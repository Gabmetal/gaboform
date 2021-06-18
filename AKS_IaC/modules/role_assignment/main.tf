resource "azurerm_role_assignment" "attach_acr" {
  count                = var.resource_count

  scope                = var.resource_id
  role_definition_name = var.role_name
  principal_id         = var.principal_id
}