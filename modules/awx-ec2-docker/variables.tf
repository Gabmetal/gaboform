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

variable "nic_id" {
    type        = string
    description = "Network interface's id to be attached"
}

variable "host_ip" {
    type        = string
    description = "host Public IP Address"
}

variable "host_user" {
    type        = string
    description = "Username to connect to the host"
}

variable "host_password" {
    type = string
    description = "Password to connect to the host"
}