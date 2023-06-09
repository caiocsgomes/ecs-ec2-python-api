resource "aws_lb_listener_rule" "service" {
  listener_arn = var.cluster_listener

  action {
    type             = "forward"
    target_group_arn = var.tg_arn
  }

  condition {
    path_pattern {
      values = [var.ecs_service_path]
    }
  }
}
