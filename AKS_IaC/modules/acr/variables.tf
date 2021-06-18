## Se definen las variables para el recurso Azure Container Registry ##

variable "rg_name" {
    description = "Nombre del Resource Group"
}

variable "acrname" {
    type = string
    description = "Nombre para el ACR"
}

variable "location" {
    description = "Location donde se levantan los Recursos"
}

variable "tags" {
    description = "tags para los recursos"
    type = map(string)
    default = {
        environment = "develop"
        application = "test"
    }
}

variable "resource_count" {
    type        = number
    description = "cantidad de recursos a desplegar"
}