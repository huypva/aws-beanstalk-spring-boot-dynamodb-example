resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr

  tags = {
    Name        = "${var.prefix}-vpc"
  }
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = try(aws_vpc.vpc.id, "")
}
