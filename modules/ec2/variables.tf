variable "key_name" {
	type        = string
	description = "The name of the EC2 key pair to use."
}
variable "security_group_id" { 
type = string
description = "The ID of the security group"
}
variable "instance_type" { 
type = string
description = "The type of the instance"
}
variable "vpc_id" { 
type = string
description = "The ID of the VPC"
}

variable "ec2_ami" {
	type        = string
	description = "The AMI ID to use for the EC2 instance."
}