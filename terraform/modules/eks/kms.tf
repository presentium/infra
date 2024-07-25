module "kms" {
  source                  = "terraform-aws-modules/kms/aws"
  deletion_window_in_days = 7
  description             = "KMS key for eks"
  enable_key_rotation     = true
  is_enabled              = true
  key_usage               = "ENCRYPT_DECRYPT"
  enable_default_policy   = true
}