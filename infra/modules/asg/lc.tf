resource "aws_launch_configuration" "lc" {
  name_prefix                 = "lc-${var.project_name}"
  image_id                    = data.aws_ami.ecs_ami.id
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.ecs_instance_profile.name
  security_groups             = ["${aws_security_group.ec2_sg.id}"]
  associate_public_ip_address = true
  key_name                    = "default-caiocsgomes-account-key"
  user_data                   = <<-EOF
              #!/bin/bash
              echo ECS_CLUSTER=${var.cluster_name} > /etc/ecs/ecs.config
              EOF
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecs_instance_profile"
  role = aws_iam_role.ec2_role.name
}

