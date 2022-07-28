#!/bin/bash

# UPDATE
sudo yum update

# INSTALL PYTHON3
sudo yum search python3
sudo yum -y install python3

# INSTALL ANSIBLE
sudo rpm -i epel-release-latest-7.noarch.rpm
sudo yum update
sudo yum install ansible
ansible --version

# DOWNLOAD CIS ANSIBLE ROLE
ansible-galaxy install RedHatOfficial.rhel8_cis