resource "azuredevops_serviceendpoint_azurerm" "azurerm" {
    project_id                = var.project_id
    service_endpoint_name     = var.CONNECTION_DESCRIPTION
    description               = "Managed by Terraform ${var.CONNECTION_DESCRIPTION}"
    credentials {
        serviceprincipalid    = var.SP_ID
        serviceprincipalkey   = var.SP_KEY
    }
    azurerm_spn_tenantid      = var.SP_TENANTID
    azurerm_subscription_id   = var.SP_SUBSCRIPTIONID
    azurerm_subscription_name = var.SP_SUBSCRIPTIONNAME
}
