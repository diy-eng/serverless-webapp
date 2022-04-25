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

### docker container
The docker container executes terraform that deploys the lambda function

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