provider "aws" {
  region  = "us-east-2"
}

#########
# S3 SITE
resource "aws_s3_bucket" "www_bucket" {
  bucket = "www.${var.bucket_name}"
  acl = "public-read"
  policy = templatefile("templates/s3-policy.json", { bucket = "www.${var.bucket_name}" })

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://www.${var.domain_name}"]
    max_age_seconds = 3000
  }

  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  tags = var.common_tags
}

# S3 bucket for redirecting non-www to www.
resource "aws_s3_bucket" "root_bucket" {
  bucket = var.bucket_name
  acl = "public-read"
  policy = templatefile("templates/s3-policy.json", { bucket = var.bucket_name })

  website {
    redirect_all_requests_to = "https://www.${var.domain_name}"
  }

  tags = var.common_tags
}

########
# LAMBDA

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