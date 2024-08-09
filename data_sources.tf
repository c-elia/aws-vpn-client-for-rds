data "aws_availability_zones" "zones" {
  state = "available"
}


data "aws_caller_identity" "current" {}



data "aws_secretsmanager_secret_version" "database_credentials_db_lambda_upload_test" {
  secret_id = "test-database-credentials-2"
}
