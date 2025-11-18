#!/bin/bash
set -e

yum update -y
yum install git -y
yum install docker -y
systemctl start docker
systemctl enable docker

if ! command -v aws >/dev/null 2>&1; then
  yum install -y awscli
fi

mkdir -p /home/ec2-user/app
cd /home/ec2-user/app

# Clonas tu repo (el que sí tiene Dockerfile)
git clone https://github.com/lsanguinetti11/OBLIGATORIO.git

# Clonas el repo del profe
git clone https://github.com/ORT-FI-7417-SolucionesCloud/e-commerce-obligatorio-2025

# Copias el código del profe dentro del contexto del Dockerfile
cp -R ./e-commerce-obligatorio-2025/* ./OBLIGATORIO/

# Moverte a la carpeta donde está el Dockerfile
cd OBLIGATORIO

# Construir imagen
docker build -t obligatorio .

# Ejecutar contenedor
docker run -d -p 80:80 --name obligatorio obligatorio
