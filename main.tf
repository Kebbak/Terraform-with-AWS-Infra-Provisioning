module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  az_count     = var.az_count
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source            = "./modules/ec2"
  ec2_ami           = var.ec2_ami
  instance_type     = var.instance_type
  key_name          = var.key_name
  security_group_id = module.sg.sg_id
  vpc_id            = module.vpc.vpc_id
  subnet_id         = module.vpc.public1_subnet_id
}

# module "db" {
#   source = "./modules/db"
#   project_name       = var.project_name
#   instance_type_db   = var.instance_type_db
#   admin_username     = var.admin_username
#   password           = var.password
#   db_engine_version  = var.db_engine_version
#   subnet_id          = module.vpc.private1_subnet_id
#   security_group_id  = module.sg.sg_id
#   vpc_id             = module.vpc.vpc_id
#   ec2_security_group_id = module.sg.ec2_sg_id
# }

# module "eks" {
#   source = "./modules/eks"
#   cluster_name = var.eks_cluster_name
#   subnet_ids = module.vpc.public_subnet_ids
#   vpc_id = module.vpc.vpc_id
#   node_group_desired_size = var.node_group_desired_size
#   node_group_max_size = var.node_group_max_size
#   node_group_min_size = var.node_group_min_size
# }


# module "s3" {
#   source = "./modules/s3"
#   bucket_name = var.bucket_name
# }