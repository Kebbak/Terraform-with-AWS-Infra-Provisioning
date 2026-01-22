variable "project_name" { type = string  default = "pci-poc" }
variable "aws_region"   { type = string  default = "eu-central-1" }

variable "vpc_cidr" { type = string  default = "10.20.0.0/16" }
# Two AZs for POC
variable "az_count" { type = number default = 2 }

variable "allowed_alb_ingress_cidrs" {
  description = "List of CIDR blocks allowed to access the ALB on 443"
  type        = list(string)
  default     = ["203.0.113.0/24"]
}

variable "egress_allowed_cidrs" {
  description = "CIDRs that the App EC2 is allowed to reach over HTTPS (e.g., resolved IPs of example.com and secureweb.com)"
  type        = list(string)
  default     = ["93.184.216.34/32", "203.0.113.25/32"]
}

variable "public_key_path" {
  description = "Path to your SSH public key (optional)"
  type        = string
  default     = null
}

variable "instance_type_app" { type = string default = "t3.micro" }
variable "instance_type_db"  { type = string default = "t3.micro" }

variable "create_rds" { type = bool default = false }

variable "db_username" { type = string default = "appuser" }
variable "db_password" { type = string default = "ChangeMe123!" sensitive = true }

variable "acm_certificate_arn" {
  description = "ACM certificate ARN for the ALB HTTPS listener"
  type        = string
}
