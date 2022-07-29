#!/bin/bash

# UPDATE
sudo yum update

# INSTALL AWS CLI
sudo yum -y install unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# CONFIGURE STS FOR GOV CLOUD
sts_client = boto3.client('sts', region_name='us-gov-east-1', endpoint_url='https://sts.us-gov-east-1.amazonaws.com')
aws sts assume-role --role-arn arn:aws:iam::AccountID:role/RoleName --role-session-name RoleName --region us-gov-east-1 --endpoint-url https://sts.us-gov-east-1.amazonaws.com




# INSTALL ANSIBLE
sudo subscription-manager repos --enable rhel-*-optional-rpms \
                           --enable rhel-*-extras-rpms \
                           --enable rhel-ha-for-rhel-*-server-rpms
sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum update
sudo yum -y install ansible
ansible --version

# DOWNLOAD CIS ANSIBLE ROLE
ansible-galaxy install RedHatOfficial.rhel8_cis