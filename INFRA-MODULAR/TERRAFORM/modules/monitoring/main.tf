
# CLOUDWATCH MONITORING PARA RDS
resource "aws_sns_topic" "alerts" {
  name = "${var.project}-alerts"
}

# Alarma: CPU alta en RDS
resource "aws_cloudwatch_metric_alarm" "rds_cpu_high" {
  alarm_name          = "${var.project}-rds-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Alarma cuando CPU > 70% en RDS"
  dimensions = {
    DBInstanceIdentifier = var.db_identifier
  }
  actions_enabled = true
  alarm_actions   = [aws_sns_topic.alerts.arn] # Notificación vía SNS
}

# Alarma: Espacio libre bajo
resource "aws_cloudwatch_metric_alarm" "rds_storage_low" {
  alarm_name          = "${var.project}-rds-storage-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = 2000000000 # ~2 GB
  alarm_description   = "Alarma cuando espacio libre < 2GB en RDS"
  dimensions = {
    DBInstanceIdentifier = var.db_identifier
  }
  actions_enabled = true
  alarm_actions   = [aws_sns_topic.alerts.arn]
}

# Alarma: Conexiones altas
resource "aws_cloudwatch_metric_alarm" "rds_connections_high" {
  alarm_name          = "${var.project}-rds-connections-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "DatabaseConnections"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = 50
  alarm_description   = "Alarma cuando conexiones > 50 en RDS"
  dimensions = {
    DBInstanceIdentifier = var.db_identifier
  }
  actions_enabled = true
  alarm_actions   = [aws_sns_topic.alerts.arn]
}
