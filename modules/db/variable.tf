variable "project_name" { 
type = string 
description = "The name of the project"
}
variable "subnet_ids" {
  type = list(string)
  description = "List of private subnet IDs in different AZs for RDS. Must cover at least 2 AZs."
}
variable "security_group_id" { 
type = string
description = "The ID of the security group"
}
variable "instance_type_db" {
  type = string
  description = "The type of the database instance"
}

variable "db_engine_version" {
type = string
description = "The version of the database engine"
}

variable "admin_username" {
type = string
description = "The admin username for the database"
}

variable "password" {
type = string   
description = "The password for the database"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type = string
}
