variable "domain" {
  description = "Domain covered by the PKI"
  default     = "presentium.ch"
}

variable "organization" {
  description = "Organization Name"
  default     = "Presentium"
}
variable "country" {
  description = "Country Code"
  default     = "CH"
}

variable "oidc_client_id" {
  description = "Github OIDC Client ID"
}
variable "oidc_client_secret" {
  description = "Github OIDC Client Secret"
}