
# creamos recurso
resource "aws_sns_topic" "infra_notifications" {
  name = "${var.project}-infra-notifications"
}

# Suscripción por email
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.infra_notifications.arn
  protocol  = "email"
  endpoint  = "luisurco8@gmail.com"  
}

# Notificación cuando la infraestructura esté lista
resource "null_resource" "notify_infra_ready" {
  provisioner "local-exec" {
    command = "aws sns publish --topic-arn ${aws_sns_topic.infra_notifications.arn} --message 'Infraestructura desplegada correctamente en AWS.'"
  }
  depends_on = [module.compute] # Espera a que el modulo compute que contiene el ASG este completo
}
