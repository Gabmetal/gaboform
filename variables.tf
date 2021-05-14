variable "AWS_DEFAULT_REGION" {
  default = "us-east-2"
  description = "region"
}
variable "AWS_ACCESS_KEY_ID" {
  description = "access key AWS"
}
variable "AWS_SECRET_ACCESS_KEY" {
  description = "secret key AWS"
}

#### NIC VARIABLES ####
variable "subnet_id" {
    type        = string
    description = "Id de subnet donde crear la NIC"
}

variable "private_ips" {
    type        = list(string)
    description = "Lista de ip privadas a asignar a la NIC"
}

variable "security_groups_id" {
    type        = list(string)
    description = "Lista de security groups"
}

#### INSTANCE VARIABLES ####
variable "ami" {
    type        = string
    description = "AMI ID"
    default     = "ami-09e67e426f25ce0d7"
}

variable "instance_type" {
    type        = string
    description = "AWC EC2 Instance type"
    default     = "t2.medium"
}

variable "host_user" {
    type        = string
    description = "Username to connect to the host"
}

# variable "host_password" {
#     type = string
#     description = "Password to connect to the host"
# }

variable "key_pair_name" {
    type = string
    description = "Nombre de la key a asociar"
}

variable "secret_key" {
    type = string
    description = "path to PEM"
}