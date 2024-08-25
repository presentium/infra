output "smtp_users" {
  value = {
    for key, val in aws_iam_access_key.smtp_user : key => {
      username = val.id
      password = val.encrypted_secret
    }
  }
}
