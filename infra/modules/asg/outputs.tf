output "asg_arn" {
  value = aws_autoscaling_group.asg.arn
}

output "tg_arn" {
  value = aws_alb_target_group.tg.arn
}

