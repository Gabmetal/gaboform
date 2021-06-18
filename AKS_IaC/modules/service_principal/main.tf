resource "azuread_application" "aks_sp_app" {
  count                        = var.resource_count
  display_name                 = "sp-${var.aks_name}"
}

resource "azuread_service_principal" "aks_sp" {
  count                        = var.resource_count
  application_id               = azuread_application.aks_sp_app[0].application_id
  app_role_assignment_required = false
}

resource "azuread_service_principal_password" "aks_sp_pwd" {
  count                        = var.resource_count
  service_principal_id         = azuread_service_principal.aks_sp[0].id
  end_date_relative            = var.end_date_relative

  lifecycle {
    ignore_changes = [
        value,
        end_date_relative
    ]
  }
}