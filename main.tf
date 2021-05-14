module "network_card" {
    source             = "./modules/aws_network_interface"
    subnet_id          = var.subnet_id
    private_ips        = var.private_ips
    security_groups_id = var.security_groups_id
}

module "awx_docker_ec2" {
  source        = "./modules/awx-ec2-docker"
  nic_id        = module.network_card.output.id
  host_user     = var.host_user
  key_pair_name = var.key_pair_name
  secret_key    = var.secret_key
}