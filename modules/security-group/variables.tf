variable "vpc_id" { type = string }
variable "allowed_alb_ingress_cidrs" { type = list(string) }
variable "egress_allowed_cidrs" { type = list(string) }
