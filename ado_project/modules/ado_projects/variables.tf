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
    default     = false
}

variable "project_version_control" {
    type        = bool
    description = "use git?"
    default     = true
}

variable "project_features" {
    type        = map(string)
    description = "Defines the status (enabled, disabled) of the project features. Valid features are boards, repositories, pipelines, testplans, artifacts"
    default     = {
        "boards"       = "enabled"
        "repositories" = "enabled"
        "pipelines"    = "enabled"
        "testplans"    = "enabled"
        "artifacts"    = "enabled"
    }
}