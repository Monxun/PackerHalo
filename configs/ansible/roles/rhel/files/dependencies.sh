#!/bin/bash

sudo su

# //////////////////////////////////////////////////////////////////////////////////////////////////////
# DEPENDENCIES
# INSTALL SALT STIG PLAYBOOK (pg. 33)

# FILEBEAT / AUDITBEAT
cd /tmp
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.14.0-x86_64.rpm
curl -L -O https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-7.14.0-x86_64.rpm

# NAGIOS AGENT DOWNLOAD
wget https://assets.nagios.com/downloads/nagiosxi/agents/linux-nrpe-agent.tar.gz
tar xzf linux-nrpe-agent.tar.gz
cd linux-nrpe-agent
./fullinstall
cd ..

# OSSEC DOWNLOAD
wget -q -O - https://updates.atomicorp.com/installers/atomic > /tmp/ossec.sh

# AWS CLI INSTALL
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

