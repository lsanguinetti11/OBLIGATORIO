
# MÓDULO VPC (con subnets y rutas incluidas)
module "vpc" {
  source   = "./modules/vpc"
  project  = var.project
  vpc_cidr = var.vpc_cidr

  vpc_az_1a = var.vpc_az_1a
  vpc_az_1b = var.vpc_az_1b

  subnet_1a = var.subnet_1a
  subnet_1b = var.subnet_1b
}