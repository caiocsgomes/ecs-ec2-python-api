resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  configuration {
    execute_command_configuration {
      logging = "OVERRIDE"
      log_configuration {
        cloud_watch_log_group_name = aws_cloudwatch_log_group.ecs_cluster_logs.name
      }
    }
  }
}

# This defines the infrastructure for the ECS cluster.
resource "aws_ecs_cluster_capacity_providers" "cluster_capacity_providers" {
  cluster_name = aws_ecs_cluster.ecs_cluster.name

  capacity_providers = [aws_ecs_capacity_provider.capacity_provider.name]

  # The capacity provide strategy is used to define how the cluster will spread tasks across the capacity providers.
  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = aws_ecs_capacity_provider.capacity_provider.name
  }
}

resource "aws_ecs_capacity_provider" "capacity_provider" {
  name = "${var.project_name}-cp"

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.asg.arn
  }
}

resource "aws_cloudwatch_log_group" "ecs_cluster_logs" {
  name = "${var.cluster_name}-logs"

  tags = {
    Application = var.cluster_name
  }
}
