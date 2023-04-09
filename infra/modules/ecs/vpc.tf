resource "aws_vpc_endpoint" "ecs_endpoint" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ecs"
  security_group_ids  = [aws_security_group.ecs_endpoint_sg.id]
  private_dns_enabled = true
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnets
}
