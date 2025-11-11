##############################################
# VARIABLES GLOBALES DEL PROYECTO
##############################################

variable "project" {
  description = "Nombre del proyecto (prefijo para recursos)"
  type        = string
  default     = "ecommerce-php"
}

variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
  default     = "us-east-1"
}

##############################################
# VARIABLES DE RED
##############################################

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_az_1a" {
  description = "Zona de disponibilidad para la primera subnet"
  type        = string
  default     = "us-east-1a"
}

variable "vpc_az_1b" {
  description = "Zona de disponibilidad para la segunda subnet"
  type        = string
  default     = "us-east-1b"
}

variable "subnet_1a" {
  description = "CIDR block de la subnet pública 1A"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_1b" {
  description = "CIDR block de la subnet pública 1B"
  type        = string
  default     = "10.0.2.0/24"
}