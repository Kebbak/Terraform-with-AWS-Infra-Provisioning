# create outputs for eks module
output "eks_cluster_id" {
  description = "The ID of the EKS cluster"
  value       = aws_eks_cluster.eks.id
}

output "eks_node_group_id" {
  description = "The ID of the EKS node group"
  value       = aws_eks_node_group.eks-node.id
}