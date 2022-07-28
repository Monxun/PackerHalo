#!/bin/bash

# UPDATE
sudo yum update
sudo yum install 

# INSTALL ANSIBLE
python3 -m pip install --user ansible

# DOWNLOAD CIS ANSIBLE ROLE
ansible-galaxy install RedHatOfficial.rhel8_cis