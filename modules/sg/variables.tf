variable "lb_sg_id" {
    description = "ID of the load balancer security group to allow traffic from."
    type        = string
    default     = null
}
variable "vpc_id" {
    type = string
    description = "The ID of the VPC"
}
