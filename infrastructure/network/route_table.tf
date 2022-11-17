# Routing table for public subnets
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.vpc.id

  tags   = {
    Name        = "${var.prefix}-public-rtb"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_rtb.id
}
