resource "aws_security_group" "web_sg" {
  name   = "${var.project}-ec2-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
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

resource "aws_instance" "app" {
  count         = var.app_instance_count
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id = var.subnet_ids[count.index % length(var.subnet_ids)]

  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]

  iam_instance_profile = "LabInstanceProfile" # AWS Academy obligatorio

  user_data = templatefile("${path.module}/user_data.sh", {
    ecr_repo_url = var.ecr_repo_url
    aws_region   = var.aws_region
  })

  tags = {
    Name    = "${var.project}-app-${count.index + 1}"
    Project = var.project
  }
}

output "public_ips" {
  value = aws_instance.app[*].public_ip
}

