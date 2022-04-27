# Front end
Vanilla js app with a form that calls the Lambda function URL.

## Path
`serverless-webapp/src/frontend`

---

# Backend
Lambda function that uses [Lambda URL](example.com). Runs a python script located at `serverless-webapp/src/backend/main.py`.

## PATH
`serverless-webapp/src/backend`

---

# Deployment

### Docker container
The docker container executes terraform that deploys the lambda function & s3 site.

### To run the container
1. Clone and cd into this repository.
2. Make any changes to the code you would like (e.g domain name in `tf/terraform.tfstate`)
3. run (with your AWS credentials)
```
docker build -t serverless-webapp:latest . && \
docker run --name serverless-webapp \
-e AWS_ACCESS_KEY_ID="XXX" \
-e AWS_SECRET_ACCESS_KEY="YYY" \
-e AWS_REGION="us-east-1" \
serverless-webapp
```
3. Copy the Lambda URL from the output.
4. In S3 navigate to the index file in the bucket and use the URL in the properties to visit the site.
5. Fill out the form including the Lambda URL.

Note: The state files for the deployed infrastructure will remain in the container & you will need the container to automatically destroy the infrastructure.

Note: Each container creates NEW infrastructure so running the container 5 times will create 5 buckets and 5 lambdas

TODO: Add github action

TODO: add s3 state to TF

### serverless-webapp

Invoke Lambda with curl
```
lambda_url="<ID>.lambda-url.<REGION>.on.aws"
contactflowid="xyz"
destinationphonenumber="+15555555555"
instanceid="xyz"
queueid="xyz"
attributes="xyz"
sourcephonenumber="+14444444444"
curl "https://${lambda_url}/?destinationphonenumber=${destinationphonenumber}&instanceid=${instanceid}&queueid=${queueid}&contactflowid=${contactflowid}&instanceid=${instanceid}&attributes=${attributes}&sourcephonenumber=${sourcephonenumber}"
```