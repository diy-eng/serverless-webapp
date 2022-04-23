import boto3

connect = boto3.client('connect')

def main(event, lambda_context):

    qParams = event.get("queryStringParameters")
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
    response = connect.start_outbound_voice_contact(
        ContactFlowId=cFlowId,
        DestinationPhoneNumber=destPhone,
        InstanceId=iId,
        QueueId=queueId,
        # Attributes=attrs,
        # SourcePhoneNumber=sourcePhone
    )

    print(response)

    return {"message": "Call to +1XXXXXX Succedded"}
