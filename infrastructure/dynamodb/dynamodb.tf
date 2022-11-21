resource "aws_dynamodb_table" "user-table" {
  name           = "User"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "name"
    type = "S"
  }

  hash_key       = "id"
  range_key      = "name"

  tags = {
    Name        = "${var.prefix}-user"
  }
}

//resource "aws_vpc_endpoint" "dynamodb" {
//  vpc_id       = var.vpc_id
//  service_name = aws_dynamodb_table.book-dynamodb-table
//}

output "dynamodb_endpoint" {
  value = "https://dynamodb.${var.aws_region}.amazonaws.com"
}