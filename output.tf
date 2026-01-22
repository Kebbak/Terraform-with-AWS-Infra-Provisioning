output "vpc_id" {
    value = module.vpc.vpc_id
}

output "public_subnet_id" {
    value = module.vpc.public_subnet_id
}
output "private_app_subnet_id" {
    value = module.vpc.private_app_subnet_id
}
output "private_db_subnet_id" {
    value = module.vpc.private_db_subnet_id
}
output "alb_dns_name" { 
    value = module.alb.alb_dns_name
}
output "app_instance_id" { 
    value = module.ec2.instance_id
}
output "db_instance_id" { 
    value = module.db.instance_id
}