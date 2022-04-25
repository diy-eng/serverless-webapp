#########
# S3 SITE

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
