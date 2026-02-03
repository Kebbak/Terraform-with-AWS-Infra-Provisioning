project_name              = "pci-poc"
vpc_cidr                  = "10.0.0.0/16"
az_count                  = 2
aws_region                = "us-east-1"
allowed_alb_ingress_cidrs = ["198.51.100.10/32", "203.0.113.0/24"] # Note these are just example IPS for the purpose of this demo
egress_allowed_cidrs      = ["93.184.216.34/32", "192.0.2.44/32"]  #Note these are just example IPS for the purpose of this demo
instance_type_app         = "t2.micro"
instance_type_db          = "t2.micro"
create_rds                = false
key_name                  = "Development"
db_username               = "app"
db_password               = "ChangeMe123!"
eks_cluster_name         = "pci-poc-eks-cluster"
node_group_desired_size  = 2
node_group_max_size      = 3
node_group_min_size      = 1

# kafka_topic_name               = "pci-poc-topic"
# kafka_topic_partitions         = 3
# kafka_topic_replication_factor = 2
# kafka_producer_user            = "pci-poc-producer"

