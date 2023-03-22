resource "aws_ecs_service" "service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.ecs_cluster.arn
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = 2

  load_balancer {
    target_group_arn = aws_alb_target_group.tg.arn
    container_name   = var.task_name
    container_port   = var.task_container_port
  }

  network_configuration {
    security_groups  = [aws_security_group.service_sg.id]
    subnets          = var.subnets
    assign_public_ip = true
  }
}
