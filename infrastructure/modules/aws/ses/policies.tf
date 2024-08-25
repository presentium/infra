data "aws_iam_policy_document" "ses_sender" {
  statement {
    sid       = "AllowSendingMail"
    effect    = "Allow"
    actions   = ["ses:SendRawEmail"]
    resources = [aws_sesv2_email_identity.domain.arn]
  }
}
