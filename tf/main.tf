provider "aws" {
  region  = "us-east-2"
}

module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "webapp-api-backend"
  description   = "API Backend"
  handler       = "main.main"
  runtime       = "python3.8"

  source_path = "../src/"

  tags = {
    Name = "webapp-api-backend"
  }
}

# LOCAL EXEC TO ENABLE URL
resource "null_resource" "create-function-url-config" {
  provisioner "local-exec" {
    command = "aws lambda create-function-url-config --function-name ${module.lambda_function.lambda_function_arn} --auth-type='NONE'"
  }

  depends_on = [
    module.lambda_function.webapp-api-backend
  ]
}