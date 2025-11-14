
# Módulo compute: crea las instancias EC2 para los servidores de aplicación

resource "aws_instance" "app" {
  count         = var.app_instance_count
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  # Usa las subnets del módulo VPC (pasadas desde el root module)
  subnet_id     = var.subnet_ids[count.index]

  # Opcional: asignar IP pública si las subnets son públicas
  associate_public_ip_address = true

  tags = {
    Name    = "${var.project}-app-${count.index + 1}"
    Project = var.project
  }
}
