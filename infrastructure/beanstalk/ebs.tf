resource "aws_elastic_beanstalk_application" "ebs_app" {
  name        = "${var.prefix}-ebs-app"
}

resource "aws_elastic_beanstalk_application_version" "ebs_app_version" {
  application = aws_elastic_beanstalk_application.ebs_app.name
  bucket = var.s3_bucket_id
  key = var.s3_bucket_object_id
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
    namespace = "aws:autoscaling:launchconfiguration"
    name = "SecurityGroups"
    value = aws_security_group.ebs_sg.id
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
}

output "ebs_url" {
  description = "The endpoint url of the ebs"
  value       = try(aws_elastic_beanstalk_environment.ebs_env.endpoint_url, "")
}