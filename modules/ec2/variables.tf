variable "project_name" { 
type = string 
description = "The name of the project"
}
variable "subnet_id" { 
type = string
description = "The ID of the subnet"
}
variable "security_group_id" { 
type = string
description = "The ID of the security group"
}
variable "instance_type" { 
type = string
description = "The type of the instance"
}
variable "public_key_path" { 
type = string
default = null 
description = "The path to the public key"
}
variable "vpc_id" { 
type = string
description = "The ID of the VPC"
}