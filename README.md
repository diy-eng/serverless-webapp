# serverless-webapp

Invoke Lambda with curl
```
<!-- lambda_url="<ID>.lambda-url.<REGION>.on.aws" -->
lambda_url="y26wtbt4matfa3nanu4kspe5rq0juram.lambda-url.us-east-2.on.aws"
curl "https://${lambda_url}/" \
ContactFlowId='100' \
DestinationPhoneNumber='+15555555555' \
"
```