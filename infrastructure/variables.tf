variable "prefix" {
  type        = string
  default     = "huypva"
}

variable "aws_region" {
  default     = "ap-southeast-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "az_count" {
  default     = "1"
}

variable "app_name" {
  default     = "hello-world"
}

variable "app_version" {
  default     = "0.0.1-SNAPSHOT"
}
