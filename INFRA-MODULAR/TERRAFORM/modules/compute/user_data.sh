#!/bin/bash
set -e

yum update -y
yum install  git -y 
yum install docker -y 
systemctl start docker
systemctl enable docker

# Install AWS CLI if missing
if ! command -v aws >/dev/null 2>&1; then
  yum install -y awscli
fi

echo $(pwd)
git clone https://github.com/Joaquin1899/obligatorio-test /home/ec2-user/obligatorio
git clone https://github.com/ORT-FI-7417-SolucionesCloud/e-commerce-obligatorio-2025 /home/ec2-user/obligatorio/html

cd /home/ec2-user/obligatorio
docker build -t obligatorio .
docker run -d -p 8080:80 --name obligatorio obligatorio


#BORRAR ECR
