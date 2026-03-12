import os
import boto3

def lambda_handler(event, context):
    sns_arn = os.environ["SNS_TOPIC_ARN"]
    sns = boto3.client("sns")
    
    # Compose a message about the S3 event
    records = event.get("Records", [])
    for record in records:
        s3_info = record.get("s3", {})
        bucket = s3_info.get("bucket", {}).get("name", "")
        key = s3_info.get("object", {}).get("key", "")
        message = f"File {key} was created/updated in bucket {bucket}."
        sns.publish(TopicArn=sns_arn, Message=message, Subject="S3 Update Notification")
    
    return {"statusCode": 200, "body": "SNS notification sent."}
