# Input variable definitions

variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "eu-central-1"
}

variable "project" {
  description = "Project this resource belongs to."

  type    = string
  default = "aws-study"
}

variable "environment" {
  description = "Environment this resource belongs to."

  type    = string
  default = "dev"
}

variable "function_name" {
  description = "Name of the Lambda function."

  type    = string
  default = "list_bucket_content"
}