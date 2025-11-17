#!/bin/bash
set -e

yum update -y
amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker

# Install AWS CLI if missing
if ! command -v aws >/dev/null 2>&1; then
  yum install -y awscli
fi

git poll repo
docker build
docker run 

#BORRAR ECR
