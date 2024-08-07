output "iam_users" {
  value = { for key, val in aws_iam_user_login_profile.login : key => val.encrypted_password }
}

output "eks_admin_role_arn" {
  value = aws_iam_role.eks_admin.arn
}
