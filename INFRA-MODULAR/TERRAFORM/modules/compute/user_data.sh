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

# Login to ECR
aws ecr get-login-password --region ${aws_region} \
  | docker login --username AWS --password-stdin ${ecr_repo_url}

# Pull and run container
docker pull ${ecr_repo_url}:latest
docker run -d -p 80:80 --name app ${ecr_repo_url}:latest
