resource "aws_security_group" "web_sg" {
  name   = "${var.project}-ec2-sg"
  vpc_id = var.vpc_id
 
  ingress {
    description = "HTTP from VPC (ALB in same VPC will route)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # <-- prefer tighten to your VPC; adjust if you changed VPC CIDR
  }
 
  ingress {
    description = "SSH from admin IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  tags = { Name = "${var.project}-ec2-sg" }
}
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
