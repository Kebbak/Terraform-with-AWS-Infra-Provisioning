import boto3
from botocore.exceptions import ClientError

# Set your desired bucket name and EC2 instance parameters
BUCKET_NAME = 'my-unique-bucket-name-20260202'  # Change to a globally unique name
REGION = 'us-east-1'
AMI_ID = 'ami-0c02fb55956c7d316' 
INSTANCE_TYPE = 't2.micro'
KEY_NAME = 'Development' 

# Create S3 bucket
def create_s3_bucket(bucket_name, region):
    s3 = boto3.client('s3', region_name=region)
    try:
        if region == 'us-east-1':
            s3.create_bucket(Bucket=bucket_name)
        else:
            s3.create_bucket(Bucket=bucket_name, CreateBucketConfiguration={'LocationConstraint': region})
        print(f"S3 bucket '{bucket_name}' created.")
    except ClientError as e:
        print(f"Error creating bucket: {e}")

# Launch EC2 instance
def launch_ec2_instance(ami_id, instance_type, key_name, region):
    ec2 = boto3.resource('ec2', region_name=region)
    # User data script to install and start Nginx
    user_data_script = '''
    #!/bin/bash
    yum update -y
    amazon-linux-extras install nginx1 -y
    systemctl enable nginx
    systemctl start nginx
    '''
    try:
        instance = ec2.create_instances(
            ImageId=ami_id,
            InstanceType=instance_type,
            KeyName=key_name,
            MinCount=1,
            MaxCount=1,
            UserData=user_data_script
        )[0]
        print(f"Launching EC2 instance {instance.id}...")
        instance.wait_until_running()
        instance.reload()
        print(f"EC2 instance {instance.id} is running at {instance.public_dns_name}")
    except ClientError as e:
        print(f"Error launching EC2 instance: {e}")

if __name__ == '__main__':
    create_s3_bucket(BUCKET_NAME, REGION)
    launch_ec2_instance(AMI_ID, INSTANCE_TYPE, KEY_NAME, REGION)
