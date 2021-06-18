variable "rg_name" {
    description = "Nombre del Resource Group"
}

variable "location" {
    description = "Location donde se levantan los Recursos"
}

variable "name" {
    description = ""
}

variable "administrator_login" {
    type = string
    description = "Nombre para el User Admin de la BD"
}

variable "administrator_login_password" {
    type = string
    description = "Password para el User Admin de la BD"
}