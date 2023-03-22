resource "aws_security_group" "db_sg" {
  name        = "${var.db_name}-db-sg"
  description = "Security group for ${var.db_name} database"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "allowed_sgs" {
  count                    = length(var.allowed_sg_connection)
  type                     = "ingress"
  from_port                = var.default_port
  to_port                  = var.default_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.db_sg.id
  source_security_group_id = var.allowed_sg_connection[count.index]
}
