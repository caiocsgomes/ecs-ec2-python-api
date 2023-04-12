data "template_file" "task" {
  template = file(format("%s/task-definitions/task.json", path.module))
  vars = {
    container_name             = var.task_name
    image                      = var.task_image
    task_cpu                   = var.task_cpu
    task_memory                = var.task_memory
    essential                  = true
    container_port             = var.task_port
    log_group                  = aws_cloudwatch_log_group.logs.name
    region                     = var.region
    env                        = var.env
    db_host                    = var.db_host
    db_name                    = var.db_name
    sm_db_user_secret_name     = var.sm_db_user_secret_name
    sm_db_password_secret_name = var.sm_db_password_secret_name
  }
}

resource "aws_ecs_task_definition" "ecs_task" {
  family                   = var.task_name
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  container_definitions    = data.template_file.task.rendered
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  task_role_arn            = aws_iam_role.task_role.arn
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}
