provider "aws" {
  region  = "us-east-2"
}

#########
# S3 SITE

variable "domain_name" {
  type    = string
  default = "auto-call-webapp-333.example.com"
}

variable "frontend_path" {
  type    = string
  default = "../src/frontend"
}

# create a bucket
resource "aws_s3_bucket" "aws_s3_bucket_website" {
  bucket  = "www.${var.domain_name}"
}

# create bucket policy
resource "aws_s3_bucket_policy" "portal_policy" {
  bucket = aws_s3_bucket.aws_s3_bucket_website.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.aws_s3_bucket_website.arn}/*"
        }
    ]
}
POLICY
}

resource "aws_s3_object" "website_files" {
  bucket = aws_s3_bucket.aws_s3_bucket_website.bucket
  key = "index.html"
  source = "${var.frontend_path}/index.html"
  acl = "public-read"

  content_type = "text/html"
}

resource "aws_s3_bucket_cors_configuration" "example" {
  bucket = aws_s3_bucket.aws_s3_bucket_website.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["https://s3-website-test.hashicorp.com"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
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

# Other Services
# E.G. Connect