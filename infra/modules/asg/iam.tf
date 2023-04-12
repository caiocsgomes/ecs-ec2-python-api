resource "aws_iam_role_policy_attachment" "attach-ecs-execution-role-policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role" "ec2_role" {
  name               = "${var.project_name}_ec2_role"
  assume_role_policy = file("${path.module}/policies/ec2-trust-policy.json")
}
