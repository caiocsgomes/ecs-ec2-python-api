resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.vpc_name}_public_subnet_rt"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "public_rt_subnet_association" {
  count          = length(var.subnet_public_cidrs)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  count  = length(aws_nat_gateway.natgw)
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw[count.index].id
  }

  tags = {
    Name        = "${aws_subnet.private_subnet[count.index].id}_rt"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "private_rt_subnet_association" {
  count          = length(aws_route_table.private_route_table)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index].id
}
