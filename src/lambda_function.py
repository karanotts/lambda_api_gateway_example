import json
import boto3

client = boto3.client('s3')

def lambda_handler(event, context):
    
    if event['queryStringParameters'] and event['queryStringParameters']['bucket']:
        bucket_name = event['queryStringParameters']['bucket']

    response = client.list_objects_v2(Bucket=bucket_name)

    keys = []
    for obj in response['Contents']:
        keys.append(obj['Key'])


    return {
        "statusCode": 200,
        "statusDescription": "200 OK",
        "isBase64Encoded": False,
        "headers": {
            "Content-Type": "text/html"
        },
        
        "body": json.dumps(keys)
    }