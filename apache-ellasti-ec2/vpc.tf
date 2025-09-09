resource "aws_vpc" "vpc01" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name="VPC-ellasticache"
  }
}

resource "aws_subnet" "public-subnet1" {
  vpc_id = aws_vpc.vpc01.id
    availability_zone       = "us-east-1a"

  cidr_block = "10.0.1.0/24"
  tags = {
    Name="Subnet1"
  }
}


resource "aws_subnet" "public-subnet2" {
  vpc_id = aws_vpc.vpc01.id
    availability_zone       = "us-east-1b"

  cidr_block = "10.0.2.0/24"
  tags = {
    Name="Subnet22"
  }
}


resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc01.id
  tags = {
    Name="InternetGateway"
  }
}

resource "aws_route_table" "subnet1-rt" {
  vpc_id = aws_vpc.vpc01.id
   route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
    }
    tags = {
    Name= "public_route_table1"
  }
}

resource "aws_route_table" "subnet2-rt" {
  vpc_id = aws_vpc.vpc01.id
   route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
    }
    tags = {
    Name= "public_route_table2"
  }
}

resource "aws_route_table_association" "rt1-ass" {
  subnet_id = aws_subnet.public-subnet1.id
  route_table_id = aws_route_table.subnet1-rt.id
  
}

resource "aws_route_table_association" "rt2-ass" {
  subnet_id =aws_subnet.public-subnet2.id
  route_table_id = aws_route_table.subnet2-rt.id
  
}