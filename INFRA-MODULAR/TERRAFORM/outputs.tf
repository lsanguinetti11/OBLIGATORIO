output "db_endpoint" {
  description = "Endpoint de la base de datos"
  value       = module.mysql.address
}

output "db_instance_arn" {
  description = "ARN de la instancia RDS"
  value       = module.mysql.arn
}

output "db_security_group_id" {
  description = "ID del Security Group del RDS"
  value       = module.rds.id
}
output "alb_dns" {
  value = module.alb.dns_name
}

output "asg_name" {
  value = module.asg.name
}

output "alb_sg_id" {
  value = module.alb_sg.id
}
output "ec2_sg_id" {
  value = module.ec2_sg.id
}
output "backup_vault_name" {
  value = module.rds_backup_vault.name
}

output "backup_plan_id" {
  value = module.rds_backup_plan.id
} 