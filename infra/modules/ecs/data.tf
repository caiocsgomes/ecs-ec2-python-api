data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}

data "aws_network_interface" "ecs_vpc_endpoint_nic" {
  filter {
    name   = "description"
    values = ["*${aws_vpc_endpoint.ecs_endpoint.id}*"]
  }
}

data "aws_subnet" "subnets" {
  count = length(var.subnets)
  id    = var.subnets[count.index]
}

