################################################################################
# SOPS policy
################################################################################

data "aws_iam_policy_document" "sops" {
  statement {
    sid    = "Allow use of the key"
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
    sid    = "Allow RDS access"
    effect = "Allow"
    actions = [
      "rds-db:connect",
    ]
    resources = [
      "arn:aws:rds-db:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:dbuser:${var.rds_database_name}/${each.value["username"]}",
    ]
  }
}

resource "aws_iam_policy" "rds_policy" {
  for_each = local.database_users

  name_prefix = "${module.eks.cluster_name}-rds-policy-${each.key}-"
  description = "Provides permissions to connect to RDS"
  policy      = data.aws_iam_policy_document.rds[each.key].json
}
