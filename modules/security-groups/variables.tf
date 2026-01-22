variable "vpc_id" { 
type = string ,
description = "The ID of the VPC"
}
variable "allowed_alb_ingress_cidrs" { 
    type = list(string) 
}
variable "egress_allowed_cidrs" { 
    type = list(string) 
    description = "The list of allowed CIDRs for egress traffic"
}