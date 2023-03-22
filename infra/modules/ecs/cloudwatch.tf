resource "aws_cloudwatch_log_group" "logs" {
  name = format("%s-%s", var.cluster_name, var.ecs_service_name)

  tags = {
    Application = var.ecs_service_name
  }
}
