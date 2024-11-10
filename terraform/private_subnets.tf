resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = format("%sa", var.aws_region)
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = format("%sb", var.aws_region)
}

resource "aws_route_table" "private_internet" {
  vpc_id = aws_vpc.main.id
  # TODO: Add TAGS
  #   tags = {
  #     Name = format("%s-private-1a", var.project_name)
  #   }
}

resource "aws_route" "private_access" {
  route_table_id         = aws_route_table.private_internet.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat.id
}


resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_internet.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_internet.id
}
