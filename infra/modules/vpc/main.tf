resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.vpc_name}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_nat_gateway" "natgw" {
  count = length(aws_subnet.public_subnet)

  allocation_id = aws_eip.natgw_eip[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id

  tags = {
    Name = "${aws_subnet.public_subnet[count.index].id}-natgw"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "natgw_eip" {
  count = length(aws_subnet.public_subnet)
  vpc   = true
}
