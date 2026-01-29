module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  az_count     = var.az_count
}

module "security_groups" {
  source                    = "./modules/security-groups"
  vpc_id                    = module.vpc.vpc_id
  allowed_alb_ingress_cidrs = var.allowed_alb_ingress_cidrs
  egress_allowed_cidrs      = var.egress_allowed_cidrs
}

module "ec2" {
  source            = "./modules/ec2"
  project_name      = var.project_name
  subnet_id         = module.vpc.private1_subnet_id
  security_group_id = module.security_groups.sg_app_id
  instance_type     = var.instance_type_app
  key_name          = var.key_name
  vpc_id            = module.vpc.vpc_id
}

module "db" {
  source            = "./modules/db"
  project_name      = var.project_name
  subnet_id         = module.vpc.private2_subnet_id
  security_group_id = module.security_groups.sg_db_id
  instance_type     = var.instance_type_db
}

# module "acm" {
#   source                        = "./modules/acm"
#   domain_name                   = var.domain_name
#   subject_alternative_names     = var.subject_alternative_names
#   route53_zone_id               = var.route53_zone_id
# }

module "alb" {
  source              = "./modules/alb"
  project_name        = var.project_name
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.public_subnet_ids
  security_group_id   = module.security_groups.sg_alb_id
  target_instance_id  = module.ec2.instance_id
  acm_certificate_arn = var.acm_certificate_arn
}

# module "pub_sub" {
#   source                         = "./modules/Pub-Sub"
#   kafka_topic_name               = var.kafka_topic_name
#   kafka_topic_partitions         = var.kafka_topic_partitions
#   kafka_topic_replication_factor = var.kafka_topic_replication_factor
#   kafka_producer_user            = var.kafka_producer_user
# }

## for testing purposes only
# To use S3 for Terraform state storage make sure  to create the s3 bucket before applying this configuration
# module "s3" {
#   source      = "./modules/s3"
#   bucket_name = "${var.project_name}-tfstate-bucket"
#   environment = var.project_name
# }