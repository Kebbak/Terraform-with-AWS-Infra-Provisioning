resource "aws_security_group" "alb" {
  name        = "alb-sg"
  description = "ALB SG"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS from allowlist"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_alb_ingress_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ALB health checks to targets"
  }
}
# Allow App SG to receive traffic from ALB SG on port 80
resource "aws_security_group" "app" {
  name        = "app-sg"
  description = "App EC2 SG"
  vpc_id      = var.vpc_id

  # Inbound only from ALB on HTTP 80 (target group)
  ingress {
    description      = "HTTP from ALB"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb.id]
  }

  # Outbound restricted to HTTPS to allowed CIDRs and MySQL to DB SG
  egress {
    description = "HTTPS to allowed external endpoints"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.egress_allowed_cidrs
  }
}

resource "aws_security_group_rule" "app_to_db" {
  type                     = "egress"
  security_group_id        = aws_security_group.app.id
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.db.id
  description              = "MySQL to DB"
}

resource "aws_security_group" "db" {
  name        = "db-sg"
  description = "DB EC2 SG"
  vpc_id      = var.vpc_id

  ingress {
    description      = "MySQL from App"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.app.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Default egress (can be restricted further if needed)"
  }
}
