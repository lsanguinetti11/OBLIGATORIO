output "db_endpoint" {
  description = "Endpoint de la base de datos"
  value       = module.rds.db_endpoint
}

output "db_instance_arn" {
  description = "ARN de la instancia RDS"
  value       = module.rds.db_instance_arn
}

output "db_security_group_id" {
  description = "ID del Security Group del RDS"
  value       = module.rds.db_security_group_id
}
output "alb_dns" {
  value = module.compute.alb_dns
}

output "asg_name" {
  value = module.compute.asg_name
}

output "alb_sg_id" {
  value = module.compute.alb_sg_id
}
output "ec2_sg_id" {
  value = module.compute.ec2_sg_id
}
output "backup_vault_name" {
  value = module.backup.backup_vault_name
}

output "backup_plan_id" {
  value = module.backup.backup_plan_id
} 