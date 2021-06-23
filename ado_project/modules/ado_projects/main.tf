resource "azuredevops_project" "project" {
    name               = var.PROJECT_NAME
    description        = var.PROJECT_DESCRIPTION
    visibility         = var.PROJECT_VISIBILITY == false ? "private" : "public"
    version_control    = var.project_version_control == true ? "Git" : "Tfvc"
    
    features           = var.project_features
}
