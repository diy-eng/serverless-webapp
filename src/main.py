import boto3

def main(event, lambda_context):

    qParams = event["queryStringParameters"]
    print("Params: ", qParams)

    cFlowId = qParams.get("contactflowid")
    destPhone = qParams.get("destinationphonenumber")
    iId = qParams.get("instanceid")
    queueId = qParams.get("queueid")
    attrs = qParams.get("attributes")
    sourcePhone = qParams.get("sourcephonenumber")

    for item in [cFlowId, destPhone, iId, queueId, attrs, sourcePhone]:
        if not item:
            raise ValueError("Missing required paramiter")

    # https://docs.aws.amazon.com/connect/latest/APIReference/API_StartOutboundVoiceContact.html
    print("call aws")

    return {"message": "Call to +1XXXXXX Succedded"}
