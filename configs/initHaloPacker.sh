#!/bin/bash

# UPDATE
sudo yum update
sudo yum -y install wget

# INSTALL PYTHON 3.7
cd /usr/src/python3



# INSTALL ANSIBLE
pip install jinja2
sudo subscription-manager repos --enable rhel-*-optional-rpms \
                           --enable rhel-*-extras-rpms \
                           --enable rhel-ha-for-rhel-*-server-rpms
sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum update
sudo yum -y install ansible
ansible --version

# DOWNLOAD CIS ANSIBLE ROLE
ansible-galaxy install mindpointgroup.rhel7_cis
ansible-galaxy install RedHatOfficial.rhel8_cis
ansible-galaxy install mindpointgroup.rhel7_stig
ansible-galaxy install redhatofficial.rhel8_stig

# INSTALL AWS CLI
sudo yum -y install unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install