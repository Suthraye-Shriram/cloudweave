output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_name" {
  description = "EKS cluster name."
  value       = aws_eks_cluster.main.name
}

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS cluster."
  value       = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id # Accessing the first element of the list
}

output "node_group_role_arn" {
  description = "IAM role ARN for the EKS node group."
  value       = aws_iam_role.eks_node_role.arn
}

output "region" {
  description = "AWS region where the cluster is deployed."
  value       = var.aws_region
}