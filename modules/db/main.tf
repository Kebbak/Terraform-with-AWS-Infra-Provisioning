data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

locals {
  user_data = <<-EOF
              #!/bin/bash
              set -euxo pipefail
              export DEBIAN_FRONTEND=noninteractive
              apt-get update -y
              apt-get install -y mysql-server
              sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf || true
              systemctl enable mysql
              systemctl restart mysql
              # Create demo DB and user
              mysql -e "CREATE DATABASE IF NOT EXISTS appdb;"
              mysql -e "CREATE USER IF NOT EXISTS 'appuser'@'%' IDENTIFIED BY 'ChangeMe123!';"
              mysql -e "GRANT ALL PRIVILEGES ON appdb.* TO 'appuser'@'%'; FLUSH PRIVILEGES;"
              EOF
}

resource "aws_instance" "db" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = false
  user_data                   = local.user_data
  tags = { Name = "${var.project_name}-db" }
  root_block_device { volume_size = 20 }
}
