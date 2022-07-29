#!/bin/bash

# SET CREDENTIAL ENV VARIABLES FROM INPUT IF NOT PRESENT KEY

# ACCESS KEY
if [ -n $AWS_ACCESS_KEY ]
  continue
else
    echo "Enter aws access key:"
    read aws_key
    export AWS_ACCESS_KEY="$aws_key"
fi

# SECRET KEY
if [ -n $AWS_SECRET_KEY ]
  continue
else
    echo "Enter aws secret key:"
    read aws_secret
    export AWS_SECRET_KEY="$aws_secret"
fi


# EXECUTE PACKER BUILD
packer init rhel.pkr.hcl
packer build -only=amazon-ebs -var-file=rhelVars.json \
-var "aws_region=us-east-1" -var "aws_version=0.1" \
rhelConfig.json

# packer build -only=azure-rm,docker config.json