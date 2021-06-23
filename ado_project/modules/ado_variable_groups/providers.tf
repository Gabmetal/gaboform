terraform {
  experiments = [module_variable_optional_attrs]
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = "0.1.5"
    }
  }
}
