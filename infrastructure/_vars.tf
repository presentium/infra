variable "aws_region" {
  description = "AWS region to deploy the resources"
}

variable "aws_arn" {
  description = "AWS ARN on which to assume the role"
}

variable "cloudflare_api_key" {
  description = "Cloudflare management API key"
  sensitive   = true
}

variable "argocd_github_oauth_client_id" {
  description = "GitHub OAuth client ID for ArgoCD Login"
  sensitive   = true
}

variable "argocd_github_oauth_client_secret" {
  description = "GitHub OAuth client secret for ArgoCD Login"
  sensitive   = true
}
