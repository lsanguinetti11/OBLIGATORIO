variable "project" {
  description = "Nombre base para los recursos"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC para los recursos"
  type        = string
}

variable "public_subnets" {
  description = "Lista de subnets públicas (para ALB y ASG)"
  type        = list(string)
}

variable "subnet_ids" {
  description = "Lista de subnets donde se crearán las instancias EC2"
  type        = list(string)
}

variable "ami" {
  description = "AMI ID para las instancias EC2"
  type        = string
}



variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}


variable "key_name" {
  description = "Nombre del Key Pair para acceso SSH"
  type        = string
}

variable "ssh_allowed_cidr" {
  description = "CIDR permitido para acceso SSH"
  type        = string
}

variable "app_instance_count" {
  description = "Cantidad de servidores de aplicación (si se usa count)"
  type        = number
  default     = 2
}



variable "aws_region" {
  description = "Región AWS"
  type        = string
  default     = "us-east-1"
}

output "alb_dns" {

  value = aws_lb.alb.dns_name

}
 
output "asg_name" {

  value = aws_autoscaling_group.asg.name

}
 
output "alb_sg_id" {

  value = aws_security_group.alb_sg.id

}
 
output "ec2_sg_id" {

  value = aws_security_group.ec2_sg.id

}
 