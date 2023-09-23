# Create data block for AZs

data "aws_availability_zones" "available" {
  state = "available"
}


# Create VPC

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = {
    Name        = "${var.project_name}_vpc"
    environment = var.environment
  }
}


# Create Public Subnets

resource "aws_subnet" "public" {
  count = 2

  vpc_id                                      = aws_vpc.vpc.id
  cidr_block                                  = var.public_subnet_cidrs[count.index]
  availability_zone                           = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch                     = var.map_public_ip_on_launch
  enable_resource_name_dns_a_record_on_launch = var.enable_public_resource_name_dns_a_record_on_launch

  tags = {
    Name        = "${var.project_name}_public_subnet_${count.index + 1}"
    environment = var.environment
  }
}


# Create Private Subnets

resource "aws_subnet" "private" {
  count = 2

  vpc_id                                      = aws_vpc.vpc.id
  cidr_block                                  = var.private_subnet_cidrs[count.index]
  availability_zone                           = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch                     = var.map_private_ip_on_launch
  enable_resource_name_dns_a_record_on_launch = var.enable_private_resource_name_dns_a_record_on_launch

  tags = {
    Name        = "${var.project_name}_private_subnet_${count.index + 1}"
    environment = var.environment
  }
}


# Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.project_name}_igw"
    environment = var.environment
  }
}


# Create Public Route Table for Public Subnets 

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.project_name}_public_route_table"
    environment = var.environment
  }
}


# Associate Public Route Table with Public Subnets

resource "aws_route_table_association" "public" {
  count = 2

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}


# Create Elastic IPs

resource "aws_eip" "eip" {
  count = 2

  domain = "vpc"
  tags = {
    Name        = "${var.project_name}_eip_${count.index + 1}"
    environment = var.environment
  }
}


# Create NAT Gateways

resource "aws_nat_gateway" "ngw" {
  count = 2

  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name        = "${var.project_name}_ngw_${count.index + 1}"
    environment = var.environment
  }

  depends_on = [aws_internet_gateway.igw]

  lifecycle {
    create_before_destroy = true
  }
}


# Create Private Route Tables for Private Subnets

resource "aws_route_table" "private" {
  count = 2

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw[count.index].id
  }
  tags = {
    Name        = "${var.project_name}_private_route_table_${count.index + 1}"
    environment = var.environment
  }
}


# Associate Private Route Tables with Private Subnets
resource "aws_route_table_association" "private" {
  count = 2

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}