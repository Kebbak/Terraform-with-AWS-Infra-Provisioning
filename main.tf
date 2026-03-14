# modules
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

# module "ec2" {
#   source            = "./modules/ec2"
#   ec2_ami           = var.ec2_ami
#   instance_type     = var.instance_type
#   key_name          = var.key_name
#   security_group_id = module.sg.sg_id
#   vpc_id            = module.vpc.vpc_id
#   subnet_id         = module.vpc.public1_subnet_id
#   target_group_arns = [module.lb.app_tg_arn]
# }

module "lambda" {
  source               = "./modules/lambda"
  subnet_id            = module.vpc.public1_subnet_id
  security_group_id    = module.sg.sg_id
  s3_bucket_name       = var.s3_bucket_name
  sns_topic_name       = "my-lambda-topic"
  lambda_function_name = var.lambda_function_name
  lambda_zip_path      = var.lambda_zip_path
  sns_email            = var.sns_email
}


# module "lb" {
#   source = "./modules/lb"
#   project_name = var.project_name
#   subnet_ids = module.vpc.public_subnet_ids
#   vpc_id = module.vpc.vpc_id
#   lb_name = var.lb_name
# }

# module "db" {
#   source = "./modules/db"
#   project_name       = var.project_name
#   instance_type_db   = var.instance_type_db
#   admin_username     = var.admin_username
#   password           = var.password
#   db_engine_version  = var.db_engine_version
#   subnet_ids         = [module.vpc.private1_subnet_id, module.vpc.private2_subnet_id]
#   security_group_id  = module.sg.sg_id
#   vpc_id             = module.vpc.vpc_id
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

