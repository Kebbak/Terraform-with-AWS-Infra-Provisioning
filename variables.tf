variable "project_name" {
  type = string
}
variable "aws_region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}
variable "az_count" {
  type = number
}

variable "allowed_alb_ingress_cidrs" {
  type = list(string)
}

variable "egress_allowed_cidrs" {
  type = list(string)
}

variable "key_name" {
  type = string
}

variable "instance_type_app" {
  type = string
}
variable "instance_type_db" {
  type = string
}

variable "create_rds" {
  type = bool
}

variable "db_username" {
  type = string
}
variable "db_password" {
  type = string
  sensitive = true
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