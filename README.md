# Lambda function and API Gateway

## About

Lorem ipsum, innit

## Usage:

Run:
- `terraform init` to initialise Terraform.
- `terraform validate` to valdiate Terraform code.
- `terraform apply` - to build AWS resources (leave default input values or provide your own)

After Terraform completes provisioning resources, it will output URL for the API Gateway:
- `echo $(terraform output -raw base_url)`

Use this link combined with the name of the S3 bucket you want to see the contents of:
- `curl "$(terraform output -raw base_url)/list?bucket=$(S3_BUCKET_NAME)`

## Requirements:

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 3.48.0" |


## Providers:

| Name | Version |
|------|---------|
| aws | ~> 3.48.0" |
| random | ~> 3.1.0 |
| archive | ~> 2.2.0 |


## Inputs:

| Name | Description |
|------|-------------|
| aws_region | AWS region for all resources. |
| project | Project this resource belongs to. |
| environment | Environment this resource belongs to. |
| function_name | Name of the Lambda function. |

## Outputs:

| Name | Description |
|------|-------------|
| lambda_bucket_name | Name of the S3 bucket used to store function code. |
| function_name | Name of the Lambda function. |
| base_url | Base URL for API Gateway stage. |

