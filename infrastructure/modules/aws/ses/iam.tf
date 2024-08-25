resource "aws_iam_user" "smtp_user" {
  for_each = toset(local.smtp_users)
  name     = "ses-smtp-user.${each.value}"
}

resource "aws_iam_access_key" "smtp_user" {
  for_each = aws_iam_user.smtp_user

  user    = each.value.name
  pgp_key = local.access_key_signing_key
}

resource "aws_iam_user_policy_attachment" "smtp_user__ses_sender" {
  for_each = aws_iam_user.smtp_user

  user       = each.value.name
  policy_arn = aws_iam_policy.ses_sender.arn
}
