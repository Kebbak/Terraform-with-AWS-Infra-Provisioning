resource "aws_vpc" "custom_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "${var.project_name}-vpc" }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.0.0/20"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags = { Name = "${var.project_name}-public-1" }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.64.0/20"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]
  tags = { Name = "${var.project_name}-public-2" }
}


resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = "10.0.32.0/20"
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = { Name = "${var.project_name}-private-1" }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = "10.0.48.0/20"
  availability_zone = data.aws_availability_zones.available.names[2]
  tags = { Name = "${var.project_name}-private-2" }
}

resource "aws_internet_gateway" "custom_igw" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = { Name = "${var.project_name}-public-rt" }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.custom_igw.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = { Name = "${var.project_name}-private-rt" }
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private.id
}