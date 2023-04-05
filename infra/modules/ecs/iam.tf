resource "aws_iam_role" "task_execution_role" {
  name               = "${var.project_name}_ecs_role"
  assume_role_policy = file("${path.module}/policies/ecs-task-role-trust.json")
}

resource "aws_iam_role_policy" "ecs_execution_role_policy" {
  name   = "${var.project_name}_ecs_role_policy"
  policy = file("${path.module}/policies/task-execution-role.json")
  role   = aws_iam_role.task_execution_role.id
}

resource "aws_iam_role" "task_role" {
  name               = "${var.project_name}_role"
  assume_role_policy = file("${path.module}/policies/ecs-task-role-trust.json")
}

resource "aws_iam_role_policy" "task_role_policy" {
  name   = "${var.project_name}_role_policy"
  policy = file("${path.module}/policies/task-role.json")
  role   = aws_iam_role.task_role.id
}

resource "aws_iam_role_policy_attachment" "attach-ecs-execution-role-policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role" "ec2_role" {
  name               = "${var.project_name}_ec2_role"
  assume_role_policy = file("${path.module}/policies/ec2-trust-policy.json")
}
