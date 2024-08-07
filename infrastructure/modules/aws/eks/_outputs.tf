output "custer_endpoint" {
  description = "EKS Kubernetes API endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_ca_certificate" {
  description = "EKS Kubernetes API CA certificate"
  value       = module.eks.cluster_certificate_authority_data
}

output "sops_irsa_arn" {
  description = "IAM role ARN for SOPS KMS"
  value       = module.sops_kms_irsa.iam_role_arn
}

output "db_irsa_arns" {
  description = "IAM role ARNs for database connections"
  value       = { for key, val in module.dbconnect_irsa : key => val.iam_role_arn }
}
