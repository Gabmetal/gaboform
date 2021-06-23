variable "project_id" {
    type          = string
    description   = "The project ID or project name."
}

variable "VARIABLEGROUP_NAME" {
    type          = string
    description   = "The name of the Variable Group"
}

variable "VARIABLEGROUP_DESCRIPTION" {
    type          = string
    description   = "The description of the Variable Group"
}

variable "ALLOW_ACCESS" {
    type          = bool
    description   = "Boolean that indicate if this variable group is shared by all pipelines of this project."
    default       = true
}

variable "variables" {
    type             = list(object({
        name         = string
        value        = optional(string)
        secret_value = optional(string)
        is_secret    = bool
    }))
    description   = "One or more variable block"
    default       = []
}
