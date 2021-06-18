variable "name" {
    description = "Release name"
}

variable "namespace" {
    type = string
    description = "The namespace to install the release into"
}

variable "repository" {
    description = "Repository URL where to locate the requested chart"
}

variable "chart_name" {
    description = "Chart name to be installed. The chart name can be local path, a URL to a chart, or the name of the chart if repository is specified"
}

variable "charts_version" {
    description = "Specify the exact chart version to install. If this is not specified, the latest version is installed."
    default =  ""
}

variable "chart_values" {
    type = string
    description = "Path to values.yaml file"
}