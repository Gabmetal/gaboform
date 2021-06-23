data "azuredevops_group" "project_group" {
    project_id    =  var.project_id
    name          =  var.group_name
}