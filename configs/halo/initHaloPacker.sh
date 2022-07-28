#!/bin/bash

# UPDATE
sudo yum update

# INSTALL PYTHON3
sudo yum search python3
sudo yum -y install python3

# INSTALL ANSIBLE
sudo yum -y install dnf
sudo dnf makecache
sudo dnf -y install epel-release
sudo dnf makecache
sudo dnf -y install ansible
ansible --version

# DOWNLOAD CIS ANSIBLE ROLE
ansible-galaxy install RedHatOfficial.rhel8_cis