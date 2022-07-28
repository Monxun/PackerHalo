#!/bin/bash

# SET CREDENTIAL ENV VARIABLES FROM INPUT
echo "Enter aws access key:"
read aws_key

echo "Enter aws secret key:"
read aws_secret

export AWS_ACCESS_KEY="$aws_key"
export AWS_SECRET_KEY="$aws_secret"


# EXECUTE PACKER BUILD
packer build -only=amazon-ebs -var-file=rhelVars.json rhelConfig.json

# packer build -only=azure-rm,docker config.json