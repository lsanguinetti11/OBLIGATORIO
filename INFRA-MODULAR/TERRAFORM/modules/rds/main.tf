resource "aws_db_subnet_group" "rds_subnets" {
  name       = "${var.project}-rds-subnet-group"
  subnet_ids = var.private_subnets
  tags = { Name = "${var.project}-rds-subnets" }
}
 
resource "aws_security_group" "rds" {
  name   = "${var.project}-rds-sg"
  vpc_id = var.vpc_id
 
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr /* allow whole VPC; can be tightened */]
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  tags = { Name = "${var.project}-rds-sg" }
}
 
resource "aws_db_instance" "mysql" {
  identifier = "${var.project}-db"
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.t3.micro"
  username = var.db_username
  password = var.db_password
  allocated_storage = var.db_storage
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name = aws_db_subnet_group.rds_subnets.name
  skip_final_snapshot = true
  publicly_accessible = false
 
  # multi_az = true  # <-- DESCOMENTAR en cuenta personal (AWS Academy suele bloquear esto)
  tags = { Name = "${var.project}-rds" }
}
 
