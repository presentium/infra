variable "github_oauth_client_id" {
  description = "GitHub OAuth client ID"
  sensitive   = true
}

variable "github_oauth_client_secret" {
  description = "GitHub OAuth client secret"
  sensitive   = true
}

variable "repo_server_role_arn" {
  description = "IRSA role ARN for the repo server service account"
}

variable "timeout_seconds" {
  description = "Timeout in seconds for the Kubernetes resources to be deployed"
  type        = number
  default     = 600
}
