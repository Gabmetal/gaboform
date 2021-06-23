variable "project_id" {
    type        = string
    description = "Target Project's id"
}

variable "CONNECTION_NAME" {
    type        = string
    description = "Service connection's name"
    default     = "AzureRM"
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