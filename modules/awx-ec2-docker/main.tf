resource "aws_instance" "main" {
    ami           = var.ami
    instance_type = var.instance_type

    network_interface {
        network_interface_id = var.nic_id
        device_index         = 0
    }

    credit_specification {
        cpu_credits = "unlimited"
    }

    provisioner "remote-exec" {
        inline = [
            "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
            "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu$(lsb_release -cs) stable\"",
            "sudo apt update",
            "sudo apt install -y docker-ce docker-ce-cli containerd.io",
            "sudo usermod -aG docker $USER",
            "sudo systemctl restart docker",
            "sudo curl -L \"https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/local/bin/docker-compose",
            "sudo chmod +x /usr/local/bin/docker-compose"
        ]
        connection {
            host     = var.host_ip
            type     = "ssh"
            user     = var.host_user
            password = var.host_password
        }
    }
}