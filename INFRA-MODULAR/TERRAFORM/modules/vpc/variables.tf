variable "project" {
  description = "Nombre base para los recursos"
  type        = string
  default     = "ecommerce-php"
}

variable "vpc_cidr" {
  description = "Bloque CIDR principal de la VPC"
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

variable "subnet_public_1a" {
  description = "CIDR block de la subnet pública 1A"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_public_1b" {
  description = "CIDR block de la subnet pública 1B"
  type        = string
  default     = "10.0.2.0/24"
}
variable "subnet_private_1a" {
  description = "CIDR block de la subnet pública 1A"
  type        = string
  default     = "10.0.3.0/24"
}
variable "subnet_private_1b" {
  description = "CIDR block de la subnet pública 1A"
  type        = string
  default     = "10.0.4.0/24"
}
output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = [aws_subnet.public_1a.id, aws_subnet.public_1b.id]
}

output "private_subnets" {
  value = [aws_subnet.private_1a.id, aws_subnet.private_1b.id]
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}