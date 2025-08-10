resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  
  tags = {
    Name= "My-VPC"
  }
}
#public and private subnet
resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name= "Public-subnet1"
  }
}
resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name= "Public-subnet2"
  }
}
#internet gateway
resource "aws_internet_gateway" "internet-gtw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name= "internet-gateway"
  }
}
#public route table and association 
resource "aws_route_table" "public_route_table1" {
  vpc_id = aws_vpc.myvpc.id
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gtw.id
  }
  tags = {
    Name= "public_route_table1"
  }
}


resource "aws_route_table" "public_route_table2" {
  vpc_id = aws_vpc.myvpc.id
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gtw.id
  }
  tags = {
    Name= "public_route_table2"
  }
}


resource "aws_route_table_association" "public_route_table" {
    route_table_id = aws_route_table.public_route_table1.id
    subnet_id = aws_subnet.subnet1.id
}

resource "aws_route_table_association" "public_route_table2" {
    route_table_id = aws_route_table.public_route_table2.id
    subnet_id = aws_subnet.subnet2.id
}
