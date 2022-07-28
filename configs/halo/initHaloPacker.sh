#!/bin/bash

# UPDATE
sudo yum update

# INSTALL ANSIBLE
sudo rpm -i epel-release-latest-7.noarch.rpm
sudo yum update
sudo yum install ansible
ansible --version

# DOWNLOAD CIS ANSIBLE ROLE
ansible-galaxy install RedHatOfficial.rhel8_cis