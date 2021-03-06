########
# LAMBDA

module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "webapp-api-backend"
  description   = "API Backend"
  handler       = "main.main"
  runtime       = "python3.9"

  source_path = var.frontend_path

  tags = {
    Name = "webapp-api-backend"
  }
}

resource "aws_lambda_function_url" "test_latest" {
  function_name      = module.lambda_function.lambda_function_arn
  authorization_type = "NONE"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}

output "lambda_url" {
  value = aws_lambda_function_url.test_latest.function_url
}

# Other Services
# E.G. Connect