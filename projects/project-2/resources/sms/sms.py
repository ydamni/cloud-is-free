import boto3

sns = boto3.client('sns')

def lambda_handler(event, context):
    sns.publish(
        PhoneNumber=event['phoneNumber'],
        Message=event['message']
    )
    return 'SMS sent!'