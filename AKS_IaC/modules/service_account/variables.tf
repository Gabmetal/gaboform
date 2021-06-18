variable "sa_name" {
    type = string
    description = "Name of the service account, must be unique. Cannot be updated."
}

variable "sa_namespace" {
    type = string
    description = "Namespace defines the space within which name of the service account must be unique."
}