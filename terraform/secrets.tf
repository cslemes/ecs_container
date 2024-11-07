resource "aws_secretsmanager_secret" "mysql_secret" {
  name = "mysql_secret-${var.project_name}-${var.environment}"
}
