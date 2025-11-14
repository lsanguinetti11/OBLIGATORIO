
module "compute" {
  source             = "./modules/compute"
  ami                = var.ami
  key_name           = var.key_name
  instance_type      = var.instance_type
  app_instance_count = var.app_instance_count
  subnet_ids         = module.vpc.subnet_ids
  project            = var.project
}

