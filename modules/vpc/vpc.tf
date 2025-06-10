# 1.Creating VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "usecase8_vpc"
  }
}

# 2. Creating Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "usecase8_igw"
  }
}

# 3. Creating Public Subnet 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

# 4.Creating Public Subnet 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

# 6. Public Route Table
resource "aws_route_table" "bayer_public_rt" {
  vpc_id = aws_vpc.bayer_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bayer_igw.id
  }

  tags = {
    Name = "bayer-public-route-table"
  }
}

# 7. Associate Subnet 1 with Route Table
resource "aws_route_table_association" "bayer_assoc_subnet_1" {
  subnet_id      = aws_subnet.bayer_public_subnet_1.id
  route_table_id = aws_route_table.bayer_public_rt.id
}

# 8. Associate Subnet 2 with Route Table
resource "aws_route_table_association" "bayer_assoc_subnet_2" {
  subnet_id      = aws_subnet.bayer_public_subnet_2.id
  route_table_id = aws_route_table.bayer_public_rt.id
}
