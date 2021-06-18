output "sp_password" {
  value = azuread_service_principal_password.aks_sp_pwd
}

output "sp_application" {
  value = azuread_service_principal.aks_sp
}
