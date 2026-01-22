# Optional key pair
resource "aws_key_pair" "this" {
  count      = var.public_key_path == null ? 0 : 1
  key_name   = "${var.project_name}-key"
  public_key = file(var.public_key_path)
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["137112412989"] # Amazon
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_iam_role" "ec2_role" {
  name               = "${var.project_name}-app-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.project_name}-app-instance-profile"
  role = aws_iam_role.ec2_role.name
}

locals {
  user_data = <<-EOF
              #!/bin/bash
              set -euxo pipefail
              # Example app provisioning. Replace example.com with internal repo for production.
              yum update -y
              # Simulate fetching a package from example.com (placeholder)
              curl -fsSL https://example.com/install.sh || true
              amazon-linux-extras enable nginx1
              yum clean metadata
              yum install -y nginx
              echo "OK" > /usr/share/nginx/html/index.html
              systemctl enable nginx
              systemctl start nginx
              EOF
}

resource "aws_instance" "app" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  iam_instance_profile        = aws_iam_instance_profile.this.name
  associate_public_ip_address = false
  key_name                    = var.public_key_path == null ? null : aws_key_pair.this[0].key_name
  user_data                   = local.user_data
  tags = { Name = "${var.project_name}-app" }
}
