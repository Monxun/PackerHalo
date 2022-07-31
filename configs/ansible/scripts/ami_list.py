import json
import boto3

ec2_client = boto3.client('ec2', region_name='us-gov-west-1') # Change as appropriate
images = ec2_client.describe_images(Owners=['self'])
print(json.dumps(images, indent=4, sort_keys=True))
