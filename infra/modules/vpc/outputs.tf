output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "igw" {
  value = aws_internet_gateway.igw.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet.*.id
}

output "public_route_table_ids" {
  value = aws_route_table.public_route_table.*.id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet.*.id
}

output "private_route_table_ids" {
  value = aws_route_table.private_route_table.*.id
}
