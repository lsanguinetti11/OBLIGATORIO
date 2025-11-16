variable "rds_arn" {
  description = "ARN de la instancia RDS"
  type        = string
}

variable "project" {
  description = "Nombre base para los recursos"
  type        = string
}

output "backup_vault_name" {
  value = aws_backup_vault.rds_backup_vault.name
}

output "backup_plan_id" {
  value = aws_backup_plan.rds_backup_plan.id
}