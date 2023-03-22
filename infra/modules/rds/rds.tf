resource "aws_db_instance" "database" {
  allocated_storage   = var.memory_size
  engine              = var.engine
  engine_version      = var.engine_version
  instance_class      = var.db_instance_class
  db_name             = var.db_name
  identifier          = format("%s-instance", var.db_name)
  username            = var.db_username
  password            = random_password.password.result
  skip_final_snapshot = true
  backup_window       = var.backup_window
  storage_type        = var.storage_type
  vpc_security_group_ids = [
    aws_security_group.db_sg.id,
  ]
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
  publicly_accessible = true
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = var.subnet_ids
}

