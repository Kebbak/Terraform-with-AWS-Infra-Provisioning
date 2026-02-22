project_name              = "devops-poc"
vpc_cidr                  = "10.0.0.0/16"
az_count                  = 2
aws_region                = "us-east-1"
key_name                  = "Development"
eks_cluster_name           = "devops-poc-eks-cluster"
node_group_desired_size    = 2
node_group_max_size        = 3
node_group_min_size        = 1
ec2_ami                    = "ami-0f3caa1cf4417e51b"
db_engine_version          = "8.0"
instance_type_db           = "db.t2.micro"
admin_username             = "app"
password                   = "ChangeMe123!"
instance_type              = "t2.micro"

