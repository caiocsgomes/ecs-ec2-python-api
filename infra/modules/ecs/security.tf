resource "aws_security_group" "service_sg" {
  name        = format("%s-%s-sg", var.cluster_name, var.ecs_service_name)
  description = format("%s-%s", var.cluster_name, var.ecs_service_name)

  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = format("%s-%s-sg", var.cluster_name, var.ecs_service_name)
  }
}

resource "aws_security_group_rule" "allowed_sgs" {
  count                    = length(var.allowed_sg_connection)
  type                     = "ingress"
  from_port                = var.task_container_port
  to_port                  = var.task_container_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.service_sg.id
  source_security_group_id = var.allowed_sg_connection[count.index]
}
