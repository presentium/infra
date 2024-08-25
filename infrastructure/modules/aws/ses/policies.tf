data "aws_iam_policy_document" "ses_sender" {
  statement {
    sid       = "AllowSendingMail"
    effect    = "Allow"
    actions   = ["ses:SendRawEmail"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ses_sender" {
  name        = "PRES-SES-SENDERPOLICY"
  description = "Allows sending emails through SES"
  policy      = data.aws_iam_policy_document.ses_sender.json
}
