import json
import boto3

ec2_client = boto3.client('ec2', region_name='us-gov-west-1') # Change as appropriate
images = ec2_client.describe_images(Owners=['self'])
parsed = json.loads(images)
print(json.dumps(parsed, indent=4, sort_keys=True))
