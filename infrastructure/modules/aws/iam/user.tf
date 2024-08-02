resource "aws_iam_user" "user" {
  for_each = local.users
  name     = each.key

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_user_login_profile" "login" {
  for_each = local.users
  user     = aws_iam_user.user[each.key].name
  pgp_key  = each.value
}

resource "aws_iam_user_policy_attachment" "test-attach" {
  for_each   = local.users
  user       = aws_iam_user.user[each.key].name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
