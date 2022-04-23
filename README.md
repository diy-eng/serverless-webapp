# serverless-webapp

Invoke Lambda with curl
```
lambda_url="<ID>.lambda-url.<REGION>.on.aws"
contactflowid="xyz"
destinationphonenumber="+15555555555"
instanceid="xyz"
queueid="xyz"
attributes="xyz"
sourcephonenumber="+14444444444"
curl "https://${lambda_url}/?destinationphonenumber=${destinationphonenumber}&instanceid=${instanceid}&queueid=${queueid}&contactflowid=${contactflowid}&instanceid=${instanceid}&attributes=${attributes}&sourcephonenumber=${sourcephonenumber}" \
```