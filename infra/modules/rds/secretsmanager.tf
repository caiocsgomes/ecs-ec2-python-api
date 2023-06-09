resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "password" {
  name                    = format("%s-db-password", var.db_name)
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "password" {
  secret_id     = aws_secretsmanager_secret.password.id
  secret_string = random_password.password.result
}

resource "aws_secretsmanager_secret" "username" {
  name                    = format("%s-db-username", var.db_name)
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "username" {
  secret_id     = aws_secretsmanager_secret.username.id
  secret_string = var.db_username
}
