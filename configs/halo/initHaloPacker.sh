#!/bin/bash

# UPDATE
sudo yum update

# INSTALL PYTHON3
sudo yum search python3
sudo yum install python3 -y
sudo yum install ansible

# INSTALL ANSIBLE
sudo python3 -m pip install --user ansible

# DOWNLOAD CIS ANSIBLE ROLE
ansible-galaxy install RedHatOfficial.rhel8_cis