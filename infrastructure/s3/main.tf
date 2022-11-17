resource "aws_s3_bucket" "s3_bucket_hello_word" {
  bucket = "${var.prefix}-hello-word-app"
}

resource "aws_s3_bucket_acl" "s3_bucket_acl_hello_word" {
  bucket = aws_s3_bucket.s3_bucket_hello_word.id
  acl    = "private"
}

output "s3_bucket_id" {
  description = "The ID of the VPC"
  value       = try(aws_s3_bucket.s3_bucket_hello_word.id, "")
}

resource "aws_s3_object" "s3_object_hello_word" {
  bucket = aws_s3_bucket.s3_bucket_hello_word.id
  key = "beanstalk/hello-word"
  source = "${path.module}/../../${var.app_name}/target/${var.app_name}-${var.app_version}.jar"
}

output "s3_bucket_object_id" {
  description = "The ID of the VPC"
  value       = try(aws_s3_object.s3_object_hello_word.id, "")
}