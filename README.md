
Versión en español [[LINK](https://dev.azure.com/gabrielc0841/Metalsa-java/_wiki/wikis/README.md/2/README_ES)]

  

# Pre-requisites

To allow terraform run and build all resources defined here you will need to create an organization in Azure DevOps and a Personal Access Token (PAT) with full access.

## Create a personal access token
1. Go to your Azure DevOps. Select an organization.

2. Click the icon next to your icon at the right top corner.

3. Select "Personal access tokens".

4. Click "New Token" then create a new personal access token with the access required by your template. This will be driven primarily based on which resources you need to provision in Azure DevOps. A token with Full access scope will work but may provide more access than you need.

5. Copy the personal access token.

  

Before run terraform you will need to set this environment variables in your pipeline or workstation.

| Variable Name | Description | Default | Type |
|--|--|--|--|
| AZDO_PERSONAL_ACCESS_TOKEN | This is the Azure DevOps organization personal access token. The account corresponding to the token will need "owner" privileges for this organization | null | String |
| AZDO_ORG_SERVICE_URL | This is the Azure DevOps organization url | null | String |
| TF_VAR_PROJECT_NAME | The Project Name | null | String |
| TF_VAR_PROJECT_DESCRIPTION | The Description of the Project | null | String |
| TF_VAR_PROJECT_VISIBILITY |  Specifies the visibility of the Project. Valid values: private or public. Defaults to private | false | Bool |
| TF_VAR_CONNECTION_NAME | The Service Endpoint name | AzureRM | String |
| TF_VAR_CONNECTION_DESCRIPTION | Service connection description | null | String
| TF_VAR_SP_ID | The service principal application Id | null | String |
| TF_VAR_SP_KEY | The service principal secret | null | String |
| TF_VAR_SP_TENANTID | The tenant id if the service principal | null | String |
| TF_VAR_SP_SUBSCRIPTIONID | The subscription Id of the Azure targets | null | String |
| TF_VAR_SP_SUBSCRIPTIONNAME | The subscription Name of the targets | null | String
| TF_VAR_VARIABLEGROUP_NAME | The name of the Variable Group | null | String |
| TF_VAR_VARIABLEGROUP_DESCRIPTION | The description of the Variable Group | null | String |
| TF_VAR_ALLOW_ACCESS | Boolean that indicate if this variable group is shared by all pipelines of this project | true | Bool |
| TF_VAR_PRINCIPAL_NAME | The principal name is the PrincipalName of a graph member from the source provider. Usually, e-mail address | null | List(string)
---
# Deploying Project
To deploy project you can run:
```
    terraform plan -out=tfplan
    terraform apply tfplan
```