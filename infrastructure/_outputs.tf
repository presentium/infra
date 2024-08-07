output "iam_users" {
  description = "IAM users for the Presentium core team (passwords are encrypted using their PGP keys)"
  value       = module.iam.iam_users
}

output "eks_sops_kms_role_arn" {
  description = "IAM role ARN for SOPS KMS to add in Kubernetes service accounts"
  value       = module.eks.sops_irsa_arn
}

output "eks_db_irsa_arns" {
  description = "IAM role ARNs for database connections"
  value       = module.eks.db_irsa_arns
}
