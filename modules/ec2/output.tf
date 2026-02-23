output "instance_id" {
  value = aws_instance.my_instance[0].id
  description = "The ID of the EC2 instance"
}

output "vpc_id" {
  value = var.vpc_id
  description = "The VPC ID passed to the EC2 module"
}