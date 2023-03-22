resource "aws_iam_role" "task_execution_role" {
  name               = format("%s-%s-ecs_task_execution_role", var.cluster_name, var.ecs_service_name)
  assume_role_policy = file(format("%s/policies/ecs-task-role-trust.json", path.module))
}

resource "aws_iam_role_policy" "ecs_execution_role_policy" {
  name   = format("%s-%s-execution_role_policy", var.cluster_name, var.ecs_service_name)
  policy = file(format("%s/policies/task-execution-role.json", path.module))
  role   = aws_iam_role.task_execution_role.id
}

resource "aws_iam_role" "task_role" {
  name               = format("%s-%s-ecs_task_role", var.cluster_name, var.ecs_service_name)
  assume_role_policy = file(format("%s/policies/ecs-task-role-trust.json", path.module))
}

resource "aws_iam_role_policy" "task_role_policy" {
  name   = format("%s-%s-role_policy", var.cluster_name, var.ecs_service_name)
  policy = file(format("%s/policies/task-role.json", path.module))
  role   = aws_iam_role.task_role.id
}