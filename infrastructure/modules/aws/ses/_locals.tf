locals {
  email_identity = "info@presentium.ch"
  email_domain   = "presentium.ch"

  dkim_key = "presentium-ses"

  smtp_users = ["authentik"]

  access_key_signing_key = "keybase:lutonite"
}
