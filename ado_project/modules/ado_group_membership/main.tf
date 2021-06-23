resource "azuredevops_user_entitlement" "user"{
    count           = length(var.PRINCIPAL_NAME)
    principal_name  = element(var.PRINCIPAL_NAME, count.index)
}

resource "azuredevops_group_membership" "membership" {
    count           = length(azuredevops_user_entitlement.user)
    group           = data.azuredevops_group.project_group.descriptor
    members          = [
        element(azuredevops_user_entitlement.user, count.index).descriptor
    ]
}
