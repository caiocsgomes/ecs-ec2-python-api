resource "aws_alb_target_group" "tg" {
  name   = "${var.project_name}-tg"
  port   = var.task_container_port
  vpc_id = var.vpc_id

  protocol    = "HTTP"
  target_type = "instance"

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    path                = "/healthcheck"
    port                = var.task_container_port
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
  }
}
