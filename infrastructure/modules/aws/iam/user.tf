resource "aws_iam_user" "user" {
  for_each = local.users
  name     = each.key
}

resource "aws_iam_user_login_profile" "login" {
  for_each = local.users
  user     = aws_iam_user.user[each.key].name
  pgp_key  = each.value
}

resource "aws_iam_user_policy_attachment" "attach_admin" {
  for_each   = local.users
  user       = aws_iam_user.user[each.key].name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    sid     = "AllowAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = [for user in keys(local.users) : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${user}"]
      type        = "AWS"
    }
  }
}

resource "aws_iam_role" "eks_admin" {
  name               = "PRES-EKS-ADMIN"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}
