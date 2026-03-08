# create instance profile to allow EC2 to assume the IAM role
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

# attach the SSM policy to the IAM role
resource "aws_iam_role_policy_attachment" "ssm_core_attachment" {
  role       = aws_iam_role.this_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}