import boto3

ec2_client = boto3.client('ec2', region_name='us-gov-west-1') # Change as appropriate

images = ec2_client.describe_images(Owners=['self'])

print(images)