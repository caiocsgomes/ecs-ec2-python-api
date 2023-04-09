resource "aws_ecs_service" "service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.ecs_cluster.arn
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = 1

  load_balancer {
    target_group_arn = aws_alb_target_group.tg.arn
    container_name   = var.task_name
    container_port   = var.task_container_port
  }
}
