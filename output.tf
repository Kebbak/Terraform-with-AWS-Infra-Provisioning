output "vpc_id" {
  value = module.vpc.vpc_id
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

# output "kafka_topic_name" {
#   value = module.pub_sub.topic_name
# }