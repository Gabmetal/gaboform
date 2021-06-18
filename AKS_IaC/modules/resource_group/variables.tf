## Se definen las variables para el recurso Azure Resource Group ##

variable "location" {
    description = "Location donde se levantan los Recursos"
}

variable "rg_name" {
    description = "Nombre del Resource Group"
}

variable "tags" {
    description = "tags para los recursos"
    type = map(string)
    default = {
        environment = "develop"
        application = "test"
    }
}