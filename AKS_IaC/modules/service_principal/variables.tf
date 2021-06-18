variable "aks_name" {
    description = "Nombre del AKS"
    type        = string
}

variable "end_date_relative" {
    type        = string
    description = "Tiempo relativo hasta el vencimiento de las credenciales ej: 8760h (1 año)"
    default     = "8760h"
}

variable "resource_count" {
    type        = number
    description = "Cantidad de recursos a desplegar"
}