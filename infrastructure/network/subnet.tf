resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(local.public_cidr_blocks)
  cidr_block              = element(local.public_cidr_blocks, count.index)
  availability_zone       = var.az_names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.prefix}-public-subnet-${var.az_names[count.index]}"
  }
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet.*.id
}