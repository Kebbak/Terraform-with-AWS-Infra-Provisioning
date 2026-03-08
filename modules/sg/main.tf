# create security group
resource "aws_security_group" "this_sg" {
  name        = "my-security-group"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = var.lb_sg_id != null ? [var.lb_sg_id] : []
    # Only allow from the LB security group
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}