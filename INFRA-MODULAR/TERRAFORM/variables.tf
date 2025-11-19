variable "project" {
  type    = string
  default = "ecommerce-php"
}
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

# VPC

variable "key_name" {
  type    = string
  default = "vockey"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "vpc_az_1a" {
  type    = string
  default = "us-east-1a"
}
variable "vpc_az_1b" {
  type    = string
  default = "us-east-1b"
}

variable "subnet_public_1a" {
  type    = string
  default = "10.0.1.0/24"
}
variable "subnet_public_1b" {
  type    = string
  default = "10.0.2.0/24"
}
variable "subnet_private_1a" {
  type = string

  default = "10.0.3.0/24"
}
variable "subnet_private_1b" {
  type    = string
  default = "10.0.4.0/24"
}

# EC2
variable "ami" {
  type    = string
  default = "ami-0cae6d6fe6048ca2c"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "ssh_allowed_cidr" {
  type    = string
  default = "0.0.0.0/0"
}
variable "app_instance_count" {
  type    = string
  default = "2"
}

#DB
variable "db_username" {
  type = string
  default = "ecom"
}
variable "db_password" {
  type = string
}
variable "db_name" {
  type = string
}
