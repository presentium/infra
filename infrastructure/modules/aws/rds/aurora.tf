data "aws_rds_engine_version" "postgresql" {
  engine  = "aurora-postgresql"
  version = "16"
}

module "database" {
  source = "terraform-aws-modules/rds-aurora/aws"

  name          = var.database_name
  database_name = var.database_name

  engine         = data.aws_rds_engine_version.postgresql.engine
  engine_mode    = "serverless"
  engine_version = data.aws_rds_engine_version.postgresql.version

  master_username = "admin"

  iam_database_authentication_enabled = true

  vpc_id               = var.vpc_id
  db_subnet_group_name = var.vpc_database_subnet_group_name
  security_group_rules = {
    vpc_ingress = {
      cidr_blocks = var.vpc_private_cidr_blocks
    }
  }

  storage_encrypted = true

  serverlessv2_scaling_configuration = {
    min_capacity = 1
    max_capacity = 1
  }

  instance_class      = "db.serverless"
  publicly_accessible = false
  instances = {
    one = {}
  }

  apply_immediately   = true
  skip_final_snapshot = true
  deletion_protection = true

  engine_lifecycle_support = "open-source-rds-extended-support-disabled"
}
