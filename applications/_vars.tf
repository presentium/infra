variable "authentik_url" {
  description = "Authentik management URL"
}

variable "authentik_api_key" {
  description = "Authentik management API key"
  sensitive   = true
}
