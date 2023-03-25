resource "aws_autoscaling_group" "asg" {
  name                 = "asg-${var.project_name}"
  max_size             = "${var.asg_max_size}"
  min_size             = "${var.asg_min_size}"
  desired_capacity     = "${var.asg_desired_capacity}"
  launch_configuration = "${aws_launch_configuration.lc.name}"
  availability_zones   = var.availability_zones

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}


resource "aws_launch_configuration" "lc" {
  depends_on           = [aws_security_group.service_sg]
  name_prefix          = "lc-${var.project_name}"
  image_id             = data.aws_ami.ecs_ami.id
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs_instance_profile.name}"
  security_groups      = ["${aws_security_group.service_sg.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecs_instance_profile"
  role = "${aws_iam_role.task_execution_role.name}"
}

data "aws_ami" "ecs_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-2018.03.*-ecs-optimized"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}