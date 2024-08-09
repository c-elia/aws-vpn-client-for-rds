resource "aws_db_instance" "database" {
  allocated_storage               = var.database["allocated_storage"]
  max_allocated_storage           = var.database["max_allocated_storage"]
  engine                          = "postgres"
  engine_version                  = var.database["engine_version"]
  instance_class                  = var.database["instance_class"]
  identifier                      = var.database["name"]
  storage_type                    = var.database["storage_type"]
  multi_az                        = var.database["multi_az"]
  publicly_accessible             = false
  vpc_security_group_ids          = [aws_security_group.rds.id]
  db_subnet_group_name            = aws_db_subnet_group.subnet_group.name
  backup_retention_period         = var.database["backup_retention_period"]
  storage_encrypted               = true
  apply_immediately               = true
  allow_major_version_upgrade     = true
  performance_insights_enabled    = true
  delete_automated_backups        = false
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  parameter_group_name            = aws_db_parameter_group.parameter_group.name
  deletion_protection             = false
  skip_final_snapshot             = true
  username                        = jsondecode(data.aws_secretsmanager_secret_version.database_credentials_db_lambda_upload_test.secret_string)["username"]
  password                        = jsondecode(data.aws_secretsmanager_secret_version.database_credentials_db_lambda_upload_test.secret_string)["password"]


  tags = {
    Name = "${var.project}-postgres-db"
  }
}


resource "aws_db_parameter_group" "parameter_group" {
  name   = "rds-parameter-group"
  family = var.database["family"]

  parameter {
    name  = "log_min_duration_statement"
    value = var.database["log_min_duration_statement"]
  }

  parameter {
    name  = "log_duration"
    value = var.database["log_duration"]
  }

  parameter {
    name  = "rds.log_retention_period"
    value = var.database["rds_log_retention_period"]
  }

  tags = {
    Name = "${var.project}-rds-parameter-group"
  }
}
