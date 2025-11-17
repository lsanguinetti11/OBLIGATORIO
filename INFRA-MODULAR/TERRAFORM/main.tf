


module "compute" {
  source             = "./modules/compute"
  vpc_id             = module.vpc.vpc_id
  ami                = var.ami
  key_name           = var.key_name
  instance_type      = var.instance_type
  app_instance_count = var.app_instance_count
  # aca pasas las SUBNET IDS públicas que exporta el módulo vpc
  subnet_ids         = module.vpc.public_subnets #configurar sg de ec2
  public_subnets = module.vpc.public_subnets  #Requiere el alb y asg
  ssh_allowed_cidr   = var.ssh_allowed_cidr
  project            = var.project
  aws_region      = var.aws_region
}

# VPC
module "vpc" {
  source            = "./modules/vpc"   # ojo con mayúsculas/minúsculas en Linux
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
  vpc_cidr        = var.vpc_cidr
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  db_username     = var.db_username
  db_password     = var.db_password
}

module "backup" {
  source       = "./modules/backup"
  project      = var.project
  rds_arn      = module.rds.db_instance_arn
}
# module "ecr" {
#   source  = "./modules/ecr"
#   project = var.project
# }

# module "monitoring" {
#   source        = "./modules/monitoring"
#   project       = var.project
#  # db_identifier = module.rds.db_identifier
# }