
terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-rds.git//.?ref=v4.3.0"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "postgres_password" {
  config_path = "../postgres-password"
}

dependency "postgres_sg" {
  config_path = "../postgres-sg"
}

inputs = {
  identifier = "interview-chainlink"

  engine            = "postgres"
  engine_version    = "12.8"
  instance_class    = "db.t2.small"
  allocated_storage = 5
  storage_encrypted = false
  multi_az          = false
  

  name     = "interview-chainlink"
  username = "postgres"

  password = dependency.postgres_password.outputs.password
  port     = 5432

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  backup_retention_period = 0

  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  vpc_security_group_ids    = [dependency.postgres_sg.outputs.security_group_id]
  db_subnet_group_name      = dependency.vpc.outputs.database_subnet_group
  family                    = "postgres12"
  major_engine_version      = "12"
  final_snapshot_identifier = "interview-chainlink"
  deletion_protection       = false
}
