
Versión en español [[LINK](https://dev.azure.com/gabrielc0841/Metalsa-java/_wiki/wikis/README.md/2/README_ES)]

  

# Pre-requisites

To allow terraform run and build all resources defined here you will need to create a service principal with "Owner" role on target subscription and "Application Administrator" on your Azure Active Directory. With these roles terraform will can deploy resorces, create Services principals and assign it to AKS cluster.

  

Before run terraform you will need to set this environment variables in your pipeline or workstation.

| Variable Name | Description | Default | Type |
|--|--|--|--|
| ARM_CLIENT_ID | Service principal app_id that terraform will use to create resources | null | String |
| ARM_CLIENT_SECRET | Service principal password that terraform will use to create resources | null | String |
| ARM_SUBSCRIPTION_ID | Target Subscription id | null | String |
| ARM_TENANT_ID | Subscription's tenant ID | null | String |
| TF_VAR_ssh_key | If you already have a ssh key you can set here. If you don't provide one, terraform will create a new one and assign it to nodes | null | String |
| TF_VAR_updating_existing_cluster | If you are updating configuration of an existing cluster set  it to true | false | Bool |
| TF_VAR_location | Location where you want to deploy resources in azure | eastus2 | String |
| TF_VAR_rg_name | Name for Resource Group where you want to deploy cluster resources | aks-test-rg | String |
| TF_VAR_tags | Tags to apply to each resource | { environment="develop", application="test" } | Map(string)
| TF_VAR_acrname | Name to assign to Azure Container Registry | testacr001 | String |
| TF_VAR_enable_attach_acr | If you want to assign ACRPull role to AKS Cluster set it to true | true | Bool |
| TF_VAR_create_new_acr | If you want to create a new Azure Container Registry for this cluster set it to true | true | Bool
| TF_VAR_end_date_relative | Relative time to credentials expiration | 8760h | String
| TF_VAR_vnet_name | Name for Virtual Network Terraform will create if TF_VAR_subnet_id_aks is null | aks-vnet | String
| TF_VAR_address_space | Virtual Network Address Spaces Terraform will create if TF_VAR_subnet_id_aks is null | ["10.0.0.0/16"] | list(string)
| TF_VAR_subnet_name | Name fot Subnet Terraform will create if TF_VAR_subnet_id_aks is null | aks-subnet | String
| TF_VAR_address_prefixes | AKS Cluster Subnet Address prefixes | ["10.0.1.0/24"] | list(string)
| TF_VAR_existing_sp_id | If you already have a service principal to assign to this cluster set the id here | null | string
| TF_VAR_existing_sp_password | If you already have a service principal to assign to this cluster set the password here | null | string
| TF_VAR_aks_name | Name for AKS Resource | testaks-01 | String |
| TF_VAR_dns_prefix | DNS prefix when creating managed cluster | testaks-01 | String
| TF_VAR_vmsizecluster | Azure VM size will use in nodes | standard_a2_v2 | String
| TF_VAR_kubernetes_version | Kubernetes version to deploy | 1.18.17 | String
| TF_VAR_subnet_id_aks | If you want to create AKS Cluster using an existing subnet set this variable with Sunet's Azure Resource ID | null | String
| TF_VAR_node_count | The initial number of nodes which should exist in this Node Pool | 1 | number
| TF_VAR_max_count | The maximum number of nodes which should exist in this Node Pool | 2 | number
| TF_VAR_min_count | The minimum number of nodes which should exist in this Node Pool | 1 | number
| TF_VAR_pod_cidr | The CIDR to use for pod IP addresses | 10.244.0.0/16 | String
| TF_VAR_dns_service_ip | IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns) It must to finish in .10 | 10.0.0.10 | String
| TF_VAR_service_cidr | The Network Range used by the Kubernetes service | 10.0.0.0/16 | String
| TF_VAR_docker_bridge_cidr | IP address (in CIDR notation) used as the Docker bridge IP address on nodes | 172.17.0.1/16 | String
| TF_VAR_sa_name | Name of the service account, must be unique to assign to AKS | null | String
| TF_VAR_api_group | The API group to drive authorization decisions | rbac.authorization.k8s.io | String
| TF_VAR_binding_kind | The type of binding to use | ClusterRole | String
| TF_VAR_role_name | The name of this ClusterRole to bind Subjects to | cluster-admin | String
| TF_VAR_subject_kind | The type of binding to use | ServiceAccount | String
| TF_VAR_subject_namespace | Namespace defines the namespace of the ServiceAccount to bind to. This value only applies to kind ServiceAccount | kube-system | String
| TF_VAR_namespace | The namespace to install the release into | null | String
| TF_VAR_name | Release name | null | String
| TF_VAR_repository | Repository URL where to locate the requested chart | null | String
| TF_VAR_chart_name | Chart name to be installed. The chart name can be local path, a URL to a chart, or the name of the chart if repository is specified | null | string
| TF_VAR_charts_version | Specify the exact chart version to install. If this is not specified, the latest version is installed. | null | String
---
# Deploying AKS
To deploy AKS cluster with all dependencies you can run:
```
    cd AKS_IaC
    terraform plan -out=tfplan
    terraform apply tfplan
```