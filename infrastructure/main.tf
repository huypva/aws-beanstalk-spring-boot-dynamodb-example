data "aws_availability_zones" "main" {
}

module "vpc" {
  source  = "./network"

  prefix      = var.prefix
  aws_region  = var.aws_region
  vpc_cidr    = var.vpc_cidr
  az_names    = data.aws_availability_zones.main.names
  az_count    = var.az_count
}

module "dynamodb" {
  source = "./dynamodb"

  prefix = var.prefix
  aws_region = var.aws_region
}


output "dynamodb_endpoint" {
  description = "The endpoint url of the dynamodb"
  value       = try(module.dynamodb.dynamodb_endpoint, "")
}

module "s3" {
  depends_on  = [module.vpc]
  source      = "./s3"

  prefix      = var.prefix
  app_file    = "${path.root}/../${var.app_name}/target/${var.app_name}-${var.app_version}.jar"
}

module "ebs" {
  depends_on        = [module.s3]
  source            = "./beanstalk"

  prefix            = var.prefix
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.public_subnet_ids
  s3_bucket_id      = module.s3.s3_bucket_id
  s3_object_id      = module.s3.s3_object_id
  app_name          = var.app_name
  app_version       = var.app_version
  aws_region        = var.aws_region
  aws_access_key_id       = var.aws_access_key_id
  aws_secret_access_key   = var.aws_secret_access_key
  dynamodb_endpoint = module.dynamodb.dynamodb_endpoint
}

output "ebs_url" {
  description = "The endpoint url of the ebs"
  value       = try(module.ebs.ebs_url, "")
}

