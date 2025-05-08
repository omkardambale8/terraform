#Create a Custom VPC with Public/Private Subnets 
#Build a VPC with internet gateway, NAT gateway, public and 
#private subnets for secure networking.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name= "My-VPC"
  }
}
#public and private subnet
resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name= "Public-subnet"
  }
}
resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name= "Private-subnet"
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
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.myvpc.id
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gtw.id
  }
  tags = {
    Name= "public_route_table"
  }
}

resource "aws_route_table_association" "public_route_table" {
    route_table_id = aws_route_table.public_route_table.id
    subnet_id = aws_subnet.public-subnet.id
}


#nat gateway and elastic IP
resource "aws_nat_gateway" "nat-gtw" {
    subnet_id = aws_subnet.public-subnet.id
  connectivity_type = "public"
  allocation_id = aws_eip.eip.id
  tags = {
    Name= "nat-gtw"
  }
}
resource "aws_eip" "eip" {
  vpc = true
  tags = {
    Name= "elastic-ip"
  }
}

#private route table and association 

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.myvpc.id
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id =aws_nat_gateway.nat-gtw.id
  }
  tags = {
    Name= "private_route_table"
  }
}

resource "aws_route_table_association" "private_route_table" {
    route_table_id = aws_route_table.private_route_table.id
    subnet_id = aws_subnet.private-subnet.id
}