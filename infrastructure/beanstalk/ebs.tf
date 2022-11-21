resource "aws_elastic_beanstalk_application" "ebs_app" {
  name        = "${var.prefix}-ebs-app"
}

resource "aws_elastic_beanstalk_application_version" "ebs_app_version" {
  application = aws_elastic_beanstalk_application.ebs_app.name
  bucket = var.s3_bucket_id
  key = var.s3_object_id
  name = "${var.app_name}-${var.app_version}"
}

resource "aws_elastic_beanstalk_environment" "ebs_env" {
  name                = "${var.prefix}-ebs-env"
  application         = aws_elastic_beanstalk_application.ebs_app.name
  solution_stack_name = "64bit Amazon Linux 2 v3.4.1 running Corretto 11"
  version_label = aws_elastic_beanstalk_application_version.ebs_app_version.name

  setting {
    name = "PORT"
    namespace = "aws:elasticbeanstalk:application:environment"
    value = "8080"
  }

  setting {
    name = "SERVER_PORT"
    namespace = "aws:elasticbeanstalk:application:environment"
    value = "8080"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "InstanceType"
    value = "t2.micro"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "EnvironmentType"
    value = "SingleInstance"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = "aws-elasticbeanstalk-ec2-role"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.subnet_ids)
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "AssociatePublicIpAddress"
    value = "true"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = aws_iam_role.role_for_beanstalk.arn
  }

  setting {
    name = "AWS_REGION"
    namespace = "aws:elasticbeanstalk:application:environment"
    value = var.aws_region
  }

  setting {
    name = "AWS_ACCESS_KEY_ID"
    namespace = "aws:elasticbeanstalk:application:environment"
    value = var.aws_access_key_id
  }

  setting {
    name = "AWS_SECRET_ACCESS_KEY"
    namespace = "aws:elasticbeanstalk:application:environment"
    value = var.aws_secret_access_key
  }

  setting {
    name = "DYNAMODB_ENPOINT"
    namespace = "aws:elasticbeanstalk:application:environment"
    value = var.dynamodb_endpoint
  }

  setting {
    name = "SPRING_PROFILES_ACTIVE"
    namespace = "aws:elasticbeanstalk:application:environment"
    value = "aws"
  }

}

output "ebs_url" {
  description = "The endpoint url of the ebs"
  value       = try(aws_elastic_beanstalk_environment.ebs_env.endpoint_url, "")
}