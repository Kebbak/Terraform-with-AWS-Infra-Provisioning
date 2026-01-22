variable "project_name" { type = string }
variable "subnet_id" { type = string }
variable "security_group_id" { type = string }
variable "instance_type" { type = string }
variable "public_key_path" { type = string, default = null }
variable "vpc_id" { type = string }
