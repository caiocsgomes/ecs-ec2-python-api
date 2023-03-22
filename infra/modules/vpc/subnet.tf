resource "aws_subnet" "public_subnet" {
  count             = length(var.subnet_public_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.subnet_public_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name        = "${var.vpc_name}_public_${element(var.availability_zones, count.index)}"
    Environment = var.environment
  }
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.subnet_private_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.subnet_private_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name        = "${var.vpc_name}_private_${element(var.availability_zones, count.index)}"
    Environment = var.environment
  }
}
