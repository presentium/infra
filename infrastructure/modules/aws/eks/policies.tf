################################################################################
# SOPS policy
################################################################################

data "aws_iam_policy_document" "sops" {
  statement {
    sid    = "AllowKeyUsage"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "sops_policy" {
  name_prefix = "${module.eks.cluster_name}-sops-policy-"
  description = "Provides permissions to use KMS for SOPS"
  policy      = data.aws_iam_policy_document.sops.json
}

################################################################################
# DB Policy
################################################################################

data "aws_iam_policy_document" "rds" {
  for_each = local.database_users

  statement {
    sid    = "AllowRDSAccess"
    effect = "Allow"
    actions = [
      "rds-db:connect",
    ]
    resources = [
      "arn:aws:rds-db:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:dbuser:${var.rds_cluster_resource_id}/${each.value["username"]}",
    ]
  }
}

resource "aws_iam_policy" "rds_policy" {
  for_each = local.database_users

  name_prefix = "${module.eks.cluster_name}-rds-policy-${each.key}-"
  description = "Provides permissions to connect to RDS"
  policy      = data.aws_iam_policy_document.rds[each.key].json
}

################################################################################
# VAULT policy
################################################################################

data "aws_iam_policy_document" "vault" {
  statement {
    sid    = "AllowKeyUsage"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:DescribeKey"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "vault_policy" {
  name_prefix = "${module.eks.cluster_name}-vault-policy-"
  description = "Provides permissions to use KMS for Vault"
  policy      = data.aws_iam_policy_document.vault.json
}