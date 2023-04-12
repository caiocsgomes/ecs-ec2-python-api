data "aws_vpc_endpoint" "ecs_vpc_endpoint_nic" {
  id = aws_vpc_endpoint.ecs_endpoint.id
}

data "aws_subnet" "subnets" {
  count = length(var.subnets)
  id    = var.subnets[count.index]
}

