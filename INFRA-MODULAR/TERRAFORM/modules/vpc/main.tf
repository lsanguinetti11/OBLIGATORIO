resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "${var.project}-vpc" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = { Name = "${var.project}-igw" }
}

# Public subnets
resource "aws_subnet" "public_1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_public_1a
  availability_zone       = var.vpc_az_1a
  map_public_ip_on_launch = true
  tags = { Name = "${var.project}-public-1a" }
}

resource "aws_subnet" "public_1b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_public_1b
  availability_zone       = var.vpc_az_1b
  map_public_ip_on_launch = true
  tags = { Name = "${var.project}-public-1b" }
}

# Private subnets
resource "aws_subnet" "private_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_private_1a
  availability_zone = var.vpc_az_1a
  tags = { Name = "${var.project}-private-1a" }
}

resource "aws_subnet" "private_1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_private_1b
  availability_zone = var.vpc_az_1b
  tags = { Name = "${var.project}-private-1b" }
}

# Route table public
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = { Name = "${var.project}-rt-public" }
}

resource "aws_route_table_association" "public_assoc_1a" {
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_assoc_1b" {
  subnet_id      = aws_subnet.public_1b.id
  route_table_id = aws_route_table.public.id
}

