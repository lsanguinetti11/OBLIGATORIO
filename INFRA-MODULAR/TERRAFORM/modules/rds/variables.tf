variable "project" {
  description = "Nombre base para los recursos"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se creará el RDS"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR de la VPC para permitir tráfico interno"
  type        = string
}

variable "private_subnets" {
  description = "Lista de subnets privadas para el RDS"
  type        = list(string)
}

variable "db_instance_class" {
  description = "Clase de instancia para la base de datos"
  type        = string
  default     = "db.t3.micro"
}

variable "db_storage" {
  description = "Almacenamiento asignado en GB"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
}


variable "db_username" {
  description = "Usuario administrador de la base de datos"
  type        = string
}

variable "db_password" {
  description = "Contraseña del usuario administrador"
  type        = string
  sensitive   = true
}
output "db_endpoint" {
  description = "Endpoint de la base de datos"
  value       = aws_db_instance.mysql.address
}

output "db_instance_arn" {
  description = "ARN de la instancia RDS"
  value       = aws_db_instance.mysql.arn
}

output "db_security_group_id" {
  description = "ID del Security Group del RDS"
  value       = aws_security_group.rds.id
}

