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


  # Restrict ALB egress to only HTTPS (443) to allowed CIDRs
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.egress_allowed_cidrs # allow from this specific list
    description = "HTTPS to allowed CIDRs (if needed)"
  }
}
# Allow App SG to receive incoming traffic from ALB SG on port 80 
resource "aws_security_group" "app" {
  name        = "app-sg"
  description = "App EC2 SG"
  vpc_id      = var.vpc_id

  ingress {
    description      = "HTTP from ALB"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb.id]
  }

  # Outbound restricted to HTTPS to allowed CIDRs (e.g., secureweb.com)
  egress {
    description = "HTTPS to allowed external endpoints (secureweb.com)"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.egress_allowed_cidrs # allow from this specific list
  }

  # Allow SSM Session Manager connectivity (outbound) ( Note for testing purposes only)
  egress {
    description = "SSM Session Manager"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Allow app to db communication on MySQL port 3306
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
