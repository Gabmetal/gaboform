variable "crb_name" {
    type = string
    description = "Name of the cluster role binding, must be unique. Cannot be updated."
}

variable "api_group" {
    type = string
    description = "The API group to drive authorization decisions. This value must be and defaults to rbac.authorization.k8s.io"
}

variable "binding_kind" {
    type = string
    description = "The type of binding to use. This value must be and defaults to ClusterRole"
}

variable "role_name" {
    type = string
    description = "The name of this ClusterRole to bind Subjects to."
}

variable "subject_kind" {
    type = string
    description = "The type of binding to use. This value must be ServiceAccount, User or Group"
}

variable "subject_name" {
    type = string
    description = "The name of this ClusterRole to bind Subjects to."
}

variable "subject_namespace" {
    type = string
    description = "Namespace defines the namespace of the ServiceAccount to bind to. This value only applies to kind ServiceAccount"
}