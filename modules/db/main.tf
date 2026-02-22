# create mysql db
resource "aws_db_instance" "mysql_db" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = var.db_engine_version
  instance_class       = var.instance_type_db
  username             = var.admin_username
  password             = var.password
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot   = true
}

# create security group for db
resource "aws_security_group" "db_sg" {
  name        = "${var.project_name}-db-sg"
  description = "Security group for RDS instance"
  vpc_id      = aws_vpc.custom_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["aws_security_group.this_sg.id"] # allow SSH from EC2 security group
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

