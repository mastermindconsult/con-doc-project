# create VPC

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = {
    Name        = "${var.project_name}-VPC"
    environment = var.environment
  }
}


# create public subnets

resource "aws_subnet" "public" {
  count = 2

  vpc_id                                      = aws_vpc.vpc.id
  cidr_block                                  = var.public_subnet_cidrs[count.index]
  availability_zone                           = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch                     = var.map_public_ip_on_launch
  enable_resource_name_dns_a_record_on_launch = var.enable_public_resource_name_dns_a_record_on_launch

  tags = {
    Name        = "${var.project_name}-public-subnet-${count.index + 1}"
    environment = var.environment
  }
}


# create private subnets

resource "aws_subnet" "private" {
  count = 2

  vpc_id                                      = aws_vpc.vpc.id
  cidr_block                                  = var.private_subnet_cidrs[count.index]
  availability_zone                           = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch                     = var.map_private_ip_on_launch
  enable_resource_name_dns_a_record_on_launch = var.enable_private_resource_name_dns_a_record_on_launch

  tags = {
    Name        = "${var.project_name}-private-subnet-${count.index + 1}"
    environment = var.environment
  }
}


# internet gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.project_name}-IGW"
    environment = var.environment
  }
}


# create public route table for public subnets 

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.project_name}-public-route-table"
    environment = var.environment
  }
}


# associate public route table with public subnets

resource "aws_route_table_association" "public" {
  count = 2

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}


# create elastic IPs

resource "aws_eip" "eip" {
  count = 2

  domain = "vpc"
  tags = {
    Name        = "${var.project_name}-EIP-${count.index + 1}"
    environment = var.environment
  }
}


# create NAT gateways

resource "aws_nat_gateway" "ngw" {
  count = 2

  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name        = "${var.project_name}-NGW-${count.index + 1}"
    environment = var.environment
  }

  depends_on = [aws_internet_gateway.igw]

  lifecycle {
    create_before_destroy = true
  }
}


# create private route tables for private subnets

resource "aws_route_table" "private" {
  count = 2

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw[count.index].id
  }
  tags = {
    Name        = "${var.project_name}-private-route-table-${count.index + 1}"
    environment = var.environment
  }
}


# associate private route tables with private subnets

resource "aws_route_table_association" "private" {
  count = 2

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}