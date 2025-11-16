variable "ami" {
  description = "AMI ID para las instancias EC2"
  type        = string
}

variable "key_name" {
  description = "Nombre del Key Pair para acceso SSH"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "app_instance_count" {
  description = "Cantidad de servidores de aplicación"
  type        = number
  default     = 2
}

variable "subnet_ids" {
  description = "Lista de subnets donde se crearán las instancias (públicas para web)"
  type        = list(string)
}

variable "project" {
  description = "Nombre base para los recursos"
  type        = string
}

variable "vpc_id" {
  description = "VPC para el SG de las instancias"
  type        = string
}
variable "ecr_repo_url" {
  description = "id del ecr (module.ecr.repository_url)"
  type = stringq
}
variable "aws_region" {
  type = string
  default = "us-east-1"
}