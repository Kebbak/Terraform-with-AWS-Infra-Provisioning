module "network" {
  source       = "./modules/network"
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  az_count     = var.az_count
}

module "security_groups" {
  source                        = "./modules/security_groups"
  vpc_id                        = module.network.vpc_id
  allowed_alb_ingress_cidrs     = var.allowed_alb_ingress_cidrs
  egress_allowed_cidrs          = var.egress_allowed_cidrs
}

module "ec2_app" {
  source                  = "./modules/ec2_app"
  project_name            = var.project_name
  subnet_id               = module.network.private_app_subnet_ids[0]
  security_group_id       = module.security_groups.sg_app_id
  instance_type           = var.instance_type_app
  public_key_path         = var.public_key_path
  vpc_id                  = module.network.vpc_id
}

module "ec2_db" {
  source            = "./modules/ec2_db"
  project_name      = var.project_name
  subnet_id         = module.network.private_db_subnet_ids[0]
  security_group_id = module.security_groups.sg_db_id
  instance_type     = var.instance_type_db
}

module "alb" {
  source                 = "./modules/alb"
  project_name           = var.project_name
  vpc_id                 = module.network.vpc_id
  subnet_ids             = module.network.public_subnet_ids
  security_group_id      = module.security_groups.sg_alb_id
  target_instance_id     = module.ec2_app.instance_id
  acm_certificate_arn    = var.acm_certificate_arn
}

module "rds" {
  count                 = var.create_rds ? 1 : 0
  source                = "./modules/rds"
  project_name          = var.project_name
  subnet_ids            = module.network.private_db_subnet_ids
  security_group_id     = module.security_groups.sg_db_id
  db_username           = var.db_username
  db_password           = var.db_password
}
