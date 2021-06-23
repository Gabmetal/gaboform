resource "azuredevops_variable_group" "variablegroup" {
    project_id        = var.project_id
    name              = var.VARIABLEGROUP_NAME
    description       = var.VARIABLEGROUP_DESCRIPTION
    allow_access      = var.ALLOW_ACCESS

    dynamic "variable" {
        for_each      = var.variables
        content {    
            name         = variable.value["name"]
            value        = lookup(variable.value, "value", "")
            secret_value = lookup(variable.value, "secret_value", "")
            is_secret    = variable.value["is_secret"]
        }
    }
}
