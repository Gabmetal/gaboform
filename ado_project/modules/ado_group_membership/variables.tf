variable "PRINCIPAL_NAME" {
    type        = list(string)
    description = "The principal name is the PrincipalName of a graph member from the source provider. Usually, e-mail address."
}

variable "project_id" {
    type        = string
    description = "The Project ID. If no project ID is specified the project collection groups will be searched."
}

variable "group_name" {
    type        = string
    description = "The Group Name"
    default     = "Project Administrators"
}
