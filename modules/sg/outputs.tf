
output "sg_id" {
	value = aws_security_group.this_sg.id
}

output "ec2_sg_id" {
  value = aws_security_group.this_sg.id
}
output "vpc_id" {
  value = var.vpc_id
  description = "The VPC ID passed to the security group module"
}