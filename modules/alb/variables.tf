variable "project_name" { 
type = string
description = "The name of the project"
}

variable "vpc_id" { 
type = string
description = "The ID of the VPC"

}
variable "subnet_ids"   { 
type = list(string) 
description = "The IDs of the subnets"
}
variable "security_group_id" { 
type = string
description = "The ID of the security group"
}
variable "target_instance_id" { 
type = string
description = "The ID of the target instance"
}
variable "acm_certificate_arn" { 
type = string
description = "The ARN of the ACM certificate"
}