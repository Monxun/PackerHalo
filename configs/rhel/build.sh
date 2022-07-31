#!/bin/bash

# SET CREDENTIAL ENV VARIABLES FROM INPUT IF NOT PRESENT KEY

# ACCESS KEY
if [ $AWS_ACCESS_KEY ]
then
  continue
else
    echo "Enter aws access key:"
    read aws_key
    export AWS_ACCESS_KEY="$aws_key"
fi

# SECRET KEY
if [ $AWS_SECRET_KEY ]
then
  continue
else
    echo "Enter aws secret key:"
    read aws_secret
    export AWS_SECRET_KEY="$aws_secret"
fi


# EXECUTE PACKER BUILDile=rhelVars.json
packer init rhel.pkr.hcl
packer build -only=amazon-ebs -var-file=rhelVars.json \
-var "aws_region=us-gov-west-1" -var "aws_version=0.1" \
rhelConfig.json

aws ec2 describe-images --region us-gov-west-1

# packer build -only=azure-rm,docker config.json
cat rhel7.9_image--log.json| jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv' 