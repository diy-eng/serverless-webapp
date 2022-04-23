provider "aws" {
  region  = "us-east-2"
}

module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "webapp-api-backend"
  description   = "API Backend"
  handler       = "main.main"
  runtime       = "python3.9"

  source_path = "../src/backend"

  tags = {
    Name = "webapp-api-backend"
  }
}

resource "aws_lambda_function_url" "test_latest" {
  function_name      = module.lambda_function.lambda_function_arn
  authorization_type = "NONE"
}

output "lambda_url" {
  value = aws_lambda_function_url.test_latest.function_url
}