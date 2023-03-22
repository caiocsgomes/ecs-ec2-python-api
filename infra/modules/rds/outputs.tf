output "rds_secrets_manager_password_id" {
  value = aws_secretsmanager_secret.password.id
}

output "rds_secrets_manager_username_id" {
  value = aws_secretsmanager_secret.username.id
}

output "db_host" {
  value = aws_db_instance.database.address
}

output "db_name" {
  value = aws_db_instance.database.name
}