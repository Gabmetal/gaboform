variable "resource_count" {
  description = "deploy role binding count"
  type        = number
  default     = 1
}

variable "resource_id" {
    type        = string
    description = "Azure resource ID"
}

variable "principal_id" {
    type        = string
    description = "AKS object_id"
}

variable "role_name" {
  type        = string
  description = "Nombre del rol a asignar"
}