# SALIDAS PRINCIPALES DE LA VPC
output "vpc_id" {
  description = "ID de la VPC principal"
  value       = module.vpc.vpc_id
}

output "subnets_ids" {
  description = "IDs de las subnets creadas"
  value       = module.vpc.subnet_ids
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway creado"
  value       = module.vpc.internet_gateway_id
}
#######################################################
