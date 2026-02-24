# create ec2 instances
resource "aws_instance" "my_instance" {
  ami                   = var.ec2_ami
  count                 = 2
  instance_type         = var.instance_type
  subnet_id             = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name
  iam_instance_profile   = aws_iam_instance_profile.my_instance_profile.name
  tags = {
    Name = "webserver"
  }

  user_data = templatefile("${path.module}/user_data.sh", {})
}

# create instance profile
resource "aws_iam_instance_profile" "my_instance_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.this_role.name
}

# create IAM role for EC2
resource "aws_iam_role" "this_role" {
  name = "ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# attach the IAM role to the instance profile
resource "aws_iam_role_policy_attachment" "my_role_attachment" {
  role       = aws_iam_role.this_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "ssm_core_attachment" {
  role       = aws_iam_role.this_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}