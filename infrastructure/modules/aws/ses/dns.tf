resource "cloudflare_record" "presentium_ses_dkim" {
  zone_id = data.cloudflare_zone.this.id
  name    = "${local.dkim_key}._domainkey"
  type    = "TXT"
  content = "v=DKIM1; p=${trimspace(var.dkim_public_key)}"
  ttl     = 60
  proxied = false

  allow_overwrite = true
}

resource "cloudflare_record" "ses_spf_mail_from" {
  zone_id = data.cloudflare_zone.this.id
  name    = aws_sesv2_email_identity_mail_from_attributes.presentium.mail_from_domain
  type    = "TXT"
  content = "v=spf1 include:amazonses.com ~all"
  ttl     = 60
  proxied = false

  allow_overwrite = true
}

resource "cloudflare_record" "ses_mx_send_mail_from" {
  zone_id  = data.cloudflare_zone.this.id
  name     = aws_sesv2_email_identity_mail_from_attributes.presentium.mail_from_domain
  type     = "MX"
  content  = "feedback-smtp.${data.aws_region.current.name}.amazonses.com"
  priority = 10
  ttl      = 60
  proxied  = false

  allow_overwrite = true
}
