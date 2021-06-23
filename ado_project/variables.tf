## Project variables
variable "PROJECT_NAME" {
    type        = string
    description = "Project Name"
}

variable "PROJECT_DESCRIPTION" {
    type        = string
    description = "Project Description"
}

variable "PROJECT_VISIBILITY" {
    type        = bool
    description = "is the project public?"
}


## AzureRM Service Connection
variable "CONNECTION_NAME" {
    type        = string
    description = "Service connection's name"
}

variable "CONNECTION_DESCRIPTION" {
    type        = string
    description = "Service connection description"
}

variable "SP_ID" {
    type        = string
    description = "The service principal application Id"
}

variable "SP_KEY" {
    type        = string
    description = "The service principal secret"
    sensitive   = true
}

variable "SP_TENANTID" {
    type        = string
    description = "The tenant id if the service principal"
}

variable "SP_SUBSCRIPTIONID" {
    type        = string
    description = "The subscription Id of the Azure targets"
}

variable "SP_SUBSCRIPTIONNAME" {
    type        = string
    description = "The subscription Name of the targets"
}

## Variable Groups parameters
variable "VARIABLEGROUP_NAME" {
    type        = string
    description = "The name of the Variable Group"
}

variable "VARIABLEGROUP_DESCRIPTION" {
    type        = string
    description = "The description of the Variable Group"
}

variable "ALLOW_ACCESS" {
    type        = bool
    description = "Boolean that indicate if this variable group is shared by all pipelines of this project."
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

variable "PRINCIPAL_NAME" {
    type          = list(string)
    description   = "The principal name is the PrincipalName of a graph member from the source provider. Usually, e-mail address."
}