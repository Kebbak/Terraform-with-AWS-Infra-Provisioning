variable "project_name" {
  type = string
}
variable "vpc_cidr" {
  type = string
}
variable "az_count" {
  type = number
}

variable "key_name" {
  type = string
}

variable "instance_type" {
  type = string
}
variable "instance_type_db" {
  type = string
}

variable "eks_cluster_name" {
  type = string
}

variable "node_group_desired_size" {
  type = number
}

variable "node_group_max_size" {
  type = number
}

variable "node_group_min_size" {
  type = number
}

variable "ec2_ami" {
  type        = string
  description = "The AMI ID to use for the EC2 instance."
}

variable "db_engine_version" {
  type        = string
  description = "The version of the database engine"
}

variable "admin_username" {
  type        = string
  description = "The admin username for the database"
}

variable "password" {
  type        = string
  description = "The password for the database"
}