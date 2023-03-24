resource "aws_autoscaling_group" "asg" {
  name                 = "asg-${var.project_name}"
  max_size             = "${var.asg_max_size}"
  min_size             = "${var.asg_min_size}"
  desired_capacity     = "${var.asg_desired_capacity}"
  launch_configuration = "${aws_launch_configuration.lc.name}"


  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}


resource "aws_launch_configuration" "lc" {
  name_prefix          = "lc-${var.project_name}"
  image_id             = data.aws_ssm_parameter.ecs_ami.value
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs_instance_profile.name}"
  security_groups      = ["${aws_security_group.service_sg.name}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecs_instance_profile"
  role = "${aws_iam_role.task_execution_role.name}"
}

data "aws_ssm_parameter" "ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux/recommended"
}