resource "aws_sesv2_email_identity" "email" {
  email_identity = local.email_identity
}

resource "aws_sesv2_email_identity" "domain" {
  email_identity         = local.email_domain
  configuration_set_name = aws_sesv2_configuration_set.presentium.configuration_set_name
}

resource "aws_sesv2_configuration_set" "presentium" {
  configuration_set_name = "presentium"
}

resource "aws_sesv2_email_identity_mail_from_attributes" "presentium" {
  email_identity = aws_sesv2_email_identity.domain.email_identity

  behavior_on_mx_failure = "REJECT_MESSAGE"
  mail_from_domain       = "mail.${aws_sesv2_email_identity.domain.email_identity}"
}
