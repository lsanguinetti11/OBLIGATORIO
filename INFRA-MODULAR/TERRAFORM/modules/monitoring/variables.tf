
variable "project" {
  description = "Nombre base para los recursos"
  type        = string
}

variable "db_identifier" {
  description = "Identificador de la instancia RDS"
  type        = string
}



output "sns_topic_arn" {
  value = aws_sns_topic.alerts.arn
}

output "rds_cpu_alarm" {
  value = aws_cloudwatch_metric_alarm.rds_cpu_high.arn
}

output "rds_storage_alarm" {
  value = aws_cloudwatch_metric_alarm.rds_storage_low.arn
}

output "rds_connections_alarm" {
  value = aws_cloudwatch_metric_alarm.rds_connections_high.arn
}