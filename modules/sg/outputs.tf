
output "sg_id" {
	value = aws_security_group.this_sg.id
}

output "ec2_sg_id" {
  value = aws_security_group.this_sg.id
}