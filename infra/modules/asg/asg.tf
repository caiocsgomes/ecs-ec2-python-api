resource "aws_autoscaling_group" "asg" {
  name                 = "asg-${var.project_name}"
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  desired_capacity     = var.asg_desired_capacity
  launch_configuration = aws_launch_configuration.lc.name
  vpc_zone_identifier  = var.subnets

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}


