resource "aws_vpc" "asg-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name= "asg-vpc"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.asg-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
    tags = {
      Name= "Subnet-1"
    }
}

resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.asg-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
      tags = {
      Name= "Subnet-2"
    }
}

resource "aws_internet_gateway" "asg-gtw" {
  vpc_id = aws_vpc.asg-vpc.id
  tags = {
    Name= "asg-Gtw"
  }
}

resource "aws_route_table" "subnet1-rt" {
  vpc_id = aws_vpc.asg-vpc.id
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.asg-gtw.id

  }
    tags = {
      Name= "Subnet-1-RT"
    }
}
resource "aws_route_table" "subnet2-rt" {
  vpc_id = aws_vpc.asg-vpc.id
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.asg-gtw.id
  }
    tags = {
      Name= "Subnet-2-RT"
    }
}

resource "aws_route_table_association" "rt1-asso" {
  subnet_id = aws_subnet.subnet1.id
  route_table_id = aws_route_table.subnet1-rt.id
  
}

resource "aws_route_table_association" "rt-asso" {
  subnet_id = aws_subnet.subnet2.id
  route_table_id = aws_route_table.subnet2-rt.id
}