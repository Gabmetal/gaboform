
variable "rg_name" {
    type                                        = string
    description                                 = "Nombre del Resource Group"
}

variable "location" {
    type                                        = string
    description                                 = ""
}

variable "resource_id_to_connect" {
    description                                 = ""
}

variable "subnet_id" {
    description                                 = ""
}

variable "tags" {
  description = "TAGS para los recursos"
  type        = map(string)
  default = {
    environment = "develop"
    application = "test"
  }
}

variable "resource_count" {
    type        = number
    description = "cantidad de recursos a desplegar"
}