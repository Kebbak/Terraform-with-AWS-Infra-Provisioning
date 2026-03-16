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
    dynamic "ingress" {
      for_each = var.lb_sg_id != null ? [var.lb_sg_id] : []
      content {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        security_groups = [aws_security_group.lb_sg.id] # allow HTTP traffic from the load balancer security group
        description     = "Allow HTTP from LB security group"
      }
    }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}