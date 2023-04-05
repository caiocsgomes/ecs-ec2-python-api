# ecs-ec2-python-api (in construction)

This repository has a template for code, infra and a simple pipeline for a Python API that uses ECS  for container management. The template can be used as a starting point for another projects.

The project was used as part of my final project for a cloud computing post graduation course in which I compared the use of ECS with Fargate and with EC2 (this is the EC2 part). This is the template architecture:

# Todo: 

service templateecsec2-service was unable to place a task because no container instance met all of its requirements. Reason: No Container Instances were found in your capacity provider. For more information, see the Troubleshooting section of the Amazon ECS Developer Guide.

No instance associated with the cluster

resource "aws_iam_role_policy_attachment" "attach-ecs-execution-role-policy" {
  role       = aws_iam_role.task_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

was added, test it -> did not solve