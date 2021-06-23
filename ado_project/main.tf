module "create_project" {
    source                    = "./modules/ado_projects/"
    PROJECT_NAME              = var.PROJECT_NAME
    PROJECT_DESCRIPTION       = var.PROJECT_DESCRIPTION
    PROJECT_VISIBILITY        = var.PROJECT_VISIBILITY
}

module "create_service_endpoint" {
    source                    = "./modules/ado_azurerm_serviceendpoint/"
    project_id                = module.create_project.output.id
    CONNECTION_NAME           = var.CONNECTION_NAME
    CONNECTION_DESCRIPTION    = var.CONNECTION_DESCRIPTION
    SP_ID                     = var.SP_ID
    SP_KEY                    = var.SP_KEY
    SP_TENANTID               = var.SP_TENANTID
    SP_SUBSCRIPTIONID         = var.SP_SUBSCRIPTIONID
    SP_SUBSCRIPTIONNAME       = var.SP_SUBSCRIPTIONNAME
    depends_on = [
      module.create_project
    ]
}

module "create_variable_groups" {
    source                    = "./modules/ado_variable_groups/"
    project_id                = module.create_project.output.id
    VARIABLEGROUP_NAME        = var.VARIABLEGROUP_NAME
    VARIABLEGROUP_DESCRIPTION = var.VARIABLEGROUP_DESCRIPTION
    ALLOW_ACCESS              = var.ALLOW_ACCESS
    depends_on = [
      module.create_project
    ]
    variables                 = [
                                    {
                                        name      =  "ARM_CLIENT_ID"
                                        value     =  var.SP_ID
                                        is_secret =  false
                                    },
                                    {
                                        name      =  "ARM_CLIENT_SECRET"
                                        secret_value     =  var.SP_KEY
                                        is_secret =  true
                                    },
                                    {
                                        name      =  "ARM_SUBSCRIPTION_ID"
                                        value     =  var.SP_SUBSCRIPTIONID 
                                        is_secret =  false
                                    },
                                    {
                                        name      =  "ARM_TENANT_ID" 
                                        value     =  var.SP_TENANTID
                                        is_secret =  false
                                    }
                                ]
}

module "assign_administrators" {
    source                    = "./modules/ado_group_membership/"
    project_id                = module.create_project.output.id
    group_name                = "Project Administrators"
    PRINCIPAL_NAME            = var.PRINCIPAL_NAME
    depends_on = [
      module.create_project
    ]
}