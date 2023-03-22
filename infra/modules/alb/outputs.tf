output "listener_arn" {
  value = aws_lb_listener.listener.arn
}

output "alb_sg" {
  value = aws_security_group.alb_security_group.id
}
