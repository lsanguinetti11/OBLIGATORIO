
# SECURITY GROUPS


# SG del ALB
resource "aws_security_group" "alb_sg" {
  name   = "${var.project}-alb-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project}-alb-sg" }
}

# SG de las EC2
resource "aws_security_group" "ec2_sg" {
  name   = "${var.project}-ec2-sg"
  vpc_id = var.vpc_id

  ingress {
    description      = "Allow ALB to EC2 HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb_sg.id]
  }

  ingress {
    description = "SSH (solo tu IP)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project}-ec2-sg" }
}


# LOAD BALANCER


resource "aws_lb" "alb" {
  name               = "${var.project}-alb"
  internal = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnets

  tags = { Name = "${var.project}-alb" }
}

resource "aws_lb_target_group" "tg" {
  name     = "${var.project}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
    port = "80"
  }
}

resource "aws_lb_listener" "listener_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}


# LAUNCH TEMPLATE


resource "aws_launch_template" "lt" {
  name_prefix   = "${var.project}-lt"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  iam_instance_profile {
    name = "LabInstanceProfile" # AWS Academy
  }

  network_interfaces {
    security_groups = [aws_security_group.ec2_sg.id]
  }

  user_data = base64encode(
    templatefile("${path.module}/user_data.sh", {
      ecr_repo_url = var.ecr_repo_url
      aws_region   = var.aws_region
    })
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project}-app"
    }
  }
}


# AUTO SCALING GROUP


resource "aws_autoscaling_group" "asg" {
  name                = "${var.project}-asg"
  min_size            = 2
  max_size            = 4
  desired_capacity    = 2
  vpc_zone_identifier = var.public_subnets

  health_check_type         = "ELB"
  health_check_grace_period = 60

  target_group_arns = [aws_lb_target_group.tg.arn]

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.project}-asg"
    propagate_at_launch = true
  }
}
