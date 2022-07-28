#!/bin/bash

# UPDATE
sudo yum update

# INSTALL PYTHON3
sudo yum search python3
sudo yum install python3 -y

# INSTALL ANSIBLE
python3 -m pip install --user ansible

# DOWNLOAD CIS ANSIBLE ROLE
ansible-galaxy install RedHatOfficial.rhel8_cis