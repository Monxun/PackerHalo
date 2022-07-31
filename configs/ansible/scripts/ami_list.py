import json
import boto3

ec2_client = boto3.client('ec2', region_name='us-gov-west-1') # Change as appropriate
images = ec2_client.describe_images(Owners=['self'])
ami_list = [(image[0]['ImageLocation'], image[0]['ImageId']) for image in images]
print(json.dumps(images, indent=4, sort_keys=True))
print(json.dumps(ami_list, indent=4, sort_keys=True))
