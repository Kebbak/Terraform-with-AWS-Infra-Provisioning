
variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster and node group"
  type        = list(string)
}
variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "node_group_desired_size" {
  description = "Desired number of nodes in the EKS node group"
  type        = number
}

variable "node_group_max_size" {
  description = "Maximum number of nodes in the EKS node group"
  type        = number
}

variable "node_group_min_size" {
  description = "Minimum number of nodes in the EKS node group"
  type        = number
}

