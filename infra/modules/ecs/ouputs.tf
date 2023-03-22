output "cluster_arn" {
  value = aws_ecs_cluster.ecs_cluster.arn
}

output "service_sg" {
  value = aws_security_group.service_sg.id
}
