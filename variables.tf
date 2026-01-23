variable "project_name" {
  type = string
}
variable "aws_region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}
# Two AZs for POC
variable "az_count" {
  type = number
}

variable "allowed_alb_ingress_cidrs" {
  description = "List of CIDR blocks allowed to access the ALB on 443"
  type        = list(string)
}

variable "egress_allowed_cidrs" {
  description = "CIDRs that the App EC2 is allowed to reach over HTTPS (e.g., resolved IPs of example.com and secureweb.com)"
  type        = list(string)
}

variable "key_name" {
  type        = string
  description = "The name of the EC2 key pair to use."
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
  type      = string
  sensitive = true
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN for the ALB HTTPS listener"
  type        = string
}
