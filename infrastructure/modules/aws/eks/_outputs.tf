output "custer_endpoint" {
  description = "EKS Kubernetes API endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_ca_certificate" {
  description = "EKS Kubernetes API CA certificate"
  value       = module.eks.cluster_certificate_authority_data
}

output "cluster_token" {
  description = "EKS Kubernetes API token"
  value       = data.aws_eks_cluster_auth.this.token
  sensitive   = true
}
