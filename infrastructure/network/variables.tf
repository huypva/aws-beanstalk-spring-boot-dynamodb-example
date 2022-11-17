variable "prefix" {}
variable "aws_region" {}
variable "vpc_cidr" {}
variable "az_names" {
  type        = list(string)
}
variable "az_count" {}


locals {
  public_cidr_blocks  = [for index in range(1, 1 + var.az_count): cidrsubnet(var.vpc_cidr, 8, index)]
  private_cidr_blocks = [for index in range(1 + var.az_count, 1 + 2 * var.az_count): cidrsubnet(var.vpc_cidr, 8, index)]
}

output "public_cidr_blocks" {
  value = local.public_cidr_blocks
}

output "private_cidr_blocks" {
  value = local.private_cidr_blocks
}

