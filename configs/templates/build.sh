#!/bin/bash

packer build -only=amazon-ebs -var-file=vars.json \
-var "aws_region=us-east-1" -var "description=packerGoldenImage" -var "version=1.0" \
config.json

packer build -only=azure-rm,docker config.json