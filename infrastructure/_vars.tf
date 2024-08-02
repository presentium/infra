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
