
resource "random_pet" "lambda_bucket_name" {
  prefix = "list-bucket-content-function"
  length = 4
}

resource "aws_s3_bucket" "lambda_bucket" {
  bucket = random_pet.lambda_bucket_name.id

  acl           = "private"
  force_destroy = true
}

data "archive_file" "lambda_function" {
  type = "zip"

  source_dir  = "${path.module}/src"
  output_path = "${path.module}/src.zip"
}

resource "aws_s3_bucket_object" "list_bucket_content" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "hello-world.zip"
  source = data.archive_file.lambda_function.output_path

  etag = filemd5(data.archive_file.lambda_function.output_path)
}

resource "aws_lambda_function" "list_bucket_content" {
  function_name = "ListBucketContent"

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_bucket_object.list_bucket_content.key

  runtime = "python3.8"
  handler = "lambda_function.lambda_handler"

  source_code_hash = data.archive_file.lambda_function.output_base64sha256

  role = aws_iam_role.lambda_exec.arn
}

resource "aws_cloudwatch_log_group" "list_bucket_content" {
  name = "/aws/lambda/${aws_lambda_function.list_bucket_content.function_name}"

  retention_in_days = 30
}

resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}