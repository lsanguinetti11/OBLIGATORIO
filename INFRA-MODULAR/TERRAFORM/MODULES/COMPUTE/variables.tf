
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
  description = "Lista de subnets donde se crearán las instancias"
  type        = list(string)
}

variable "project" {
  description = "Nombre base para los recursos"
  type        = string
  default     = "ecommerce-php"
}
variable "public_subnets" {
  description = "Subnets publicas para las instancias"
  type        = string
}
