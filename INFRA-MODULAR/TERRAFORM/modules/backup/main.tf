# Obtener el rol LabRole de AWS Academy
data "aws_iam_role" "labrole" {
  name = "LabRole"
}

# Vault para almacenar backups
resource "aws_backup_vault" "rds_backup_vault" {
  name = "${var.project}-rds-backup-vault"
  tags = {
    Name = "${var.project}-rds-backup-vault"
  }
}

# Plan de backup diario
resource "aws_backup_plan" "rds_backup_plan" {
  name = "${var.project}-rds-backup-plan"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.rds_backup_vault.name
    schedule          = "cron(0 5 * * ? *)" # Todos los días a las 05:00 UTC
    start_window      = 60
    completion_window = 180
    lifecycle {
      delete_after = 30 # Retención: 30 días
    }
  }
}

# Selección de recursos (RDS)
resource "aws_backup_selection" "rds_backup_selection" {
  name         = "${var.project}-rds-selection"
  plan_id      = aws_backup_plan.rds_backup_plan.id
  iam_role_arn = data.aws_iam_role.labrole.arn # Rol de AWS Academy

  resources = [
    var.rds_arn
  ]
}