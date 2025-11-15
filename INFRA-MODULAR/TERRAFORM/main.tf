
module "compute" {
  source             = "./modules/compute"
  ami                = var.ami
  key_name           = var.key_name
  instance_type      = var.instance_type
  app_instance_count = var.app_instance_count
  public_subnets = module.vpc.public_subnets
  project            = var.project
}
# VPC
module "vpc" {
  source            = "./modules/vpc"
  project           = var.project
  vpc_cidr          = var.vpc_cidr
  vpc_az_1a         = var.vpc_az_1a
  vpc_az_1b         = var.vpc_az_1b
  subnet_public_1a  = var.subnet_public_1a
  subnet_public_1b  = var.subnet_public_1b
  subnet_private_1a = var.subnet_private_1a
  subnet_private_1b = var.subnet_private_1b
}
module "rds" {
  source          = "./modules/rds"
  project         = var.project
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  db_username     = var.db_username
  db_password     = var.db_password
}
