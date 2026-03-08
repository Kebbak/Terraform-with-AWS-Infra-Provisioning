variable "lb_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "subnet_ids" {
    description = "List of subnet IDs for the load balancer"
    type        = list(string)
}

# variable "lb_sg" {
#     description = "Security group ID for the load balancer"
#     type        = string
# }

variable "vpc_id" {
    description = "VPC ID for the load balancer"
    type        = string
}

variable "lb_sg_id" {
  description = "ID of the load balancer security group to allow traffic from."
  type        = string
  default     = null
}