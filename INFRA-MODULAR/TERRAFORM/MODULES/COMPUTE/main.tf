
# Módulo compute: crea las instancias EC2 para los servidores de aplicación

resource "aws_instance" "app" {
  count         = var.app_instance_count
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = element(var.public_subnets, count.index)
  tags = {
    Name    = "${var.project}-app-${count.index + 1}"
    Project = var.project
  }
}
