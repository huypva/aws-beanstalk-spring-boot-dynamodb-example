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

module "s3" {
  depends_on  = [module.vpc]
  source      = "./s3"

  prefix      = var.prefix
  app_name    = var.app_name
  app_version = var.app_version
}

module "ebs" {
  depends_on  = [module.s3]
  source      = "./beanstalk"

  prefix      = var.prefix
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids
  s3_bucket_id = module.s3.s3_bucket_id
  s3_bucket_object_id = module.s3.s3_bucket_object_id
  app_name    = var.app_name
  app_version = var.app_version
}

output "ebs_url" {
  description = "The endpoint url of the ebs"
  value       = try(module.ebs.ebs_url, "")
}