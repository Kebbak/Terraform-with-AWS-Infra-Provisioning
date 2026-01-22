variable "project_name" { 
    type = string 
    description = "The name of the project"
}
variable "vpc_cidr" { 
    type = string
    description = "The CIDR block for the VPC"

}
variable "az_count" { 
    type = number
    description = "The number of availability zones to use"
}